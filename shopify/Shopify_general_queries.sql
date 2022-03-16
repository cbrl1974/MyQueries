-- Merchants
select * from shopify.shopifyMerchants where merchantid = 2798
select  * from shopify.ShopifyMerchantConfigurations where ShopifyMerchantId = 7
select * from shopify.ShopifyConfigurations order by id
select * from shopify.ShopifyMerchantCollections where merchantid = 2798
select * from shopify.shopifyProducts where merchantid = 2798
--Count
select count(tailbaseID) from shopify.ShopifyMerchantCollections where merchantid = 2798
select count(collectionID) from datatail20130410.dbo.merchantCollections where merchant_id = 2798
select count(tailbaseID) from shopify.shopifyProducts where merchantid = 2798
select count(productid) from datatail20130410.dbo.merchantProds where merchant_id = 2798

select top 10 * from shopify.ShopifyCollectionRuleInputs
select top 10 * from shopify.ShopifyMerchantCollectionImages 

--Configs
select  sc.id, c.Configuration, sc.ConfigurationValue from shopify.ShopifyMerchantConfigurations sc
inner join shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = 7



--Exports & Reports
select * from MerchantExports
 
-- update top (1) MerchantExports
-- set [status] = 1
-- where merchantid = 2798

select * from shopify.ShopifyConvertReports where merchantid = 2798 order by EndTime desc
select * from shopify.ShopifySyncReports where merchantid = 2798

select * from shopify.shopifyProducts where merchantid = 2798

--Logs
select top 100 * from logs
-- where merchantid = 1175
order by id desc



select * from SyncStatus

