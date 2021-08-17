DECLARE @TargetId AS INT = 1680

UPDATE O SET O.FeatureValue = '(CASE WHEN mpe.displayorder IS NULL THEN 1 ELSE 0 END), ISNULL(mpe.displayorder, 0), mpe.specialbuy DESC, mpe.brandHidden DESC, mc.display_order, mpe.category, mpe.cie ASC, ISNULL(mpe.realprice, 9999999) ASC'
--SELECT * 
FROM Merchants M
JOIN MerchantWebsiteFeatures F ON F.Merchant_Id = M.ID AND F.FeatureCode = 'template'
LEFT JOIN MerchantWebsiteFeatures O ON O.Merchant_Id = M.ID AND O.FeatureCode = 'defaultSort'
WHERE F.FeatureValue IN ('tbmega1','tbmega2') 
AND O.Merchant_Id IS NOT NULL
AND M.id = @TargetId


INSERT INTO MerchantWebsiteFeatures(Merchant_Id, FeatureCode, FeatureValue)
SELECT  M.Id, 'defaultSort', '(CASE WHEN mpe.displayorder IS NULL THEN 1 ELSE 0 END), ISNULL(mpe.displayorder, 0), mpe.specialbuy DESC, mpe.brandHidden DESC, mc.display_order, mpe.category, mpe.cie ASC, ISNULL(mpe.realprice, 9999999) ASC'
FROM Merchants M
JOIN MerchantWebsiteFeatures F ON F.Merchant_Id = M.ID AND F.FeatureCode = 'template'
LEFT JOIN MerchantWebsiteFeatures O ON O.Merchant_Id = M.ID AND O.FeatureCode = 'defaultSort'
WHERE F.FeatureValue IN ('tbmega1','tbmega2') 
AND O.Merchant_Id IS NULL
AND M.id = @TargetId


