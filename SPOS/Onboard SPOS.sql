Declare @merchantID as int = 1479;
select * from MerchantPosConfigs where merchantId = @merchantID

INSERT INTO MerchantPosConfigs (MerchantId, ApiKey, LocalPath, [FileName], Config) VALUES
(
 @merchantID,
 NEWID(),
 '/GermainLariviere/ProductInventory',
 'ProductInventory.json',
 '{"ProcessProducts": true, "ProcessInventory": true, "ProcessMerchantItemTags": false, "ProcessAdditionalInformation": false}'
)

select * from MerchantPosConfigs where merchantId = @merchantID
 
