--Update = 1
--Convert = 2 
--Synchronize = 3

Declare @action as int = 3;

-- Merchants
select
    s.MerchantId,
	case
	when @action = 1  then 'https://api.tailbasify.com/'+ s.ApiVersion + '/api/Shopify/Update/' + s.SecurityStamp 
	WHEN  @action = 2 then 'https://api.tailbasify.com/'+ s.ApiVersion + '/api/Converter/Convert/' + s.SecurityStamp 
	WHEN  @action = 3 then 'https://api.tailbasify.com/'+ s.ApiVersion + '/api/Synchronizer/Synchronize/' + s.SecurityStamp 
	  END AS EndPoint,
	s.id, m.merchant, s.ShopUrl, s.SecurityStamp
from shopify.shopifyMerchants s
    inner join datatail20130410.dbo.merchants m on m.id = s.MerchantId
order by m.id


--===============================================================================================

update MerchantExports
 set [status]  = 1
 where merchantid  = 1911
  --where [status] <> 1

--===============================================================================================

----**************EXPORT STATUS**************
use Tailbasify

select m.merchant, me.*
from MerchantExports me WITH (NOLOCK)
    inner join datatail20130410.dbo.merchants m on m.id = me.MerchantId
order by [Status] desc, ModificationDate desc

--===============================================================================================

----**************LOGS**************
select  distinct top 100 *  from logs  WITH (NOLOCK) 
order by LogTime desc 

select  distinct top 100 *  from logs  WITH (NOLOCK) 
WHERE  merchantid = 1911 
order by LogTime desc 

--===============================================================================================

--**************DB STATS**************

select count(1) from datatail20130410.dbo.MerchantProds where Merchant_ID = 1448 --29127
select count(1) from datatail20130410.dbo.MerchantCollections where Merchant_ID = 1911 --2094
select count(1) from datatail20130410.dbo.MerchantRebates where Merchant_ID = 1911 and active = 1 --68
select count(1) from datatail20130410.dbo.MerchantINstallations where MerchantID = 1911 --2
select count(1) from datatail20130410.dbo.MerchantWarranties where MerchantID = 1911 --1
select * from datatail20130410.dbo.MerchantRebates where Merchant_ID = 1911 and active = 1 and DisplayEndDate >= GETDATE() --68
--total of 31292




--===============================================================================================

--**************CONVERT REPORTS**************

select top(10)
    *
from Shopify.ShopifyConvertReports h WITH (NOLOCK)
    join Shopify.ShopifyConvertProductReportsDetail d on h.id = d.ConvertReportId
where h.MerchantId = 1911
    and d.TailbaseId in (489477)
order by h.id desc





--===============================================================================================

--**************SYNC REPORTS**************

select top 10 *    
from Shopify.ShopifySyncReports h WITH (NOLOCK)
    join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 1911
--and GraphQLCallInfo is not null
    and d.ShopifyProductId in (509029)
order by h.id desc


--===============================================================================================

--**************DEBUG**************

SELECT TOP 20 * FROM Shopify.ShopifySyncReports WHERE MerchantId = 1911 ORDER BY ID DESC


SELECT * FROM Shopify.ShopifyProducts
WHERE ID IN (SELECT ShopifyProductId FROM Shopify.ShopifyProductSyncReportsDetail WHERE SyncReportId IN (321658))
AND MerchantId = 1911
AND SyncStatusId IN (1)
AND ShopifyGeneratedProductId IS NULL



select * from datatail20130410.dbo.merchantProds where merchant_id = 1911 and productid in (
select tailbaseid
from shopify.shopifyProducts
where merchantid = 1911
	and syncStatusID = 1
	and itemtype = 1 
)





--===============================================================================================

--**************PRODUCTS**************
select *
from shopify.shopifyProducts
where merchantid = 1911
	--and syncStatusID = 2
	--and itemtype = 1 
	--and itemtype = 2 
	--and itemtype = 3 
	--and itemtype = 4 
	--and itemtype = 5 
	and tailbaseid in (489477)
	--and handle = 'amana-44cuft-top-load-washer-ntw4519jw'
	--and id in (1089844)


--===============================================================================================

--**************COLLECTIONS**************

select *
FROM shopify.ShopifyMerchantCollections mc
inner join shopify.shopifyProducts sp on sp.TailbaseId = mc.TailbaseId
where mc.merchantid = 1911 
and mc.TailbaseId = 489477
--and sp.SyncStatusId = 2





--===============================================================================================
--**************METAFIELDS**************

select  m.* from shopify.ShopifyMerchantMetafields m
inner join shopify.shopifyProducts sp on sp.id = m.ShopifyProductId
where sp.merchantid = 1911
and m.ShopifyProductId = 1247362
--and sp.SyncStatusId = 2


--===============================================================================================

--**************MEDIA**************

select m.*
    from Shopify.ShopifyProductMedia m
	inner join shopify.shopifyProducts sp on sp.id = m.ShopifyProductId
where sp.merchantid = 1911
and m.SyncStatusId <> 4
order by m.MediaContentTypeId,m.tailbaseid, m.DisplayOrder

select * from shopify.shopifyproducts where id in (511641,611642)


select * from shopify.shopifyProducts where MerchantId  = 1911 and tailbaseid = 489477
select * from shopify.shopifyProducts where  id = 510379
select * from datatail20130410.dbo.merchantProds where merchant_id =  1911 and productid = 489477


--===============================================================================================

--**************VARIANTS**************

select v.*
from shopify.ShopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid = 1911
and v.ShopifyProductID = 510379



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

