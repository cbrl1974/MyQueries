DECLARE @IDREBATE INT= 1068145;
DECLARE @SourceMerchant INT= 2415;
DECLARE @DestMerchant INT= 3397;
select *
from MerchantRebates
where  id_rebate = @IDREBATE
select *
from MerchantRebateProducts
where rebateID = @IDREBATE



insert into MerchantRebates (merchant_id, name_1, name_2, description_1, description_2, fileName, DisplayStartDate, DisplayEndDate, shortDescription_1, shortDescription_2, NmgRebateID, RebateParentID, Active, Locked, LinkAddress, fileName_2, LinkAddress_2, ShowFirst, Process_type, RebateFeedID, BatchId)
select @DestMerchant, r.name_1, r.name_2, r.description_1, r.description_2, r.fileName, r.DisplayStartDate, r.DisplayEndDate, r.shortDescription_1, r.shortDescription_2, r.NmgRebateID, r.RebateParentID, r.Active, r.Locked, r.LinkAddress, r.fileName_2, r.LinkAddress_2, r.ShowFirst, NULL, r.RebateFeedID, r.BatchId
from merchants m
inner join MerchantRebates r on r.merchant_id = @SourceMerchant and r.id_rebate = @IDREBATE
where m.id = @SourceMerchant
order by m.merchant_code


insert into MerchantRebateProducts (RebateID, CatID, ProductID, CieID, Amount)
select r.ID_Rebate, p.CatID, p.ProductID, p.CieID, p.Amount
from merchantRebates r
    inner join merchants m on m.id = r.merchant_id
    inner join MerchantRebateProducts p on p.RebateID = @IDREBATE
where m.id = @SourceMerchant
order by m.merchant_code

select * from MerchantRebateProducts where rebateid = 1068145
select * from merchantRebates where ID_Rebate = 1068145









