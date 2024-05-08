--Delete Specific Products Shopify

-- *** Make sure that the product or collection are deleted also from the console first if exists.
DECLARE @shopifycollectionID AS INT = 17720
-- Delete Collections
BEGIN TRANSACTION
  delete from  [Shopify].[ShopifyCollectionRuleInputs] where ShopifyMerchantCollectionId = @shopifycollectionID
  delete  from shopify.ShopifyMerchantCollections where id  = @shopifycollectionID
  delete  from shopify.ShopifyCollectionSyncReportsDetail where shopifycollectionID = @shopifycollectionID
COMMIT TRANSACTION


