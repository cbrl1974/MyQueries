WITH DistinctBrands AS (
    SELECT 
        m.AccountingID,
        m.merchant_url,
        co.cie,
        co.BrandFamilyId,
        p.manufid,
        mwi.infoValue as Template,
        COALESCE(CAST(co.BrandFamilyId AS VARCHAR(50)), CAST(p.manufid AS VARCHAR(50))) AS BrandKey
    FROM merchants m
    JOIN merchantProds mp ON mp.Merchant_ID = m.id
    JOIN products p ON p.id_product = mp.productid
    JOIN companies co ON co.id_cie = p.manufid
    JOIN merchantwebsiteinformation mwi on mwi.merchant_id = m.id and mwi.infoCode = 'template'
    WHERE m.AccountingID IN (
        'TB0082','TB0187','TB0205','TB0233','TB0372','TB0381','TB0413','TB0424','TB0434','TB0436','TB0563',
        'TB0566','TB0655','TB0689','TB0707','TB0762','TB0908','TB0918','TB0923','TB0937','TB0938','TB0951',
        'TB0953','TB0958','TB0959','TB0962','TB0965','TB0969','TB0973','TB0981','TB1003','TB1007','TB1011',
        'TB1013','TB1061','TB1066','TB1069','TB1070','TB1075','TB1080','TB1082','TB1089','TB1090','TB1095',
        'TB1102','TB1107','TB1065'
    )
    GROUP BY m.AccountingID, m.merchant_url, co.cie, co.BrandFamilyId, p.manufid, mwi.infoValue
),
CollapsedBrands AS (
    SELECT DISTINCT
        AccountingID,
        merchant_url,
        cie,
        Template,
        BrandKey
    FROM DistinctBrands
)
SELECT
    cb.AccountingID,
    cb.merchant_url,
    cb.Template,
    COUNT(DISTINCT cb.BrandKey) AS Total_Brands_on_Website,
    STRING_AGG(cb.cie, ', ') AS BrandsList
FROM CollapsedBrands cb
GROUP BY cb.AccountingID, cb.merchant_url, Template
ORDER BY cb.AccountingID, cb.merchant_url, Template;


select id_cie, brandfamilyid from companies where cie in ('Café','GE','GE Profile','Haier','Hotpoint')
