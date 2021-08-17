DECLARE @TargetId AS INT = 1680
DECLARE @Lang AS VARCHAR(10) = 'en'
DECLARE @PrefLang AS VARCHAR(10) = 'en'

--UPDATE MerchantWebsiteFeatures SET FeatureValue = @Lang WHERE Merchant_Id = @TargetId AND FeatureCode = 'languages'
-- MerchantWebsiteFeatures SET FeatureValue = @PrefLang WHERE Merchant_Id = @TargetId AND FeatureCode = 'preferredLanguage'

INSERT INTO MerchantWebsiteFeatures(Merchant_Id, FeatureCode, FeatureValue)
SELECT @TargetId, 'languages', @Lang
WHERE NOT EXISTS ( SELECT 1 FROM MerchantWebsiteFeatures WHERE Merchant_Id = @TargetId AND FeatureCode = 'languages')

INSERT INTO MerchantWebsiteFeatures(Merchant_Id, FeatureCode, FeatureValue)
SELECT @TargetId, 'preferredLanguage', @PrefLang
WHERE NOT EXISTS ( SELECT 1 FROM MerchantWebsiteFeatures WHERE Merchant_Id = @TargetId AND FeatureCode = 'preferredLanguage')


--select * from MerchantWebsiteFeatures where merchant_id = 1680 AND FeatureCode = 'preferredLanguage'

--update top (1)MerchantWebsiteFeatures set featurevalue = 'en' where merchant_id = 1680 AND FeatureCode = 'languages'
