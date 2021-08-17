use datatail20130410
Declare @MerchantID as int = 1918;
  
SELECT 	textcode,content_1 AS content
FROM 	MerchantWebsiteTexts
WHERE   merchant_ID = @MerchantID 
AND textcode like 'ScLink%'

insert into MerchantWebsiteTexts (merchant_id,textcode,content_1) values
(@MerchantID ,'SCLINKYELP','https://www.yelp.ca/user_details?userid=V26kIqy0RrH-rzCeKDUMGA')

delete top (1) from MerchantWebsiteTexts
WHERE   merchant_ID = @MerchantID 
and textcode = 'SCLINKYELP'