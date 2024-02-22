--Delete Specific Products Shopify

-- *** Make sure that the product or collection are deleted also from the console first if exists.

declare @merchantId int = 3405;
declare @shopifyProductid int = 1607902;
BEGIN TRANSACTION
delete from shopify.ShopifyMerchantMetafields where ShopifyProductId in
(select id from shopify.ShopifyProducts where MerchantId=@merchantId and id = @shopifyProductid ) 

delete from shopify.ShopifyProductVariants where ShopifyProductID in
(select id from shopify.ShopifyProducts where MerchantId=@merchantId and id = @shopifyProductid ) 

delete from shopify.ShopifyProductVariantMetafields where ShopifyProductVariantId in
(select id from shopify.ShopifyProductVariants where ShopifyProductID in
(select id from shopify.ShopifyProducts where MerchantId=@merchantId and id = @shopifyProductid))

delete from shopify.ShopifyProductMedia where ShopifyProductID in
(select id from shopify.ShopifyProducts where MerchantId=@merchantId and id = @shopifyProductid)

delete from shopify.ShopifyMerchantProductMedia where ShopifyProductID in
(select id from shopify.ShopifyProducts where MerchantId=@merchantId and id = @shopifyProductid)

delete from  shopify.ShopifyProducts where MerchantId=@merchantId and id = @shopifyProductid
COMMIT TRANSACTION



DECLARE @shopifycollectionID AS INT = 
-- Delete Collections
BEGIN TRANSACTION
  delete top (1) from shopify.ShopifyMerchantCollections where id  = @shopifycollectionID
  delete top (1) from shopify.ShopifyCollectionSyncReportsDetail where shopifycollectionID = @shopifycollectionID
COMMIT TRANSACTION
