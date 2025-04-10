use Datatail20130410

select    * from Datatail20130410.feeds.FeedDumps  WITH (NOLOCK)
where  RunDate > convert(date,getdate()-1)
   and feedid = 9
and merchantid in (1762)
order by feedid,merchantid,RunDate desc


delete top (25) 
--select *
from Datatail20130410.feeds.FeedDumps  
where  RunDate > convert(date,getdate()-1)
and feedid = 9
--and merchantid = 3541 
--and id in (3541)
    and CurrentIndex < totalcount
and totalcount = 0

with MerchantRunSummary as (
	select 
		d.merchantid,
		count(*) as CountMerchant
	from Datatail20130410.feeds.FeedDumps d WITH (NOLOCK)
	where d.RunDate > convert(date, getdate() - 1)
		and d.feedid = 9
	group by d.merchantid
)

select 
	distinct mf.merchantid as merchantOnboarded,
	d.merchantid,
	d.RunDate,
	d.feedid,
	mrs.CountMerchant,
	case 
		when d.CurrentIndex > d.totalcount then 'Complete'
		when mrs.CountMerchant = 2 then 'Complete'
		else 'Incomplete'
	end as status
from Datatail20130410.feeds.FeedDumps d WITH (NOLOCK)
inner join feeds.MerchantFeeds mf 
	on mf.FeedId = d.FeedId and mf.MerchantId = d.MerchantId
inner join MerchantRunSummary mrs 
	on mrs.merchantid = d.merchantid
where d.RunDate > convert(date, getdate() - 1)
	and d.feedid = 9
order by mrs.CountMerchant, mf.merchantid, d.merchantid, d.RunDate desc, d.feedid desc


--Check if all merchants onboarded preload ran
select merchantid from feeds.MerchantFeeds where feedid = 9 and merchantid not in ( 
select distinct merchantid from feeds.FeedDumps where feedid = 9 and RunDate > convert(date,getdate()-1))
order by merchantid


SELECT
    --top 20
    [LogID]
      , [Project]
      , [Category]
      , [Text]
      , [Time]
      , [Severity]
      , [Module]
      , [Location]
FROM [EventReactor].[dbo].[Logs] WITH (NOLOCK)
where 1= 1
	and category = 'feeds'
    and text like '%Ashley%'
	--and text not like '%DumpData%'
	and time >=  getdate()
	--and time between '2025-04-04 00:00:00.00' and '2025-04-05 00:00:00.00'
    --and text like '%verify if there could be an issue with the data%'
--and time between '2024-11-27 14:44:14.377' and '2024-11-27 14:46:14.377'
order by [time] desc


select *
from Datatail20130410.feeds.feeds
where id = 9
--where updatefrequency not like '%api%'

select f.ClassName, mf.*
from Datatail20130410.feeds.MerchantFeeds mf
join feeds.feeds f on f.id =mf.FeedId
where 
merchantid in (2322,3575,2534,3393,3236,2680)
--and feedid = 25
--and merchantid = 3447
order by feedid


select mp.merchant_id, mp.productid, mp.ptr, p.model, p.manufmodel, p.ManufacturerIdentifier, p.active, p.discontinued from Datatail20130410.dbo.merchantProds mp
inner join products p on p.id_product = mp.productid
where merchant_id = 3447
and p.manufID = 2982
and p.manufmodel= 'SM300TTB'


-- update top (1) Datatail20130410.feeds.MerchantFeeds
-- set FeedOptionsJson = ''
-- where feedid = 9 and merchantid = 3515

select *
from Datatail20130410.feeds.MerchantFeeds
where merchantid = 2798
order by merchantid



--Old Feed
select *
--delete top (20)
from Datatail20130410.dbo.MerchantFeeds
where merchant_id in  (3569,3586,3510,3541,2384,2771,2264,2046,1785,3490,1922,3171,1574)
    and brand = 'Ashley'

select *
from Datatail20130410.dbo.MerchantFeeds
where merchant_id in (3336,2312) and brand = 'Ashley'



SELECT *
FROM [Datatail20130410].[TrackTailApp].[ClientAccounts]
where merchantid in (645,2724)


select productid, price, merchantid, feedid, AdditionalPricingData
from Datatail20130410.feeds.ProductBasePrices
where ProductId =  234959 and FeedId = 9
--delete top (1) from Datatail20130410.feeds.ProductBasePrices where ProductId =  554229 and FeedId = 9 and merchantid = 1448

-- --Delete records from today
DELETE  FROM Datatail20130410.feeds.FEEDDUMPS 
  WHERE  RUNDATE > CONVERT(DATE,GETDATE()-1)
    AND FEEDID = 9
--   and merchantid = 1448

select *
from Datatail20130410.feeds.Locations
where feedid = 21


SELECT mp.productid 
    ,p.manufacturerIdentifier
	,mp.cost 'costOnMerchantprods'
	,mp.price, 
	mp.reducedPrice
    ,mp.QtyPerPackage 
	,f.Price, 'costOnAshley'
	f.AdditionalPricingData
FROM Datatail20130410.dbo.MerchantProds  mp
    INNER JOIN Datatail20130410.dbo.products p on p.Id_product = mp.ProductID
	inner join feeds.ProductBasePrices f on f.MerchantId = mp.Merchant_ID and f.feedid = 9
WHERE 	mp.Merchant_ID = 2798
    and p.manufID in (6183, 3181, 3182, 3184, 4226, 4227, 6183);





SELECT mp.merchant_id, mp.productid, p.manufacturerIdentifier, mp.cost, mp.price, mp.reducedPrice, mp.QtyPerPackage, fb.Price, fb.AdditionalPricingData
FROM Datatail20130410.dbo.MerchantProds mp WITH (NOLOCK)
    INNER JOIN Datatail20130410.dbo.products p on p.Id_product = mp.ProductID
    INNER join Datatail20130410.feeds.ProductBasePrices fb on fb.ProductId = mp.productid
WHERE 	mp.Merchant_ID in (589)
    and p.manufID in (3437)
    --and mp.cost is null
    and mp.productid = 457125--235293
--and QtyPerPackage != ''
-- and QtyPerPackage > 1

--  update Datatail20130410.dbo.MerchantProds
--  set QtyPerPackage = null
--  where merchant_id = 1448



--**************************Comparing data with 2 Datatail20130410.dbo.merchants using old and new versions Ashley
SELECT
    mp1.productid AS productid_1448,
    mp2.productid AS productid_2312,
    p1.manufacturerIdentifier AS manufacturerIdentifier_1448,
    p2.manufacturerIdentifier AS manufacturerIdentifier_2312,
    mp1.QtyPerPackage AS QtyPerPackage_1448,
    mp2.QtyPerPackage AS QtyPerPackage_2312,
    mp1.cost AS cost_1448,
    mp2.cost AS cost_2312
--mp1.price AS price_1448,
--mp2.price AS price_2312,
--mp1.reducedPrice AS reducedPrice_1448,
--mp2.reducedPrice AS reducedPrice_2312
FROM
    Datatail20130410.dbo.MerchantProds mp1
    LEFT JOIN
    Datatail20130410.dbo.MerchantProds mp2 ON mp1.productid = mp2.productid AND mp2.Merchant_ID = 2312
    INNER JOIN
    Datatail20130410.dbo.products p1 ON p1.Id_product = mp1.ProductID AND p1.manufid IN ('6183', '3181', '3182', '3184', '4226', '4227')
    LEFT JOIN
    Datatail20130410.dbo.products p2 ON p2.Id_product = mp2.ProductID AND p2.manufid IN ('6183', '3181', '3182', '3184', '4226', '4227')
WHERE 
    mp1.Merchant_ID = 1448
    --AND mp2.QtyPerPackage IS NOT NULL
    --and mp1.productid = 389679
    AND mp1.cost != mp2.cost
ORDER BY 
    mp1.QtyPerPackage DESC


select fb.productid, p.ManufacturerIdentifier, fb.price, fb.merchantid, fb.feedid, fb.AdditionalPricingData
from Datatail20130410.feeds.ProductBasePrices fb
    inner join products p on p.id_product = fb.ProductId
where fb.ProductId =  389679
    and fb.FeedId = 9

--delete from Datatail20130410.feeds.ProductBasePrices where feedid = 9

--************Get Datatail20130410.dbo.products*************
DECLARE @MerchantId AS int = 2312;
DECLARE @ProductCount AS  int = (
SELECT count(1)
FROM Datatail20130410.dbo.MerchantProds  mp
    INNER JOIN Datatail20130410.dbo.products p on p.Id_product = mp.ProductID
WHERE 	mp.Merchant_ID = @MerchantId
    and p.manufID in (6183, 3181, 3182, 3184, 4226, 4227, 6183));


select @ProductCount


-- **********Delete Datatail20130410.dbo.products**********
delete top (@ProductCount) FROM Datatail20130410.dbo.MerchantProds
 where merchant_id = @MerchantId
    and productid in (
    SELECT mp.ProductID
    FROM Datatail20130410.dbo.MerchantProds  mp
        INNER JOIN Datatail20130410.dbo.products p on p.Id_product = mp.ProductID
    WHERE 	mp.Merchant_ID = @MerchantId
        and p.manufID in (1436,3181,3182,3184,4226,4227,6183)
 )



-- ************Delete Datatail20130410.dbo.COLLECTIONS************
DECLARE @MerchantIdForCollections AS int = 2312;
DECLARE @CollectionCountCount AS  int = (
SELECT count(distinct mc.collectionID) as total
FROM Datatail20130410.dbo.MerchantCollections  mc
    inner join Datatail20130410.dbo.COLLECTIONS c on c.id = mc.collectionid
    inner join Datatail20130410.dbo.collection_product cp on cp.collectionID = c.id
    INNER JOIN Datatail20130410.dbo.products p on p.Id_product = cp.ProductID
WHERE 	mc.Merchant_ID = @MerchantIdForCollections
    and p.manufID in (1436,3181,3182,3184,4226,4227, 6183))


select @CollectionCountCount

DELETE TOP (@COLLECTIONCOUNTCOUNT) FROM Datatail20130410.dbo.MerchantCollections
 WHERE MERCHANT_ID =  @MERCHANTIDFORCOLLECTIONS
    AND COLLECTIONID IN (
    SELECT distinct MC.COLLECTIONID
    FROM Datatail20130410.dbo.MerchantCollections  MC
        INNER JOIN Datatail20130410.dbo.COLLECTIONS C ON C.ID = MC.COLLECTIONID
        INNER JOIN Datatail20130410.dbo.collection_product CP ON CP.COLLECTIONID = C.ID
        INNER JOIN Datatail20130410.dbo.products P ON P.ID_PRODUCT = CP.PRODUCTID
    WHERE 	MC.MERCHANT_ID =  @MERCHANTIDFORCOLLECTIONS
        AND P.MANUFID IN (1436,3181,3182,3184,4226,4227, 6183)
 )




-- ************Brands management************
DECLARE @MerchantIdForBrands AS int = 2312;
DECLARE @BrandsCount AS  int = (
select count(cieId) as total
from Datatail20130410.dbo.merchantBrands
where merchant_id = @MerchantIdForBrands
    and cieId in  (3181,3182,3184,4226,4227,6183))

select @BrandsCount

delete top ( @BrandsCount) from  Datatail20130410.dbo.merchantBrands
 where merchant_id = @MerchantIdForBrands
    and cieId in  (3181,3182,3184,4226,4227, 6183)

select @BrandsCount



----Current Query to get Combined Datatail20130410.dbo.products
--select p.id_product,p.model,p.manufid,p.manufmodel,mp.lock,mp.featured,mp.reducedPrice,mp.price,mp.cost,c.category,d.dept 
--from Datatail20130410.dbo.products p
--inner join Datatail20130410.dbo.MerchantProds mp on mp.productid = p.id_product and mp.merchant_id = 1448
--inner join categories c on c.id_category = p.catid and c.id_langue = 1
--inner join departments d on d.id_dept = c.deptID and d.id_langue = 1		    
--where p.manufid in (1436,3181,3182,3184,4226,4227)
--and p.manufmodel like '%/%'


Declare @model as varchar(200) = '%CM7267N%';
    select p.id_product, p.model, p.manufmodel, co.cie, p.ManufacturerIdentifier, p.modelkey, p.manufid
    from Datatail20130410.dbo.products p
        inner join Datatail20130410.dbo.companies co on co.id_cie = p.manufid
    where p.model like @model
union all
    select p.id_product, p.model, p.manufmodel, co.cie, p.ManufacturerIdentifier, p.modelkey, p.manufid
    from Datatail20130410.dbo.products p
        inner join Datatail20130410.dbo.companies co on co.id_cie = p.manufid
    where p.manufmodel like @model
union all
    select p.id_product, p.model, p.manufmodel, co.cie, p.ManufacturerIdentifier, p.modelkey, p.manufid
    from Datatail20130410.dbo.products p
        inner join Datatail20130410.dbo.companies co on co.id_cie = p.manufid
    where p.ManufacturerIdentifier like @model
union all
    select p.id_product, p.model, p.manufmodel, co.cie, p.ManufacturerIdentifier, p.modelkey, p.manufid
    from Datatail20130410.dbo.products p
        inner join Datatail20130410.dbo.companies co on co.id_cie = p.manufid
    where p.modelKey like @model




select * from VW_MerchantCollectionProducts



select top 100 * from AssociatedCollections
where maincollectionID = 29365