--Delete Specific Products Shopify

-- *** Make sure that the product or collection are deleted also from the console first if exists.
DECLARE @shopifycollectionID AS INT = 
-- Delete Collections
BEGIN TRANSACTION
  delete top (1) from shopify.ShopifyMerchantCollections where id  = @shopifycollectionID
  delete top (1) from shopify.ShopifyCollectionSyncReportsDetail where shopifycollectionID = @shopifycollectionID
COMMIT TRANSACTION
