--Update = 1
--Synchronize = 3

Declare @action as int = 1;

-- Merchants
select
    s.MerchantId,
	case
	when @action = 1  then 'https://api.tailbasify.com/'+ s.ApiVersion + '/api/Shopify/Update/' + s.SecurityStamp 
	WHEN  @action = 2 then 'https://api.tailbasify.com/'+ s.ApiVersion + '/api/Converter/Convert/' + s.SecurityStamp 
	WHEN  @action = 3 then 'https://api.tailbasify.com/'+ s.ApiVersion + '/api/Synchronizer/Synchronize/' + s.SecurityStamp 
	  END AS EndPoint,
	s.id, m.merchant, s.ShopUrl, s.SecurityStamp, s.AccessToken, ApiKey
from shopify.shopifyMerchants s
    inner join datatail20130410.dbo.merchants m on m.id = s.MerchantId
	and s.MerchantId = 571
order by m.id

select * from shopify.shopifyMerchants where merchantid = 2798
select * from shopify.shopifyMerchants where merchantid = 2232



--===============================================================================================

update MerchantExports
 set [status]  = 1
 where merchantid  = 2186
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
WHERE  merchantid = 571
order by LogTime desc 

--===============================================================================================

--**************DB STATS**************

select count(1) from datatail20130410.dbo.MerchantProds where Merchant_ID = 571 --29127
select count(1) from datatail20130410.dbo.MerchantCollections where Merchant_ID = 571 --2094
select count(1) from datatail20130410.dbo.MerchantRebates where Merchant_ID = 571 and active = 1 --68
select count(1) from datatail20130410.dbo.MerchantINstallations where MerchantID = 571 --2
select count(1) from datatail20130410.dbo.MerchantWarranties where MerchantID = 571 --1
select * from datatail20130410.dbo.MerchantRebates where Merchant_ID = 571 and active = 1 and DisplayEndDate >= GETDATE() --68
--total of 31292






--===============================================================================================

--**************CONVERT REPORTS**************

select top(10)
    *
from Shopify.ShopifyConvertReports h WITH (NOLOCK)
    join Shopify.ShopifyConvertProductReportsDetail d on h.id = d.ConvertReportId
where h.MerchantId = 571
    and d.TailbaseId in (489477)
order by h.id desc





--===============================================================================================

--**************SYNC REPORTS**************

select top 100 *    
from Shopify.ShopifySyncReports h WITH (NOLOCK)
    join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 3478
--and text = 'User Errors Detected - Media User Error'
    and d.ShopifyProductId in (1408445)
order by h.id desc


--===============================================================================================

--**************DEBUG**************

SELECT TOP 20 * FROM Shopify.ShopifySyncReports WHERE MerchantId = 571 ORDER BY ID DESC


SELECT * FROM Shopify.ShopifyProducts
WHERE ID IN (SELECT ShopifyProductId FROM Shopify.ShopifyProductSyncReportsDetail WHERE SyncReportId IN (321658))
AND MerchantId = 571
AND SyncStatusId IN (1)
AND ShopifyGeneratedProductId IS NULL



select * from datatail20130410.dbo.merchantProds where merchant_id = 571 and productid in (
select tailbaseid
from shopify.shopifyProducts
where merchantid = 571
	and syncStatusID = 1
	and itemtype = 1 
)



--===============================================================================================
update top (2) shopify.shopifyProducts
set SyncStatusId = 2
where merchantid = 2569
and tailbaseid in (771517,771514)
 

 select productid, Elasticsearch_CustomTerm from datatail20130410.dbo.merchantProds where merchant_id = 2724 and Elasticsearch_CustomTerm <> ''

 update top (1) datatail20130410.dbo.merchantProds
 set Elasticsearch_CustomTerm = 'en_Electric'
 where merchant_id = 2724
 and ProductID = 727682

--**************PRODUCTS**************
select  *
from shopify.shopifyProducts
where merchantid = 2724
and tailbaseid = 727682
--and id = 802544 
	--and syncStatusID = 2
	--and itemtype = 1 
	--and ShopifyGeneratedProductId is not null
	--and itemtype = 2 
	--and itemtype = 3 
	--and itemtype = 4 
	--and itemtype = 5 
	--and tailbaseid in (771517,771514)
	--and handle = 'amana-44cuft-top-load-washer-ntw4519jw'
	--and id in (1089844)

	--and titleEn like '%UM7300PUA%'

	select * from datatail20130410.dbo.merchantProds where merchant_id = 2798 and productid in (510292,510297,530622)

select v.*
from shopify.ShopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid = 2798
and v.ShopifyProductID in (165088,
165090,
166640)


--===============================================================================================

--**************COLLECTIONS**************

select *
FROM shopify.ShopifyMerchantCollections mc
inner join shopify.shopifyProducts sp on sp.TailbaseId = mc.TailbaseId
where mc.merchantid = 571 
and mc.TailbaseId = 489477
--and sp.SyncStatusId = 2





--===============================================================================================
--**************METAFIELDS**************

select  m.* from shopify.ShopifyMerchantMetafields m
inner join shopify.shopifyProducts sp on sp.id = m.ShopifyProductId
where sp.merchantid = 2798
and m.ShopifyProductId in (165088,
165090,
166640)
and keyname = 'VariantGroups'


--===============================================================================================

--**************MEDIA**************

select m.*
    from Shopify.ShopifyProductMedia m
	inner join shopify.shopifyProducts sp on sp.id = m.ShopifyProductId
where sp.merchantid = 2569
and m.ShopifyProductId in (1567779,1567780)
order by m.MediaContentTypeId,m.tailbaseid, m.DisplayOrder

update top (7) Shopify.ShopifyProductMedia
set SyncStatusId = 1,
ShopifyGeneratedMediaId = null
where ShopifyProductId in (1567779,1567780)

select


delete top (6) from Shopify.ShopifyProductMedia where id in (6335493,6335494,6335495,6335496,6335497,6335498)

update top (6) from Shopify.ShopifyProductMedia 
set syncstatus

--===============================================================================================

--**************VARIANTS**************

select v.*
from shopify.ShopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid = 571
and v.ShopifyProductID = 1090072

select  * from  shopify.ShopifyProductVariants where ShopifyProductID in (select id
from shopify.shopifyProducts
where merchantid = 571
	and itemtype = 1 
	and ShopifyGeneratedProductId is not null)

	update top (591) shopify.ShopifyProductVariants
	set SyncStatusId = 2 
	where ShopifyProductID in (select id
from shopify.shopifyProducts
where merchantid = 571
	and itemtype = 1 
	and ShopifyGeneratedProductId is not null)




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

