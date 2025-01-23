SELECT 
top 50
 [LogID]
      ,[Project]
      ,[Category]
      ,[Text]
      ,[Time]
      ,[Severity]
      ,[Module]
      ,[Location]
  FROM [EventReactor].[dbo].[Logs] WITH (NOLOCK)
  where category = 'Feeds'
  --and text not like '%FoaPreload%'
  --and text not like '%schema%'
  --and text like '%coaster%'
  --and time between '2024-11-27 14:44:14.377' and '2024-11-27 14:46:14.377'
    order by [time] desc

    select id, active from datatail20130410.dbo.merchants where id = 196

select top 10 * from datatail20130410.dbo.SpecsProd
select id, merchant, merchantpwd from datatail20130410.dbo.merchants where id in (select MerchantId from datatail20130410.feeds.MerchantFeeds where feedid = 9)
select id, merchant, merchantpwd from datatail20130410.dbo.merchants where id = 1448

select * from datatail20130410.feeds.feeds
 where id = 25

Select distinct UpdateFrequency from datatail20130410.feeds.feeds
 where id=4

SELECT 
id, options, updatefrequency,
    JSON_VALUE(Options, '$.DownloaderSettings.ProductFilename') AS ProductFilename,
    JSON_VALUE(Options, '$.DownloaderSettings.InventoryFilename') AS InventoryFilename,
    JSON_VALUE(Options, '$.DownloaderSettings.MerchantFilename') AS MerchantFilename,
    JSON_VALUE(Options, '$.DownloaderSettings.PricingFileName') AS PricingFileName
FROM datatail20130410.feeds.feeds
union all
SELECT 
    id, [Options], updatefrequency,
    JSON_VALUE(Options, '$.downloaderSettings.productFilename') AS ProductFilename,
    JSON_VALUE(Options, '$.downloaderSettings.inventoryFilename') AS InventoryFilename,
    JSON_VALUE(Options, '$.downloaderSettings.merchantFilename') AS MerchantFilename,
    JSON_VALUE(Options, '$.downloaderSettings.pricingFileName') AS PricingFileName
FROM datatail20130410.feeds.feeds



select * from datatail20130410.dbo.MerchantCollectionPricer where merchantid = 2203


select productid, price, reducedPrice from datatail20130410.dbo.MerchantProds 
where merchant_id = 2203 
and productid in (select productid from datatail20130410.dbo.collection_product where collectionID = 18426
)

select price, reducedPrice  from datatail20130410.dbo.MerchantCollections where merchant_id = 2203  and collectionid = 18426



--Old feed
select * from datatail20130410.feeds.MerchantFeeds where feedid = 4 and  merchantid = 589 order by merchantid
select * from datatail20130410.feeds.MerchantFeeds where merchantid = 2858 order by merchantid



select * from datatail20130410.dbo.MerchantFeeds where merchant_id = 2858 and brand = 'Ashley'
select * from datatail20130410.dbo.MerchantFeeds where merchant_id = 2312 and brand = 'Ashley'


select * from datatail20130410.feeds.FeedDumps  WITH (NOLOCK)
where  RunDate > convert(date,getdate()-1) 
--and MerchantId = 2798
 --and FEEDID = 4
order by RunDate desc



-- --Delete records from today
--   DELETE top (2) FROM datatail20130410.feeds.FEEDDUMPS 
--   WHERE  RUNDATE > CONVERT(DATE,GETDATE()-1) 
--   AND FEEDID = 4

  select * from datatail20130410.feeds.Locations where feedid = 21



  select * from datatail20130410.feeds.LocationsProducts where locationid = 26

   
select * from datatail20130410.feeds.ProductBasePrices   WITH (NOLOCK) where feedid = 4
--delete from datatail20130410.feeds.ProductBasePrices where feedid = 9 and merchantid = 1448



  select id_product, model, manufmodel, ManufacturerIdentifier from datatail20130410.dbo.products where id_product = 523051

  select * from datatail20130410.dbo.companies where cie like '%furniture of america%'



SELECT mp.merchant_id, mp.productid, p.manufacturerIdentifier, mp.cost, mp.price, mp.reducedPrice, mp.QtyPerPackage, fb.Price, fb.AdditionalPricingData
FROM datatail20130410.dbo.MerchantProds mp WITH (NOLOCK)  
INNER JOIN datatail20130410.dbo.products p on p.Id_product = mp.ProductID
INNER join datatail20130410.feeds.ProductBasePrices fb on fb.ProductId = mp.productid
WHERE 	mp.Merchant_ID in (589)
and p.manufID in (3437)
--and mp.cost is null
and  mp.productid = 457125--235293
--and QtyPerPackage != ''
-- and QtyPerPackage > 1

--  update datatail20130410.dbo.MerchantProds
--  set QtyPerPackage = null
--  where merchant_id = 1448

select * from datatail20130410.feeds.ProductBasePrices where ProductId =  457125 and PricingTierId = 5

select merchant_id, productid, price, reducedPrice from datatail20130410.dbo.MerchantProds  where ProductId =  457125

--**************************Comparing data with 2 datatail20130410.dbo.merchants using old and new versions Ashley
SELECT 
    mp1.merchant_id AS merchant_id_1448,
    mp1.productid AS productid_1448,
    p1.manufacturerIdentifier AS manufacturerIdentifier_1448,
    mp1.cost AS cost_1448,
    mp1.price AS price_1448,
    mp1.reducedPrice AS reducedPrice_1448,
    mp1.QtyPerPackage AS QtyPerPackage_1448,
    mp2.merchant_id AS merchant_id_2312,
    mp2.productid AS productid_2312,
    p2.manufacturerIdentifier AS manufacturerIdentifier_2312,
    mp2.cost AS cost_2312,
    mp2.price AS price_2312,
    mp2.reducedPrice AS reducedPrice_2312,
    mp2.QtyPerPackage AS QtyPerPackage_2312
FROM 
    datatail20130410.dbo.MerchantProds mp1
LEFT JOIN 
    datatail20130410.dbo.MerchantProds mp2 ON mp1.productid = mp2.productid AND mp2.Merchant_ID = 2312
INNER JOIN 
    datatail20130410.dbo.products p1 ON p1.Id_product = mp1.ProductID AND p1.manufid IN ('6183', '3181', '3182', '3184', '4226', '4227')
LEFT JOIN 
    datatail20130410.dbo.products p2 ON p2.Id_product = mp2.ProductID AND p2.manufid IN ('6183', '3181', '3182', '3184', '4226', '4227')
WHERE 
    mp1.Merchant_ID = 1448



--************Get datatail20130410.dbo.products*************
DECLARE @MerchantId AS int = 2312;
DECLARE @ProductCount AS  int = (
SELECT count(1) FROM datatail20130410.dbo.MerchantProds  mp
INNER JOIN datatail20130410.dbo.products p on p.Id_product = mp.ProductID
WHERE 	mp.Merchant_ID = @MerchantId
and p.manufID in (6183, 3181, 3182, 3184, 4226, 4227, 6183));


select @ProductCount


-- **********Delete datatail20130410.dbo.products**********
 delete top (@ProductCount) FROM datatail20130410.dbo.MerchantProds
 where merchant_id = @MerchantId 
 and productid in (
    SELECT mp.ProductID FROM datatail20130410.dbo.MerchantProds  mp
        INNER JOIN datatail20130410.dbo.products p on p.Id_product = mp.ProductID
    WHERE 	mp.Merchant_ID = @MerchantId 
    and p.manufID in (1436,3181,3182,3184,4226,4227,6183)
 )



-- ************Delete datatail20130410.dbo.COLLECTIONS************
DECLARE @MerchantIdForCollections AS int = 2312;
DECLARE @CollectionCountCount AS  int = (
SELECT count(distinct mc.collectionID) as total FROM datatail20130410.dbo.MerchantCollections  mc
inner join datatail20130410.dbo.COLLECTIONS c on c.id = mc.collectionid
inner join datatail20130410.dbo.collection_product cp on cp.collectionID = c.id
INNER JOIN datatail20130410.dbo.products p on p.Id_product = cp.ProductID
WHERE 	mc.Merchant_ID = @MerchantIdForCollections
and p.manufID in (1436,3181,3182,3184,4226,4227, 6183))


select @CollectionCountCount

 DELETE TOP (@COLLECTIONCOUNTCOUNT) FROM datatail20130410.dbo.MerchantCollections
 WHERE MERCHANT_ID =  @MERCHANTIDFORCOLLECTIONS
 AND COLLECTIONID IN (
    SELECT distinct MC.COLLECTIONID FROM datatail20130410.dbo.MerchantCollections  MC
    INNER JOIN datatail20130410.dbo.COLLECTIONS C ON C.ID = MC.COLLECTIONID
    INNER JOIN datatail20130410.dbo.collection_product CP ON CP.COLLECTIONID = C.ID
    INNER JOIN datatail20130410.dbo.products P ON P.ID_PRODUCT = CP.PRODUCTID
    WHERE 	MC.MERCHANT_ID =  @MERCHANTIDFORCOLLECTIONS
    AND P.MANUFID IN (1436,3181,3182,3184,4226,4227, 6183)
 )




-- ************Brands management************
DECLARE @MerchantIdForBrands AS int = 2312;
DECLARE @BrandsCount AS  int = (
select count(cieId) as total  from  datatail20130410.dbo.merchantBrands
where merchant_id = @MerchantIdForBrands 
and cieId in  (3181,3182,3184,4226,4227,6183))

select @BrandsCount

 delete top ( @BrandsCount) from  datatail20130410.dbo.merchantBrands
 where merchant_id = @MerchantIdForBrands
 and  cieId in  (3181,3182,3184,4226,4227, 6183)

 select @BrandsCount

 

----Current Query to get Combined datatail20130410.dbo.products
--select p.id_product,p.model,p.manufid,p.manufmodel,mp.lock,mp.featured,mp.reducedPrice,mp.price,mp.cost,c.category,d.dept 
--from datatail20130410.dbo.products p
--inner join datatail20130410.dbo.MerchantProds mp on mp.productid = p.id_product and mp.merchant_id = 1448
--inner join categories c on c.id_category = p.catid and c.id_langue = 1
--inner join departments d on d.id_dept = c.deptID and d.id_langue = 1		    
--where p.manufid in (1436,3181,3182,3184,4226,4227)
--and p.manufmodel like '%/%'


Declare @model as varchar(200) = '%CM7267N%';
select p.id_product, p.model, p.manufmodel, co.cie, p.ManufacturerIdentifier, p.modelkey, p.manufid 
from datatail20130410.dbo.products p
inner join datatail20130410.dbo.companies co on co.id_cie = p.manufid
where p.model like @model
union all
select p.id_product, p.model, p.manufmodel, co.cie, p.ManufacturerIdentifier, p.modelkey, p.manufid 
from datatail20130410.dbo.products p
inner join datatail20130410.dbo.companies co on co.id_cie = p.manufid
where p.manufmodel like @model
union all
select p.id_product, p.model, p.manufmodel, co.cie, p.ManufacturerIdentifier, p.modelkey, p.manufid 
from datatail20130410.dbo.products p
inner join datatail20130410.dbo.companies co on co.id_cie = p.manufid
where p.ManufacturerIdentifier like @model
union all
select p.id_product, p.model, p.manufmodel, co.cie, p.ManufacturerIdentifier, p.modelkey, p.manufid 
from datatail20130410.dbo.products p
inner join datatail20130410.dbo.companies co on co.id_cie = p.manufid
where p.modelKey like @model
