use Tailbasify

--Update = 1
--Convert only = 2 
--Synchronize only = 3

Declare @action as int = 3;

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
	and s.merchantid = 1956 --3374
	--and s.ApiVersion = 'v2'
	and m.active = 1
order by s.id

select * from shopify.shopifyMerchants where merchantid = 3209

--===============================================================================================

update MerchantExports
 set [status]  = 1
 where merchantid  = 1956
  --where [status] <> 1

--===============================================================================================

----**************EXPORT STATUS**************
select  me.MerchantId,merchant, me.Status, me.ModificationDate, me.ShopifyMerchantId
from MerchantExports me WITH (NOLOCK)
    inner join datatail20130410.dbo.merchants m on m.id = me.MerchantId
order by [Status] desc, me.ModificationDate desc

--===============================================================================================

----**************LOGS**************
select  distinct top 100 *  from logs  WITH (NOLOCK) 
order by LogTime desc 

select distinct top 10 *  from logs  WITH (NOLOCK) 
WHERE  merchantid = 1956
and LogTime > convert(date,getdate()-1)
--and logtime between '2024-02-10' and '2024-02-11'
--and text like '%Failed Convert for 3477%'
order by LogTime desc 

select distinct top 10 *  from logs  WITH (NOLOCK) 
WHERE  merchantid = 3405--3096--1911 --3242
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

select count(1) from datatail20130410.dbo.MerchantProds where Merchant_ID = 3477 --29127
select count(1) from datatail20130410.dbo.MerchantCollections where Merchant_ID = 571 --2094
select count(1) from datatail20130410.dbo.MerchantRebates where Merchant_ID = 1477 and active = 1 --68
select count(1) from datatail20130410.dbo.MerchantINstallations where MerchantID = 571 --2
select count(1) from datatail20130410.dbo.MerchantWarranties where MerchantID = 571 --1
select * from datatail20130410.dbo.MerchantRebates where Merchant_ID = 3209 and active = 1  and id_rebate = 1121453
and DisplayEndDate >= GETDATE() --68
select * from datatail20130410.dbo.MerchantRebateProducts where rebateid in (1121453) order by productid --68 


bosch-achetez-plus-economisez-plus-de-bosch
select * from datatail20130410.dbo.products where id_product = 789636 
select * from datatail20130410.dbo.merchantprods where merchant_id = 3405 and productid = 789636
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
where h.MerchantId = 1956
    and d.TailbaseId in (789363)
order by h.id desc

--===============================================================================================

--**************SYNC REPORTS**************

select top 100 *    
from Shopify.ShopifySyncReports h WITH (NOLOCK)
    join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 2339
--where text like '%video%'
    and d.ShopifyProductId in (1680643)
order by h.id desc

--===============================================================================================

--**************DEBUG**************

SELECT TOP 40 * FROM Shopify.ShopifySyncReports WHERE MerchantId = 1956 
and endtime >= getdate()
ORDER BY ID DESC


SELECT * FROM Shopify.ShopifyProducts
WHERE ID IN (SELECT ShopifyProductId FROM Shopify.ShopifyProductSyncReportsDetail 
WHERE SyncReportId IN (61536))
AND MerchantId = 3209
--AND SyncStatusId IN (2)
--AND ShopifyGeneratedProductId IS NULL


--===============================================================================================
--update top (2) shopify.shopifyProducts
--set SyncStatusId = 2
--where merchantid = 2569
--and tailbaseid in (771517,771514)


--**************PRODUCTS**************
select  *
from shopify.shopifyProducts
where merchantid = 1956
and id = 1685902
--and tailbaseid = 792599
--and itemtype = 1 --products
--and ShopifyGeneratedProductId is not null
--and itemtype = 2 --bundles(Collections)
--and itemtype = 3 --rebates
--and itemtype = 4 --Warranty
--and itemtype = 5 --installation
--and tailbaseid in (771517,771514)
--and handle = 'amana-44cuft-top-load-washer-ntw4519jw'
--and id in (1089844)


--===============================================================================================

--**************COLLECTIONS**************

select *
FROM shopify.ShopifyMerchantCollections mc
inner join shopify.shopifyProducts sp on sp.TailbaseId = mc.TailbaseId
where mc.merchantid = 1956 
and mc.TailbaseId = 1121300
--and sp.TitleEn like '%rebates%'

--and sp.id in (select  id
--from shopify.shopifyProducts
--where merchantid = 3388
--	and syncStatusID != 4)
--and mc.SyncStatusId != 4


--===============================================================================================
--**************METAFIELDS**************

select  m.* from shopify.ShopifyMerchantMetafields m
inner join shopify.shopifyProducts sp on sp.id = m.ShopifyProductId
where sp.merchantid = 1956
and m.ShopifyProductId = 1685902
--and m.ShopifyProductId in (select id from shopify.shopifyProducts where MerchantId = 1958)
--and m.SyncStatusId != 4
--and keyname = 'VariantGroups'

--update top (1) shopify.ShopifyMerchantMetafields
--set SyncStatusId = 3
--where shopifyProductID = 1685902
--and keyname = 'ProductsInRebate' 



--===============================================================================================

--**************MEDIA**************

select m.*
    from Shopify.ShopifyProductMedia m
	inner join shopify.shopifyProducts sp on sp.id = m.ShopifyProductId
where sp.merchantid = 1190
and m.ShopifyProductId in (1408487
)
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

select v.*
from shopify.ShopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid = 1958
and v.ShopifyProductID in (select id from shopify.shopifyProducts where MerchantId = 1958
)
--and v.SyncStatusId != 4

--update top (1) shopify.ShopifyProductVariants
--set syncStatusID = 2
--where shopifyProductid = 1408487



select top 1000 p.* from shopify.shopifyProducts p
--inner join shopify.shopifyMerchants m on m.id = p.merchantID
where p.id  in (select shopifyProductID
from shopify.ShopifyProductVariants  where price = 0 and SyncStatusId = 4)
and p.merchantid != 3497
order by p.merchantid desc
--and m.ApiVersion = 'v2'



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

