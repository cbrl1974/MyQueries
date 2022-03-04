DECLARE @MerchantID as int = 3331;
DECLARE @GoogleAnalyticsID as varchar(20) = 'UA-213335548-1';
DECLARE @HasEcommerceCode as varchar(20) = 'hasEcommerce';
DECLARE @GoogleAnalyticsCode as varchar(20) = 'googleAnalyticsID';

--Check If exists
select * from  merchantwebsitefeatures
where merchant_id = @MerchantID
and featurecode in (@HasEcommerceCode, @GoogleAnalyticsCode)


insert into merchantwebsitefeatures values 
(@MerchantID,@HasEcommerceCode, NULL),
(@MerchantID,@GoogleAnalyticsCode,@GoogleAnalyticsID)

