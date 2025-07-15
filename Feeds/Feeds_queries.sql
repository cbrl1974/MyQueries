use datatail20130410

select *
from datatail20130410.feeds.FeedDumps  WITH (NOLOCK)
where  RunDate > convert(date,getdate()-1)
--where 1 = 1
    and feedid = 9
    --and MerchantId in (3606)
	--and CurrentIndex <= totalcount
order by feedid,merchantid,RunDate desc

delete top (20) datatail20130410.feeds.FeedDumps 
where  RunDate > convert(date,getdate()-1)
and  feedid = 9 
--and CurrentIndex <= totalcount
and MerchantId in (3606)


select mp.merchant_id, mp.cost, mp.productid, mp.price, mp.reducedprice, mp.QtyPerPackage, fp.productid 'Productid_From_Feed', fp.price, fp.merchantid, fp.feedid, fp.AdditionalPricingData
from feeds.ProductBasePrices fp
    left join merchantprods mp on mp.Merchant_ID = fp.MerchantId and mp.productid = fp.ProductId
    inner join merchants m on m.id = fp.MerchantId
where  fp.feedid = 9
    and fp.MerchantId in (761)
    and fp.productid = 625189
    and m.active = 1


	

select mp.merchant_id, mp.cost, mp.productid, mp.price, mp.reducedprice, mp.QtyPerPackage, fp.productid 'Productid_From_Feed', fp.price, fp.merchantid, fp.feedid, fp.AdditionalPricingData
from feeds.ProductBasePrices fp
    left join merchantprods mp on mp.Merchant_ID = fp.MerchantId and mp.productid = fp.ProductId
    inner join merchants m on m.id = fp.MerchantId
where  fp.feedid = 9
    and fp.MerchantId in (1202)
    and fp.productid in (258565,258558)
    and m.active = 1



--delete top (2) datatail20130410.feeds.FeedDumps 
--where  RunDate > convert(date,getdate()-1)
--and  feedid = 9 
--and MerchantId in (1448)



with
    MerchantRunSummary
    as
    (
        select
            d.merchantid,
            count(*) as CountMerchant
        from datatail20130410.feeds.FeedDumps d WITH (NOLOCK)
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
		when mrs.CountMerchant >= 2 then 'Complete'
		else 'Incomplete'
	end as status
from datatail20130410.feeds.FeedDumps d WITH (NOLOCK)
    inner join feeds.MerchantFeeds mf
    on mf.FeedId = d.FeedId and mf.MerchantId = d.MerchantId
    inner join MerchantRunSummary mrs
    on mrs.merchantid = d.merchantid
where d.RunDate > convert(date, getdate() - 1)
    and d.feedid = 9
order by mrs.CountMerchant, mf.merchantid, d.merchantid, d.RunDate desc, d.feedid desc


--Check if all merchants onboarded preload ran
select merchantid
from feeds.MerchantFeeds
where feedid = 9 and merchantid not in ( 
select distinct merchantid
    from feeds.FeedDumps
    where feedid = 9 and RunDate > convert(date,getdate()-1))
order by merchantid



SELECT --top 150
    [LogID]
      , [Project]
      , [Category]
	  , text
      , [Time]
      , [Severity]
      , [Module]
      , [Location]
FROM [EventReactor].[dbo].[Logs] WITH (NOLOCK)
where category = 'feeds'
    --and text not like '%soap%'
    --and text  like '%Starting DumpData for AshleyAPI(9 -%'
   and severity != 2
    --and text like '%MerchantProds updated for feed AshleyAPI(9), MerchantID:%'
    --and time between '2025-06-14 00:00:00.000' and '2025-06-14 23:59:59.999'
    and time > convert(date,getdate()-0)
order by [time] desc

2025-06-14 06:09:41.227

select *
from datatail20130410.feeds.feeds
where id = 9

select *
from datatail20130410.feeds.merchantfeeds
where feedid = 9
and merchantid = 1202
--where updatefrequency not like '%api%'

select m.id, m.merchant, f.id, f.Name, f.ClassName, mf.MerchantFeedId, mf.FeedOptionsJson,
    JSON_VALUE(mf.FeedOptionsJson, '$.DealerId') AS MerchantFilename
from datatail20130410.feeds.MerchantFeeds mf
    join feeds.feeds f on f.id =mf.FeedId
    join merchants m on m.id = mf.MerchantId
    join merchantwebsiteInformation mwi on mwi.merchant_id = m.id and mwi.infoCode = 'template'
where  mf.merchantid = 1202
    and m.active = 1
order by MerchantId


--UPDATE top(82) mf
--SET FeedOptionsJson = JSON_MODIFY(FeedOptionsJson, '$.ApplySurcharge', 'false')
--FROM datatail20130410.feeds.MerchantFeeds mf
--JOIN feeds.feeds f ON f.id = mf.FeedId
--JOIN merchants m ON m.id = mf.MerchantId
--JOIN merchantwebsiteInformation mwi ON mwi.merchant_id = m.id AND mwi.infoCode = 'template'
--WHERE mf.FeedId = 9
--and mf.MerchantId  != 1448
--  AND m.active = 1;


select distinct mc.collectionid, c.brands, mc.price, mc.reducedPrice, mc.lock
from merchantcollections mc
    inner join collections c on c.id = mc.collectionId
    inner join collection_product cp on cp.collectionid = c.id
    inner join products p on p.id_product = cp.productid
where  mc.merchant_id = 2798
    and p.manufid =2434


select 
--mp.merchant_id, mp.cost, mp.productid, p.active, p.discontinued, p.manufacturerIdentifier,
--    mp.price, mp.reducedprice, mp.QtyPerPackage,
    fp.productid 'Productid_From_Feed', fp.price, fp.merchantid, fp.feedid, fp.AdditionalPricingData
from feeds.ProductBasePrices fp
    left join merchantprods mp on mp.Merchant_ID = fp.MerchantId and mp.productid = fp.ProductId
    join products p on p.id_product =  fp.ProductId
where  fp.feedid = 4
and fp.productid = 521331 
    --and p.discontinued = 0
    --and p.active = 1
    and fp.MerchantId = 1448

select distinct mp.productid, mp.cost, mp.price, mp.reducedprice, mp.QtyPerPackage, p.manufacturerIdentifier, 
fp.price, fp.AdditionalPricingData, p.active, p.discontinued, p.photo
from merchantProds mp
inner join feeds.ProductBasePrices fp on fp.MerchantId = mp.Merchant_ID and fp.productid = mp.productid 
inner join products p on fp.productid = p.id_product
where  mp.Merchant_ID = 1448
and fp.feedid = 9
and mp.productid in (805314,842001) 
--and p.ManufacturerIdentifier = 'A1001088'
select * from feeds.merchantFeeds where merchantid = 1448 and feedid = 9

--update top (186) merchantcollections
--set  reducedPrice = null,
--price = null,
--lock = 1
--where merchant_id = 2959 
--and collectionid in (select distinct mc.collectionid
--from merchantcollections mc
--inner join collections c on c.id = mc.collectionId
--inner join collection_product cp on cp.collectionid = c.id
--inner join products p on p.id_product = cp.productid
--where  mc.merchant_id = 2959 
--and p.manufid =2768
--)




select manufacturerIdentifier
from products
where id_product = 577574


-- update top (1) datatail20130410.feeds.MerchantFeeds
-- set FeedOptionsJson = ''
-- where feedid = 9 and merchantid = 3515

select *
from datatail20130410.feeds.MerchantFeeds
where feedid = 9
--and merchantid = 3429
order by merchantid

select *
from feeds.Locations
where feedid = 17

--Old Feed
select m.id, m.merchant, mf.*
--delete top (20)
from datatail20130410.dbo.MerchantFeeds mf
    join merchants m on m.id = mf.merchant_id
--where merchant_id in  (3569,3586,3510,3541,2384,2771,2264,2046,1785,3490,1922,3171,1574)
where mf.brand = 'Ashley'
    and m.active = 1

select *
from datatail20130410.dbo.MerchantFeeds
where merchant_id in (3429) and brand = 'Ashley'



select mp.merchant_id, mp.cost, mp.productid, mp.price, mp.reducedprice, mp.QtyPerPackage, fp.productid 'Productid_From_Feed', fp.price, fp.merchantid, fp.feedid, fp.AdditionalPricingData
from feeds.ProductBasePrices fp
    left join merchantprods mp on mp.Merchant_ID = fp.MerchantId and mp.productid = fp.ProductId
where  fp.feedid = 9
    and fp.MerchantId = 1448
--and fp.productid = 805314

select *
from feeds.ProductBasePrices fp
where feedid = 9 and merchantid = 2087 and productid =577574

select id_product, manufmodel
from products
where manufmodel in ('52693730','52693731','52693732','52693740','52693751','52693761','52693762','52694130','52694131','52694132','52694140','52694151','52694161','52694162','52775431','52775432','52775440','52775451','52775461','52775462','52776131','52776132','52776140','52776151','52776161','52776162','52786731','52786732','52786740','52786751','52786761','52786762','52786831','52786832','52786840','52786851','52786861','52786862','52786931','52786932','52786940','52786951','52786961','52786962','52813330','52813331','52813332','52813340','52813351','52813361','52813362','52813430','52813431','52813432','52813440','52813451','52813461','52813462','52814030','52814031','52814032','52814040','52814051','52814061','52814062','52919130','52919131','52919132','52919140','52919151','52919161','52919162','52919230','52919231','52919232','52919240','52919251','52919261','52919262','52919330','52919331','52919332','52919340','52919351','52919361','52919362','52919430','52919431','52919432','52919440','52919451','52919461','52919462','53199030','53199031','53199032','53199040','53199051','53199061','53199062','53199530','53199531','53199532','53199540','53199551','53199561','53199562','53199630','53199631','53199632','53199640','53199651','53199661','53199662','53199830','53199831','53199832','53199840','53199851','53199861','53199862','53199930','53199931','53199932','53199940','53199951','53199961','53199962','53200231','53200232','53200240','53200251','53200261','53200262','53200531','53200532','53200540','53200551','53200561','53200562','53204030','53204031','53204032','53204040','53204051','53204061','53204062','53204130','53204131','53204132','53204140','53204151','53204161','53204162','53204230','53204231','53204232','53204240','53204251','53204261','53204262','53204330','53204331','53204332','53204340','53204351','53204361','53204362','53204531','53204532','53204540','53204551','53204561','53204562','53204631','53204632','53204640','53204651','53204661','53204662','53204731','53204732','53204740','53204751','53204761','53204762','53204831','53204832','53204840','53204851','53204861','53204862','53204931','53204932','53204940','53204951','53204961','53204962')
select id_product, model, manufmodel, manufID, manufacturerIdentifier
from products
where model like '%Brenham%'

select productid, price, merchantid, feedid, AdditionalPricingData
from datatail20130410.feeds.ProductBasePrices
where ProductId =  234959 and FeedId = 9
--delete top (1) from datatail20130410.feeds.ProductBasePrices where ProductId =  554229 and FeedId = 9 and merchantid = 1448

-- --Delete records from today
DELETE  FROM datatail20130410.feeds.FEEDDUMPS 
  WHERE  RUNDATE > CONVERT(DATE,GETDATE()-1)
    AND FEEDID = 9
--   and merchantid = 1448

select *
from datatail20130410.feeds.Locations
where feedid = 21


SELECT mp.productid 
    ,p.manufacturerIdentifier
	,mp.cost 'costOnMerchantprods'
	,mp.price, 
	mp.reducedPrice
    ,mp.QtyPerPackage 
	,f.Price, 'costOnAshley'
	f.AdditionalPricingData
FROM datatail20130410.dbo.MerchantProds  mp
    INNER JOIN datatail20130410.dbo.products p on p.Id_product = mp.ProductID
    inner join feeds.ProductBasePrices f on f.MerchantId = mp.Merchant_ID and f.feedid = 9
WHERE 	mp.Merchant_ID = 2798
    and p.manufID in (6183, 3181, 3182, 3184, 4226, 4227, 6183);





SELECT mp.merchant_id, mp.productid, p.manufacturerIdentifier, mp.cost, mp.price, mp.reducedPrice, mp.QtyPerPackage, fb.Price, fb.AdditionalPricingData
FROM datatail20130410.dbo.MerchantProds mp WITH (NOLOCK)
    INNER JOIN datatail20130410.dbo.products p on p.Id_product = mp.ProductID
    INNER join datatail20130410.feeds.ProductBasePrices fb on fb.ProductId = mp.productid
WHERE 	mp.Merchant_ID in (1202)
    and p.manufID in (3437)
    --and mp.cost is null
    and mp.productid = 805314--235293
--and QtyPerPackage != ''
-- and QtyPerPackage > 1

--  update datatail20130410.dbo.MerchantProds
--  set QtyPerPackage = null
--  where merchant_id = 1448



--**************************Comparing data with 2 datatail20130410.dbo.merchants using old and new versions Ashley
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
    datatail20130410.dbo.MerchantProds mp1
    LEFT JOIN
    datatail20130410.dbo.MerchantProds mp2 ON mp1.productid = mp2.productid AND mp2.Merchant_ID = 2312
    INNER JOIN
    datatail20130410.dbo.products p1 ON p1.Id_product = mp1.ProductID AND p1.manufid IN ('6183', '3181', '3182', '3184', '4226', '4227')
    LEFT JOIN
    datatail20130410.dbo.products p2 ON p2.Id_product = mp2.ProductID AND p2.manufid IN ('6183', '3181', '3182', '3184', '4226', '4227')
WHERE 
    mp1.Merchant_ID = 1448
    --AND mp2.QtyPerPackage IS NOT NULL
    --and mp1.productid = 389679
    AND mp1.cost != mp2.cost
ORDER BY 
    mp1.QtyPerPackage DESC


select fb.productid, p.ManufacturerIdentifier, fb.price, fb.merchantid, fb.feedid, fb.AdditionalPricingData
from datatail20130410.feeds.ProductBasePrices fb
    inner join products p on p.id_product = fb.ProductId
where fb.ProductId =  389679
    and fb.FeedId = 9

--delete from datatail20130410.feeds.ProductBasePrices where feedid = 9

select ManufacturerIdentifier
from products
where id_product =805314

--************Get datatail20130410.dbo.products*************
DECLARE @MerchantId AS int = 2312;
DECLARE @ProductCount AS  int = (
SELECT count(1)
FROM datatail20130410.dbo.MerchantProds  mp
    INNER JOIN datatail20130410.dbo.products p on p.Id_product = mp.ProductID
WHERE 	mp.Merchant_ID = @MerchantId
    and p.manufID in (6183, 3181, 3182, 3184, 4226, 4227, 6183));


select @ProductCount


-- **********Delete datatail20130410.dbo.products**********
delete top (@ProductCount) FROM datatail20130410.dbo.MerchantProds
 where merchant_id = @MerchantId
    and productid in (
    SELECT mp.ProductID
    FROM datatail20130410.dbo.MerchantProds  mp
        INNER JOIN datatail20130410.dbo.products p on p.Id_product = mp.ProductID
    WHERE 	mp.Merchant_ID = @MerchantId
        and p.manufID in (1436,3181,3182,3184,4226,4227,6183)
 )



-- ************Delete datatail20130410.dbo.COLLECTIONS************
DECLARE @MerchantIdForCollections AS int = 2312;
DECLARE @CollectionCountCount AS  int = (
SELECT count(distinct mc.collectionID) as total
FROM datatail20130410.dbo.MerchantCollections  mc
    inner join datatail20130410.dbo.COLLECTIONS c on c.id = mc.collectionid
    inner join datatail20130410.dbo.collection_product cp on cp.collectionID = c.id
    INNER JOIN datatail20130410.dbo.products p on p.Id_product = cp.ProductID
WHERE 	mc.Merchant_ID = @MerchantIdForCollections
    and p.manufID in (1436,3181,3182,3184,4226,4227, 6183))


select @CollectionCountCount

DELETE TOP (@COLLECTIONCOUNTCOUNT) FROM datatail20130410.dbo.MerchantCollections
 WHERE MERCHANT_ID =  @MERCHANTIDFORCOLLECTIONS
    AND COLLECTIONID IN (
    SELECT distinct MC.COLLECTIONID
    FROM datatail20130410.dbo.MerchantCollections  MC
        INNER JOIN datatail20130410.dbo.COLLECTIONS C ON C.ID = MC.COLLECTIONID
        INNER JOIN datatail20130410.dbo.collection_product CP ON CP.COLLECTIONID = C.ID
        INNER JOIN datatail20130410.dbo.products P ON P.ID_PRODUCT = CP.PRODUCTID
    WHERE 	MC.MERCHANT_ID =  @MERCHANTIDFORCOLLECTIONS
        AND P.MANUFID IN (1436,3181,3182,3184,4226,4227, 6183)
 )

select *
from companies
where id_cie IN (1436,3181,3182,3184,4226,4227, 6183)

select id_product, catid, manufacturerIdentifier
from products
where manufid =1436 and manufacturerIdentifier is not null
select id_product, manufid, catid, manufacturerIdentifier, active, discontinued
from products
where id_product in ( select id_product
from products
where manufid =1436 and manufacturerIdentifier is not null)


-- ************Brands management************
DECLARE @MerchantIdForBrands AS int = 2312;
DECLARE @BrandsCount AS  int = (
select count(cieId) as total
from datatail20130410.dbo.merchantBrands
where merchant_id = @MerchantIdForBrands
    and cieId in  (3181,3182,3184,4226,4227,6183))

select @BrandsCount

delete top ( @BrandsCount) from  datatail20130410.dbo.merchantBrands
 where merchant_id = @MerchantIdForBrands
    and cieId in  (3181,3182,3184,4226,4227, 6183)

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


select *
from products
where ManufacturerIdentifier = 'D501-02X2'

