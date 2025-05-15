      declare @MerchantId int=589;
      declare @FeedBrandCategories as FeedBrandCategory;
      insert into @FeedBrandCategories values (2434,'58,88,134,175,178,180,181,182,183,184,186,187,188,189,190,191,192,193,194,196,197,208,210,209,258,257,260,277,282,294,298,308,310,315,311,312,313,314,316,318,319,372,389,179,407,419,431,448,447,457,473,487,519,527,533,248,539,587,261,590,591,267,600,87,607,649,657');
      declare @FeedBrandDepartments as FeedBrandCategory;
      insert into @FeedBrandDepartments values (2434,'23,25,29,28,26,27,30,58');
      declare @FeedId int=9;
      declare @LocationName nvarchar(1000)='';
     
    
--Find all of the products managed by the feed for this merchant.
WITH cte_ProductFromFeedSettings
AS (
    SELECT *
    FROM (
        SELECT p.Id_product 'ProductId'
	        ,mp.Merchant_ID 'MerchantId'
	        ,p.catid 'CategoryId'
	        ,d.dept 'Department'
	        ,p.manufid 'BrandId'
            ,ci.cie 'BrandName'
	        ,p.active 'Active'
	        ,c.deptID 'DepartmentId'
	        ,CONVERT(int, CASE 
			        WHEN fbc.BrandId IS NULL
				        THEN 0
			        ELSE 1
			        END) 'ProductCategoryIsPartOfFeedSettings'
	        ,CONVERT(int, CASE 
			        WHEN mp.ID IS NULL
				        THEN 0
			        ELSE 1
			        END) 'IsInMerchantProds'          
        FROM products p
        LEFT JOIN @FeedBrandCategories fbc ON p.manufID = fbc.BrandId
	        AND p.catID IN (
				(select [value] from OpenJson('[' + fbc.CategoryIds + ']'))
		        )
        LEFT JOIN MerchantProds mp ON mp.ProductID = p.Id_product
	        AND mp.Merchant_ID = @MerchantId
        LEFT JOIN Companies ci on p.manufID=ci.Id_cie
        LEFT JOIN Categories c ON p.catID = c.Id_category and c.Id_langue=1
        LEFT JOIN Departments d ON c.deptID = d.Id_dept and d.Id_langue=1		
        WHERE p.manufID IN (
		        SELECT DISTINCT a.BrandId
		        FROM @FeedBrandCategories a
		        )
				    and p.photo=1 
    and p.specs=1 
    and p.bundle=0                     
    and p.model not like '%refurb%'
    and p.model not like '%blemished%'
        ) x
    )
    --Find all of the managed products that also are collection_products
    ,cte_CollectionProducts
AS (
    SELECT cp.productID
        ,cp.collectionID
        ,p.CategoryId
        ,p.Department
        ,ProductCategoryIsPartOfFeedSettings
        ,CONVERT(int, CASE 
		        WHEN fbd.BrandId IS NULL
			        THEN 0
		        ELSE 1
		        END) 'ProductDepartmentIsPartOfFeedSettings'
        ,p.BrandId
        ,p.BrandName
        ,p.DepartmentId
        ,p.Active        
    FROM collection_product cp
    LEFT JOIN cte_ProductFromFeedSettings p ON cp.productID = p.ProductId
    LEFT JOIN @FeedBrandDepartments fbd ON p.BrandId = fbd.BrandId
        AND p.DepartmentId IN (
			(select [value] from OpenJson('[' + fbd.CategoryIds + ']'))
	        ) --Actually fbd.CategoryIds is a deptid. We just reused the category table variable definition.
    )
	,cte_CollectionProductsInMerchant
	AS (
		SELECT 
			cp.collectionID,
			COUNT(*) AS TotalProducts,
			COUNT(mp.ProductID) AS ProductsOnMerchant
		FROM collection_product cp
		LEFT JOIN MerchantProds mp 
			ON mp.ProductID = cp.productID 
			AND mp.Merchant_ID = @MerchantId
		GROUP BY cp.collectionID
	)
    --select collectionID,DepartmentId,count(*) 'DistinctProducts' from cte_CollectionProducts where ProductCategoryIsPartOfFeedSettings=1 and ProductDepartmentIsPartOfFeedSettings=1
    --group by collectionID,DepartmentId
    --Find all the collections that contain only active feed products. 
    --Some collections might contains only SOME active products, those will get removed
    --Some collection might contain some products from brands that are not managed by this feed. Those won't be managed by any feed.
    ,cte_AffectedCollections as (		
        select 
        a.collectionID
        ,a.ProductIds
        ,a.DepartmentId
        ,a.Department
        ,a.BrandIds,a.BrandNames
        ,convert(bit,a.CollectionContainsOnlyActiveProducts) 'CollectionContainsOnlyActiveProducts'
        ,convert(bit,case when a.ManagedCollectionProducts=b.TotalCollectionProducts then 1 else 0 end) 'CollectionProductsAreAllManaged'
        ,convert(bit,a.ProductCategoryIsPartOfFeedSettings) 'ProductCategoryIsPartOfFeedSettings'
        ,convert(bit,a.ProductDepartmentIsPartOfFeedSettings) 'ProductDepartmentIsPartOfFeedSettings'		 
        from (
	        select collectionID
	        ,DepartmentId
	        ,Department
	        ,dbo.group_concat(distinct BrandId) 'BrandIds'
	        ,dbo.GROUP_CONCAT(distinct BrandName) 'BrandNames'
            ,dbo.GROUP_CONCAT(distinct ProductId) 'ProductIds'
	        ,min(convert(int, Active)) 'CollectionContainsOnlyActiveProducts'
	        ,min(ProductCategoryIsPartOfFeedSettings) 'ProductCategoryIsPartOfFeedSettings'
	        ,min(ProductDepartmentIsPartOfFeedSettings) 'ProductDepartmentIsPartOfFeedSettings'			
	        ,count(*) 'ManagedCollectionProducts'
	        from cte_CollectionProducts 
	        where ProductCategoryIsPartOfFeedSettings is not null and ProductDepartmentIsPartOfFeedSettings is not null
	        group by collectionID,DepartmentId,Department
        ) a
        left join (
	        select cp.collectionID,count(*) 'TotalCollectionProducts' from collection_product cp
	        group by cp.collectionID
        ) b on a.collectionID=b.collectionID
        --Only return collections that contain only managed products
        where a.ManagedCollectionProducts=b.TotalCollectionProducts
    )
   select 
    ac.*,
    convert(bit, case when mc.ID is not null then 1 else 0 end) 'IsInMerchantCollections',
    convert(bit, mc.lock) 'IsLocked',
    convert(bit, case when coalesce(mc.featured,0)=0 then 0 else 1 end) 'IsFeatured',
    mc.price 'MerchantCollectionPrice',
    mc.reducedPrice 'MerchantCollectionReducedPrice',
    c.collection_1 'CollectionName',
    convert(bit, case when c.active=1 and c.complete=1 then 1 else 0 end) 'CollectionIsActiveAndComplete',
    
    -- 💡 New flag:
    convert(bit, case 
        when cpm.ProductsOnMerchant = cpm.TotalProducts 
        then 1 else 0 
    end) as AllProductsOfTheCollectionAreOnTheMerchant
	from cte_AffectedCollections ac
	left join MerchantCollections mc on ac.collectionID = mc.collectionID and mc.Merchant_ID = @MerchantId
	left join collections c on ac.collectionID = c.ID
	left join cte_CollectionProductsInMerchant cpm on ac.collectionID = cpm.collectionID



