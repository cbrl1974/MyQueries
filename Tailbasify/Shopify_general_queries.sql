

-- Merchants
select 
--m.merchant, s.*
s.id, m.merchant, s.MerchantId, s.ShopUrl, s.SecurityStamp, s.ApiVersion
from shopify.shopifyMerchants s
    inner join datatail20130410.dbo.merchants m on m.id = s.MerchantId
where m.id = 3335

-- update top (1) MerchantExports
-- set [status] = 1
-- where merchantid = 3405

select  m.merchant, me.*
from MerchantExports me
 inner join datatail20130410.dbo.merchants m on m.id = me.MerchantId
order by [Status] desc, ModificationDate desc


--Logs for Converter
select top 50
    *
from logs  WITH (NOLOCK)
WHERE  merchantid = 3335
    AND module = 'Converter'
order by LogTime desc



select top(10) *
from Shopify.ShopifyConvertReports h WITH (NOLOCK)
    join Shopify.ShopifyConvertProductReportsDetail d on h.id = d.ConvertReportId
where h.MerchantId = 3335
    and d.TailbaseId in (354660)
order by h.id desc


--Logs for Synchronizer
select top(50) * from logs  WITH (NOLOCK)  
WHERE  merchantid = 3335
AND module = 'Synchronizer'
order by id desc


--Sunc Report
select top(10) * from Shopify.ShopifySyncReports h WITH (NOLOCK)
join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 3335
and d.ShopifyProductId in (774003)
order by h.id desc

--Different Catalog info
SELECT  sp.*
  FROM [Shopify].[ShopifyProducts] sp 
  inner join datatail20130410.dbo.merchantprods mp on mp.productId = sp.TailbaseId 
  inner join datatail20130410.dbo.products p on p.id_product = mp.productid
  and sp.MerchantId = mp.merchant_id
  where mp.merchant_id  = 3335
  and sp.handle = 'yorkdale-matelas-tres-grand-madison-pillow-top-mattress-king'
  --and mp.productid = 729155


  
select *
from shopify.ShopifyMerchantCollections
where MerchantId = 3335 
and tailbaseId in (select TailbaseId from shopify.shopifyProducts where ItemType = 2 and MerchantId = 3335)

  
select *
from shopify.ShopifyMerchantMetafields
where ShopifyProductId IN ( 776365)





select *
from SyncStatus


sel


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

