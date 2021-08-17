UPDATE M SET M.flyer_management = 0
--SELECT * 
FROM Merchants M
JOIN MerchantWebsiteFeatures F ON F.Merchant_Id = M.ID AND F.FeatureCode = 'template'
WHERE F.FeatureValue IN ('tbmega1','tbmega2')
AND M.flyer_management = 1