use datatail20130410
SELECT
    m.id,
    m.merchant,
    m.AccountingID,
    MIN(ms.city) AS city,
    MIN(ms.postalCode) AS postalCode,
    MIN(ms.province) AS "State/Province",
    MIN(ms.email) AS email,
    mi.infovalue,
    CASE 
        WHEN JSON_VALUE(mf.FeedOptionsJson, '$.PricingActive') = 'true' THEN 'Yes'
        WHEN JSON_VALUE(mf.FeedOptionsJson, '$.PricingActive') = '1' THEN 'Yes'
        ELSE 'No'
    END AS [Tempur Feed Activation]
FROM merchants m
INNER JOIN MerchantWebsiteInformation mi
    ON mi.merchant_id = m.id and mi.infoCode = 'Template'
INNER JOIN merchantstores ms
    ON ms.merchantid = m.id
INNER JOIN merchantBrands mb
    ON mb.merchant_id = m.id
INNER JOIN companies co
    ON co.Id_cie = mb.cieId
LEFT JOIN FEEDS.MerchantFeeds mf 
    on mf.MerchantId = m.id and mf.FeedId = 27
WHERE co.BrandFamilyId = 7
  AND m.active = 1
  AND m.merchant NOT LIKE '%demo%'
  AND m.merchant NOT LIKE '%old%'
  AND m.merchant NOT LIKE '%test%'
  --and m.countryCode = 'us'
GROUP BY m.id, m.merchant, m.AccountingID, mi.infovalue, mf.FeedOptionsJson;

select * from companies where cie like '%tempur%'
