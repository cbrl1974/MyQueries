Declare @MerchantID as int = 2676;
Declare @googleAnalyticsID as int = UA-162082285-1;


select * from merchantwebsitefeatures
where merchant_id = @MerchantID
and featurecode = 'googleAnalyticsID'

insert into merchantwebsitefeatures values
(@MerchantID,'googleAnalyticsID', @googleAnalyticsID),
(@MerchantID,'hasECommerce',NULL)

update top (1) merchantwebsitefeatures
set featureValue = @googleAnalyticsID
where merchant_id = @MerchantID
and featurecode = 'googleAnalyticsID'

//https://docs.microsoft.com/en-us/sql/t-sql/language-elements/if-else-transact-sql?view=sql-server-ver15





