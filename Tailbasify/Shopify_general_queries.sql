

-- Merchants
select
    --m.merchant, s.*
    s.id, m.merchant, s.MerchantId, s.ShopUrl, s.SecurityStamp, s.ApiVersion
from tailbasify.shopify.shopifyMerchants s
    inner join datatail20130410.dbo.merchants m on m.id = s.MerchantId
where m.id = 3398

--===============================================================================================

update top (1) MerchantExports
 set [status] = 1
 where merchantid = 3398

--===============================================================================================


select m.merchant, me.*
from tailbasify.dbo.MerchantExports me
    inner join datatail20130410.dbo.merchants m on m.id = me.MerchantId
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

--===============================================================================================

select *
from shopify.ShopifyProductVariants
where ShopifyProductID in (
    select id
        from shopify.shopifyProducts
    where merchantid = 3398 and itemtype = 1
)

--===============================================================================================

select *
from shopify.shopifyProducts
where merchantid = 3398 
and Handle = 'nspire-table-de-salle-a-manger-sydney-avec-pied-central-201-378'

--===============================================================================================


select * from datatail20130410.dbo.merchantProds where merchant_id = 3398
select * from datatail20130410.dbo.merchantCollections where merchant_id = 3398


--Sunc Report
select top(10)
    *
from Shopify.ShopifySyncReports h WITH (NOLOCK)
    join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 3398
    and d.ShopifyProductId in (770145)
order by h.id desc

--===============================================================================================

--Different Catalog info
SELECT sp.*
FROM [Shopify].[ShopifyProducts] sp
    inner join datatail20130410.dbo.merchantprods mp on mp.productId = sp.TailbaseId
    inner join datatail20130410.dbo.products p on p.id_product = mp.productid
        and sp.MerchantId = mp.merchant_id
where mp.merchant_id  = 3398
    --and sp.TailbaseId  = 1094756
    AND itemtype = 3
--and sp.handle = 'frigidaire-41-cu-ft-top-loading-washer-fftw4120sw'
--and mp.productid = 729155

--===============================================================================================

SELECT *
    FROM tailbasify.shopify.ShopifyProducts
WHERE merchantid = 3398


--===============================================================================================


select *
from shopify.ShopifyMerchantCollections
where MerchantId = 3398
and tailbaseId in 
(
    select TailbaseId
        from shopify.shopifyProducts
    where MerchantId = 3398
)

--===============================================================================================

select *
    from datatail20130410.dbo.merchantrebates
where merchant_id = 3398 
and id_rebate in (1094611,1094660)

--===============================================================================================

select *
from shopify.ShopifyMerchantMetafields
where ShopifyProductId IN ( select id from Shopify.ShopifyProducts where merchantid = 3398)

--===============================================================================================


select mt.MediaContentType, m.*
    from Shopify.ShopifyProductMedia m
    inner join shopify.ShopifyMediaContentTypes mt on mt.Id = m.MediaContentTypeId
where m.TailbaseId in 
(
    select tailbaseid
        from shopify.ShopifyProducts
    where MerchantId = 3398
)



select * from shopify.ShopifyMediaContentTypes


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

