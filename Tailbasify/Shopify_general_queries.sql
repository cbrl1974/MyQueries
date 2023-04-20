

-- Merchants
select
    --m.merchant, s.*
    s.id, m.merchant, s.MerchantId, s.ShopUrl, s.SecurityStamp, s.ApiVersion
from shopify.shopifyMerchants s
    inner join devTailbasecore.dbo.merchants m on m.id = s.MerchantId
where m.id = 3398

--===============================================================================================

update top (1) MerchantExports
 set [status] = 1
 where merchantid = 3398

--===============================================================================================


select m.merchant, me.*
from MerchantExports me
    inner join devTailbasecore.dbo.merchants m on m.id = me.MerchantId
order by [Status] desc, ModificationDate desc

--===============================================================================================

--Logs for Converter
select top 50
    *
from logs  WITH (NOLOCK)
WHERE  merchantid = 3398
    AND module = 'Converter'
order by LogTime desc

--===============================================================================================

select top(10)
    *
from Shopify.ShopifyConvertReports h WITH (NOLOCK)
    join Shopify.ShopifyConvertProductReportsDetail d on h.id = d.ConvertReportId
where h.MerchantId = 3398
    and d.TailbaseId in (526940)
order by h.id desc


--===============================================================================================

--Logs for Synchronizer
select top(50)
    *
from logs  WITH (NOLOCK)
WHERE  merchantid = 3398
    AND module = 'Synchronizer'
order by id desc
SELECT *
  FROM [Tailbasify].[Shopify].[ShopifyCollectionSyncReportsDetail]
  where ShopifyCollectionId = 12323

--===============================================================================================

--Sunc Report
select top(10)
    *
from Shopify.ShopifySyncReports h WITH (NOLOCK)
    join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 3398
    and d.ShopifyProductId in (1024171)
order by h.id desc

--===============================================================================================
select * from datata

select 
*
	--id, tailbaseid, itemtype, titleEn, TitleFr, DescriptionEn, DescriptionFr, SyncStatusId
from shopify.shopifyProducts
where merchantid = 2887  
	--and itemtype = 1 
	--and itemtype = 2 
	--and itemtype = 3 
	--and itemtype = 4 
	--and itemtype = 5 
	and tailbaseid = 1096099
	
update top (1) shopify.shopifyProducts
set translationStatusID = 1
where id = 1024171


select * from devTailbasecore.dbo.merchantprods 
where merchant_id = 3398 and productid = 753143




--Product = 1,
--Collection = 2,
--Rebate = 3,
--Warranty = 4,
--Installation = 5

select * from devTailbasecore.dbo.merchantINstallations where merchantid = 3398


--===============================================================================================


select 
*
--id, TailbaseID, SyncStatusId, TitleEn, TitleFr, DescriptionHtmlEn, DescriptionHtmlFr
from shopify.ShopifyMerchantCollections
where id = 12323
where MerchantId = 3398
and tailbaseId in 
(
    select TailbaseId
        from shopify.shopifyProducts
    where MerchantId = 3398
)

select * from datatail20130410.dbo.merchantrebates where merchant_id = 2887 and id_rebate = 1096099

--===============================================================================================

select 
*
--ShopifyProductId, SyncStatusId, ValueEn, ValueFr, DescriptionEn, DescriptionFr
--top 100 *
from shopify.ShopifyMerchantMetafields
--where ShopifyProductId  = 1024171
where ShopifyProductId in
 ( 
    select id 
    from Shopify.ShopifyProducts 
    where merchantid = 3398
)
and KeyName like '%feature%'



--===============================================================================================


select m.TailbaseId,m.OriginalSource, m.TailbaseIdType, m.SyncStatusId, m.ShopifyGeneratedMediaId, m.LastModificationDate, m.ShopifyMediaStatusId
    from Shopify.ShopifyProductMedia m
where m.shopifyProductID in 
(
    select id
        from shopify.ShopifyProducts
    where MerchantId = 3398
)
and m.SyncStatusId <> 3

update Shopify.ShopifyProductMedia
set SyncStatusId = 3,
ShopifyMediaStatusId = NULL
where shopifyProductID in 
(
    select id
        from shopify.ShopifyProducts
    where MerchantId = 3398
)
and SyncStatusId <> 3

select * from devTailbasecore.dbo.merchantprods where merchant_id = 3398 and ProductID = 706528


--===============================================================================================

select *
from shopify.ShopifyProductVariants
where ShopifyProductID in (
    select id
        from shopify.shopifyProducts
        where merchantid = 3398 
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

