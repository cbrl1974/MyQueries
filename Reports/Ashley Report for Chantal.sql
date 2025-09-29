
;WITH cleaned_merchants AS (
    SELECT 
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
)

SELECT 
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

    COUNT(DISTINCT mp.productid) AS AshleyProdsOnWebsite,

    MAX(CASE 
        WHEN cm.isAshleyFeedActive = 1 THEN 'yes' 
        WHEN cm.mfe_merchantid IS NOT NULL THEN 'yes'  
        ELSE 'no' 
    END) AS IsAshleyFeedActiveInTheConsole,

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
OUTER APPLY (
    SELECT TOP 1 GeoPosition, city, province, postalcode, Country
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

GROUP BY cm.id
ORDER BY cm.id;


--************************** old one
--select m.id, m.merchant, SUBSTRING(mf.remoteFTPUser, 4, 6) as AccountNumber,
--    m.merchant_url,
--    (
--    CASE WHEN mwf.featurecode = 'ShoppingCartType' THEN 'yes' 
--	when mwi.infoCode = 'temaplate' and mwi.infoValue like '%Tailbasify%' then 'yes' 
--	else 'no' end
--) as EcommerceSite,
--    (
--    CASE WHEN ms.dropShippingProgramID = 1 THEN 'yes' else 'no' end
--) as DirectExress,
--    (
--    CASE 
--    WHEN COUNT(CASE WHEN mb.cieId IN (1436, 4227, 3184, 3182, 4226, 3181) THEN 1 ELSE NULL END) = 6 
--    THEN 'Ashley Only' 
--    ELSE 'Multi MFG' 
--    end
--) as isAshley,
--    (
--    CASE WHEN mc.RTOConsole = 1 THEN 'yes' else 'no' end
--) as isRTO,
--    md.city,
--    md.statecode,
--    md.CountryName,
--    replace(REPLACE(mf.lastModified,'{ts ''', ''), '''}','') as lastmodified,
--    count(distinct mp.productid) as AshleyProdsOnWebsite,
--     (
--        CASE WHEN mf.active = 1 THEN 'yes' else 'no' end
--    ) as IsAshleyFeedActiveInTheConsole
--from  merchants m 
--    inner join merchantProds mp on mp.Merchant_ID = m.id
--	inner join products p on p.Id_product = mp.ProductID
--	inner join merchantCms mc on mc.Merchant_id = m.id
--	inner join MerchantWebsiteInformation mwi on mwi.merchant_id = m.id
--    left join merchantfeeds mf on m.id = mf.merchant_id
--    inner join merchantBrands mb on mb.merchant_id = m.id and mb.cieId = p.manufID
--    left join MerchantDistributorWarehouseLocations md on md.merchantid = m.id
--    left join merchantwebsitefeatures mwf on mwf.merchant_id = m.id and mwf.featurecode = 'shoppingCartType'
--    left join merchantshipping ms on ms.merchant_id = md.MerchantID and ms.dropShippingProgramID = 1
--	left join feeds.merchantfeeds mfe on mfe.merchantid = m.id and mfe.FeedId = 9
--where ( mf.brand = 'Ashley' or mfe.FeedId = 9)
--    and m.active = 1	
--    and p.manufID in (1486,6183, 3181, 3182, 3184, 4226, 4227)
--group by m.id, m.merchant,mf.remoteFTPUser,m.merchant_url,mwf.featurecode,mwi.infoCode, mwi.infovalue, ms.dropShippingProgramID,md.city, md.statecode, md.CountryName,mc.RTOConsole, lastmodified, mf.active
--order by m.id


select top 10 * from merchantStores