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
	and s.merchantid = 3227
	and m.active = 1
order by s.id

select sm.merchantid, m.merchant, m.active, concat('https://admin.shopify.com/store/', LEFT(ShopUrl, CHARINDEX('.',ShopUrl) - 1), '/apps/shopify-graphiql-app')  AS subdomain, sm.ApiVersion
  from shopify.shopifyMerchants sm
inner joindatatail20130410.dbo.merchants m on m.id = sm.MerchantId 
where m.active = 1

select * from shopify.shopifyMerchants  where merchantid = 3558



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
 where merchantid  = 3242
 
----**************LOGS**************
select * from logsType

select  distinct  *  from logs  WITH (NOLOCK) 
where Text like '%Failed%'
and LogTime > convert(date,getdate()-1)
and MerchantID != 3209
order by LogTime desc 



select distinct   text,logtime, category module 
from logs  WITH (NOLOCK) 
WHERE  merchantid = 3039
and LogTime > convert(date,getdate()-1)
order by LogTime desc 



select distinct top 100 *  from logs  WITH (NOLOCK) 
WHERE  merchantid = 3096--3096--1911 --3242
and category = 'Statistics'
and module = 'Converter'
order by LogTime desc 

select distinct top 50 *  from logs  WITH (NOLOCK) 
WHERE  merchantid = 3096--3096--1911 --3242
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
select * from shopify.ShopifyProducts where id = 2742242


select * 
from Shopify.ShopifySyncReports h WITH (NOLOCK)
    join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
    where d.ShopifyProductId in (2322315)
order by h.id desc

 --

 --**************COLLECTION REPORTS**************
 select top 10  * from Shopify.ShopifyCollectionSyncReportsDetail 
    where SyncReportId in (select id from Shopify.ShopifySyncReports where merchantid = 3096 and CAST(StartTime AS DATE) = '2024-08-21') 
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

select * from datatail20130410.dbo.merchantcollections where merchant_id = 3096 and collectionID = 6602

select * from shopify.ShopifyProducts where MerchantId = 2724 and TailbaseId = 796174

--**************PRODUCTS**************
select  
merchantid,id, vendor, tailbaseid, handle, syncstatusid, TemplateSuffix, ShopifyGeneratedProductId
from shopify.shopifyProducts
where merchantid = 3558
and TailbaseId = 806437



select m.* from shopify.ShopifyMerchantMetafields m 
inner join shopify.shopifyProducts sp on sp.id = m.ShopifyProductId
where 1= 1
and sp.merchantid = 3065
and keyname = 'QuantitiesInFeeds'
--and keyname like '%feed%'
and m.ShopifyProductId in (2767726)



--update top (1) shopify.ShopifyMerchantMetafields
--set SyncStatusId = 2
--where ShopifyProductId in (2313689)

--update top (1) shopify.ShopifyProducts
--set SyncStatusId = 2
--where id in (2313689)



select sp.merchantid,
--v.sku, v.Price, v.CompareAtPrice, mp.price, mp.reducedPrice,
v.*
from shopify.ShopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
	inner join datatail20130410.dbo.Merchantprods mp on  mp.productid =sp.tailbaseid and mp.merchant_id = sp.merchantid
    where sp.merchantid =  3096
	--and ShopifyProductID in (695752 ,695749,695750,695751)
	and sp.tailbaseid in (635315)




--**************COLLECTIONS**************

select *
FROM shopify.ShopifyMerchantCollections mc
where mc.merchantid = 3096 
and syncstatusid <> 6
--and TitleEn like '%mod%'
order by id desc




--**************METAFIELDS**************

select top 250 m.* from shopify.ShopifyMerchantMetafields m 
inner join shopify.shopifyProducts sp on sp.id = m.ShopifyProductId
where 1= 1
and m.ShopifyProductId in (2313689)

--update top (1) shopify.ShopifyMerchantMetafields
--set SyncStatusId = 2
--where ShopifyProductId in (2313689)

--update top (1) shopify.ShopifyProducts
--set SyncStatusId = 2
--where id in (2313689)



select distinct keyname from shopify.ShopifyMerchantMetafields m 




--**************MEDIA**************

select  sp.id, sp.MerchantId, sp.handle, sp.tailbaseid, sp.SyncStatusId, m.Id, m.OriginalSource, m.SyncStatusId
    from Shopify.ShopifyProductMedia m
	inner join shopify.shopifyProducts sp on sp.id = m.ShopifyProductId
	where sp.MerchantId  = 3096
and m.ShopifyProductId in (select  id from shopify.shopifyProducts where merchantid = 3096 and SyncStatusId =2)
--and sp.MerchantId  = 3096
order by m.MediaContentTypeId,m.tailbaseid, m.DisplayOrder

--update top (7) Shopify.ShopifyProductMedia
--set SyncStatusId = 1,
--ShopifyGeneratedMediaId = null
--where ShopifyProductId in (select id
--from shopify.shopifyProducts
--where merchantid = 3096
--and SyncStatusId != 4)





--**************VARIANTS**************

select sp.merchantid,v.*
from shopify.ShopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
    where sp.merchantid =  3096
	and 
    --where v.ShopifyProductID = 83
--where sp.merchantid != 3470
and v.ShopifyGeneratedVariantId is null
--and v.SyncStatusId is null




select sp.merchantid, sp.id, sp.tailbaseid, sp.handle, sp.itemType, v.* from shopify.ShopifyProductVariants v 
join shopify.shopifyProducts sp on sp.id = v.ShopifyProductID
inner joindatatail20130410.dbo.merchantprods
 where sp.merchantid = 2724
 and sp.id = 1775033

 






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
