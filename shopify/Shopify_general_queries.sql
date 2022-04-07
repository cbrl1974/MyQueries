-- Merchants
select * from shopify.shopifyMerchants where merchantid = 2217
select  * from shopify.ShopifyMerchantConfigurations where ShopifyMerchantId = 9
select * from shopify.ShopifyConfigurations order by id
select * from shopify.ShopifyMerchantCollections where merchantid = 2217
select * from shopify.shopifyProducts where merchantid = 2217


select  * from shopify.ShopifyMerchantConfigurations where ShopifyMerchantId = 9

 



--Count
select count(1) from shopify.ShopifyMerchantCollections where merchantid = 2217 -- 0

select count(1) from shopify.shopifyProducts where merchantid = 2217  --7947
select count(1) from shopify.ShopifyProductVariants where ShopifyProductID  in (select id from shopify.shopifyProducts where merchantid = 2217) --7939
select count(1) from shopify.ShopifyMerchantMetafields where ShopifyProductId  in (select id from shopify.shopifyProducts where merchantid = 2217) --1681


select count(1) from datatail20130410.dbo.merchantProds where merchant_id = 2217 --7637
select count(1) from datatail20130410.dbo.merchantCollections where merchant_id = 2217 --270
select count(1) from datatail20130410.dbo.merchantRebates where merchant_id = 2217 -- 92



select top 10 * from shopify.ShopifyCollectionRuleInputs
select top 10 * from shopify.ShopifyMerchantCollectionImages 
select * from SyncStatus

--Configs
select  c.id, c.Configuration, sc.ConfigurationValue from shopify.ShopifyMerchantConfigurations sc
inner join shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = 9
select  * from shopify.ShopifyMerchantConfigurations where ShopifyMerchantId = 9




--Exports & Reports
select * from MerchantExports
 
-- update top (1) MerchantExports
-- set [status] = 1
-- where merchantid = 2217

select * from shopify.ShopifyConvertReports where merchantid = 2217 order by EndTime desc
select * from shopify.ShopifySyncReports where merchantid = 2217

select * from shopify.shopifyProducts where merchantid = 2217

--Logs
select top 500 * from logs
order by id desc



