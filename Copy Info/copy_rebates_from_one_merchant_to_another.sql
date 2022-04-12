DECLARE @OLDIDREBATE INT= 1066753;
DECLARE @NEWIDREBATE INT;
DECLARE @SourceMerchant INT= 2415;
DECLARE @DestMerchant INT= 3397;


-- select *
-- from MerchantRebates
-- where displayEnddate >= GETDATE()
-- and merchant_id = @SourceMerchant

-- select *
-- from MerchantRebateProducts
-- where rebateID =  @OLDIDREBATE



insert into MerchantRebates (merchant_id, name_1, name_2, description_1, description_2, fileName, DisplayStartDate, DisplayEndDate, shortDescription_1, shortDescription_2, NmgRebateID, RebateParentID, Active, Locked, LinkAddress, fileName_2, LinkAddress_2, ShowFirst, Process_type, RebateFeedID, BatchId)
select @DestMerchant, r.name_1, r.name_2, r.description_1, r.description_2, r.fileName, r.DisplayStartDate, r.DisplayEndDate, r.shortDescription_1, r.shortDescription_2, r.NmgRebateID, r.RebateParentID, r.Active, r.Locked, r.LinkAddress, r.fileName_2, r.LinkAddress_2, r.ShowFirst, NULL, r.RebateFeedID, r.BatchId
from merchants m
inner join MerchantRebates r on r.merchant_id = @SourceMerchant and r.id_rebate = @OLDIDREBATE 
where m.id = @SourceMerchant
order by m.merchant_code
SET @NEWIDREBATE = @@IDENTITY



insert into MerchantRebateProducts (RebateID, CatID, ProductID, CieID, Amount)
select @NEWIDREBATE, p.CatID, p.ProductID, p.CieID, p.Amount
from merchantRebates r
    inner join MerchantRebateProducts p on p.RebateID = @OLDIDREBATE 
where r.merchant_id = @SourceMerchant
and r.ID_Rebate in (select RebateID from MerchantRebateProducts where RebateID = @OLDIDREBATE)














