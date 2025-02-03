SELECT
    Id_cie AS BrandID,
    cie AS BrandName,
    (CASE 
        WHEN Id_cie IN (1436,2768,3437,2434,2584,3181,3182,3184,4226,4227,2067,1920,2565,2982,3038,7860,2982,7793,2424,7789,4340,7793,2611) THEN 'feed'
        WHEN HasAutomatedPricing = 1 THEN 'automated Pricing'
        WHEN maintained = 1 THEN 'maintained' 
        WHEN (SELECT COUNT(*) FROM Products WHERE manufID = Id_cie AND active = 1 AND discontinued = 0) > 4 THEN 'standard'
        WHEN (SELECT COUNT(*) FROM Products WHERE manufID = Id_cie AND active = 1 AND discontinued = 0) <= 4 THEN 'niche'
        ELSE 'unknown'
    END) AS FirstTag
FROM
    (SELECT 
        Companies.Id_cie, 
        Companies.cie, 
        Companies.maintained, 
        Companies.HasAutomatedPricing, 
        COUNT(MerchantProdsCompanies.Merchant_ID) AS ActiveMerchantsCount
    FROM 
        MerchantProdsCompanies
    INNER JOIN Companies ON Companies.Id_cie = MerchantProdsCompanies.cieid
    INNER JOIN merchants ON merchants.ID = MerchantProdsCompanies.Merchant_ID
    WHERE 
        merchants.active = 1
        AND merchants.merchant_url NOT LIKE '%tailbase%'
        AND merchants.Merchant NOT LIKE '%demo%'
        AND merchants.Merchant NOT LIKE '%internal%'
        AND merchants.Merchant NOT LIKE '% old'
        AND merchants.Merchant NOT LIKE '%test%'
        AND merchants.merchant <> 'E-store'
        AND Companies.Id_cie NOT IN (8652,8653,1446,8743,5568,6044,6916,8807,1492)
    GROUP BY 
        Companies.Id_cie, 
        Companies.cie, 
        Companies.maintained, 
        Companies.HasAutomatedPricing
    ) AS qry
ORDER BY 
    ActiveMerchantsCount DESC;

