

-- Merchants
select s.id, m.merchant, s.MerchantId, s.ShopUrl, s.SecurityStamp, s.ApiVersion
from shopify.shopifyMerchants s
    inner join devTailbaseCore.dbo.merchants m on m.id = s.MerchantId
where m.id = 1202

select count(productid) from devTailbaseCore.dbo.merchantProds where merchant_id = 1202

-- update top (1) MerchantExports
-- set [status] = 1
-- where merchantid = 1202

select  m.merchant, me.*
from MerchantExports me
 inner join devTailbaseCore.dbo.merchants m on m.id = me.MerchantId
order by [Status] desc


--Logs for Converter
select top 50
    *
from logs  WITH (NOLOCK)
WHERE  merchantid = 1202
    AND module = 'Converter'
order by LogTime desc

SELECT *
  FROM [Tailbasify].[Shopify].[ShopifyProducts]
  where TailbaseId = 744424

select
    top(10)
    *
from Shopify.ShopifyConvertReports h WITH (NOLOCK)
    join Shopify.ShopifyConvertProductReportsDetail d on h.id = d.ConvertReportId
where h.MerchantId = 1202
    and d.TailbaseId in (744424)
order by h.id desc


--Logs for Synchronizer
select top(50)
    *
from logs  WITH (NOLOCK)
WHERE  merchantid = 1202
    AND module = 'Synchronizer'
--AND text like '%235625%'
order by id desc

--Sunc Report
select
    top(10)
    *
from Shopify.ShopifySyncReports h WITH (NOLOCK)
    join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 1202
    and d.ShopifyProductId in (639104)
order by h.id desc

select *
from shopify.ShopifyMerchantMetafields
where ShopifyProductId IN ( 623004,358235)


select *
from devTailbaseCore.dbo.merchantProds
where merchant_id = 1202 and


select *
from devTailbaseCore.dbo.merchantprods
where merchant_id = 1202
 and productid in (628629)

select *
from devTailbaseCore.dbo.merchantCollections
where merchant_id = 1202 and collectionID = 22771

select *
from devTailbaseCore.dbo.merchantcats
where merchant_id = 1202



select tailbaseid, TitleEn, TitleFr
from shopify.shopifyProducts
where merchantid = 1202 
and tailbaseid  in (494842, 623406, 494851)


select *
from shopify.ShopifyMerchantCollections
where MerchantId = 1202 and id = 6890


--Configs
select c.id, c.Configuration, sc.ConfigurationValue
from shopify.ShopifyMerchantConfigurations sc
    inner join shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = 6


select *
from shopify.ShopifyMerchantConfigurations
where ShopifyConfigurationId = 8

select *
from shopify.ShopifyConfigurations
order by id



-- Other tables on Tailbasify
select top 10
    *
from shopify.ShopifyCollectionRuleInputs
select top 10
    *
from shopify.ShopifyMerchantCollectionImages

select *
from SyncStatus

select *
from shopify.shopifyProducts
where merchantid = 1448

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



--Fix collections
select *
from shopify.ShopifyMerchantCollections
where MerchantId = 1202 and id = 6890

select *
from shopify.ShopifyCollectionRuleInputs
where ShopifyMerchantCollectionId = 6890
--First Delete Rule
-- delete top (1)  from shopify.ShopifyCollectionRuleInputs where ShopifyMerchantCollectionId =6890
-- --Second Delete ShopifyMerchantCollections
-- delete top (1)  from shopify.ShopifyMerchantCollections where MerchantId = 1202 and id = 6890

select * from Shopify.ShopifyMediaContentTypes

select * from shopify.ShopifyProductMedia where ShopifyProductId = 626050