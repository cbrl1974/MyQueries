DECLARE @MerchantStoreId AS INT = 5561

INSERT INTO MerchantStoreInfos(MerchantStoreId,InfoLabel,InfoValue,DisplayType,DisplayOrder)
SELECT @MerchantStoreId, * 
FROM (
	VALUES 
		('Store Page','cp-furniture-gallery-summerside','Internal Link',1),
		('Unique ID','','Simple Text',2),
		('Is BSC','1','Boolean',3),
		('Website','https://www.furnituregallery.ca/','External Link',4),
		('Toll Free','0','Simple Text',5),
		('Has Appliances','1','Boolean',6),
		('Has Furniture','1','Boolean',7),
		('Has Mattresses','1','Boolean',8),
		('Has Electronics','0','Boolean',9),
		('Has Delivery Service','1','Boolean',10),
		('Has Installation Service','0','Boolean',11),
		('Has Repair Service','0','Boolean',12),
		('Has Design Service','0','Boolean',13),
		('Has Parts Service','0','Boolean',14),
		('Has Financing','1','Boolean',15),
		('BrandList','','Brand List',16)
)
AS SI(InfoLabel,InfoValue,DisplayType,DisplayOrder)



