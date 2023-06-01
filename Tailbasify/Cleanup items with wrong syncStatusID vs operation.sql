select *
from shopify.shopifyProducts
where syncStatusID in (2,3)
and ShopifyGeneratedProductId is null

update  shopify.shopifyProducts
set syncStatusID = 1
where syncStatusID in (2,3)
and ShopifyGeneratedProductId is null


select *
from shopify.ShopifyMerchantCollections
where syncStatusID in (2,3)
and ShopifyGeneratedCollectionId is null

update  shopify.ShopifyMerchantCollections
set syncStatusID = 1
where syncStatusID in (2,3)
and ShopifyGeneratedCollectionId is null
