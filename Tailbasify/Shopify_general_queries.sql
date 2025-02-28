use Tailbasify

--Update = 1
--Convert only = 2 
--Synchronize only = 3

Declare @action as int = 1;

-- Merchants
select
    s.MerchantId, s.id, m.merchant,
	case
	when @action = 1  then 'https://api.tailbasify.com/'+ s.ApiVersion + '/api/Shopify/Update/' + s.SecurityStamp 
	WHEN  @action = 2 then 'https://api.tailbasify.com/'+ s.ApiVersion + '/api/Converter/Convert/' + s.SecurityStamp 
	WHEN  @action = 3 then 'https://api.tailbasify.com/'+ s.ApiVersion + '/api/Synchronizer/Synchronize/' + s.SecurityStamp 
	  END AS EndPoint,
	 s.ShopUrl, s.SecurityStamp, s.AccessToken, ApiKey
from shopify.shopifyMerchants s
    inner join datatail20130410.dbo.merchants m on m.id = s.MerchantId
	and s.merchantid = 3447
	and m.active = 1
order by s.id

select sm.merchantid, m.merchant, m.active, concat('https://admin.shopify.com/store/', LEFT(ShopUrl, CHARINDEX('.',ShopUrl) - 1), '/apps/shopify-graphiql-app')  AS subdomain, sm.ApiVersion
  from shopify.shopifyMerchants sm
inner join datatail20130410.dbo.merchants m on m.id = sm.MerchantId 
where m.active = 1

select * from shopify.shopifyMerchants sm where id = 38


----**************EXPORT STATUS**************
select  me.MerchantId,merchant, me.Status, me.ModificationDate, me.ShopifyMerchantId
from tailbasify.dbo.MerchantExports me WITH (NOLOCK)
    inner join datatail20130410.dbo.merchants m on m.id = me.MerchantId
	--and  me.MerchantId = 3447
order by [Status] desc, me.ModificationDate desc




-- ************* Reset sync status
update MerchantExports
 set [status]  = 1
 where merchantid  = 3447


 select count(productid) from datatail20130410.dbo.merchantProds where merchant_id = 3447

----**************LOGS**************
select * from logsType

select  distinct  top 10  *  from logs  WITH (NOLOCK) 
where Text like '%Failed%'
and LogTime > convert(date,getdate()-5)
order by LogTime desc 

select distinct top 250  text,logtime, category module 
from logs  WITH (NOLOCK) 
WHERE  merchantid = 3447
--and LogTime > convert(date,getdate()-1)
order by LogTime desc 


select sp.merchantid,v.*
from shopify.ShopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid = 3388
and v.ShopifyProductID in (select  id from shopify.shopifyProducts where merchantid = 1956 and itemType = 1)
and v.Options is not null


  select id, tailbaseid, ShopifyGeneratedProductId, handle from  Shopify.ShopifyProducts
    where merchantid = 1448
    and TailbaseId in (739110)  

select ShopifyProductID, ShopifyGeneratedVariantId from Shopify.ShopifyProductVariants where shopifyProductid in (
    select id from  Shopify.ShopifyProducts
    where merchantid = 1448
    and TailbaseId IN (739110)  
)




select distinct top 100 *  from logs  WITH (NOLOCK) 
WHERE  merchantid = 3388--3096--1911 --3242
and category = 'Statistics'
and module = 'Converter'
order by LogTime desc 

select distinct top 50 *  from logs  WITH (NOLOCK) 
WHERE  merchantid = 3388--3096--1911 --3242
and category = 'Statistics'
--and module = 'Synchronizer'
order by LogTime desc 

--**************CONVERT REPORTS**************

select top(10)
    *
from Shopify.ShopifyConvertReports h WITH (NOLOCK)
    join Shopify.ShopifyConvertProductReportsDetail d on h.id = d.ConvertReportId
where h.MerchantId = 3447
    and d.TailbaseId in (654225)
order by h.id desc



--**************SYNC REPORTS**************

select * 
from Shopify.ShopifySyncReports h WITH (NOLOCK)
    join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 3447
    and d.ShopifyProductId in (2456804)
order by h.id desc

select top 50 * from Shopify.ShopifySyncReports h WITH (NOLOCK) where h.MerchantId = 3388 order by h.id desc

 

 --**************COLLECTION REPORTS**************
 select top 10  * from Shopify.ShopifyCollectionSyncReportsDetail 
    where SyncReportId in (select id from Shopify.ShopifySyncReports where merchantid = 1448 and CAST(StartTime AS DATE) = '2024-08-21') 
    and ShopifyCollectionId = 18646 order by id desc; 






--**************DEBUG**************

SELECT TOP 10 * FROM Shopify.ShopifySyncReports WHERE MerchantId = 3447 
and endtime >= getdate()
ORDER BY ID DESC


SELECT * FROM Shopify.ShopifyProducts
WHERE ID IN (SELECT ShopifyProductId FROM Shopify.ShopifyProductSyncReportsDetail 
WHERE SyncReportId IN (2311031))
AND MerchantId = 1202
--AND SyncStatusId IN (2)
--AND ShopifyGeneratedProductId IS NULL

select * from datatail20130410.dbo.merchantcollections where merchant_id = 3388 and collectionID = 6602

delete top (1) from datatail20130410.dbo.merchantcollections where merchant_id = 3388 and collectionID = 6602

--**************PRODUCTS**************
select  *
from shopify.shopifyProducts
where merchantid = 3447
and tailbaseid = 654225


select sp.merchantid,v.*
from shopify.ShopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
    where sp.merchantid =  3447
	and ShopifyProductID = 2456804

--and tailbaseid = 1147394
--and tailbaseid in (256216,256228,256278,256409,256442,256529,256566,256724,256752,256813,256828,256908,256916,256947,256952,256960,256965,262093,263571,265416,265417,267626,267633,268297,268308,273877,299078,299200,299207,340808,340857,341913,341920,342639,342705,342794,351190,351195,351238,371363,412989,513718,529240,529248,581039,583173,583449,583508,583513,583526,622881,622884,636244,636248,636249,636762,636796,636949,636958,636961,682175,682194,682204,710320,710324,724147,751737,755930,758391,758396,772415,785565,785567,792190,792192,813739,816143,816151,816152,820508,820681,829707)

select * 
from Shopify.ShopifySyncReports h WITH (NOLOCK)
    join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 3447
    and d.ShopifyProductId in (2456804)
order by h.id desc




--**************COLLECTIONS**************

select *
FROM shopify.ShopifyMerchantCollections mc
where mc.merchantid = 2795 
--and TitleEn like '%mod%'
order by id desc



--**************METAFIELDS**************

select m.* from shopify.ShopifyMerchantMetafields m 
inner join shopify.shopifyProducts sp on sp.id = m.ShopifyProductId
where sp.merchantid = 2456
and keyname like '%rebate%'
and m.ShopifyProductId in (686691,686692)
-- and keyname = 'specs'
-- and m.ShopifyGeneratedMetaFieldId is null
--and keyname like '%media%'
-- and m.SyncStatusId != 4

update top (380) shopify.ShopifyMerchantMetafields
set SyncStatusId = 2
where id in  (select m.id from shopify.ShopifyMerchantMetafields m 
inner join shopify.shopifyProducts sp on sp.id = m.ShopifyProductId
where sp.merchantid = 2456
and m.ShopifyProductId in (select id from shopify.shopifyProducts where merchantid = 2456 and SyncStatusId =2))

select distinct keyname from shopify.ShopifyMerchantMetafields m 




--**************MEDIA**************

select m.*
    from Shopify.ShopifyProductMedia m
	inner join shopify.shopifyProducts sp on sp.id = m.ShopifyProductId
    where m.tailbaseid = 43889
    and m.MediaContentTypeId = 1
    order by m.tailbaseid
where sp.merchantid = 571
and m.ShopifyProductId in (select  id from shopify.shopifyProducts where merchantid = 571 and SyncStatusId =2)
and m.MediaContentTypeId = 1
--and m.SyncStatusId != 4
order by m.MediaContentTypeId,m.tailbaseid, m.DisplayOrder

--update top (7) Shopify.ShopifyProductMedia
--set SyncStatusId = 1,
--ShopifyGeneratedMediaId = null
--where ShopifyProductId in (select id
--from shopify.shopifyProducts
--where merchantid = 3388
--and SyncStatusId != 4)





--**************VARIANTS**************

select sp.merchantid,v.*
from shopify.ShopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
    where sp.merchantid =  3388
    --where v.ShopifyProductID = 83
--where sp.merchantid != 3470
and v.ShopifyGeneratedVariantId is null
--and v.SyncStatusId is null

update top (90) shopify.ShopifyProductVariants
set SyncStatusId = 1
where ShopifyProductID in (select v.shopifyProductId
from shopify.ShopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid = 3388
and v.ShopifyGeneratedVariantId is null
--and v.SyncStatusId is null
)



select sp.merchantid, sp.id, sp.itemType, v.* from shopify.ShopifyProductVariants v 
join shopify.shopifyProducts sp on sp.id = v.ShopifyProductID
 where v.ShopifyGeneratedVariantId is null 
 and sp.merchantid = 3388

select collectionid, count(collectionID) from datatail20130410.dbo.merchantCollections where merchant_id = 3470 
group by collectionid
having count(collectionID) > 1

select productid, count(productid) from datatail20130410.dbo.merchantProds where merchant_id =3470 
group by productid
having count(productid) > 1

delete  shopify.ShopifyProductVariants where id  in (select v.id
from shopify.ShopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid = 3470
and v.ShopifyGeneratedVariantId is null)




-- delete top (17398) from shopify.ShopifyProductVariants
-- where id in (select v.id
-- from shopify.ShopifyProductVariants v
-- 	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
-- where sp.merchantid = 2339
-- and v.ShopifyProductID in (select  id from shopify.shopifyProducts where merchantid = 2339 and SyncStatusId =2)
-- and v.ShopifyGeneratedVariantId is null)


--**************SyncStatus**************

select *
from SyncStatus



--Convert STATUS:
-- ConvertedOnly = 1,
-- ConvertedAndCompared = 2,
-- ConversionFailed = 3,
-- ConversionSuccess = 4

-- Sync Status:
-- 1	Insert
-- 2	Update
-- 3	Delete
-- 4	Synced
-- 5	DeleteSynced


--Translation Status
    -- Translate = 1
    -- Translated = 2
    -- None = 3

