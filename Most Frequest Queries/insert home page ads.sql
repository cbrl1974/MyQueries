DECLARE @MerchantId AS INT = 3009;
select * from MerchantWebsiteTexts where merchant_id = @MerchantId and textcode like  '%homepagead%'

insert into MerchantWebsiteTexts (merchant_id,textcode,content_1) values
(@MerchantId,'homePageAd10AltText',''),
(@MerchantId,'homePageAd10Image','home-page-ad-10.jpg'),
(@MerchantId,'homePageAd10Link','')


