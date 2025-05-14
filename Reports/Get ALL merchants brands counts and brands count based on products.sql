WITH TailbasiFyMerchants AS (
    SELECT DISTINCT mi.id, mi.merchant, mi.AccountingID
    FROM merchants mi
    WHERE mi.active = 1
),
merchantBrandsCount AS (
    SELECT 
        mb.merchant_id,
        COUNT(DISTINCT 
            CASE 
                WHEN co.brandfamilyid IS NOT NULL THEN CONCAT('F', co.brandfamilyid)
                ELSE CONCAT('B', co.Id_cie)
            END
        ) AS cieid
    FROM merchantBrands mb
    INNER JOIN Companies co ON co.Id_cie = mb.cieId 
    GROUP BY mb.merchant_id
),
productsBrandsCount AS (
    SELECT 
        mp.merchant_id,
        COUNT(DISTINCT 
            CASE 
                WHEN co.brandfamilyid IS NOT NULL THEN CONCAT('F', co.brandfamilyid)
                ELSE CONCAT('B', co.Id_cie)
            END
        ) AS manufid
    FROM products p 
    INNER JOIN merchantprods mp ON mp.productid = p.Id_product
    INNER JOIN Companies co ON co.Id_cie = p.manufid
    GROUP BY mp.merchant_id
)
SELECT 
    tm.id, 
    tm.merchant, 
    tm.AccountingID, 
    mbc.cieid AS 'Brands Count'   
FROM TailbasiFyMerchants tm
INNER JOIN merchantBrandsCount mbc ON mbc.merchant_id = tm.id
INNER JOIN productsBrandsCount pbc ON pbc.merchant_id = tm.id
ORDER BY tm.id;
