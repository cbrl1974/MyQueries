--Cart Options
DECLARE @MerchantIdforMerchantCartOptions AS INT = 3445;
select  * from MerchantCartOptions where 
merchantid = @MerchantIdforMerchantCartOptions  

--insert into MerchantCartOptions values 
--(3445,'value-range', 1, '5yr Furniture Protection', NULL, '5yr Furniture Protection Plan-provides coverage for accidental damage, stains, punctures, rips, burn',null,1, NULL)


--Cart Options Fixed Rate
DECLARE @MerchantIdforMerchantCartOptionPricesByFixedRate AS INT = 1507;
select * from MerchantCartOptionPricesByFixedRate
where MerchantCartOptionId in (select id from MerchantCartOptions where 
merchantid = @MerchantIdforMerchantCartOptionPricesByFixedRate)


--Cart Options value Ranges
DECLARE @MerchantIdforMerchantCartOptionPricesByValueRanges AS INT = 1507;
select * from MerchantCartOptionPricesByValueRanges
where MerchantCartOptionId in (select id from MerchantCartOptions where 
merchantid = @MerchantIdforMerchantCartOptionPricesByValueRanges)

--insert into MerchantCartOptionPricesByValueRanges (MerchantCartOptionId,MerchantZoneId,LowPrice,HighPrice,Price,Code) values
--(9,NULL, null, 10000.00,149.99,null)
--select 9,MerchantZoneId,LowPrice,HighPrice,Price,Code
--from MerchantCartOptionPricesByValueRanges
--where MerchantCartOptionId = 2


--Cart Options include rules
DECLARE @MerchantCartOptionShippingIncludeRules AS INT = 1507;
select * from MerchantCartOptionShippingIncludeRules where 
MerchantCartOptionId in (select id from MerchantCartOptions where 
merchantid = @MerchantCartOptionShippingIncludeRules)

--Cart Options exclude rules
DECLARE @MerchantCartOptionShippingExcludeRules AS INT = 1507;
select * from MerchantCartOptionShippingExcludeRules where 
MerchantCartOptionId in (select id from MerchantCartOptions where 
merchantid = @MerchantCartOptionShippingExcludeRules)
