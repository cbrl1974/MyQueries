DECLARE @MerchantIdforFones AS INT = 1097;
select * from merchantzones where merchant_id =@MerchantIdforFones
select  mz.name_1,mzc.stateCode, mzc.postalCode from merchantzonecodes mzc
join merchantzones mz on mz.id = mzc.merchantzoneId
where mzc.merchantzoneid in (select id from merchantzones where merchant_id = @MerchantIdforFones)