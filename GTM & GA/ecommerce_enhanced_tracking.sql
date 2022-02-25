DECLARE @MerchantID as int = 3372;
DECLARE @GoogleAnalyticsID as varchar(20) = 'UA-159292788-1';

insert into merchantwebsitefeatures values 
(@MerchantID,'hasEcommerce', NULL),
(@MerchantID,'googleAnalyticsID',@GoogleAnalyticsID)

