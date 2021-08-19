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
select * from merchantzones where merchant_id =@MerchantIdZones
select mz.name_1,mzc.stateCode, mzc.postalCode from merchantzonecodes mzc
join merchantzones mz on mz.id = mzc.merchantzoneId
where mzc.merchantzoneid in (select id from merchantzones where merchant_id = @MerchantIdZones)



--*****************Finding duplicated zipcodes on delivery zones************************

WITH CTE_zones (id, merchant_id, name_1) as (
    select id, merchant_id, name_1 from merchantzones
),
 CTE_merchantZoneCodes AS 
(
     select merchantzoneid, stateCode, postalCode
     from merchantZoneCodes
),
CTE_zone_duplicates AS 
(
    SELECT  postalcode
    from merchantzonecodes 
    where merchantzoneid in (select id from merchantzones where merchant_id = 1097)
    GROUP BY postalcode 
    HAVING COUNT(postalcode) > 1
)

select z.name_1, zc.stateCode, zc.postalCode from CTE_zones z
join CTE_merchantZoneCodes zc on zc.merchantzoneid = z.id
join CTE_zone_duplicates d on d.postalCode = zc.postalCode
where z.merchant_id = 1097


--*********************Delete Duplicates**********************
WITH CTE AS
(
SELECT mz.name_1,mzc.*,ROW_NUMBER() OVER (PARTITION BY postalcode ORDER BY postalcode) AS RN
from merchantzonecodes mzc
inner join merchantzones mz on mz.id = mzc.merchantZoneId
where merchantzoneid in (select id from merchantZones where merchant_id = 1097 and name_1 <> 'No Zone/Zone 0')
)

select * FROM CTE WHERE RN <> 1
--DELETE FROM CTE WHERE RN<>1

