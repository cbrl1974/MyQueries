declare @merchantId int = 1448

delete from devtailbasify.shopify.ShopifyMerchantMetafields where ShopifyProductId in
(select id
from devtailbasify.shopify.ShopifyProducts
where MerchantId=@merchantId )

delete from devtailbasify.shopify.ShopifyProductVariants where ShopifyProductID in
(select id
from devtailbasify.shopify.ShopifyProducts
where MerchantId=@merchantId)

delete from devtailbasify.shopify.ShopifyProductVariantMetafields where ShopifyProductVariantId in
(select id
from devtailbasify.shopify.ShopifyProductVariants
where ShopifyProductID in
(select id
from devtailbasify.shopify.ShopifyProducts
where MerchantId=@merchantId))

delete from devtailbasify.shopify.ShopifyProductMedia where ShopifyProductID in
(select id
from devtailbasify.shopify.ShopifyProducts
where MerchantId=@merchantId)

delete from devtailbasify.shopify.ShopifyProductMedia where ShopifyProductID in
(select id
from devtailbasify.shopify.ShopifyProducts
where MerchantId=@merchantId)

delete from  [DevTailbasify].[Shopify].[ShopifyCollectionRuleInputs] where ShopifyMerchantCollectionId in
(select id
from devtailbasify.shopify.ShopifyMerchantCollections
where MerchantId=@merchantId)

delete from  devtailbasify.shopify.ShopifyProducts where MerchantId=@merchantId

delete from devtailbasify.shopify.ShopifyMerchantCollections where MerchantId=@merchantId

