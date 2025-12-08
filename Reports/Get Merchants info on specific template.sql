WITH FirstStore AS (
    SELECT 
        merchantid,
        email,
        phone,
        city,
        province,
        ROW_NUMBER() OVER (PARTITION BY merchantid ORDER BY id) AS rn
    FROM merchantStores
)
SELECT 
    m.merchant,
    m.accountingid,
    mwi.infoValue,
    mwt.content_1 as contact,
    fs.email,
    fs.phone,
    fs.city,
    fs.province,
    mwt.content_1 AS ContactFormEmail
FROM merchants m
INNER JOIN MerchantWebsiteInformation mwi 
    ON mwi.merchant_id = m.id
   AND mwi.infoCode = 'template'
   AND mwi.infoValue IN (
        'V3 Low Ticket Offer','V3 Lite','V3 Standard','V3 All-Inclusive',
        'NSW V3 Low Ticket Offer','NSW V3 Lite','NSW V3 Standard','NSW V3 All-Inclusive'
   )
LEFT JOIN FirstStore fs 
    ON fs.merchantid = m.id
   AND fs.rn = 1
LEFT JOIN MerchantWebsiteTexts mwt
    ON mwt.merchant_id = m.id
   AND mwt.textcode = 'contactformemail'
   WHERE m.active = 1
   and m.merchant not like '%demo%'
    and m.merchant not like '%tailbase%'
