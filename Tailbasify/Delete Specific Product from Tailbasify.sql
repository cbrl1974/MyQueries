--Delete Specific Products Shopify
-- 1860321
-- 1860253
-- 1860246
-- *** Make sure that the product or collection are deleted also from the console first if exists.
use devtailbasify
declare @merchantId int = 2798;
declare @shopifyProductid int = 1057698;
BEGIN TRANSACTION
delete from devtailbasify.shopify.ShopifyMerchantMetafields where ShopifyProductId in
(select id
from devtailbasify.shopify.ShopifyProducts
where MerchantId=@merchantId and id = @shopifyProductid )

delete from devtailbasify.shopify.ShopifyProductVariants where ShopifyProductID in
(select id
from devtailbasify.shopify.ShopifyProducts
where MerchantId=@merchantId and id = @shopifyProductid )

delete from devtailbasify.shopify.ShopifyProductVariantMetafields where ShopifyProductVariantId in
(select id
from devtailbasify.shopify.ShopifyProductVariants
where ShopifyProductID in
(select id
from devtailbasify.shopify.ShopifyProducts
where MerchantId=@merchantId and id = @shopifyProductid))

-- delete from devtailbasify.shopify.ShopifyProductMedia where ShopifyProductID in
-- (select id
-- from devtailbasify.shopify.ShopifyProducts
-- where MerchantId=@merchantId and id = @shopifyProductid)


delete from  devtailbasify.shopify.ShopifyProducts where MerchantId=@merchantId and id = @shopifyProductid
COMMIT TRANSACTION



-- DECLARE @shopifycollectionID AS INT = 
-- -- Delete Collections
-- BEGIN TRANSACTION
--   delete top (1) from devtailbasify.shopify.ShopifyMerchantCollections where id  = @shopifycollectionID
--   delete top (1) from devtailbasify.shopify.ShopifyCollectionSyncReportsDetail where shopifycollectionID = @shopifycollectionID
-- COMMIT TRANSACTION
