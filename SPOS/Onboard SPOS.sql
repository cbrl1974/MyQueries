Declare @merchantID as int = 3507;
select * from MerchantPosConfigs where merchantId = @merchantID

-- INSERT INTO MerchantPosConfigs (MerchantId, ApiKey, LocalPath, [FileName], Config) VALUES
-- (
--  @merchantID,
--  NEWID(),
--  '/GermainLariviere/ProductInventory',
--  'ProductInventory.json',
--  '{"ProcessProducts": true, "ProcessInventory": true, "ProcessMerchantItemTags": false, "ProcessAdditionalInformation": false}'
-- )

select * from MerchantPosConfigs where merchantId = @merchantID


select top 250 * from MerchantPosLogs
order by time desc
 

select distinct InventoryType from MerchantInventoryTypes

select * from MerchantInventoryTypes

--insert into MerchantInventoryTypes values
--(3507,'Total',1)

--update top (1) MerchantInventoryTypes
--set InventoryType = 'Total'
--where merchantid = 3507