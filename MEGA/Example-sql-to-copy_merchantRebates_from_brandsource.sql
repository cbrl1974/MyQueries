/*
This sql example is to duplicate a merchant rebate to a list of websites identified by merchant_code
1. prepare a list of merchant_code to copy to
2. import to view each step to make sure the number of records
3. never run the example sql because those specific rebated were already copied
*/
-- Important to check the original merchant rebate to be copied and do a replacement of merchant code list and id_rebate
DECLARE @IDREBATE INT= 1044963;
select *
from MerchantRebates
where  id_rebate = @IDREBATE
select *
from MerchantRebateProducts
where rebateID = @IDREBATE
select *
from MerchantRebateFiles
where Id_Rebate = @IDREBATE
select *
from MerchantRebates
where process_type = 'temp'

DECLARE @IDREBATEFORMERCHANTREBATES INT= 1044963;
insert into MerchantRebates
(merchant_id, name_1, name_2, description_1, description_2, fileName, DisplayStartDate, DisplayEndDate, shortDescription_1, shortDescription_2, NmgRebateID, RebateParentID, Active, Locked, LinkAddress, fileName_2, LinkAddress_2, ShowFirst, Process_type, RebateFeedID, BatchId)
-- Importtant: before insert, highlight the select part to view the records to be copied, set process_type = 'temp' in this step to identify the new rebates
select m.id, name_1, name_2, description_1, description_2, fileName, DisplayStartDate, DisplayEndDate, shortDescription_1, shortDescription_2, NmgRebateID, RebateParentID, r.Active, Locked, LinkAddress, fileName_2, LinkAddress_2, ShowFirst, 'temp', RebateFeedID, BatchId
from merchants m
    inner join MerchantRebates r on r.merchant_id = 1491 and r.id_rebate = @IDREBATEFORMERCHANTREBATES
where m.merchant_code in ('absbvt','absric','kleduc','km2000')
order by m.merchant_code

DECLARE @IDREBATEFORMERCHANTREBATEPRODUCTS INT= 1044963;
insert into MerchantRebateProducts
(RebateID, CatID, ProductID, CieID, Amount)
--  Importtant: before insert, highlight the select part to view the records to be copied
select r.ID_Rebate, CatID, ProductID, CieID, Amount
from merchantRebates r
    inner join merchants m on m.id = r.merchant_id
    inner join MerchantRebateProducts p on p.RebateID = @IDREBATEFORMERCHANTREBATEPRODUCTS
where r.Process_type = 'temp'
    and m.merchant_code in ('absbvt','absric','kleduc','km2000')
order by m.merchant_code



-- get new Rebate ID for report
select m.merchant, m.merchant_code, r.ID_Rebate
from merchantRebates r
    inner join merchants m on m.id = r.merchant_id
where r.Process_type = 'temp'
order by m.merchant_code

-- check again
select *
from MerchantRebates
where process_type = 'temp'


-- finally, remove the flag for new
update MerchantRebates
set Process_type = 'Mega' 
where process_type = 'temp'
