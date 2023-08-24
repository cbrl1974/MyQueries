use tailbasify
DECLARE @MerchantId AS INT = 3390;
DECLARE @NewShopifyMerchantId AS INT;
DECLARE @shopifyMerchantUrl AS varchar(max) = 'just-right-mattress-gallery.myshopify.com';
DECLARE @TailbasifyAppURL AS varchar(max) = 'jrmaga.tailbasify.com';
DECLARE @shopifyMerchantApiVersion AS varchar(10) = 'v2';
--You will Get this when you create the new app on Shopify apps
DECLARE @ShopifyApiKey as nvarchar(max) = 'f8059a6b88ce6a1f6a980371b7f352af'
DECLARE @ShopifySecretKey as nvarchar(max) = '99966fda135d3fd0e80dcb89323c6676'

update top (1) shopify.shopifyMerchants
set SHOPURL = 'just-right-mattress-gallery.myshopify.com'
where id = 55
-- Check Merchants for any existing merchant
select 
 s.*
from shopify.shopifyMerchants s
    inner join datatail20130410.dbo.merchants m on m.id = s.MerchantId
where s.id = 55

-- Links for the app installlation
--https://jrmaga.tailbasify.com/v2/api/shopify/install
--https://jrmaga.tailbasify.com/v2/api/Shopify/Authorize

--Insert New Store
	--INSERT INTO [Shopify].[ShopifyMerchants](MERCHANTID, SHOPURL, LIVE, SECURITYSTAMP, CREATIONDATE, MODIFICATIONDATE, APIKEY, SecretKey,APPURL, APIVersion)
	-- VALUES (@MerchantId, @shopifyMerchantUrl, 0, NEWID(), GETDATE(), GETDATE(), @ShopifyApiKey, @ShopifySecretKey, @TailbasifyAppURL, @shopifyMerchantApiVersion)
	-- SET @NewShopifyMerchantId = @@IDENTITY

--Add Record to Merchant Exports Table
 --INSERT INTO [dbo].[MerchantExports] (MERCHANTID, status, ShopifyMerchantId)
 --VALUES (@MerchantId, 1, @NewShopifyMerchantId)

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
DECLARE @NewShopifyMerchantIdForConfigs AS INT = 55;

-- select *
-- from shopify.ShopifyConfigurations
-- order by id

--Add Config Record
insert into shopify.ShopifyMerchantConfigurations (shopifyMerchantid, ShopifyConfigurationId, ConfigurationValue) values
(@NewShopifyMerchantIdForConfigs,1,'True'), -- Inventory
(@NewShopifyMerchantIdForConfigs,4,'English'), -- PrimaryLanguage
(@NewShopifyMerchantIdForConfigs,8,'True'),  -- PriceQualifier
(@NewShopifyMerchantIdForConfigs,3,'True')  -- AssociatedProducts

--Check Entry
select c.id, c.Configuration, sc.ConfigurationValue
from shopify.ShopifyMerchantConfigurations sc
    inner join shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = 55

select * from shopify.ShopifyMerchantConfigurations where ShopifyMerchantId = 51
delete from shopify.ShopifyMerchantConfigurations where id in (255,256,257) and ShopifyMerchantId = 51
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
  select * from datatail20130410.dbo.merchantstores where merchantid = 3390

  select * from datatail20130410.dbo.MerchantStoresInventory  where merchantid = 3390

  --Add record on ShopifyMerchantStoreLocations
DECLARE @NewShopifyMerchantIdForLocations AS INT = 55;
 insert into tailbasify.Shopify.ShopifyMerchantStoreLocations
     (Name, ShopifyMerchantId, ShopifyGeneratedLocationId, MerchantStoreId, StorePickup)
     values
		('Just Right Mattress Gallery', @NewShopifyMerchantIdForLocations, 'gid://shopify/Location/90010452242', 6514, 1)
		



--Chech entry 
select * from tailbasify.Shopify.ShopifyMerchantStoreLocations
where ShopifyMerchantId =  55




--In Case of an update

--update top (1) Shopify.ShopifyMerchantStoreLocations
--set StorePickup = 1 
--where id = 111