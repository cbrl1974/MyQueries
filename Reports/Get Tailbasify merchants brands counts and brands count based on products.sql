WITH CantrexMerchants AS (
    SELECT DISTINCT mi.merchant_id, m.merchant
    FROM MerchantWebsiteInformation mi
    INNER JOIN merchants m ON m.id = mi.merchant_id
    WHERE m.active = 1
      AND mi.infoValue LIKE '%cantrex%'
      and m.merchant not like '%demo%'
),
merchantBrandsCount AS (
    SELECT merchant_id, COUNT(cieid) AS cieid
    FROM merchantBrands
    GROUP BY merchant_id
),
productsBrandsCount AS (
    SELECT mp.merchant_id, COUNT(DISTINCT p.manufid) AS manufid
    FROM products p 
    INNER JOIN merchantprods mp ON mp.productid = p.Id_product
    GROUP BY mp.merchant_id
),
merchantBrandNames AS (
    SELECT 
        mb.merchant_id,
        STRING_AGG(c.cie, ', ') AS BrandList
    FROM merchantBrands mb
    INNER JOIN companies c ON c.id_cie = mb.cieid
    GROUP BY mb.merchant_id
)
SELECT 
    tm.merchant_id,
    tm.merchant,
    mbc.cieid AS [Count of Merchant Brands],
    pbc.manufid AS [Count of Distinct Brands from Products],
    mbn.BrandList AS [Brands]
FROM CantrexMerchants tm
LEFT JOIN merchantBrandsCount mbc ON mbc.merchant_id = tm.merchant_id
LEFT JOIN productsBrandsCount pbc ON pbc.merchant_id = tm.merchant_id
LEFT JOIN merchantBrandNames mbn ON mbn.merchant_id = tm.merchant_id
ORDER BY tm.merchant_id;
