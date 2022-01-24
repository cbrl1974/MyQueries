

DECLARE @InstallationTool AS varchar(200) = 'installationsSettings';
DECLARE @MerchantID AS int = 2217;

--Check if Installation tool already in place
select * from merchantwebsitefeatures where merchant_id = @MerchantID and featurecode =  @InstallationTool

--Add Installation Tool
insert into merchantwebsitefeatures (merchant_id, featureCode) VALUES
(@MerchantID, @InstallationTool)

--Confirm if Installation tool already in place
select * from merchantwebsitefeatures where merchant_id = @MerchantID and featurecode =  @InstallationTool

