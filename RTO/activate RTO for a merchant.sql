Declare @merchantid INT = 2758;

select * from datatail20130410.dbo.merchantwebsitefeatures where merchant_id =  @merchantid

insert into datatail20130410.dbo.merchantwebsitefeatures  VALUES
(@merchantid,'hasPricingOptions','')