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
       'TB0198','TB0336','TB0347','TB0360','TB0362','TB0760','TB0034','TB0262','TB0285','TB0752',
       'TB0040','TB0321','TB0057','TB0444','TB0456','TB0555','TB0580','TB0604','TB0916','TB0916',
       'TB0097','TB0156','TB0383','TB0446','TB0457','TB0554','TB0597','TB0333','TB0345','TB0596',
       'TB0624','TB0674','TB0936','TB0123','TB0157','TB0620','TB0636','TB0698','TB0919','TB0926',
       'TB0932','TB0160','TB0657','TB0660','TB0669','TB0902','TB0904','TB0915','TB0703','TB0986',
       'TB0361','TB0131','TB0731','TB0380','TB0008'
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


--select id_cie, brandfamilyid from companies where cie in ('Café','GE','GE Profile','Haier','Hotpoint')
