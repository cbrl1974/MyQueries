

-- Merchants
select id, MerchantId,ShopUrl, SecurityStamp,ApiVersion from shopify.shopifyMerchants where merchantid = 2217


-- update top (1) MerchantExports
-- set [status] = 1
-- where merchantid = 1931

select * from MerchantExports order by [Status] desc

select top 10 *   from shopify.shopifyProducts 
select top 10 *   from shopify.ShopifyProductVariants 

 
select top 150 * from logs  WITH (NOLOCK)
WHERE  merchantid = 2217
and module = 'Converter'
order by LogTime desc



--Reports
--Convert Report
select  top(50) *
from Shopify.ShopifyConvertReports h
join Shopify.ShopifyConvertProductReportsDetail d on h.Id = d.ConvertReportId
where h.MerchantId = 2217
--and d.tailbaseid = 195384
order by h.id desc



--Sunc Report
select top(50) *
from Shopify.ShopifySyncReports h
join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
--where h.MerchantId = 2217
--AND d.ShopifyProductId = 195384
order by h.id desc



select top (1) * from  Shopify.ShopifyConvertReports 
select top (1) * from  Shopify.ShopifyProductSyncReportsDetail 

select * from datatail20130410.dbo.merchantCollections where merchant_id = 3209
select * from datatail20130410.dbo.merchantprods where merchant_id = 1956 and productid in (730869)-- 
select * from shopify.shopifyProducts where id = 195779
select  * from shopify.ShopifyProducts where MerchantId = 2217 and Handle = 'crown-mark-sheffield-3-drawer-nightstand-b1100-2'
select  * from shopify.ShopifyProducts where MerchantId = 2217 and [TitleEn] = 'LG 4.2 cu. ft. Front Loading Washer WM2355CS'
select  * from shopify.ShopifyProducts where MerchantId = 2217 and [TitleFr] = 'LG Laveuse à chargement frontal de 4,2 pi cu WM2355CS'




--Count on tailbasify
select count(1) from shopify.ShopifyMerchantCollections where merchantid = 1202
select * from shopify.shopifyProducts where merchantid = 1202 and ShopifyGeneratedProductId is not null
select count(1) from shopify.ShopifyProductVariants where ShopifyProductID  in (select id from shopify.shopifyProducts where merchantid = 1202)
select count(1) from shopify.ShopifyMerchantMetafields where ShopifyProductId  in (select id from shopify.shopifyProducts where merchantid = 3209)
select top 500 * from shopify.ShopifyMerchantMetafields where ShopifyProductId  in (select id from shopify.shopifyProducts where merchantid = 2217) and 



--Configs
select  c.id, c.Configuration, sc.ConfigurationValue from shopify.ShopifyMerchantConfigurations sc
inner join shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = 9

insert into shopify.ShopifyMerchantConfigurations (shopifyMerchantId, ShopifyConfigurationId, ConfigurationValue) VALUES
(9, '1', 'False'),
(9, '3', 'True'),
(9, '8', 'True')

--8 -PriceQualifier
-3 --AssociatedProducts
--1 -Inventory

select  * from shopify.ShopifyMerchantConfigurations where ShopifyMerchantId = 9
select * from shopify.ShopifyConfigurations order by id



-- Other tables on Tailbasify
select top 10 * from shopify.ShopifyCollectionRuleInputs
select top 10 * from shopify.ShopifyMerchantCollectionImages 
select * from SyncStatus
select * from shopify.shopifyProducts where merchantid = 1448




