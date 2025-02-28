-- Get Merchants info
use devtailbasify
select
    s.id, m.merchant, s.MerchantId, s.ShopUrl, s.SecurityStamp, s.ApiVersion
from shopify.shopifyMerchants s
    inner join devtailbasecore.dbo.merchants m on m.id = s.MerchantId
where m.id = 3388

select distinct top 100
    *
from logs  WITH (NOLOCK)
WHERE  merchantid = 3388
order by LogTime desc

select top 100
    *
from Shopify.ShopifySyncReports h WITH (NOLOCK)
    join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 3388
    and d.ShopifyProductId in (802546)
order by h.id desc



select l.*
from devtailbasecore.dbo.MerchantStores ms
    inner join Shopify.ShopifyMerchantStoreLocations l on l.MerchantStoreId = ms.id
where ms.MerchantID = 1448


select *
from devtailbasecore.dbo.merchantstoresInventory
where merchantid = 3230

select *
from devtailbasecore.dbo.MerchantInventoryTypes
order by MerchantId

select *
from devtailbasecore.dbo.merchantStores
where MerchantID = 3230

select *
from Shopify.ShopifyMerchantStoreLocations
where shopifyMerchantId = 57

insert into Shopify.ShopifyMerchantStoreLocations
    (ShopifyMerchantId, [name], ShopifyGeneratedLocationId, MerchantStoreId, IncludeInventoryAsTags, IncludeInventory, StorePickup, OnlineStockThreshold)
VALUES
    (57, 'Tempe Location', 'gid://shopify/Location/100014588210', 6841, 0, 0, 1, null)



-- update top (2) Shopify.ShopifyMerchantStoreLocations
-- set IncludeInventoryAsTags = 1
-- where ShopifyMerchantId = 4

select *
from devtailbasecore.dbo.MerchantStores
where merchantid =   3230

select *
from devtailbasecore.dbo.merchantstoresInventory
where merchantid = 3230
select *
from devtailbasecore.dbo.MerchantInventoryStore
where merchant_id = 3230


select sp.MerchantId, sp.id, sp.TailbaseID, sp.handle, sp.tags, sp.SyncStatusId, sp.ModificationDate, si.Quantity, mt.InventoryType
from shopify.shopifyProducts sp
    inner join devtailbasecore.dbo.merchantstoresInventory si on si.MerchantId = sp.MerchantId
        and si.ItemId = sp.TailbaseId and si.ItemType = 1
    inner join devtailbasecore.dbo.MerchantInventoryTypes mt on mt.Id = si.MerchantInventoryTypeId and mt.MerchantId = sp.MerchantId
where sp.MerchantId = 3388
    and sp.ItemType = 1
    and sp.tailbaseid in (44160,76142,43888)

SELECT *
from shopify.ShopifyProductVariants
where shopifyProductid = 802546











