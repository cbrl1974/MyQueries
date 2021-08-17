SELECT *
FROM (
	SELECT M.ID,M.Merchant_Code,
		STUFF (
			(
				SELECT DISTINCT '"' + C.Cie 
				FROM (
					SELECT	DISTINCT P.ManufId AS CieId
					FROM	MerchantProds MP
						JOIN Products P ON P.Id_Product = MP.ProductId
					WHERE	MP.Merchant_Id = M.Id
					UNION
					SELECT	DISTINCT MB.CieId
					FROM	MerchantBrands MB
					WHERE	MB.Merchant_Id = M.Id
				) DC
				JOIN Companies C ON C.Id_Cie = DC.CieId
				ORDER BY 1
				FOR XML PATH('')
			), 1, 1, ''
		) AS BrandsList
	FROM Merchants M
		JOIN MerchantWebsiteFeatures T ON T.Merchant_Id = M.Id AND T.FeatureCode = 'template' 
	WHERE M.Active = 1
		AND T.FeatureValue IN ('tbmega1','tbmega2')
) BL
WHERE BrandsList IS NOT NULL
ORDER BY 1