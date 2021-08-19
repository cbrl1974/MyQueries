DECLARE @MerchantIdforFones AS INT = 1097;
select * from merchantzones where merchant_id =@MerchantIdforFones
select * from merchantzonecodes
where merchantzoneid in (select id from merchantzones where merchant_id =@MerchantIdforFones)



DECLARE @MerchantIdforZone2 AS INT = 1097;
--Get new Zone 2
select distinct postalcode as z, statecode as s
from merchantzonecodes
where merchantZoneId = (select id from merchantzones where merchant_id = @MerchantIdforZone2 and name_1 = 'Zone 2 - remote')
--and statecode not in ('CT')
for json path



--Get new Zone 3
DECLARE @MerchantIdforZone3 AS INT = 1097;
select distinct postalcode as z, statecode as s
from merchantzonecodes
where merchantZoneId = (select id from merchantzones where merchant_id = @MerchantIdforZone3 and name_1 = 'Zone 3 - isolated')
and statecode not in ('CT')
for json path


--NewZone 4 with 
DECLARE @MerchantIdforZone4 AS INT = 1097;
select  postalcode as z, statecode as s
from merchantzonecodes
where merchantZoneId = (select id from merchantzones where merchant_id = @MerchantIdforZone4 and name_1 = 'Zone 4')
and statecode not in ('CT')
for json path



--Script to poulate the shipping options shared document for alliance furnishings
DECLARE @MerchantIdZones AS INT = 1097;
--select * from merchantzones where merchant_id =@MerchantIdZones
select mz.name_1,mzc.stateCode, mzc.postalCode from merchantzonecodes mzc
join merchantzones mz on mz.id = mzc.merchantzoneId
where mzc.merchantzoneid in (select id from merchantzones where merchant_id = @MerchantIdZones)
and mzc.postalCode = '70502'



--Finding duplicated zipcodes on delivery zones
WITH CTE AS 
(
    SELECT  postalcode
    from merchantzonecodes 
    where merchantzoneid in (select id from merchantzones where merchant_id = 1097)
    GROUP BY postalcode 
    HAVING COUNT(postalcode) > 1
)

select mz.name_1,mzc.stateCode, mzc.postalCode from merchantzonecodes mzc
join merchantzones mz on mz.id = mzc.merchantzoneId
join CTE ct on ct.postalCode = mzc.postalCode
where mzc.merchantzoneid in (select id from merchantzones where merchant_id = 1097) 

WITH CTE AS
(
SELECT *,ROW_NUMBER() OVER (PARTITION BY postalcode ORDER BY postalcode) AS RN
from merchantzonecodes 
where merchantzoneid = 1051
)

DELETE FROM CTE WHERE RN<>1