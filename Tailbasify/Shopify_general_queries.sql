use Tailbasify

--Update = 1
--Synchronize = 3

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
	and s.merchantid = 3230
	--and s.ApiVersion = 'v1'
order by s.id

select * from shopify.shopifyMerchants where merchantid = 2798





--===============================================================================================

update MerchantExports
 set [status]  = 1
 where merchantid  = 3475
  --where [status] <> 1

--===============================================================================================

----**************EXPORT STATUS**************
select  me.MerchantId,merchant, me.Status, me.ModificationDate, me.ShopifyMerchantId
from MerchantExports me WITH (NOLOCK)
    inner join datatail20130410.dbo.merchants m on m.id = me.MerchantId
	--and m.id = 3478
order by [Status] desc, me.ModificationDate desc

--===============================================================================================

----**************LOGS**************
select  distinct top 100 *  from logs  WITH (NOLOCK) 
order by LogTime desc 

select distinct top 500 *  from logs  WITH (NOLOCK) 
WHERE  merchantid = 3065
and LogTime > convert(date,getdate()-1)
--and logtime between '2024-02-10' and '2024-02-11'
order by LogTime desc 

select distinct top 10 *  from logs  WITH (NOLOCK) 
WHERE  merchantid = 3065
and category = 'Statistics'
and module = 'Converter'
order by LogTime desc 

select m.id, m.merchant, s.id, c.ShopifyConfigurationId, c.ConfigurationValue from shopify.shopifyMerchants s
    inner join datatail20130410.dbo.merchants m on m.id = s.MerchantId
	inner join Shopify.ShopifyMerchantConfigurations c on c.ShopifyMerchantId = s.ID
where c.ShopifyConfigurationId = 1
and c.ConfigurationValue = 'false'
and s.ApiVersion = 'v2'


--===============================================================================================

--**************DB STATS**************

select count(1) from datatail20130410.dbo.MerchantProds where Merchant_ID = 571 --29127
select count(1) from datatail20130410.dbo.MerchantCollections where Merchant_ID = 571 --2094
select count(1) from datatail20130410.dbo.MerchantRebates where Merchant_ID = 571 and active = 1 --68
select count(1) from datatail20130410.dbo.MerchantINstallations where MerchantID = 571 --2
select count(1) from datatail20130410.dbo.MerchantWarranties where MerchantID = 571 --1
select * from datatail20130410.dbo.MerchantRebates where Merchant_ID = 1190 and active = 1 and DisplayEndDate >= GETDATE() --68
--total of 31292

select * from datatail20130410.dbo.MerchantProds where Merchant_ID = 3209 and productid =789931
 
select * from datatail20130410.dbo.products where id_product =  789931

--===============================================================================================

--**************CONVERT REPORTS**************

select top(10)
    *
from Shopify.ShopifyConvertReports h WITH (NOLOCK)
    join Shopify.ShopifyConvertProductReportsDetail d on h.id = d.ConvertReportId
where h.MerchantId = 3388
    and d.TailbaseId in (51148)
order by h.id desc

--===============================================================================================

--**************SYNC REPORTS**************

select top 100 *    
from Shopify.ShopifySyncReports h WITH (NOLOCK)
    join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 3388
--where text like '%video%'
    and d.ShopifyProductId in (1621412)
order by h.id desc


select  *
from shopify.shopifyProducts
where ItemType = 3 
and syncStatusId =1



--===============================================================================================

--**************DEBUG**************

SELECT TOP 46 * FROM Shopify.ShopifySyncReports WHERE MerchantId = 3388 ORDER BY ID DESC


SELECT * FROM Shopify.ShopifyProducts
WHERE ID IN (SELECT ShopifyProductId FROM Shopify.ShopifyProductSyncReportsDetail 
WHERE SyncReportId IN (576376))
AND MerchantId = 3388
--AND SyncStatusId IN (2)
--AND ShopifyGeneratedProductId IS NULL


--===============================================================================================
--update top (2) shopify.shopifyProducts
--set SyncStatusId = 2
--where merchantid = 2569
--and tailbaseid in (771517,771514)

select * from datatail20130410.dbo.itemvideos where itemid = 142005
--**************PRODUCTS**************
select  *
from shopify.shopifyProducts
where merchantid = 3388
	and syncStatusID != 4
--and tailbaseid = 789931
--and id = 802544 
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
where mc.merchantid = 3388 
--and sp.TitleEn like '%rebates%'
--and mc.TailbaseId = 489477
and sp.id in (select  id
from shopify.shopifyProducts
where merchantid = 3388
	and syncStatusID != 4)
and mc.SyncStatusId != 4


--===============================================================================================
--**************METAFIELDS**************

select  m.* from shopify.ShopifyMerchantMetafields m
inner join shopify.shopifyProducts sp on sp.id = m.ShopifyProductId
where sp.merchantid = 3388
--and m.ShopifyProductId = 568501
and m.ShopifyProductId in (select id
from shopify.shopifyProducts
where merchantid = 3388
and SyncStatusId != 4)
and m.SyncStatusId != 4
--and keyname = 'VariantGroups'


--===============================================================================================

--**************MEDIA**************

select m.*
    from Shopify.ShopifyProductMedia m
	inner join shopify.shopifyProducts sp on sp.id = m.ShopifyProductId
where sp.merchantid = 3388
and m.ShopifyProductId in (select  id
from shopify.shopifyProducts
where merchantid = 3388
	and syncStatusID != 4
)
and m.SyncStatusId != 4
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
where sp.merchantid = 3388
and v.ShopifyProductID in (select id
from shopify.shopifyProducts
where merchantid = 3388
and SyncStatusId != 4)
and v.SyncStatusId != 4



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

