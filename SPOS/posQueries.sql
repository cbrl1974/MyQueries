use datatail20130410

--When onboarding you need to add the new merchant here 
select * from datatail20130410.dbo.merchants where id = 3054
select * from datatail20130410.dbo.MerchantPosConfigs

--CheckLogs
select  * from datatail20130410.dbo.MerchantPosLogs 
where time > convert(date,getdate()-1)
order by time desc



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