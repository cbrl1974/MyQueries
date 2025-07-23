WITH TailbasiFyMerchants AS (
    SELECT DISTINCT mi.id, mi.merchant, mi.AccountingID
    FROM merchants mi
    WHERE mi.active = 1
),
merchantSolutions AS (
 SELECT DISTINCT mwi.merchant_id, mwi.infoValue as solution
    FROM MerchantWebsiteInformation mwi
    WHERE mwi.infoCode = 'template'
	and mwi.infoValue like '%cantrex%'
),
TotalproductsPerMerchant AS (
 SELECT merchant_id, count(productid) as totalProducts
    FROM merchantprods 
	group by merchant_id
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
    --tm.AccountingID,
	ms.solution,
	tp.totalProducts,
    mbc.cieid AS 'Brands Count'   
FROM TailbasiFyMerchants tm
inner join merchantSolutions ms on ms.merchant_id = tm.ID
INNER JOIN merchantBrandsCount mbc ON mbc.merchant_id = tm.id
INNER JOIN productsBrandsCount pbc ON pbc.merchant_id = tm.id
inner join TotalproductsPerMerchant tp on tp.merchant_id = tm.ID
ORDER BY tm.id;
