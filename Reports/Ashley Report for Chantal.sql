--THe first one does not have the column "Is Ashley defaulted to first position on product pages if no other sorting criteria is stated by retailer?" but the second one has and it takes 2:35 minutes secs to complete

;WITH
    cleaned_merchants
    AS
    (
        SELECT
            'Tailbase' as Company,
            m.id,
            m.merchant,
            m.merchant_url,
            m.active AS isActive,
            mf.remoteFTPUser,
            mfe.FeedOptionsJson,
            mfe.ModifiedOn,
            mfe.merchantid AS mfe_merchantid,
            mf.lastModified AS rawLastModified,
            mf.active AS isAshleyFeedActive,
            COALESCE(
            TRY_CAST(REPLACE(REPLACE(mf.lastModified, '{ts ''', ''), '''}', '') AS datetime),
            mfe.ModifiedOn
        ) AS lastmodified,
            COALESCE(
            SUBSTRING(mf.remoteFTPUser, 4, 6),
            JSON_VALUE(mfe.FeedOptionsJson, '$.CustomerId')
        ) AS AccountNumber
        FROM merchants m
            LEFT JOIN merchantfeeds mf ON m.id = mf.merchant_id
            LEFT JOIN feeds.merchantfeeds mfe ON mfe.merchantid = m.id AND mfe.FeedId = 9
    ),

    ashley_pages
    AS
    (
        SELECT DISTINCT
            mwp.merchant_id,
            'YES' AS HasAshleyLandingPage
        FROM merchantwebsitepages mwp
        WHERE mwp.name LIKE '%Ashley%'
            OR mwp.name LIKE '%Ashley Sleep%'
            OR mwp.name LIKE '%Benchcraft%'
            OR mwp.name LIKE '%Millennium%'
            OR mwp.name LIKE '%Sierra Sleep%'
            OR mwp.name LIKE '%Signature Design%'
    )

SELECT
    cm.Company,
    cm.id,
    MAX(cm.merchant) AS merchant,
    MAX(cm.AccountNumber) AS AccountNumber,
    MAX(cm.merchant_url) AS merchant_url,

    MAX(CASE 
        WHEN mwf.featurecode = 'ShoppingCartType' THEN 'yes' 
        WHEN mwi.infoCode = 'template' AND mwi.infoValue LIKE '%Tailbasify%' THEN 'yes' 
        ELSE 'no' 
    END) AS EcommerceSite,

    MAX(CASE 
        WHEN ms.dropShippingProgramID = 1 THEN 'yes' 
        ELSE 'no' 
    END) AS DirectExress,

    CASE 
        WHEN COUNT(DISTINCT CASE WHEN mb.cieId IN (1436, 4227, 3184, 3182, 4226, 3181) THEN mb.cieId END) = 6 
        THEN 'Ashley Only' 
        ELSE 'Multi MFG' 
    END AS isAshley,

    MAX(CASE 
        WHEN mc.RTOConsole = 1 THEN 'yes' 
        ELSE 'no' 
    END) AS isRTO,

    MAX(md.city) AS city,
    MAX(md.statecode) AS statecode,
    MAX(md.CountryName) AS CountryName,
    MAX(cm.lastmodified) AS lastmodified,

    MAX(
        'https://www.google.com/maps/place/' +
        REPLACE(
            CONCAT(
                ISNULL(mstore.address, ''), ' ',
                ISNULL(mstore.city, ''), ', ',
                ISNULL(mstore.province, ''), ' ',
                ISNULL(mstore.postalcode, ''), ', ',
                ISNULL(mstore.Country, '')
            ),
            ' ',
            '+'
        ) +
        '/@' + mstore.GeoPosition + ',17z'
    ) AS LocationUrl,

    COUNT(DISTINCT mp.productid) AS AshleyProdsOnWebsite,

    MAX(CASE 
        WHEN cm.isAshleyFeedActive = 1 THEN 'yes' 
        WHEN cm.mfe_merchantid IS NOT NULL THEN 'yes'  
        ELSE 'no' 
    END) AS IsAshleyFeedActiveInTheConsole,

    MAX(CASE 
        WHEN ap.HasAshleyLandingPage IS NOT NULL THEN 'YES'
        ELSE 'NO'
    END) AS HasAshleyLandingPage,

    MAX(mstore.city)        AS City,
    MAX(mstore.province)    AS Province,
    MAX(mstore.postalcode)  AS PostalCode,
    MAX(mstore.Country)     AS Country,
    MAX(mstore.GeoPosition) AS geoLocation

FROM cleaned_merchants cm
    INNER JOIN merchantProds mp ON mp.Merchant_ID = cm.id
    INNER JOIN products p ON p.Id_product = mp.ProductID
    INNER JOIN merchantCms mc ON mc.Merchant_id = cm.id
    INNER JOIN MerchantWebsiteInformation mwi ON mwi.merchant_id = cm.id
    INNER JOIN merchantBrands mb ON mb.merchant_id = cm.id AND mb.cieId = p.manufID
    LEFT JOIN ashley_pages ap ON ap.merchant_id = cm.id
OUTER APPLY (
    SELECT TOP 1
        GeoPosition, city, province, postalcode, Country, address
    FROM MerchantStores ms2
    WHERE ms2.MerchantID = cm.id
    ORDER BY ms2.ID
) mstore
    LEFT JOIN MerchantDistributorWarehouseLocations md ON md.merchantid = cm.id
    LEFT JOIN merchantwebsitefeatures mwf ON mwf.merchant_id = cm.id AND mwf.featurecode = 'shoppingCartType'
    LEFT JOIN merchantshipping ms ON ms.merchant_id = md.MerchantID AND ms.dropShippingProgramID = 1

WHERE 
    cm.isActive = 1
    AND (cm.rawLastModified IS NOT NULL OR cm.mfe_merchantid IS NOT NULL)
    AND p.manufID IN (1486, 6183, 3181, 3182, 3184, 4226, 4227)

GROUP BY cm.id, cm.Company
ORDER BY cm.id, cm.Company;

--***************** new one with the column "Is Ashley defaulted to first position on product pages if no other sorting criteria is stated by retailer?"

;WITH
    cleaned_merchants
    AS
    (
        SELECT
            'Tailbase' AS Company,
            m.id,
            m.merchant,
            m.merchant_url,
            m.active AS isActive,
            mf.remoteFTPUser,
            mfe.FeedOptionsJson,
            mfe.ModifiedOn,
            mfe.merchantid AS mfe_merchantid,
            mf.lastModified AS rawLastModified,
            mf.active AS isAshleyFeedActive,
            COALESCE(
            TRY_CAST(REPLACE(REPLACE(mf.lastModified, '{ts ''', ''), '''}', '') AS datetime),
            mfe.ModifiedOn
        ) AS lastmodified,
            COALESCE(
            SUBSTRING(mf.remoteFTPUser, 4, 6),
            JSON_VALUE(mfe.FeedOptionsJson, '$.CustomerId')
        ) AS AccountNumber
        FROM merchants m
            LEFT JOIN merchantfeeds mf ON m.id = mf.merchant_id
            LEFT JOIN feeds.merchantfeeds mfe ON mfe.merchantid = m.id AND mfe.FeedId = 9
    ),

    ashley_pages
    AS
    (
        SELECT DISTINCT
            mwp.merchant_id,
            'YES' AS HasAshleyLandingPage
        FROM merchantwebsitepages mwp
        WHERE mwp.name LIKE '%Ashley%'
            OR mwp.name LIKE '%Ashley Sleep%'
            OR mwp.name LIKE '%Benchcraft%'
            OR mwp.name LIKE '%Millennium%'
            OR mwp.name LIKE '%Sierra Sleep%'
            OR mwp.name LIKE '%Signature Design%'
    ),

    ashley_sort_check
    AS
    (
        SELECT DISTINCT
            cm.id AS MerchantID,
            'YES' AS IsAshleyDefaulted
        FROM cleaned_merchants cm
            JOIN merchantwebsitefeatures mf ON mf.merchant_id = cm.id
            LEFT JOIN merchantprods mp2 ON mp2.merchant_id = cm.id
            LEFT JOIN products p2 ON p2.id_product = mp2.productid
        WHERE (mf.featureCode LIKE '%sort%' AND mf.featureValue LIKE '%1436%')
            OR (p2.manufID IN (3181,3182,3184,4226,4227,1436) AND mp2.DisplayOrder IS NOT NULL)
    )

SELECT
    cm.Company,
    cm.id,
    MAX(cm.merchant) AS merchant,
    MAX(cm.AccountNumber) AS AccountNumber,
    MAX(cm.merchant_url) AS merchant_url,

    MAX(CASE 
        WHEN mwf.featurecode = 'ShoppingCartType' THEN 'yes' 
        WHEN mwi.infoCode = 'template' AND mwi.infoValue LIKE '%Tailbasify%' THEN 'yes' 
        ELSE 'no' 
    END) AS EcommerceSite,

    MAX(CASE 
        WHEN ms.dropShippingProgramID = 1 THEN 'yes' 
        ELSE 'no' 
    END) AS DirectExress,

    CASE 
        WHEN COUNT(DISTINCT CASE WHEN mb.cieId IN (1436, 4227, 3184, 3182, 4226, 3181) THEN mb.cieId END) = 6 
        THEN 'Ashley Only' 
        ELSE 'Multi MFG' 
    END AS isAshley,

    MAX(CASE 
        WHEN mc.RTOConsole = 1 THEN 'yes' 
        ELSE 'no' 
    END) AS isRTO,

    MAX(md.city) AS city,
    MAX(md.statecode) AS statecode,
    MAX(md.CountryName) AS CountryName,
    MAX(cm.lastmodified) AS lastmodified,

    MAX(
        'https://www.google.com/maps/place/' +
        REPLACE(
            CONCAT(
                ISNULL(mstore.address, ''), ' ',
                ISNULL(mstore.city, ''), ', ',
                ISNULL(mstore.province, ''), ' ',
                ISNULL(mstore.postalcode, ''), ', ',
                ISNULL(mstore.Country, '')
            ),
            ' ',
            '+'
        ) +
        '/@' + mstore.GeoPosition + ',17z'
    ) AS LocationUrl,

    COUNT(DISTINCT mp.productid) AS AshleyProdsOnWebsite,

    MAX(CASE 
        WHEN cm.isAshleyFeedActive = 1 THEN 'yes' 
        WHEN cm.mfe_merchantid IS NOT NULL THEN 'yes'  
        ELSE 'no' 
    END) AS IsAshleyFeedActiveInTheConsole,

    MAX(CASE 
        WHEN ap.HasAshleyLandingPage IS NOT NULL THEN 'YES'
        ELSE 'NO'
    END) AS HasAshleyLandingPage,

    MAX(mstore.city)        AS City,
    MAX(mstore.province)    AS Province,
    MAX(mstore.postalcode)  AS PostalCode,
    MAX(mstore.Country)     AS Country,
    MAX(mstore.GeoPosition) AS geoLocation,

    -- Latest addition: always YES or NO
    MAX(CASE 
        WHEN asc_check.IsAshleyDefaulted = 'YES' THEN 'YES'
        ELSE 'NO'
    END) AS [Is Ashley defaulted to first position on product pages if no other sorting criteria is stated by retailer?]

FROM cleaned_merchants cm
    INNER JOIN merchantProds mp ON mp.Merchant_ID = cm.id
    INNER JOIN products p ON p.Id_product = mp.ProductID
    INNER JOIN merchantCms mc ON mc.Merchant_id = cm.id
    INNER JOIN MerchantWebsiteInformation mwi ON mwi.merchant_id = cm.id
    INNER JOIN merchantBrands mb ON mb.merchant_id = cm.id AND mb.cieId = p.manufID
    LEFT JOIN ashley_pages ap ON ap.merchant_id = cm.id
    LEFT JOIN ashley_sort_check asc_check ON asc_check.MerchantID = cm.id
OUTER APPLY (
    SELECT TOP 1
        GeoPosition, city, province, postalcode, Country, address
    FROM MerchantStores ms2
    WHERE ms2.MerchantID = cm.id
    ORDER BY ms2.ID
) mstore
    LEFT JOIN MerchantDistributorWarehouseLocations md ON md.merchantid = cm.id
    LEFT JOIN merchantwebsitefeatures mwf ON mwf.merchant_id = cm.id AND mwf.featurecode = 'shoppingCartType'
    LEFT JOIN merchantshipping ms ON ms.merchant_id = md.MerchantID AND ms.dropShippingProgramID = 1

WHERE 
    cm.isActive = 1
    AND (cm.rawLastModified IS NOT NULL OR cm.mfe_merchantid IS NOT NULL)
    AND p.manufID IN (1486, 6183, 3181, 3182, 3184, 4226, 4227)

GROUP BY cm.id, cm.Company
ORDER BY cm.id, cm.Company;