
select id, merchant, merchantpwd from merchants where id in (select MerchantId from feeds.merchantFeeds where feedid = 9)
select * from feeds.feeds where id = 9

select * from devTAilbaseCore.feeds.MerchantFeeds where FeedId = 9 and MerchantId = 3336

--Compare with Old
select * from merchantfeeds where merchant_id = 1448

select * from dbo.products where model like '%D199-01%'
--46464


select top 10  * from feeds.FeedDumps 
where  RunDate > convert(date,getdate()-1) 
--and MerchantId = 3336
order by RunDate desc, merchantid



--Delete records from today
 DELETE FROM FEEDS.FEEDDUMPS 
 WHERE  RUNDATE > CONVERT(DATE,GETDATE()-1) 
 AND FEEDID = 9



 SELECT mp.productid, p.manufmodel, mp.cost, b.Price as CostFromFeed, b.AdditionalPricingData, mp.price, mp.reducedPrice FROM dbo.MerchantProds  mp
INNER JOIN dbo.products p on p.Id_product = mp.ProductID
left join feeds.ProductBasePrices b on b.MerchantId = mp.Merchant_ID and b.ProductId = mp.ProductID
WHERE 	mp.Merchant_ID = 1448
and p.manufID in (6183, 3181, 3182, 3184, 4226, 4227)
and mp.ProductID in (select ProductID from feeds.ProductBasePrices where merchantid = 3336)
and b.ProductId = 629101

select * from ItemNotes

select * from feeds.feeds where id = 9
select distinct merchantid from feeds.MerchantFeeds where FeedId = 9
select count(1) from feeds.ProductBasePrices where FeedId = 9 and MerchantId = 3336
select * from feeds.ProductBasePrices where feedid = 9 and productid = 629101

select * from products where id_product = 738184

select id_product, model, manufModel, ManufacturerIdentifier,specs,IgnoreInFeed from products 
where manufID in (6183, 3181, 3182, 3184, 4226, 4227)
and active = 1
--and manufmodel like '%/%'
and ManufacturerIdentifier is  null
--and ManufacturerIdentifier = 'D287D2'
--and id_product in (select productid from feeds.ProductBasePrices where FeedId = 9 and MerchantId = 3336)




--update top (2) feeds.ProductBasePrices
--set ItemsPercase = 2
--where merchantid in (589,3336) and ProductId = 706807



SELECT 
TOP (100)
 [LogID]
      ,[Project]
      ,[Category]
      ,[Text]
      ,[Time]
      ,[Severity]
      ,[Module]
      ,[Location]
  FROM [devEventReactor].[dbo].[Logs]
  where category = 'feeds'
  order by [time] desc

select * from feeds.PriceTypes
select * from products where manufacturerIdentifier = 'B070B1'
select * from merchants where id = 589

use DevTailbaseCore

ALTER TABLE merchantprods
alter column FeedsQuantity INT NULL ;

select * from feeds.ProductBasePrices 
where FeedId = 9
and merchantid in ( 3336) --3336
--and itemsPercase >= 1
--and productid = 465275
order by ProductBasePriceId desc






select productid, price, reducedPrice, realPrice, reducedPriceEndDate, createdByapp from merchantProds where merchant_id = 589
and productid = 172786

select  * from feeds.productbasePrices where  productID = 155451  and id = 14031 


--delete top (7041) dbo.MerchantProds 
--where productid in 
--(
--	 SELECT mp.productid FROM dbo.MerchantProds  mp
--	INNER JOIN dbo.products p on p.Id_product = mp.ProductID
--	WHERE 	mp.Merchant_ID = 3336
--	and p.manufID in (6183, 3181, 3182, 3184, 4226, 4227)
--)
--and merchant_id = 3336



--************Get Products*************
DECLARE @MerchantId AS int = 1448;
DECLARE @ProductCount AS  int = (
SELECT count(1) FROM MerchantProds  mp
INNER JOIN products p on p.Id_product = mp.ProductID
WHERE 	mp.Merchant_ID = @MerchantId
and p.manufID in (6183, 3181, 3182, 3184, 4226, 4227));


select @ProductCount

SELECT productid  FROM MerchantProds mp WITH (NOLOCK)  
INNER JOIN products p on p.Id_product = mp.ProductID
WHERE 	mp.Merchant_ID = 1448
and p.manufID in (6183, 3181, 3182, 3184, 4226, 4227)




-- **********Delete Products**********
 delete top (@ProductCount) FROM MerchantProds
 where merchant_id = @MerchantId 
 and productid in (
     SELECT mp.ProductID FROM MerchantProds  mp
         INNER JOIN products p on p.Id_product = mp.ProductID
     WHERE 	mp.Merchant_ID = @MerchantId 
     and p.manufID in (1436,3181,3182,3184,4226,4227)
 )

-- **********Collections management**********



--Get Collection for a merchant
--SELECT distinct mc.collectionID, mc.specificBrand, c.collection_1, mc.price, mc.reducedPrice, mc.advPrice, mc.realPrice
-- FROM MerchantCollections  mc
--inner join collections c on c.id = mc.collectionid
--inner join collection_product cp on cp.collectionID = c.id
--INNER JOIN products p on p.Id_product = cp.ProductID
--WHERE 	mc.Merchant_ID = 1448
--and p.manufID in (1436,3181,3182,3184,4226,4227)


----Current Query to get Combined Products
--select p.id_product,p.model,p.manufid,p.manufmodel,mp.lock,mp.featured,mp.reducedPrice,mp.price,mp.cost,c.category,d.dept 
--from products p
--inner join merchantProds mp on mp.productid = p.id_product and mp.merchant_id = 3336
--inner join categories c on c.id_category = p.catid and c.id_langue = 1
--inner join departments d on d.id_dept = c.deptID and d.id_langue = 1		    
--where p.manufid in (1436,3181,3182,3184,4226,4227)
--and p.manufmodel like '%/%'

-- ************Delete Collections************
DECLARE @MerchantIdForCollections AS int = 1448;
DECLARE @CollectionCountCount AS  int = (
SELECT count(mc.collectionID) as total FROM MerchantCollections  mc
inner join collections c on c.id = mc.collectionid
inner join collection_product cp on cp.collectionID = c.id
INNER JOIN products p on p.Id_product = cp.ProductID
WHERE 	mc.Merchant_ID = @MerchantIdForCollections
and p.manufID in (1436,3181,3182,3184,4226,4227))


select @CollectionCountCount

DELETE TOP (@COLLECTIONCOUNTCOUNT) FROM MERCHANTCOLLECTIONS
WHERE MERCHANT_ID =  @MERCHANTIDFORCOLLECTIONS
AND COLLECTIONID IN (
    SELECT MC.COLLECTIONID FROM MERCHANTCOLLECTIONS  MC
    INNER JOIN COLLECTIONS C ON C.ID = MC.COLLECTIONID
    INNER JOIN COLLECTION_PRODUCT CP ON CP.COLLECTIONID = C.ID
    INNER JOIN PRODUCTS P ON P.ID_PRODUCT = CP.PRODUCTID
    WHERE 	MC.MERCHANT_ID =  @MERCHANTIDFORCOLLECTIONS
    AND P.MANUFID IN (1436,3181,3182,3184,4226,4227)
)


-- ************Brands management************
DECLARE @MerchantIdForBrands AS int = 3336;
DECLARE @BrandsCount AS  int = (
select count(cieId) as total  from  merchantBrands
where merchant_id = @MerchantIdForBrands 
and cieId in  (1436,3181,3182,3184,4226,4227))

select @BrandsCount

delete top ( @BrandsCount) from  merchantBrands
where merchant_id = @MerchantIdForBrands
and  cieId in  (1436,3181,3182,3184,4226,4227)

select * from companies where id_cie in (3181,3182,3184,4226,4227,1436)
select * from companies where id_cie = 1436

