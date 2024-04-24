SELECT merchant_id, collectionID
from merchantCollections 
GROUP BY merchant_id, collectionID
HAVING COUNT(collectionID) > 1

select * from merchantCollections where collectionid = 2055

WITH CTE AS
(
SELECT *,ROW_NUMBER() OVER (PARTITION BY postalcode ORDER BY postalcode) AS RN
from merchantzonecodes 
where merchantzoneid = 1051
)

--DELETE FROM CTE WHERE RN<>1

--Delete collections duplicated per merchant 
WITH CTE AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY merchant_ID, collectionID ORDER BY collectionID) AS RN
    FROM merchantCollections 
)
delete FROM CTE WHERE RN > 1