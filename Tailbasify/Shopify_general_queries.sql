
use tailbasify
-- Merchants
select
    --m.merchant, s.*
    s.id, m.merchant, s.MerchantId, s.ShopUrl, s.SecurityStamp, s.ApiVersion
from shopify.shopifyMerchants s
    inner join devTailbaseCore.dbo.merchants m on m.id = s.MerchantId
where m.id = 1448


--===============================================================================================

update top (1) MerchantExports
 set [status]  = 1
 where merchantid  = 1448

--===============================================================================================

use Tailbasify
select m.merchant, me.*
from MerchantExports me
    inner join devTailbaseCore.dbo.merchants m on m.id = me.MerchantId
order by [Status] desc, ModificationDate desc


--===============================================================================================

--Logs for Converter
select top 50
    *
from logs  WITH (NOLOCK)
WHERE  merchantid = 1448
    AND module = 'Converter'
	--and text like '%timeout%'
order by LogTime desc




--Logs for Converter
select top 50
    *
from logs  WITH (NOLOCK)
WHERE  merchantid = 1448
    AND module = 'Converter'
	and text like '%timeout%'
order by LogTime desc

--===============================================================================================

select top(10)
    *
from Shopify.ShopifyConvertReports h WITH (NOLOCK)
    join Shopify.ShopifyConvertProductReportsDetail d on h.id = d.ConvertReportId
where h.MerchantId = 571
    --and d.TailbaseId in (1125613)
order by h.id desc





--===============================================================================================
use Tailbasify
--Logs for Synchronizer
select top(50)
    *
from logs  WITH (NOLOCK)
WHERE  merchantid = 1448
    AND module = 'Synchronizer'
order by id desc





--===============================================================================================

--Sunc Report
select top(10)
    *
from Shopify.ShopifySyncReports h WITH (NOLOCK)
    join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 1448
--and GraphQLCallInfo is not null
    and d.ShopifyProductId in (1092388)
order by h.id desc

in(1151205, 1151203,  1151204)
--===============================================================================================

select 
*
	--id, tailbaseid, itemtype, titleEn, TitleFr, DescriptionEn, DescriptionFr, SyncStatusId
from shopify.shopifyProducts
where merchantid = 3039  
	--and itemtype = 1 
	--and itemtype = 2 
	--and itemtype = 3 
	--and itemtype = 4 
	and itemtype = 5 
	--and tailbaseid in (494322)
--and handle = 'amana-44cuft-top-load-washer-ntw4519jw'

	-- update  shopify.shopifyProducts
	-- set SyncStatusId = 2
	-- where MerchantId = 3039
	-- --and itemtype = 4 
	-- and productType =  'Beverage Centers'


--===============================================================================================


select 
*
from shopify.ShopifyMerchantCollections
where MerchantId = 1448
--and TitleEn like '%Jennair%'
and ShopifyGeneratedCollectionId is null
and handle  like '%salon%'

-- update top (1) shopify.ShopifyMerchantCollections
-- set syncStatusid = 2,
-- ShopifyGeneratedCollectionId = 'gid://shopify/Collection/277847998627'
-- where  merchantid = 1448
-- and id = 11705
-- and ShopifyGeneratedCollectionId is null 


--===============================================================================================

-- update Shopify.ShopifyProducts 
-- set syncStatusID = 2
-- where merchantid = 1448
-- and id in (
-- 	select ShopifyProductId
-- 	from shopify.ShopifyMerchantMetafields
-- 	where itemtypeid = 2
-- 	and ShopifyGeneratedMetafieldId is null
-- )
-- and ItemType = 2


--===============================================================================================


select m.TailbaseId,m.OriginalSource, m.TailbaseIdType, m.SyncStatusId, m.ShopifyGeneratedMediaId, m.LastModificationDate, m.ShopifyMediaStatusId
    from Shopify.ShopifyProductMedia m
where m.shopifyProductID in 
(
    select id
        from shopify.ShopifyProducts
    where MerchantId = 1448
)
and m.SyncStatusId <> 3

-- update Shopify.ShopifyProductMedia
-- set SyncStatusId = 3,
-- ShopifyMediaStatusId = NULL
-- where shopifyProductID in 
-- (
--     select id
--         from shopify.ShopifyProducts
--     where MerchantId = 1448
-- )
-- and SyncStatusId <> 3



-- update shopify.ShopifyProducts
-- set SyncStatusId = 2
--   where MerchantId = 1448
-- 	and ItemType in (1,2)
--  select id
--         from shopify.ShopifyProducts
--     where MerchantId = 1448
-- 	and ItemType in (1,2)

--===============================================================================================

select *
from shopify.ShopifyProductVariants
where ShopifyProductID = 1126204
not in (
    select id
        from shopify.shopifyProducts
        where merchantid = 1911 
		--and SyncStatusId = 3
)


--===============================================================================================

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

