
-- Specs created on the past day
select id_product, model, catid, SpecsModifDate, specsModifier
from products 
WHERE CAST(SpecsModifDate AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE)
and active =1
and specs = 1
and discontinued = 0
and bundle = 0
and model not like '% bdl%'
and manufID not in (select distinct brandid from productCreationToolSettings )


-- List of products created per category as well as dictionaries entries per category
SELECT 
    p.catid, 
    c.category, 
    COUNT(p.id_product) AS totalofproducts,
    COALESCE(std.total, 0) AS totalSpecsTranslations
FROM 
    products p
INNER JOIN 
    categories c ON c.id_category = p.catid AND c.id_langue = 1
LEFT JOIN 
    (
        SELECT CategoryId, COUNT(*) as total
        FROM SpecTranslationDictionary
        GROUP BY CategoryId
    ) std ON std.CategoryId = p.catid
WHERE 
    p.active = 1
    AND p.specs = 1
    AND p.discontinued = 0
    AND p.bundle = 0
    AND p.model NOT LIKE '%bdl%'
    AND p.manufID NOT IN (
        SELECT DISTINCT brandid
        FROM productCreationToolSettings 
    )
    and std.total > 0
GROUP BY 
    p.catid, 
    c.category, 
    std.total
ORDER BY 
    totalofproducts DESC;

--Get Statistics
select top 4 * from SpecsTranslationSnapshot order by id desc

--Get  state
select * from SpecsTranslatorState


-- Specs for specific category
select sp.productid, sp.SpecValue_1, sp.SpecValue_2
 from specsProd sp
inner join products p on p.id_product = sp.productid
 and p.active = 1
    AND p.specs = 1
    AND p.discontinued = 0
    AND p.bundle = 0
    AND p.model NOT LIKE '%bdl%'
    AND p.manufID NOT IN (
        SELECT DISTINCT brandid
        FROM productCreationToolSettings 
    )
    and p.catid = 194
    and DATALENGTH(sp.SpecValue_1) > 0
    order by sp.productid desc


    select * from SpecTranslationDictionary where CategoryId = 257 and SpecEng like '%Closed back%'
