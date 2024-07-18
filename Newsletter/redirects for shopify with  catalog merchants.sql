WITH CatalogUrls (cataloghandle, id, category) AS (
    SELECT DISTINCT 
        'https://www.germainlariviere.com/en/catalog/' + CAST(md.id AS varchar) + '-' + LOWER(REPLACE(d.dept, ' ', '-')) + '/' + CAST(c.id_category AS varchar) + '-' + LOWER(REPLACE(c.category, ' ', '-')) AS cataloghandle, m.id, c.category 
    FROM merchantDepartments md 
    INNER JOIN departments d ON d.id_dept = md.DepartmentID AND d.Id_langue = 1
    INNER JOIN merchants m ON m.id = md.merchant_id 
    INNER JOIN merchantcats mc ON mc.merchant_id = m.id
    INNER JOIN categories c ON c.id_category = mc.catID AND c.id_langue = 1 AND c.deptID = md.DepartmentID
    WHERE m.id = 1479
),
HandleEnUrls (handleEnForShopify, TitleEn) AS (
    SELECT 
        CONCAT('https://www.germainlariviere.com/en/collections/', LOWER(REPLACE(TitleEn, ' ', '-'))) as handleEnForShopify, s.TitleEn
    FROM tailbasify.shopify.ShopifyMerchantCollections s 
    WHERE s.MerchantId = 3527
    AND s.CollectionTypeId = 1
)

SELECT distinct c.cataloghandle, handleEnForShopify
FROM CatalogUrls c
inner join HandleEnUrls s on  c.category = s.TitleEn
