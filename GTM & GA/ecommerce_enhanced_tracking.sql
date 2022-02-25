DECLARE @MerchantID as int = 3382;
DECLARE @GoogleAnalyticsID as varchar(20) = 'UA-221362734-1';

insert into merchantwebsitefeatures values 
(@MerchantID,'hasEcommerce',''),
(@MerchantID,@GoogleAnalyticsID,'')
