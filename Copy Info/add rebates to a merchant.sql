Declare @SourceMerchantID as int = 1727;
Declare @DestinationMerchantID as int = 3547;

insert into MerchantRebateGroups (merchant_id,rebateGroupId,active,memberId,locationID,defaultShow)
select @DestinationMerchantID,rebateGroupId,active,memberId,locationID,defaultShow
from MerchantRebateGroups where merchant_id = @SourceMerchantID


select * from merchantRebates where merchant_id = 3547