--Delete Specific Products Shopify

-- *** Make sure that the product or collection are deleted also from the console first if exists.
DECLARE @shopifyproductid AS INT = 
BEGIN TRANSACTION
  delete top (1) from shopify.shopifyproductvariants where shopifyproductid  = @shopifyproductid
  delete top (1) from shopify.shopifyproductmedia where shopifyproductid  = @shopifyproductid
  delete top (1) from shopify.shopifyproductsyncreportsdetail where shopifyproductid  = @shopifyproductid
  delete top (1) from shopify.shopifymerchantmetafields where shopifyproductid  = @shopifyproductid
  delete top (1) from shopify.shopifymerchantproductmedia where shopifyproductid  = @shopifyproductid
  delete top (1) from shopify.shopifyproducts where id  = 
COMMIT TRANSACTION


DECLARE @shopifycollectionID AS INT = 
-- Delete Collections
BEGIN TRANSACTION
  delete top (1) from shopify.ShopifyMerchantCollections where id  = @shopifycollectionID
  delete top (1) from shopify.ShopifyCollectionSyncReportsDetail where shopifycollectionID = @shopifycollectionID
COMMIT TRANSACTION
