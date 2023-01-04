-- Merchants
select 
m.merchant, s.*
from shopify.shopifyMerchants s
    inner join datatail20130410.dbo.merchants m on m.id = s.MerchantId
where m.id = 3443

--Insert New Store
--INSERT INTO [Shopify].[ShopifyMerchants](MERCHANTID, SHOPURL, LIVE, SECURITYSTAMP, CREATIONDATE, MODIFICATIONDATE, APIKEY, SecretKey,APPURL, APIVersion)
--VALUES (3443, 'lux-by-walo.myshopify.com', 0, NEWID(), GETDATE(), GETDATE(), '5814a9b3795b318f76c562f9370a3694', '9058e7faf4495aa45515a981f0eecaf4','lxbywa.tailbasify.com','v2')

--Add Record to Merchant Exports Table
--INSERT INTO [dbo].[MerchantExports] (MERCHANTID, status, ShopifyMerchantId)
--VALUES (3443, 1, 33)

--Check new entry
select * from [dbo].[MerchantExports]

--Add configs
--Get example
select c.id, c.Configuration, sc.ConfigurationValue
from shopify.ShopifyMerchantConfigurations sc
    inner join shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = 33

select *
from shopify.ShopifyConfigurations
order by id

--Add Config Record
insert into shopify.ShopifyMerchantConfigurations (shopifyMerchantid, ShopifyConfigurationId, ConfigurationValue) values
(33,4,'English'), -- PrimaryLanguage
(33,8,'True')  -- ProceQualifier

-- ***********All configs available******************

-- 1	Inventory
-- 2	SellOutOfStock
-- 3	AssociatedProducts
-- 4	PrimaryLanguage
-- 5	SecondaryLanguage
-- 6	ManageTranslations
-- 7	DataDecoratorName
-- 8	PriceQualifier
-- 9	IncludeFeeInPrices
-- 10	IncludeInventoryAsTags
-- 11	MerchantProdsRepositoryName
-- 13	BrandTemplate
-- 14	SendLegacyInventoryTag
-- 15	Warranties
-- 16	Installations