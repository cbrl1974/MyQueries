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
DECLARE @MerchantIdforFones AS INT = 1097;
select * from merchantzones where merchant_id =@MerchantIdforFones
select  mz.name_1,mzc.stateCode, mzc.postalCode from merchantzonecodes mzc
join merchantzones mz on mz.id = mzc.merchantzoneId
where mzc.merchantzoneid in (select id from merchantzones where merchant_id = @MerchantIdforFones)