DECLARE @count INT;

select @count = COUNT(*) from shopify.ShopifyMerchantCollections  where  SyncStatusId  = 6
and ShopifyGeneratedCollectionId is null

select @count

IF @count > 0
	BEGIN
		delete from shopify.ShopifyCollectionRuleInputs where ShopifyMerchantCollectionId in 
		(
			select id from shopify.ShopifyMerchantCollections  where  SyncStatusId  = 6
		and ShopifyGeneratedCollectionId is null
		)

		delete from shopify.ShopifyMerchantCollections
		where  SyncStatusId  = 6
		and ShopifyGeneratedCollectionId is null
	END