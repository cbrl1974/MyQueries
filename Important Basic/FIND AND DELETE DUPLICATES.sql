SELECT merchant_id, collectionID
from merchantCollections 
GROUP BY merchant_id, collectionID
HAVING COUNT(collectionID) > 1


WITH CTE AS (
    SELECT 
        P.ID_PRODUCT, 
        P.MANUFMODEL, 
        P.MANUFID, 
        CO.CIE, 
        ROW_NUMBER() OVER (PARTITION BY P.MANUFMODEL, P.MANUFID ORDER BY P.MANUFMODEL) AS RN
    FROM 
        PRODUCTS P
    INNER JOIN 
        COMPANIES CO 
    ON 
        CO.ID_CIE = P.MANUFID
    WHERE 
        P.MANUFID IN (1436, 2768, 3437, 2434, 2584, 3181, 3182, 3184, 4226, 4227, 6183, 2067, 1920, 2565, 2982, 3038, 7772, 7860, 2982)
    AND 
        P.MANUFMODEL <> ''
    GROUP BY 
        P.ID_PRODUCT, 
        P.MANUFMODEL, 
        P.MANUFID, 
        CO.CIE
)

SELECT * FROM CTE WHERE RN <> 1;

SELECT ID_PRODUCT, MANUFMODEL, MANUFID FROM PRODUCTS WHERE MANUFMODEL  = '2256 2151-09/2152-48|2257 2151-09/2152-48'

--Delete collections duplicated per merchant 
-- WITH CTE AS (
--     SELECT *, ROW_NUMBER() OVER (PARTITION BY merchant_ID, collectionID ORDER BY collectionID) AS RN
--     FROM merchantCollections 
-- )
-- delete FROM CTE WHERE RN > 1