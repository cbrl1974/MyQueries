DECLARE @TargetId AS INT = 1210
DECLARE @MerchantStoreId AS INT = 4882
DECLARE @MerchantStorePage AS VARCHAR(100) = 'airdrie-appliance-and-furniture-airdrie' -- (Slug WITHOUT cp)
DECLARE @MerchantStorePageId AS INT
DECLARE @MerchantStoreName AS VARCHAR(100)

INSERT INTO MerchantWebsitePages(merchant_id, name, slug, WebsitePageDesignId, active, useV2Rendering)
SELECT @TargetId, S.Store + ' Page', @MerchantStorePage, 28, 1, 1
FROM MerchantStores S
WHERE S.Id = @MerchantStoreId


SELECT @MerchantStorePageId = @@identity
SELECT @MerchantStoreName = Store FROM MerchantStores WHERE MerchantId = @TargetId AND Id = @MerchantStoreId


INSERT INTO MerchantWebsitePageContent(MerchantWebsitePageId, ContentCode, Content, Id_langue)
SELECT @MerchantStorePageId, * 
FROM (
	VALUES 
		('PageTitle',@MerchantStoreName,1),
		('Picture1Image','',1),
		('Picture1AltText','',1),
		('Picture1Link','',1),
		('StoreGallery1Image','',1),
		('StoreText','',1),
		('StoreId',cast(@MerchantStoreId as varchar(10)),1),
		('MetaDescription','',1),
		('PageTitle',@MerchantStoreName,2),
		('Picture1Image','',2),
		('Picture1AltText','',2),
		('Picture1Link','',2),
		('StoreGallery1Image','',2),
		('StoreText','',2),
		('StoreId',cast(@MerchantStoreId as varchar(10)),2),
		('MetaDescription','',2)
)
AS PC(ContentCode, Content, Id_langue)






