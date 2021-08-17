DECLARE @TargetId AS INT = 1680
 
--UPDATE Fd SET Fd.FeatureValue = Fs.FeatureValue
----SELECT    Fs.*, Fd.* 
--FROM    Merchants M
--    JOIN  MerchantWebsiteFeatures Fs ON Fs.Merchant_Id = 1258 AND Fs.FeatureCode != 'ppublickey'
--    LEFT JOIN MerchantWebsiteFeatures Fd ON Fd.Merchant_Id = M.Id AND Fd.FeatureCode = Fs.FeatureCode
--WHERE    M.Id = @TargetId
--    AND Fd.Merchant_Id IS NOT NULL
--    AND ISNULL(Fs.FeatureValue,'') != ISNULL(Fd.FeatureValue,'')

--INSERT INTO MerchantWebsiteFeatures(Merchant_Id,FeatureCode,FeatureValue)
SELECT    M.Id, Fs.FeatureCode, Fs.FeatureValue 
FROM    Merchants M
    JOIN  MerchantWebsiteFeatures Fs ON Fs.Merchant_Id = 1210 AND Fs.FeatureCode != 'ppublickey'
    LEFT JOIN MerchantWebsiteFeatures Fd ON Fd.Merchant_Id = M.Id AND Fd.FeatureCode = Fs.FeatureCode
WHERE    M.Id = @TargetId
    AND Fd.Merchant_Id IS NULL



