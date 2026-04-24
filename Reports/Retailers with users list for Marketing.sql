SELECT 
    m.id,
    m.AccountingID, 
    m.merchant, 
    mu.f_name + ' ' + mu.l_name AS Name, 
    mu.f_name AS 'First name', 
    mu.l_name AS 'Last name',
    CASE 
        WHEN LEFT(cms.languages, 2) = 'fr' THEN 'French'
        WHEN LEFT(cms.languages, 2) = 'en' THEN 'English'
        ELSE cms.languages
    END AS Language,
    CASE 
        WHEN m.countryCode = 'US' THEN 'United States' 
        ELSE 'Canada' 
    END AS Country,
    mu.email_user AS Email,
    m.membersGroup AS 'Buying group',
    mwi.infovalue AS Platform,
    min(ms.province) AS 'Province/State'
FROM merchants m
JOIN merchantUsers mu ON m.id = mu.merchant_ID
JOIN merchantcms cms ON cms.Merchant_id = m.id
LEFT JOIN merchantwebsiteinformation mwi ON mwi.merchant_id = m.id AND mwi.infocode = 'template' 
JOIN merchantstores ms ON ms.merchantid = m.id
WHERE m.active = 1 	
    AND m.merchant NOT LIKE '%demo%'
    AND m.merchant NOT LIKE '%old%'
    AND m.merchant NOT LIKE '%Espace 67%'
    AND m.merchant NOT LIKE '%test%'
    and m.merchant NOT LIKE '%Perreault%'
    AND mu.active = 1
    AND mu.admin = 1
group by m.id, m.AccountingID, m.merchant, mu.f_name, mu.l_name, cms.languages, m.countryCode, mu.email_user, m.membersGroup, mwi.infovalue
