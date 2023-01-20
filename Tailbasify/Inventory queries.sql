-- Get Merchants info
select 
s.id, m.merchant, s.MerchantId, s.ShopUrl, s.SecurityStamp, s.ApiVersion
from shopify.shopifyMerchants s
    inner join devTailbasecore.dbo.merchants m on m.id = s.MerchantId
where m.id = 1448

-- Get MerchantExports status
select  m.merchant, me.*
from MerchantExports me
 inner join devTailbasecore.dbo.merchants m on m.id = me.MerchantId
order by [Status] desc, ModificationDate desc

-- Get MerchantExports status if stucked
update top (1) MerchantExports
set [status] = 1
where merchantid = 1448

-- Get logs info Converter
select top 10 * from logs  WITH (NOLOCK)
WHERE  merchantid = 1448
    AND module = 'Converter'
order by LogTime desc


-- Get logs info Synchronizer
select top(50) * from logs  WITH (NOLOCK)  
WHERE  merchantid = 1448
AND module = 'Synchronizer'
order by id desc



--Check the values on the db shopify.shopifyProducts table
select id, tailbaseid, handle, SyncStatusId, InventorySyncStatusId 
from shopify.shopifyProducts 
where merchantid = 1448 
and handle = 'whirlpool-lave-vaisselle-integre-de-24-po-avec-cycle-de-lavage-1-heure-wdf330pahb'
and id = 768857

--Check the values on the db shopify.ShopifyProductVariants  table
select *
from shopify.ShopifyProductVariants 
where ShopifyProductID  = 768857

--Inventory table
--Check the current Inventory for the merchant
select * from devtailbasecore.dbo.merchantstoresInventory where merchantid = 1448

--add Inventory
insert into devtailbasecore.dbo.merchantstoresInventory values
(1448,409669,1, 5141, 7,5)

--remove Inventory
DELETE FROM devtailbasecore.dbo.merchantstoresInventory
WHERE merchantid = 1448 

--Configs
--Check Configs for the merchant
select c.*, sc.*
from shopify.ShopifyMerchantConfigurations sc
    inner join shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = 5

--Delete Configs
delete top (1) shopify.ShopifyMerchantConfigurations where  shopifyMerchantId = 5 and ShopifyconfigurationId = 2

--Insert Configs
insert into shopify.ShopifyMerchantConfigurations values
(5,1,'False'), -- Inventory
(5,2,'False') -- Sell OutOfStock

--Update Configs
update top (2) shopify.ShopifyMerchantConfigurations 
set configurationvalue = 'True'
where shopifyMerchantId = 5
and ShopifyconfigurationId in (1,2)

