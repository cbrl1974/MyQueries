use tailbasify
DECLARE @MerchantId AS INT = 2384;
DECLARE @NewShopifyMerchantId AS INT;
DECLARE @shopifyMerchantUrl AS varchar(max) = 'landeros-furniture-outlet.myshopify.com';
DECLARE @TailbasifyAppURL AS varchar(max) = 'lanfur.tailbasify.com';
DECLARE @shopifyMerchantApiVersion AS varchar(10) = 'v2';
DECLARE @ShopifyApiKey as nvarchar(max) = '648dbfab411b22190aa0df99acca762d'
DECLARE @ShopifySecretKey as nvarchar(max) = 'eeea5cfa7a9f53f0aac03619bdb27449'

-- Check Merchants for any existing merchant
select 
m.merchant, s.*
from shopify.shopifyMerchants s
    inner join datatail20130410.dbo.merchants m on m.id = s.MerchantId
where m.id = @MerchantId

-- Links for the app installlation
--https://lanfur.tailbasify.com/v2/api/shopify/install
--https://lanfur.tailbasify.com/v2/api/Shopify/Authorize

--Insert New Store
-- INSERT INTO [Shopify].[ShopifyMerchants](MERCHANTID, SHOPURL, LIVE, SECURITYSTAMP, CREATIONDATE, MODIFICATIONDATE, APIKEY, SecretKey,APPURL, APIVersion)
-- VALUES (@MerchantId, @shopifyMerchantUrl, 0, NEWID(), GETDATE(), GETDATE(), @ShopifyApiKey, @ShopifySecretKey, @TailbasifyAppURL, @shopifyMerchantApiVersion)
-- SET @NewShopifyMerchantId = @@IDENTITY

--Add Record to Merchant Exports Table
-- INSERT INTO [dbo].[MerchantExports] (MERCHANTID, status, ShopifyMerchantId)
-- VALUES (@MerchantId, 1, @NewShopifyMerchantId)

-- Check Merchants new entry
select 
m.merchant, s.*
from shopify.shopifyMerchants s
    inner join datatail20130410.dbo.merchants m on m.id = s.MerchantId
where m.id = @MerchantId

--Check new entry
select * from [dbo].[MerchantExports]

--********** configs

--Get example
DECLARE @NewShopifyMerchantIdForConfigs AS INT = 36;

-- select *
-- from shopify.ShopifyConfigurations
-- order by id

--Add Config Record
insert into shopify.ShopifyMerchantConfigurations (shopifyMerchantid, ShopifyConfigurationId, ConfigurationValue) values
(@NewShopifyMerchantIdForConfigs,4,'English'), -- PrimaryLanguage
(@NewShopifyMerchantIdForConfigs,8,'True'),  -- PriceQualifier
(@NewShopifyMerchantIdForConfigs,3,'True')  -- AssociatedProducts

--Check Entry
select c.id, c.Configuration, sc.ConfigurationValue
from shopify.ShopifyMerchantConfigurations sc
    inner join shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = @NewShopifyMerchantIdForConfigs

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


--===================================================================================================

-- *****Not important but in the case a merchant has inventory then yes but you can add it anyway****

--Step 1 Run this graphQl query on the Client Shopify Console:
-- This query will give some required information to insert after like the location id

    {
        locations(first:10) {
            nodes {
            id
            name
            }
        }
    }

-- Step2
--Get merchantstores from tailbase
  select * from datatail20130410.dbo.merchantstores where merchantid = 2384

  select * from datatail20130410.dbo.MerchantStoresInventory  where merchantid = 2384

  --Add record on ShopifyMerchantStoreLocations
DECLARE @NewShopifyMerchantIdForLocations AS INT = 36;
-- insert into Shopify.ShopifyMerchantStoreLocations
--     (Name, ShopifyMerchantId, ShopifyGeneratedLocationId, MerchantStoreId, StorePickup)
--     values
--     ('Landeros Furniture Outlet', @NewShopifyMerchantIdForLocations, 'gid://shopify/Location/78201880879', 5625, 1)
-- ,('Squamish Store', @NewShopifyMerchantIdForLocations, 'gid://shopify/Location/77751550227', 6440, 0)
-- ,('Distribution Center', @NewShopifyMerchantIdForLocations, 'gid://shopify/Location/77751615763', 6559, 0)


--Chech entry 
select * from Shopify.ShopifyMerchantStoreLocations
where ShopifyMerchantId =  @NewShopifyMerchantIdForLocations


--In Case of an update

update top (1) Shopify.ShopifyMerchantStoreLocations
set StorePickup = 1 
where id = 111