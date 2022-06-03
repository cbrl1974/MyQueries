

-- Merchants
select * from shopify.shopifyMerchants
 where merchantid = 3398


update top (1) MerchantExports
set [status] = 1
where merchantid = 3209

select * from MerchantExports


select top 100 * from logs  WITH (NOLOCK)
--WHERE  merchantid = 3209
order by LogTime desc


--Reports
--Convert Report
select top(50) *
from Shopify.ShopifyConvertReports h
join Shopify.ShopifyConvertProductReportsDetail d on h.Id = d.ConvertReportId
where h.MerchantId = 3209
order by h.id desc


--Sunc Report
select top(50) *
from Shopify.ShopifySyncReports h
join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 3209
order by h.id desc



select * from Shopify.ShopifyProducts where MerchantId = 3398
select top (1) * from  Shopify.ShopifyConvertReports 
select top (1) * from  Shopify.ShopifyProductSyncReportsDetail 


select * from datatail20130410.dbo.merchantprods where merchant_id = 3209 and productid = 400217
select * from shopify.ShopifyProducts where merchantid = 3209 and tailbaseid = 400217

select * from datatail20130410.dbo.merchantCollections where merchant_id = 3209

--Count on tailbasify
select count(1) from shopify.ShopifyMerchantCollections where merchantid = 1202
select * from shopify.shopifyProducts where merchantid = 1202 and ShopifyGeneratedProductId is not null
select count(1) from shopify.ShopifyProductVariants where ShopifyProductID  in (select id from shopify.shopifyProducts where merchantid = 1202)
select count(1) from shopify.ShopifyMerchantMetafields where ShopifyProductId  in (select id from shopify.shopifyProducts where merchantid = 1202)



--Configs
select  c.id, c.Configuration, sc.ConfigurationValue from shopify.ShopifyMerchantConfigurations sc
inner join shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = 12


select  * from shopify.ShopifyMerchantConfigurations where ShopifyMerchantId = 9
select * from shopify.ShopifyConfigurations order by id



-- Other tables on Tailbasify
select top 10 * from shopify.ShopifyCollectionRuleInputs
select top 10 * from shopify.ShopifyMerchantCollectionImages 
select * from SyncStatus
select * from shopify.shopifyProducts where merchantid = 1448




