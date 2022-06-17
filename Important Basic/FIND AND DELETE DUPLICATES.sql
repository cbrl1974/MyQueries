SELECT  productid
from merchantProducts 
where merchant_id = 1931
GROUP BY productid
HAVING COUNT(productid) > 1

WITH CTE AS
(
SELECT *,ROW_NUMBER() OVER (PARTITION BY postalcode ORDER BY postalcode) AS RN
from merchantzonecodes 
where merchantzoneid = 1051
)

DELETE FROM CTE WHERE RN<>1