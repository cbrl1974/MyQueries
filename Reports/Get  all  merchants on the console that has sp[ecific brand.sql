SELECT
    m.id,
    m.merchant,
    m.AccountingID,
    MIN(ms.city) AS city,
    MIN(ms.postalCode) AS postalCode,
    MIN(ms.email) AS email
FROM merchants m
INNER JOIN merchantstores ms
    ON ms.merchantid = m.id
INNER JOIN merchantBrands mb
    ON mb.merchant_id = m.id
INNER JOIN companies co
    ON co.Id_cie = mb.cieId
WHERE co.BrandFamilyId = 7
  AND m.active = 1
  AND m.merchant NOT LIKE '%demo%'
  AND m.merchant NOT LIKE '%old%'
  AND m.merchant NOT LIKE '%test%'
GROUP BY m.id, m.merchant, m.AccountingID;
