Declare @merchantID as int = 1479;
select * from MerchantPosConfigs where merchantId = @merchantID

-- INSERT INTO MerchantPosConfigs (MerchantId, ApiKey, LocalPath, [FileName], Config) VALUES
-- (
--  @merchantID,
--  NEWID(),
--  '/GermainLariviere/ProductInventory',
--  'ProductInventory.json',
--  '{"ProcessProducts": true, "ProcessInventory": true, "ProcessMerchantItemTags": false, "ProcessAdditionalInformation": false}'
-- )

select * from MerchantPosConfigs 


select top 250  m.id, m.merchant, pos.* from MerchantPosLogs pos
inner join merchants m on m.id = pos.MerchantId
order by  time desc, MerchantId
 
