
--Exports & Reports
select * from MerchantExports
 
-- update top (1) MerchantExports
-- set [status] = 1
-- where merchantid = 3336


--Logs
select top 100 * from logs
--where text like '%583771%'
order by id desc


-- Merchants
select * from shopify.shopifyMerchants where merchantid = 3336

--Collections
select * from shopify.ShopifyMerchantCollections where merchantid = 3336

--Products
select * from shopify.shopifyProducts where merchantid = 3336 and tailbaseid = 583771




--Count on tailbasify
select count(1) from shopify.ShopifyMerchantCollections where merchantid = 3336 -- 173
select count(1) from shopify.shopifyProducts where merchantid = 3336  --7947
select count(1) from shopify.ShopifyProductVariants where ShopifyProductID  in (select id from shopify.shopifyProducts where merchantid = 3336) --7939
select count(1) from shopify.ShopifyMerchantMetafields where ShopifyProductId  in (select id from shopify.shopifyProducts where merchantid = 3336) --1681

--Count on Production
select count(1) from [pvm701].datatail20130410.dbo.merchantProds where merchant_id = 3336 --7637
select count(1) from [pvm701].datatail20130410.dbo.merchantCollections where merchant_id = 3336 --270
select count(1) from [pvm701].datatail20130410.dbo.merchantRebates where merchant_id = 3336 -- 92



--Configs
select  c.id, c.Configuration, sc.ConfigurationValue from shopify.ShopifyMerchantConfigurations sc
inner join shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = 9
select  * from shopify.ShopifyMerchantConfigurations where ShopifyMerchantId = 9


select  * from shopify.ShopifyMerchantConfigurations where ShopifyMerchantId = 9
select * from shopify.ShopifyConfigurations order by id

--Reports
select * from shopify.ShopifyConvertReports where merchantid = 3336 order by EndTime desc
select * from shopify.ShopifySyncReports where merchantid = 3336

-- Other tables on Tailbasify
select top 10 * from shopify.ShopifyCollectionRuleInputs
select top 10 * from shopify.ShopifyMerchantCollectionImages 
select * from SyncStatus
select * from shopify.shopifyProducts where merchantid = 3336



