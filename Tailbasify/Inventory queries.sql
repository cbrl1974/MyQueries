-- Get Merchants info
select 
s.id, m.merchant, s.MerchantId, s.ShopUrl, s.SecurityStamp, s.ApiVersion
from shopify.shopifyMerchants s
    inner join datatail20130410.dbo.merchants m on m.id = s.MerchantId
where m.id = 3388

select  distinct top 100 *  from logs  WITH (NOLOCK) 
WHERE  merchantid = 3388
order by LogTime desc 

select top 100 *    
from Shopify.ShopifySyncReports h WITH (NOLOCK)
    join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 3388
    and d.ShopifyProductId in (802546)
order by h.id desc



select  l.* from datatail20130410.dbo.MerchantStores ms 
inner join Shopify.ShopifyMerchantStoreLocations l  on l.MerchantStoreId = ms.id
where ms.MerchantID = 3065

select * from datatail20130410.dbo.merchantstoresInventory where merchantid = 1202
select * from datatail20130410.dbo.MerchantInventoryTypes order by MerchantId

--insert into Shopify.ShopifyMerchantStoreLocations (ShopifyMerchantId, ShopifyGeneratedLocationId, MerchantStoreId, IncludeInventoryAsTags, IncludeInventory, OnlineStockThreshold)
--VALUES
--(3388, 'gid://shopify/Location/60953231528', 6031, 1,1,4),
--(3388, 'gid://shopify/Location/63336612008', 6032, 1,1,4)



-- update top (2) Shopify.ShopifyMerchantStoreLocations
-- set IncludeInventoryAsTags = 1
-- where ShopifyMerchantId = 4

select * from datatail20130410.dbo.MerchantStores where merchantid =   3388

select * from datatail20130410.dbo.merchantstoresInventory where merchantid = 3388
select * from datatail20130410.dbo.MerchantInventoryStore where merchant_id = 3388

-- update top (1) datatail20130410.dbo.merchantstoresInventory
-- set Quantity = 2
-- where id = 13541219


select sp.MerchantId, sp.id,  sp.TailbaseID, sp.handle, sp.tags, sp.SyncStatusId,sp.ModificationDate, si.Quantity, mt.InventoryType from shopify.shopifyProducts sp 
    inner join datatail20130410.dbo.merchantstoresInventory si on si.MerchantId = sp.MerchantId 
    and si.ItemId = sp.TailbaseId and si.ItemType = 1
    inner join datatail20130410.dbo.MerchantInventoryTypes mt on mt.Id = si.MerchantInventoryTypeId and mt.MerchantId = sp.MerchantId
where sp.MerchantId = 3388
and sp.ItemType = 1 
and sp.tailbaseid in (44160,76142,43888)

SELECT * from shopify.ShopifyProductVariants where shopifyProductid = 802546











