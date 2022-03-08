-- Merchants
select * from shopify.shopifyMerchants where merchantid = 2798
select  * from shopify.ShopifyMerchantConfigurations where ShopifyMerchantId = 7
select * from shopify.ShopifyConfigurations order by id

--Configs
select  sc.id, c.Configuration, sc.ConfigurationValue from shopify.ShopifyMerchantConfigurations sc
inner join shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = 7

select * from shopify.shopifyProducts where merchantid = 2798

--Exports & Reports
select * from MerchantExports where merchantid = 2798

update top (1) MerchantExports
set [status] = 1
where merchantid = 2798

select * from shopify.ShopifyConvertReports where merchantid = 2798 order by EndTime desc
select * from shopify.ShopifySyncReports where merchantid = 2798

select * from shopify.shopifyProducts where merchantid = 2798

--Logs
select top 100 * from tailbasify.dbo.logs
where merchantid = 2798
order by id desc

select * from SyncStatus

