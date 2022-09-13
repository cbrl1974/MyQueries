

-- Merchants
select  s.id, m.merchant, s.MerchantId,s.ShopUrl, s.SecurityStamp,s.ApiVersion
 from shopify.shopifyMerchants s
 inner join  datatail20130410.dbo.merchants m on m.id = s.MerchantId
where m.id = 1202

update top (1) MerchantExports
set [status] = 1
where merchantid = 2798

select * from MerchantExports order by [Status] desc

 --Logs for Converter
select top 200 * from logs  WITH (NOLOCK)
WHERE  merchantid = 1202
AND module = 'Converter'
order by LogTime desc



select 
--distinct d.[Status]
top(10) *
from Shopify.ShopifyConvertReports h WITH (NOLOCK)
join Shopify.ShopifyConvertProductReportsDetail d on h.id = d.ConvertReportId
where h.MerchantId = 1202
and d.TailbaseId in (628629)
order by h.id desc


 --Logs for Synchronizer
select  top(50) * from logs  WITH (NOLOCK)
WHERE  merchantid = 1202
AND module = 'Synchronizer'
--AND text like '%235625%'
order by id desc

--Sunc Report
select 
--distinct d.[Status]
top(10) *
from Shopify.ShopifySyncReports h WITH (NOLOCK)
join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 1202
and d.ShopifyProductId in (626050) 
--and status = 6
--623004
--group by  d.[Status]
order by h.id desc

select * from shopify.ShopifyMerchantMetafields where ShopifyProductId IN ( 623004,358235)
select * from datatail20130410.dbo.merchantProds where merchant_id = 1202 and 


select * from datatail20130410.dbo.merchantCollections where merchant_id = 1202 and collectionID = 22771
select * from datatail20130410.dbo.merchantcats where merchant_id = 1202
select top 10 * from datatail20130410.dbo.categories where merchant_id = 1202
select * from datatail20130410.dbo.merchantprods where merchant_id = 1202 and productid in (610780,628629)-- 


select * from shopify.shopifyProducts where merchantid = 1202 and tailbaseid  in (628629)
select * from shopify.ShopifyMerchantCollections where MerchantId = 1202 and id = 6890


--Configs
select  c.id, c.Configuration, sc.ConfigurationValue from shopify.ShopifyMerchantConfigurations sc
inner join shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = 6


select  * from shopify.ShopifyMerchantConfigurations where ShopifyConfigurationId = 8
select * from shopify.ShopifyConfigurations order by id



-- Other tables on Tailbasify
select top 10 * from shopify.ShopifyCollectionRuleInputs
select top 10 * from shopify.ShopifyMerchantCollectionImages 
select * from SyncStatus
select * from shopify.shopifyProducts where merchantid = 1448

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
select * from shopify.ShopifyMerchantCollections where MerchantId = 1202 and id = 6890

select  * from shopify.ShopifyCollectionRuleInputs where ShopifyMerchantCollectionId = 6890
--First Delete Rule
delete top (1)  from shopify.ShopifyCollectionRuleInputs where ShopifyMerchantCollectionId =6890
--Second Delete ShopifyMerchantCollections
delete top (1)  from shopify.ShopifyMerchantCollections where MerchantId = 1202 and id = 6890

 