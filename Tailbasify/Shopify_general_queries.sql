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
	and s.merchantid = 3527
	and m.active = 1
order by s.id

select sm.merchantid, m.merchant, m.active, concat('https://admin.shopify.com/store/', LEFT(ShopUrl, CHARINDEX('.',ShopUrl) - 1), '/apps/shopify-graphiql-app')  AS subdomain, sm.ApiVersion
  from shopify.shopifyMerchants sm
inner join datatail20130410.dbo.merchants m on m.id = sm.MerchantId 
where m.active = 1


--===============================================================================================

----**************EXPORT STATUS**************
select  me.MerchantId,merchant, me.Status, me.ModificationDate, me.ShopifyMerchantId
from MerchantExports me WITH (NOLOCK)
    inner join datatail20130410.dbo.merchants m on m.id = me.MerchantId
	--and  me.MerchantId = 3544
order by [Status] desc, me.ModificationDate desc

-- ************* Reset sync status
update MerchantExports
 set [status]  = 1
 where merchantid  = 3527


--===============================================================================================

----**************LOGS**************
select * from logsType

select  distinct top 500 *  from logs  WITH (NOLOCK) 
order by LogTime desc 

select distinct top 100 *  from logs  WITH (NOLOCK) 
WHERE  merchantid = 3374
and LogTime > convert(date,getdate()-1)
order by LogTime desc 

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


--===============================================================================================

--**************DB STATS**************

select count(1) from datatail20130410.dbo.MerchantProds where Merchant_ID = 3547 --29127
select count(1) from datatail20130410.dbo.MerchantCollections where Merchant_ID = 3547 --2094
select count(1) from datatail20130410.dbo.MerchantRebates where Merchant_ID = 3547 and active = 1 --68
select count(1) from datatail20130410.dbo.MerchantINstallations where MerchantID = 3388 --2
select count(1) from datatail20130410.dbo.MerchantWarranties where MerchantID = 3388 --1
select * from datatail20130410.dbo.MerchantRebates where Merchant_ID = 3209 and active = 1  and id_rebate = 1121453
and DisplayEndDate >= GETDATE() --68
select * from datatail20130410.dbo.MerchantRebateProducts where rebateid in (1121453) order by productid --68 

select * from datatail20130410.dbo.MerchantProds where Merchant_ID = 2339 and productid = 641603



select * from datatail20130410.dbo.products where id_product = 3547 
select * from datatail20130410.dbo.merchantprods where merchant_id = 3406 and productid = 789636
select * from shopify.shopifyProducts where merchantid = 3405 and tailbaseid = 789636
select * from datatail20130410.dbo.variantProducts where variantid = 135262
select  * from datatail20130410.dbo.VariantSpecs where variantid = 90137
select  top 10 * from datatail20130410.dbo.variants 
select * from datatail20130410.dbo.specsProd where productid = 789363 order by specID
select * from datatail20130410.dbo.specs where catid = 41
select * from datatail20130410.dbo.categories where id_langue = 1 and id_category = 41

--**************CONVERT REPORTS**************

select top(10)
    *
from Shopify.ShopifyConvertReports h WITH (NOLOCK)
    join Shopify.ShopifyConvertProductReportsDetail d on h.id = d.ConvertReportId
--where h.MerchantId = 1804
    and d.TailbaseId in (789363)
order by h.id desc

--===============================================================================================

--**************SYNC REPORTS**************

select * 
from Shopify.ShopifySyncReports h WITH (NOLOCK)
    join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 3478
--and text like '%error%'
    and d.ShopifyProductId in (1757720)
order by h.id desc

select top 50 * from Shopify.ShopifySyncReports h WITH (NOLOCK) where h.MerchantId = 3388 order by h.id desc




--===============================================================================================

--**************DEBUG**************

SELECT TOP 10 * FROM Shopify.ShopifySyncReports WHERE MerchantId = 3447 
and endtime >= getdate()
ORDER BY ID DESC


SELECT * FROM Shopify.ShopifyProducts
WHERE ID IN (SELECT ShopifyProductId FROM Shopify.ShopifyProductSyncReportsDetail 
WHERE SyncReportId IN (1404544))
AND MerchantId = 3478
--AND SyncStatusId IN (2)
--AND ShopifyGeneratedProductId IS NULL


--===============================================================================================
select * from datatail20130410.dbo.MerchantProds where Merchant_ID = 3478 and productid = 642319


--**************PRODUCTS**************
select  id, tailbaseid, handle, SyncStatusId
from shopify.shopifyProducts
where merchantid = 3527
and itemtype = 1



--===============================================================================================

--**************COLLECTIONS**************

select *
FROM shopify.ShopifyMerchantCollections mc
where mc.merchantid = 1448 
order by id desc

select * from datatail20130410.dbo.companies where cie like '%canadel%'
select * from datatail20130410.dbo.countries  where langid = 1 order by country


select distinct co.id_cie, co.cie
from datatail20130410.dbo.products p
inner join datatail20130410.dbo.companies co on co.id_cie = p.manufid
where p.catID = 315

select top 10 * from shopify.ShopifyCollectionSyncReportsDetail
where ShopifyCollectionID = 285729
order by id desc



--===============================================================================================
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



--===============================================================================================

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




--===============================================================================================

--**************VARIANTS**************

select v.ShopifyProductID, v.Price, v.CompareAtPrice, v.Cost, mp.cost as costFromMerchantProds, v.SyncStatusId
from shopify.ShopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
    inner join DevTailbaseCore.dbo.merchantProds mp on mp.merchant_id = sp.MerchantId and mp.ProductID = sp.TailbaseId
where sp.merchantid = 2798
and v.ShopifyProductID in (select  id from shopify.shopifyProducts where merchantid = 2798 and itemType = 1)
and v.ShopifyGeneratedVariantId is not null
order by v.cost desc

-- delete top (17398) from shopify.ShopifyProductVariants
-- where id in (select v.id
-- from shopify.ShopifyProductVariants v
-- 	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
-- where sp.merchantid = 2339
-- and v.ShopifyProductID in (select  id from shopify.shopifyProducts where merchantid = 2339 and SyncStatusId =2)
-- and v.ShopifyGeneratedVariantId is null)

--===============================================================================================

--**************SyncStatus**************

select *
from SyncStatus

--===============================================================================================

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

