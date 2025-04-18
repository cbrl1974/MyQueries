   SELECT
        Id_cie AS BrandID,
        cie AS BrandName,
        (CASE WHEN maintained = 1 THEN 'Yes' ELSE 'No' END) AS IsBrandMaintained,
        COUNT(ID) AS NbrOfActiveMerchants,
        'https://alt-content.tailbase.com/www/cies/' + CONVERT(varchar, Id_cie) + '.gif' AS BrandLogoPath,

        (SELECT COUNT(*)
         FROM Products
         WHERE active = 1 AND discontinued = 0 AND manufID = Id_cie) AS NumberOfActiveProducts,

          -- We cannot Join of Feeds so I simply hardcoded what we have so far.
        IIF(Id_cie IN (1436,2768,3437,2434,2584,3181,3182,3184,4226,4227,2067,1920,2565,2982,3038,7860,2982,7793,2424,7789,4340,7793,2611,7793,2185,1946,2180,3380), 'YES', 'NO') AS IsFeedAvailable,

        IIF(HasAutomatedPricing = 1, 'YES', 'NO') AS HasAutomatedPricing,

		IIF(COUNT(ID) <= 4, 'YES', 'NO') AS ISNICHE

    FROM (
        SELECT Companies.Id_cie, Companies.cie, merchants.ID, Companies.maintained, Companies.HasAutomatedPricing
        FROM MerchantProdsCompanies
        INNER JOIN Companies ON Companies.Id_cie = MerchantProdsCompanies.cieid
        INNER JOIN merchants ON merchants.ID = MerchantProdsCompanies.Merchant_ID
        WHERE merchants.active = 1
            AND merchants.merchant_url NOT LIKE '%tailbase%'
            AND merchants.Merchant NOT LIKE '%demo%'
            AND merchants.Merchant NOT LIKE '%internal%'
            AND merchants.Merchant NOT LIKE '% old'
            AND merchants.Merchant NOT LIKE '%test%'
            AND merchants.merchant <> 'E-store'
            and Companies.Id_cie not in (8652,8653,1446,8743,5568,6044,6916,8807,1492)
        GROUP BY Companies.Id_cie, Companies.cie, merchants.ID, Companies.maintained, Companies.HasAutomatedPricing
    ) AS qry

    GROUP BY Id_cie, cie, maintained, HasAutomatedPricing
    ORDER BY
        NbrOfActiveMerchants DESC
