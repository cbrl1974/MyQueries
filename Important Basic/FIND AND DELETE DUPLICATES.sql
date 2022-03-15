SELECT  postalcode
from merchantzonecodes 
where merchantzoneid = 1053
GROUP BY postalcode
HAVING COUNT(postalcode) > 1

WITH CTE AS
(
SELECT *,ROW_NUMBER() OVER (PARTITION BY postalcode ORDER BY postalcode) AS RN
from merchantzonecodes 
where merchantzoneid = 1051
)

DELETE FROM CTE WHERE RN<>1