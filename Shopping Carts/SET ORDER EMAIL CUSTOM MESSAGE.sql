 use datatail20130410 Declare @MerchantID AS int = 2785

INSERT INTO merchantwebsitetexts (merchant_id,textcode,content_1) values (@MerchantID,'emailCustomMessage', 'Thank you for your order. One of our qualified representatives will reach out to you to finalize your order.')

INSERT INTO merchantwebsitefeatures values(@MerchantID,'showGeneralCustomMessageOnOrderEmailHeader',NULL) update top (1) merchantwebsitetexts

SET content_1 = 'One of our qualified representatives will reach out to you to finalize your order.'
WHERE merchant_id = @MerchantID 
AND textcode = 'emailCustomMessage'  