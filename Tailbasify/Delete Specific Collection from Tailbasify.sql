--Delete Specific Products Shopify

-- *** Make sure that the product or collection are deleted also from the console first if exists.
DECLARE @shopifycollectionID AS INT = 17702
-- Delete Collections
BEGIN TRANSACTION
  delete from  [Shopify].[ShopifyCollectionRuleInputs] where ShopifyMerchantCollectionId in
  (select id from shopify.ShopifyMerchantCollections where id = 17702)
  delete top (1) from shopify.ShopifyMerchantCollections where id  = @shopifycollectionID
  delete top (1) from shopify.ShopifyCollectionSyncReportsDetail where shopifycollectionID = @shopifycollectionID
COMMIT TRANSACTION


