
select id, merchant, merchantpwd from merchants where id in (select MerchantId from devTailbaseCore.feeds.merchantFeeds where feedid = 9)
select * from devTailbaseCore.feeds.feeds where id = 9

select * from devTailbaseCore.feeds.MerchantFeeds where FeedId = 9 and MerchantId = 3336

--Compare with Old
select * from merchantfeeds where merchant_id = 3336

select * from devtailbasecore.dbo.products where model like '%D199-01%'
--46464


select top 10  * from devTailbaseCore.feeds.FeedDumps 
where  RunDate > convert(date,getdate()-1) 
--and MerchantId = 3336
order by RunDate desc, merchantid


--Delete records from today
 DELETE FROM DEVTAILBASECORE.FEEDS.FEEDDUMPS 
 WHERE  RUNDATE > CONVERT(DATE,GETDATE()-1) 
 AND FEEDID = 9



 SELECT mp.productid, p.manufmodel, mp.cost, b.Price as CostFromFeed, b.AdditionalPricingData, mp.price, mp.reducedPrice FROM devTailbaseCore.dbo.MerchantProds  mp
INNER JOIN devTailbaseCore.dbo.products p on p.Id_product = mp.ProductID
left join devTailbaseCore.feeds.ProductBasePrices b on b.MerchantId = mp.Merchant_ID and b.ProductId = mp.ProductID
WHERE 	mp.Merchant_ID = 3336
and p.manufID in (6183, 3181, 3182, 3184, 4226, 4227)
and mp.cost is not null
and mp.ProductID in (select ProductID from feeds.ProductBasePrices where merchantid = 3336)
and b.ProductId = 340663


select * from devTailbaseCore.feeds.feeds where id = 9
select * from devTailbaseCore.feeds.MerchantFeeds where FeedId = 9 and MerchantId = 3336
select * from feeds.ProductBasePrices where merchantid = 3336 and ProductId = 340663
select * from feeds.PriceTypes
select * from products where manufmodel = '1090012'
select * from merchants where id = 3336



select * from devTailbaseCore.feeds.ProductBasePrices 
where FeedId = 9
and merchantid = 3336
--and productid = 465275
order by ProductBasePriceId desc


select productid, price, reducedPrice, realPrice, reducedPriceEndDate, createdByapp from merchantProds where merchant_id = 589
and productid = 172786

select  * from productsPrices where  productID = 172786  and id = 14031 


--delete top (7041) devTailbaseCore.dbo.MerchantProds 
--where productid in 
--(
--	 SELECT mp.productid FROM devTailbaseCore.dbo.MerchantProds  mp
--	INNER JOIN devTailbaseCore.dbo.products p on p.Id_product = mp.ProductID
--	WHERE 	mp.Merchant_ID = 3336
--	and p.manufID in (6183, 3181, 3182, 3184, 4226, 4227)
--)
--and merchant_id = 3336



--************Get Products*************
DECLARE @MerchantId AS int = 3336;
DECLARE @ProductCount AS  int = (
SELECT count(mp.productid) FROM MerchantProds  mp
INNER JOIN products p on p.Id_product = mp.ProductID
WHERE 	mp.Merchant_ID = @MerchantId
and p.manufID in (6183, 3181, 3182, 3184, 4226, 4227));


select @ProductCount




-- **********Delete Products**********
-- delete top (@ProductCount) FROM MerchantProds
-- where merchant_id = @MerchantId 
-- and productid in (
--     SELECT mp.ProductID FROM MerchantProds  mp
--         INNER JOIN products p on p.Id_product = mp.ProductID
--     WHERE 	mp.Merchant_ID = @MerchantId 
--     and p.manufID in (1436,3181,3182,3184,4226,4227)
-- )

-- **********Collections management**********
DECLARE @MerchantIdForCollections AS int = 3336;
DECLARE @CollectionCountCount AS  int = (
SELECT count(mc.collectionID) as total FROM MerchantCollections  mc
inner join collections c on c.id = mc.collectionid
inner join collection_product cp on cp.collectionID = c.id
INNER JOIN products p on p.Id_product = cp.ProductID
WHERE 	mc.Merchant_ID = @MerchantIdForCollections
and p.manufID in (1436,3181,3182,3184,4226,4227))


select @CollectionCountCount


--Get Collection for a merchant
SELECT distinct mc.collectionID, mc.specificBrand, c.collection_1, mc.price, mc.reducedPrice, mc.advPrice, mc.realPrice
 FROM MerchantCollections  mc
inner join collections c on c.id = mc.collectionid
inner join collection_product cp on cp.collectionID = c.id
INNER JOIN products p on p.Id_product = cp.ProductID
WHERE 	mc.Merchant_ID = 3336
and p.manufID in (1436,3181,3182,3184,4226,4227)


--Current Query to get Combined Products
select p.id_product,p.model,p.manufid,p.manufmodel,mp.lock,mp.featured,mp.reducedPrice,mp.price,mp.cost,c.category,d.dept 
from products p
inner join merchantProds mp on mp.productid = p.id_product and mp.merchant_id = 3336
inner join categories c on c.id_category = p.catid and c.id_langue = 1
inner join departments d on d.id_dept = c.deptID and d.id_langue = 1		    
where p.manufid in (1436,3181,3182,3184,4226,4227)
and p.manufmodel like '%/%'

-- ************Delete Collections************
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

select * from companies where id_cie in (3181,3182,3184,4226,4227,1436)
select * from companies where id_cie = 1436

