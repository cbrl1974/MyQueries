DECLARE @sourceMerchantId AS INT = 1491
DECLARE @targetMerchantId AS INT = 1267
-- COPYING MERCHANT REBATES
--INSERT INTO MerchantRebates(merchant_id,name_1,name_2,description_1,description_2,fileName,DisplayStartDate,DisplayEndDate,shortDescription_1,shortDescription_2,NmgRebateID,RebateParentID,Active,Locked,LinkAddress,fileName_2,LinkAddress_2,ShowFirst)
--SELECT @targetMerchantId,mr.name_1,mr.name_2,mr.description_1,mr.description_2,mr.fileName,mr.DisplayStartDate,mr.DisplayEndDate,mr.shortDescription_1,mr.shortDescription_2,mr.NmgRebateID,mr.RebateParentID,mr.Active,mr.Locked,mr.LinkAddress,mr.fileName_2,mr.LinkAddress_2,mr.ShowFirst
--FROM MerchantRebates mr
--WHERE mr.merchant_id = @sourceMerchantId
--and mr.id_rebate = 964126
--AND mr.NmgRebateID IS NULL -- ONLY MANUAL REBATES

-- COPYING MERCHANTREBATEPRODUCTS
INSERT INTO MerchantRebateProducts(RebateID,CatID,ProductID,CieID,Amount)
SELECT mrN.ID_Rebate,rp.CatID,rp.ProductID,rp.CieID,rp.Amount
FROM MerchantRebateProducts rp
JOIN MerchantRebates mrO ON mrO.ID_Rebate=rp.RebateID
JOIN MerchantRebates mrN ON mrN.merchant_id = @targetMerchantId AND mrN.name_1 = mrO.name_1
WHERE mrO.merchant_id = @sourceMerchantId
and  mrN.ID_Rebate = 964823
--AND mrO.NmgRebateID  IS NULL -- ONLY MANUAL REBATES




