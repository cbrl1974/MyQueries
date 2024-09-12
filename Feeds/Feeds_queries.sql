
select id, merchant, merchantpwd from merchants where id in (select MerchantId from feeds.merchantFeeds where feedid = 9)
select id, merchant, merchantpwd from merchants where id = 1448

select * from feeds.feeds
 where id = 4

Select distinct UpdateFrequency from feeds.feeds
 where id=4

SELECT 
id, options, updatefrequency,
    JSON_VALUE(Options, '$.DownloaderSettings.ProductFilename') AS ProductFilename,
    JSON_VALUE(Options, '$.DownloaderSettings.InventoryFilename') AS InventoryFilename,
    JSON_VALUE(Options, '$.DownloaderSettings.MerchantFilename') AS MerchantFilename,
    JSON_VALUE(Options, '$.DownloaderSettings.PricingFileName') AS PricingFileName
FROM feeds.feeds
union all
SELECT 
    id, [Options], updatefrequency,
    JSON_VALUE(Options, '$.downloaderSettings.productFilename') AS ProductFilename,
    JSON_VALUE(Options, '$.downloaderSettings.inventoryFilename') AS InventoryFilename,
    JSON_VALUE(Options, '$.downloaderSettings.merchantFilename') AS MerchantFilename,
    JSON_VALUE(Options, '$.downloaderSettings.pricingFileName') AS PricingFileName
FROM feeds.feeds






-- update top (1) feeds.feeds
-- set active  = 0
-- where id = 17
--Old feed
select * from feeds.merchantfeeds where feedid = 19 order by merchantid
select * from feeds.merchantfeeds where merchantid = 2858 order by merchantid



select * from MerchantFeeds where merchant_id = 2858 and brand = 'Ashley'
select * from MerchantFeeds where merchant_id = 2312 and brand = 'Ashley'


select   * from feeds.FeedDumps  WITH (NOLOCK)
where  RunDate > convert(date,getdate()-1) 
--and MerchantId = 2798
 and FEEDID = 4
order by RunDate desc
, merchantid


-- --Delete records from today
  DELETE top (1) FROM FEEDS.FEEDDUMPS 
  WHERE  RUNDATE > CONVERT(DATE,GETDATE()-1) 
  AND FEEDID = 4
  and merchantid = 1448

   
select * from feeds.ProductBasePrices   WITH (NOLOCK) where feedid = 9 and merchantid = 1448 and productid = 291167
--delete from feeds.ProductBasePrices where feedid = 9 and merchantid = 1448

SELECT 
top 100
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
  and text like '%Ashley%'
  and time >= getdate()
  --and logid >= 50766812
  order by [time] desc

  select id_product, model, manufmodel, ManufacturerIdentifier from products where manufmodel like '%3840152%'



SELECT mp.merchant_id, mp.productid, p.manufacturerIdentifier, mp.cost, mp.price, mp.reducedPrice, mp.QtyPerPackage, fb.Price, fb.AdditionalPricingData
FROM MerchantProds mp WITH (NOLOCK)  
INNER JOIN products p on p.Id_product = mp.ProductID
left join feeds.ProductBasePrices fb on fb.MerchantId = mp.Merchant_ID and fb.ProductId = mp.productid
WHERE 	mp.Merchant_ID in (1448,2312)
and p.manufID in (6183, 3181, 3182, 3184, 4226, 4227)
--and mp.cost is null
and  mp.productid = 788603--235293
--and QtyPerPackage != ''
-- and QtyPerPackage > 1

--  update MerchantProds
--  set QtyPerPackage = null
--  where merchant_id = 1448

--**************************Comparing data with 2 merchants using old and new versions Ashley
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
    MerchantProds mp1
LEFT JOIN 
    MerchantProds mp2 ON mp1.productid = mp2.productid AND mp2.Merchant_ID = 2312
INNER JOIN 
    products p1 ON p1.Id_product = mp1.ProductID AND p1.manufid IN ('6183', '3181', '3182', '3184', '4226', '4227')
LEFT JOIN 
    products p2 ON p2.Id_product = mp2.ProductID AND p2.manufid IN ('6183', '3181', '3182', '3184', '4226', '4227')
WHERE 
    mp1.Merchant_ID = 1448



--************Get Products*************
DECLARE @MerchantId AS int = 2312;
DECLARE @ProductCount AS  int = (
SELECT count(1) FROM MerchantProds  mp
INNER JOIN products p on p.Id_product = mp.ProductID
WHERE 	mp.Merchant_ID = @MerchantId
and p.manufID in (6183, 3181, 3182, 3184, 4226, 4227, 6183));


select @ProductCount


-- **********Delete Products**********
 delete top (@ProductCount) FROM MerchantProds
 where merchant_id = @MerchantId 
 and productid in (
    SELECT mp.ProductID FROM MerchantProds  mp
        INNER JOIN products p on p.Id_product = mp.ProductID
    WHERE 	mp.Merchant_ID = @MerchantId 
    and p.manufID in (1436,3181,3182,3184,4226,4227,6183)
 )



-- ************Delete Collections************
DECLARE @MerchantIdForCollections AS int = 2312;
DECLARE @CollectionCountCount AS  int = (
SELECT count(distinct mc.collectionID) as total FROM MerchantCollections  mc
inner join collections c on c.id = mc.collectionid
inner join collection_product cp on cp.collectionID = c.id
INNER JOIN products p on p.Id_product = cp.ProductID
WHERE 	mc.Merchant_ID = @MerchantIdForCollections
and p.manufID in (1436,3181,3182,3184,4226,4227, 6183))


select @CollectionCountCount

 DELETE TOP (@COLLECTIONCOUNTCOUNT) FROM MERCHANTCOLLECTIONS
 WHERE MERCHANT_ID =  @MERCHANTIDFORCOLLECTIONS
 AND COLLECTIONID IN (
    SELECT distinct MC.COLLECTIONID FROM MERCHANTCOLLECTIONS  MC
    INNER JOIN COLLECTIONS C ON C.ID = MC.COLLECTIONID
    INNER JOIN COLLECTION_PRODUCT CP ON CP.COLLECTIONID = C.ID
    INNER JOIN PRODUCTS P ON P.ID_PRODUCT = CP.PRODUCTID
    WHERE 	MC.MERCHANT_ID =  @MERCHANTIDFORCOLLECTIONS
    AND P.MANUFID IN (1436,3181,3182,3184,4226,4227, 6183)
 )




-- ************Brands management************
DECLARE @MerchantIdForBrands AS int = 2312;
DECLARE @BrandsCount AS  int = (
select count(cieId) as total  from  merchantBrands
where merchant_id = @MerchantIdForBrands 
and cieId in  (3181,3182,3184,4226,4227,6183))

select @BrandsCount

 delete top ( @BrandsCount) from  merchantBrands
 where merchant_id = @MerchantIdForBrands
 and  cieId in  (3181,3182,3184,4226,4227, 6183)

 select @BrandsCount

 

----Current Query to get Combined Products
--select p.id_product,p.model,p.manufid,p.manufmodel,mp.lock,mp.featured,mp.reducedPrice,mp.price,mp.cost,c.category,d.dept 
--from products p
--inner join merchantProds mp on mp.productid = p.id_product and mp.merchant_id = 1448
--inner join categories c on c.id_category = p.catid and c.id_langue = 1
--inner join departments d on d.id_dept = c.deptID and d.id_langue = 1		    
--where p.manufid in (1436,3181,3182,3184,4226,4227)
--and p.manufmodel like '%/%'

