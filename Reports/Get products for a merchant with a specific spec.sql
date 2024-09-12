-- ---------------------------Refrigeratotrs
SELECT DISTINCT sp.productid, s.catid, c.category, sp.specsID_1, sp.SpecValue_1
FROM SpecsProd sp
INNER JOIN specs s ON s.id = sp.specsID_1
INNER JOIN merchantProds mp ON mp.ProductID = sp.productid
INNER JOIN categories c ON c.Id_category = s.catid AND c.Id_langue = 1
WHERE s.catid = 41
AND sp.specsID_1 = 2359
AND CAST(sp.SpecValue_1 AS DECIMAL(10, 2)) >= 2.5
AND s.Id_langue = 1
AND mp.Merchant_ID = 3142
GROUP BY sp.productid, s.catid, c.category, sp.specsID_1, sp.SpecValue_1
--ORDER BY sp.SpecValue_1
union all

-- ------------------------------Freezers
SELECT DISTINCT 
    sp.productid,
    s.catid,
    c.category,
    sp.specsID_1,
    sp.SpecValue_1
FROM SpecsProd sp
    INNER JOIN specs s ON s.id = sp.specsID_1
    INNER JOIN merchantProds mp ON mp.ProductID = sp.productid
    INNER JOIN categories c ON c.Id_category = s.catid AND c.Id_langue = 1
WHERE s.catid = 437
    AND sp.specsID_1 = 15192
    AND ISNUMERIC(sp.SpecValue_1) = 1
    AND CAST(sp.SpecValue_1 AS DECIMAL(10, 2)) >= 2.5 
    AND s.Id_langue = 1
    AND mp.Merchant_ID = 3142
GROUP BY sp.productid, s.catid, c.category, sp.specsID_1, sp.SpecValue_1
union all

-- -------------------------Wine storage
select distinct sp.productid, s.catid, c.category,  sp.specsID_1, sp.SpecValue_1 from SpecsProd sp 
inner join specs s on s.id = sp.specsID_1
inner join merchantProds mp on mp.ProductID = sp.productid
inner join categories c on c.Id_category = s.catid and c.Id_langue = 1
where s.catid  = 255
and sp.specsID_1 = 7205
    AND ISNUMERIC(sp.SpecValue_1) = 1
    AND CAST(sp.SpecValue_1 AS DECIMAL(10, 2)) >= 2.5 
and s.Id_langue = 1
and mp.Merchant_ID = 3142
group by sp.productid, s.catid,  c.category,  sp.specsID_1, sp.SpecValue_1
order by sp.SpecValue_1




select * from specs where catid = 437 --20610
select * from specsProd where  specsID_1 = 7205



select * from categories where category like '%wine%'