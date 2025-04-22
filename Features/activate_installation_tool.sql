
DECLARE @InstallationTool AS varchar(200) = 'installationsSettings';
DECLARE @MerchantID AS int = 2217;

--Check if orders in the merchantcms table
select orders from merchantCms where merchant_id = @MerchantID 

--Check if Installation tool already in place
select * from merchantwebsitefeatures where merchant_id = @MerchantID and featurecode =  @InstallationTool


--Activate orders
update top (1) merchantCms
set orders = 1
where merchant_id =  @MerchantID



--Add Installation Tool
insert into merchantwebsitefeatures (merchant_id, featureCode) VALUES
(@MerchantID, @InstallationTool)

--Confirm if Installation tool already in place
select * from merchantwebsitefeatures where merchant_id = @MerchantID and featurecode =  @InstallationTool

