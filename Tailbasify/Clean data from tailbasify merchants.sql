declare @merchantId int = 1448

delete from shopify.ShopifyMerchantMetafields where ShopifyProductId in
(select id from shopify.ShopifyProducts where MerchantId=@merchantId ) 

delete from shopify.ShopifyProductVariants where ShopifyProductID in
(select id from shopify.ShopifyProducts where MerchantId=@merchantId) 

delete from shopify.ShopifyProductVariantMetafields where ShopifyProductVariantId in
(select id from shopify.ShopifyProductVariants where ShopifyProductID in
(select id from shopify.ShopifyProducts where MerchantId=@merchantId))

delete from shopify.ShopifyProductMedia where ShopifyProductID in
(select id from shopify.ShopifyProducts where MerchantId=@merchantId)

delete from  [Shopify].[ShopifyCollectionRuleInputs] where ShopifyMerchantCollectionId in
(select id from shopify.ShopifyMerchantCollections where MerchantId=@merchantId)

delete from  shopify.ShopifyProducts where MerchantId=@merchantId

delete from shopify.ShopifyMerchantCollections where MerchantId=@merchantId

