use datatail20130410
Declare @MerchantID as int = 2179;
Declare @TailbasifyInfoValue as varchar = 'Tailbasify';
Declare @PlatinumFeatureValue as varchar = 'tbplatinum';


select  top 10 * from MerchantWebsiteInformation where merchant_id = @MerchantID

update top (1) MerchantWebsiteInformation
set infoValue = @TailbasifyInfoValue
where merchant_id = @MerchantID

update top (1) merchantWebsiteFeatures
set featurevalue = @PlatinumFeatureValue 
where featurecode = 'template'
and merchant_id = @MerchantID
