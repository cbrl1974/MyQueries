use tailbasify

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
	and s.merchantid = 2798
	and m.active = 1
order by s.id

select sm.merchantid, m.merchant, m.active, concat('https://admin.shopify.com/store/', LEFT(ShopUrl, CHARINDEX('.',ShopUrl) - 1), '/apps/shopify-graphiql-app')  AS subdomain, sm.ApiVersion
  from shopify.shopifyMerchants sm
inner joindatatail20130410.dbo.merchants m on m.id = sm.MerchantId 
where m.active = 1

select * from shopify.shopifyMerchants  where merchantid = 3477



----**************EXPORT STATUS**************
select  me.MerchantId,merchant, me.Status, me.ModificationDate, me.ShopifyMerchantId
from tailbasify.dbo.MerchantExports me WITH (NOLOCK)
    inner join datatail20130410.dbo.merchants m on m.id = me.MerchantId
	inner join tailbasify.shopify.ShopifyMerchants sm on sm.MerchantId = me.MerchantId
	--and  me.MerchantId = 1956
	and sm.ApiVersion is not null
order by [Status] desc, me.ModificationDate desc


-- ************* Reset sync status
update MerchantExports
 set [status]  = 1
 where merchantid  = 2798


 select count(productid) fromdatatail20130410.dbo.merchantProds where merchant_id = 1956

----**************LOGS**************
select * from logsType

select  distinct  *  from logs  WITH (NOLOCK) 
where Text like '%Failed%'
and LogTime > convert(date,getdate()-5)
order by LogTime desc 

select distinct   text,logtime, category module 
from logs  WITH (NOLOCK) 
WHERE  merchantid = 3477
and LogTime > convert(date,getdate()-1)
order by LogTime desc 

select sp.MerchantId, sp.id, sp.tailbaseid, sp.handle, sp.SyncStatusId, 
m.Sku, m.Price, m.CompareAtPrice, m.SyncStatusId, m.ShopifyGeneratedVariantId, m.InventoryLevel 
from shopify.ShopifyProductVariants m 
inner join shopify.shopifyProducts sp on sp.id = m.ShopifyProductId
inner join shopify.shopifymerchants sm on sm.MerchantId = sp.MerchantId
inner join datatail20130410.dbo.merchants me on me.id = sm.merchantid
where 1= 1
and m.SyncStatusId = 2
and me.active = 1
and me.id = 3477
order by sp.merchantid
--115

update shopify.shopifyProducts
set syncstatusid = 2 
where id in (select shopifyProductid from shopify.ShopifyProductVariants where SyncStatusId =2)
and MerchantId = 2798



update top (50) shopify.shopifyProducts
set SyncStatusId = 2
where id in (select shopifyProductid from shopify.ShopifyMerchantMetafields where SyncStatusId = 3)
and merchantid = 3470



select distinct top 100 *  from logs  WITH (NOLOCK) 
WHERE  merchantid = 3477--3096--1911 --3242
and category = 'Statistics'
and module = 'Converter'
order by LogTime desc 

select distinct top 50 *  from logs  WITH (NOLOCK) 
WHERE  merchantid = 3477--3096--1911 --3242
and category = 'Statistics'
--and module = 'Synchronizer'
order by LogTime desc 

--**************CONVERT REPORTS**************

select top(10)
    *
from Shopify.ShopifyConvertReports h WITH (NOLOCK)
    join Shopify.ShopifyConvertProductReportsDetail d on h.id = d.ConvertReportId
where h.MerchantId = 3447
    and d.TailbaseId in (33010)
order by h.id desc



--**************SYNC REPORTS**************

select * 
from Shopify.ShopifySyncReports h WITH (NOLOCK)
    join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
    where d.ShopifyProductId in (1852198)
order by h.id desc

select top 50 * from Shopify.ShopifySyncReports h WITH (NOLOCK) where h.MerchantId = 3477 order by h.id desc

 

 --**************COLLECTION REPORTS**************
 select top 10  * from Shopify.ShopifyCollectionSyncReportsDetail 
    where SyncReportId in (select id from Shopify.ShopifySyncReports where merchantid = 3477 and CAST(StartTime AS DATE) = '2024-08-21') 
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

select * fromdatatail20130410.dbo.merchantcollections where merchant_id = 3477 and collectionID = 6602

select * from shopify.ShopifyProducts where MerchantId = 2724 and TailbaseId = 796174

--**************PRODUCTS**************
select  merchantid,id, vendor, tailbaseid, handle, syncstatusid
from shopify.shopifyProducts
where merchantid = 3509
and tailbaseid = 33010


select * fromdatatail20130410.dbo.MerchantProducts_ChangeTracking where MerchantId = 3497 and ProductId = 503918



select sp.merchantid,v.*
from shopify.ShopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
    where sp.merchantid =  3497
	and ShopifyProductID = 2068452



	--update top (1) shopify.ShopifyProductVariants
	--set SyncStatusId = 1
	--where ShopifyProductID = 2634605

select * 
from Shopify.ShopifySyncReports h WITH (NOLOCK)
    join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 3477
    and d.ShopifyProductId in (1122460)
order by h.id desc




--**************COLLECTIONS**************

select *
FROM shopify.ShopifyMerchantCollections mc
where mc.merchantid = 3509 
and syncstatusid <> 6
--and TitleEn like '%mod%'
order by id desc




--**************METAFIELDS**************

select top 250 m.* from shopify.ShopifyMerchantMetafields m 
inner join shopify.shopifyProducts sp on sp.id = m.ShopifyProductId
where 1= 1
--and sp.merchantid = 2456
and keyname like '%associated%'
--and keyname like '%rebate%'
and m.ShopifyProductId in (686691,686692)
-- and keyname = 'specs'
-- and m.ShopifyGeneratedMetaFieldId is null
--and keyname like '%media%'
-- and m.SyncStatusId != 4



select distinct keyname from shopify.ShopifyMerchantMetafields m 




--**************MEDIA**************

select  sp.id, sp.MerchantId, sp.handle, sp.tailbaseid, sp.SyncStatusId, m.Id, m.OriginalSource, m.SyncStatusId
    from Shopify.ShopifyProductMedia m
	inner join shopify.shopifyProducts sp on sp.id = m.ShopifyProductId
	where sp.MerchantId  = 3477
and m.ShopifyProductId in (select  id from shopify.shopifyProducts where merchantid = 3477 and SyncStatusId =2)
--and sp.MerchantId  = 3477
order by m.MediaContentTypeId,m.tailbaseid, m.DisplayOrder

--update top (7) Shopify.ShopifyProductMedia
--set SyncStatusId = 1,
--ShopifyGeneratedMediaId = null
--where ShopifyProductId in (select id
--from shopify.shopifyProducts
--where merchantid = 3477
--and SyncStatusId != 4)





--**************VARIANTS**************

select sp.merchantid,v.*
from shopify.ShopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
    where sp.merchantid =  3477
	and 
    --where v.ShopifyProductID = 83
--where sp.merchantid != 3470
and v.ShopifyGeneratedVariantId is null
--and v.SyncStatusId is null

796174


select sp.merchantid, sp.id, sp.tailbaseid, sp.handle, sp.itemType, v.* from shopify.ShopifyProductVariants v 
join shopify.shopifyProducts sp on sp.id = v.ShopifyProductID
inner joindatatail20130410.dbo.merchantprods
 where sp.merchantid = 2724
 and sp.id = 1775033

 select * fromdatatail20130410.dbo.merchantprods where merchant_id = 2724 and ProductID =796174
 






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

	select spsr.id, spsr.syncreportid, spsr.shopifyproductid, spsr.Operation, spsr.[Status], spsr.text, ssr.StartTime, spsr.graphqlcallinfo
    from Shopify.ShopifyProductSyncReportsDetail spsr with (nolock)
    join Shopify.ShopifySyncReports ssr on ssr.id = spsr.syncreportid
    where ssr.merchantid = 1175 and CAST(ssr.StartTime AS DATE) = '2025-03-31'
    and spsr.ShopifyProductId in (1109674)
    order by spsr.id desc;