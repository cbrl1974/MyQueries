SELECT 
    m.id, 
    m.AccountingID, 
    m.merchant, 
    m.merchant_url, 
    mwi.infoValue, 
    oldestStore.province AS State,
    oldestStore.email AS Email,
    oldestStore.phone AS Phone,
    CASE WHEN mwf.featureValue IS NOT NULL THEN 'YES' ELSE 'No' END AS HasShoppingCart,
    CASE WHEN coPricing.HasAutomatedPricing = 1 THEN 'YES' ELSE 'No' END AS HasAutomatedPricing,
    brandList.Brands
FROM merchants m
    INNER JOIN MerchantWebsiteInformation mwi 
        ON mwi.merchant_id = m.id 
    CROSS APPLY (
        SELECT TOP 1 ms.province, ms.email, ms.phone
        FROM MerchantStores ms
        WHERE ms.MerchantID = m.id
        ORDER BY ms.id ASC 
    ) AS oldestStore
    CROSS APPLY (
        SELECT STUFF((
            SELECT DISTINCT ', ' + co2.cie
            FROM merchantBrands mb2
            INNER JOIN companies co2 
                ON co2.id_cie = mb2.cieid
            WHERE mb2.merchant_id = m.id
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS Brands
    ) AS brandList
    INNER JOIN merchantprods mp 
        ON mp.merchant_id = m.id
    INNER JOIN products p 
        ON p.id_product = mp.productid
    INNER JOIN companies coPricing 
        ON coPricing.id_cie = p.manufid
    LEFT JOIN merchantwebsitefeatures mwf 
        ON mwf.merchant_id = m.id 
       AND mwf.featureCode = 'shoppingCartType'
WHERE 
    m.active = 1
    AND m.merchant_url NOT LIKE '%tailbase%'
    AND m.merchant NOT LIKE '%tailbase%'
    AND m.merchant NOT LIKE '%old%'
    AND m.countryCode = 'US'
    AND coPricing.BrandFamilyId = 3
GROUP BY 
    m.id, 
    m.AccountingID, 
    m.merchant, 
    m.merchant_url, 
    mwi.infoValue, 
    oldestStore.province,
    oldestStore.email,
    oldestStore.phone,
    mwf.featureValue,
    coPricing.HasAutomatedPricing,
    brandList.Brands;
