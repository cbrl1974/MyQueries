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
	and s.merchantid = 3336
	and m.active = 1
order by s.id

select sm.merchantid, m.merchant, m.active, concat('https://admin.shopify.com/store/', LEFT(ShopUrl, CHARINDEX('.',ShopUrl) - 1), '/apps/shopify-graphiql-app')  AS subdomain, sm.ApiVersion
  from shopify.shopifyMerchants sm
inner join datatail20130410.dbo.merchants m on m.id = sm.MerchantId 
where m.active = 1

select merchantid, ShopUrl, securityStamp from shopify.shopifyMerchants sm where merchantid = 2798


----**************EXPORT STATUS**************
select  me.MerchantId,merchant, me.Status, me.ModificationDate, me.ShopifyMerchantId
from tailbasify.dbo.MerchantExports me WITH (NOLOCK)
    inner join datatail20130410.dbo.merchants m on m.id = me.MerchantId
	--and  me.MerchantId = 3447
order by [Status] desc, me.ModificationDate desc


-- ************* Reset sync status
update MerchantExports
 set [status]  = 1
 where merchantid  = 2798



----**************LOGS**************
select * from logsType

select  distinct  top 20  *  from logs  WITH (NOLOCK) 
where Text like '%Failed%'
order by LogTime desc 

select distinct top 150 text,logtime, category module 
from logs  WITH (NOLOCK) 
WHERE  merchantid = 3336
--and LogTime > convert(date,getdate()-1)
order by LogTime desc 

select  sp.tailbaseid,v.ShopifyProductID, v.SyncStatusId, v.Price, v.ShopifyGeneratedVariantId
from shopify.ShopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
    where sp.MerchantId = 2798
    and sp.TailbaseId in (19295,13902)
    order by v.ShopifyProductID desc


    select id, tailbaseid, SyncStatusId, vendor, ShopifyGeneratedProductId from shopify.shopifyProducts 
    where merchantid = 2798
    and itemtype = 2
    and TailbaseId in (19295,13902)




select sp.merchantid,v.*
from shopify.ShopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid = 1956
and v.ShopifyProductID in (select  id from shopify.shopifyProducts where merchantid = 1956 and itemType = 1)
and v.Options is not null


select * from shopify.shopifyProducts where MerchantId = 1956 and id = 1608503



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
--where h.MerchantId = 1804
    and d.TailbaseId in (789363)
order by h.id desc



--**************SYNC REPORTS**************

select * 
from Shopify.ShopifySyncReports h WITH (NOLOCK)
    join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 3447
    and d.ShopifyProductId in (2414611)
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



--**************PRODUCTS**************
select  *
from shopify.shopifyProducts
where merchantid = 1956
and id in (2024085)


select * 
from Shopify.ShopifySyncReports h WITH (NOLOCK)
    join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 3447
    and d.ShopifyProductId in (2414611)
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
where sp.merchantid = 1448
and m.KeyName = 'VariantGroups'
-- and m.ShopifyProductId in (select id from shopify.shopifyProducts where merchantid = 3447 and itemtype in (1,2))
-- and keyname = 'specs'
-- and m.ShopifyGeneratedMetaFieldId is null
--and keyname like '%media%'
-- and m.SyncStatusId != 4

-- update top (7000) shopify.ShopifyMerchantMetafields
-- set SyncStatusId = 2
-- where id in  (select  m.id from shopify.ShopifyMerchantMetafields m 
-- inner join shopify.shopifyProducts sp on sp.id = m.ShopifyProductId
-- where sp.merchantid = 3447
-- and m.ShopifyProductId in (select id from shopify.shopifyProducts where merchantid = 3447 and itemtype in (1,2))
-- and keyname = 'specs')

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
    where sp.merchantid =  1956
    and v.options is not null
    --where v.ShopifyProductID = 83
--where sp.merchantid != 3470
--and v.ShopifyGeneratedVariantId is null
where v.SyncStatusId is null

update top (90) shopify.ShopifyProductVariants
set SyncStatusId = 1
where ShopifyProductID in (select v.shopifyProductId
from shopify.ShopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
--where sp.merchantid != 3470
--and v.ShopifyGeneratedVariantId is null
where v.SyncStatusId is null)

--and v.Options is not null

delete top (15000) from shopify.ShopifyProductVariants where ShopifyProductID in (select v.ShopifyProductID
from shopify.ShopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid != 3470
and v.ShopifyGeneratedVariantId is null)


select sp.merchantid, sp.id, sp.itemType, v.* from shopify.ShopifyProductVariants v 
join shopify.shopifyProducts sp on sp.id = v.ShopifyProductID
 where v.SyncStatusId is null

update  shopify.ShopifyProductVariants
set SyncStatusId = 1
where SyncStatusId is null

 select * from shopify.shopifyProducts where id = 2318555

--group by v.ShopifyProductID
--having count(v.ShopifyProductID) > 1 
--order by v.ShopifyProductID


select * from shopify.ShopifyProductVariants where ShopifyProductID in (1859650)
select * from shopify.ShopifyMerchantMetafields where ShopifyProductId = 2309058

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

