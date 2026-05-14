--Delete Specific Products Shopify
-- 1860321
-- 1860253
-- 1860246
-- *** Make sure that the product or collection are deleted also from the console first if exists.
use tailbasify
declare @merchantId int = 3621;
declare @shopifyProductid int = 3610793;
BEGIN TRANSACTION
delete from tailbasify.shopify.ShopifyMerchantMetafields where ShopifyProductId in
(select id
from tailbasify.shopify.ShopifyProducts
where MerchantId=@merchantId and id = @shopifyProductid )

delete from tailbasify.shopify.ShopifyProductVariants where ShopifyProductID in
(select id
from tailbasify.shopify.ShopifyProducts
where MerchantId=@merchantId and id = @shopifyProductid )

delete from tailbasify.shopify.ShopifyProductVariantMetafields where ShopifyProductVariantId in
(select id
from tailbasify.shopify.ShopifyProductVariants
where ShopifyProductID in
(select id
from tailbasify.shopify.ShopifyProducts
where MerchantId=@merchantId and id = @shopifyProductid))

delete from tailbasify.shopify.ShopifyProductMedia where ShopifyProductID in
(select id
from tailbasify.shopify.ShopifyProducts
where MerchantId=@merchantId and id = @shopifyProductid)


delete from  tailbasify.shopify.ShopifyProducts where MerchantId=@merchantId and id = @shopifyProductid
COMMIT TRANSACTION



-- DECLARE @shopifycollectionID AS INT = 
-- -- Delete Collections
-- BEGIN TRANSACTION
--   delete top (1) from tailbasify.shopify.ShopifyMerchantCollections where id  = @shopifycollectionID
--   delete top (1) from tailbasify.shopify.ShopifyCollectionSyncReportsDetail where shopifycollectionID = @shopifycollectionID
-- COMMIT TRANSACTION
