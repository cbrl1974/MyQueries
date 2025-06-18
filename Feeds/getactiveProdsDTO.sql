 Declare @AllBrandCatsActive int = 0;
  Declare @merchantid int = 2087;
  declare @FeedBrandCategories as FeedBrandCategory;
  insert into @FeedBrandCategories values
  (3181,'58,88,134,175,178,180,181,182,183,184,186,187,188,189,190,191,192,193,194,196,197,208,210,209,258,257,260,277,282,294,298,308,310,315,311,312,313,314,316,318,319,372,389,179,407,419,431,448,447,457,473,487,519,527,533,248,539,587,261,590,591,267,600,87,607,649,657'),
  (3182,'134,175,178,180,181,182,183,184,185,186,187,188,190,208,210,209,58,310,315,311,312,313,314,316,318,179,419,282,431,457,473,587,267,657'),
  (3184,'175,178,181,182,183,184,186,188,210,310,315,311,312,313,314,316,179,473,519,587,591'),
  (4226,'262,272,331,372'),
  (4227,'262,272,331,372');
 
 select * from (
 SELECT p.Id_product 'ProductId',
 mp.ProductID 'ProductIdFromMerchantprods'
     ,mp.Merchant_ID 'MerchantId'
     ,p.catid 'CategoryId'
     ,p.manufid 'BrandId'
     ,ca.Category
     ,dp.Dept 'Department'
     ,p.ManufModel
     ,p.active 'Active'
     ,mp.price
     ,CONVERT(BIT,CASE 
         WHEN @AllBrandCatsActive = 1
             THEN 1
         WHEN fbc.BrandId IS NULL
             THEN 0
         ELSE 1
         END) 'ProductCategoryIsPartOfFeedSettings'
     ,CONVERT(BIT,CASE 
         WHEN mp.ID IS NULL
             THEN 0
         ELSE 1
         END) 'IsInMerchantProds'
     ,convert(BIT,coalesce(mp.lock,0)) 'IsLocked'
     ,convert(bit,case when coalesce(mp.featured,0)=0 then 0 else 1 end) 'IsFeatured'
     ,ci.cie 'Brand'
     ,mp.price 'MerchantProdPrice'
     ,mp.ReducedPrice 'MerchantProdReducedPrice'                                
 FROM products p
 LEFT JOIN @FeedBrandCategories fbc ON p.manufID = fbc.BrandId
     AND p.catID IN (
						(select [value] from OpenJson('[' + fbc.CategoryIds + ']'))
         )
 LEFT JOIN Companies ci on p.manufid=ci.id_cie
 LEFT JOIN Categories ca on p.catid=ca.id_category and ca.id_langue=1    
 LEFT JOIN Departments dp on ca.deptid=dp.id_dept and dp.id_langue=1
 LEFT JOIN MerchantProds mp ON mp.ProductID = p.Id_product AND mp.Merchant_ID = @MerchantId                            
     WHERE p.manufID IN (
             SELECT DISTINCT a.BrandId
             FROM @FeedBrandCategories a
             )
     and p.photo=1 
     and p.specs=1 
     and p.bundle=0                     
     and model not like '%refurb%'
     and model not like '%blemished%'
                     ) x
             where not (IsInMerchantProds=0 and active=0)
			 and productid = 698281

