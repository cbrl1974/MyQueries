

-- Merchants
select s.id, m.merchant, s.MerchantId, s.ShopUrl, s.SecurityStamp, s.ApiVersion
from shopify.shopifyMerchants s
    inner join datatail20130410.dbo.merchants m on m.id = s.MerchantId
where m.id = 2456
order by m.id

select count(productid) from datatail20130410.dbo.merchantProds where merchant_id = 2456

update top (1) MerchantExports
set [status] = 1
where merchantid = 1956

select  m.merchant, me.*
from MerchantExports me
 inner join datatail20130410.dbo.merchants m on m.id = me.MerchantId
order by [Status] desc


--Logs for Converter
select top 50
    *
from logs  WITH (NOLOCK)
WHERE  merchantid = 1956
    AND module = 'Converter'
order by LogTime desc



select
    top(10)
    *
from Shopify.ShopifyConvertReports h WITH (NOLOCK)
    join Shopify.ShopifyConvertProductReportsDetail d on h.id = d.ConvertReportId
where h.MerchantId = 2456
    and d.TailbaseId in (380546)
order by h.id desc


--Logs for Synchronizer
select top(50)
    *
from logs  WITH (NOLOCK)
WHERE  merchantid = 2456
    AND module = 'Synchronizer'
AND text like '%380546%'
order by id desc

--Sunc Report
select
    top(10)
    *
from Shopify.ShopifySyncReports h WITH (NOLOCK)
    join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 2456
    and d.ShopifyProductId in (715233)
order by h.id desc

select *
from shopify.ShopifyMerchantMetafields
where ShopifyProductId IN ( 715233)


select *
from datatail20130410.dbo.merchantProds
where merchant_id = 2456 


select *
from datatail20130410.dbo.merchantprods
where merchant_id = 2456
 and productid in (628629)

select *
from datatail20130410.dbo.merchantCollections
where merchant_id = 2456 and collectionID = 25235

select *
from datatail20130410.dbo.merchantcats
where merchant_id = 2456


SELECT *
  FROM [Tailbasify].[Shopify].[ShopifyProducts]
  where TailbaseId in (25235, 25150)


select *
from shopify.ShopifyMerchantCollections
where MerchantId = 2456 
and tailbaseId in (select TailbaseId from shopify.shopifyProducts where ItemType = 2 and MerchantId = 2456)


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
where MerchantId = 2456 and tailbaseID in (select TailbaseId from shopify.shopifyProducts where MerchantId = 2456 and ItemType = 2)
and tailbaseID = 1081732

select *
from shopify.shopifyProducts
where merchantid = 2456 
and tailbaseid  in (25235)
715233

select * from datatail20130410.dbo.merchantRebates where merchant_id = 2456 and id_rebate =1081732
and active = 1 order by DisplayEndDate desc

select *
from shopify.ShopifyCollectionRuleInputs
where ShopifyMerchantCollectionId = 6890
--First Delete Rule
-- delete top (1)  from shopify.ShopifyCollectionRuleInputs where ShopifyMerchantCollectionId =6890
-- --Second Delete ShopifyMerchantCollections
-- delete top (1)  from shopify.ShopifyMerchantCollections where MerchantId = 2456 and id = 6890

select * from Shopify.ShopifyMediaContentTypes

select * from shopify.ShopifyProductMedia where TailbaseId = 25235