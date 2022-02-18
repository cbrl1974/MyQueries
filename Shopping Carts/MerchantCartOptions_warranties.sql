--Cart Options
DECLARE @MerchantIdforMerchantCartOptions AS INT = 2676;
select  * from MerchantCartOptions where 
merchantid = @MerchantIdforMerchantCartOptions  


--Cart Options Fixed Rate
DECLARE @MerchantIdforMerchantCartOptionPricesByFixedRate AS INT = 2676;
select * from MerchantCartOptionPricesByFixedRate
where MerchantCartOptionId in (select id from MerchantCartOptions where 
merchantid = @MerchantIdforMerchantCartOptionPricesByFixedRate)

--Cart Options value Ranges
DECLARE @MerchantIdforMerchantCartOptionPricesByValueRanges AS INT = 2676;
select * from MerchantCartOptionPricesByValueRanges
where MerchantCartOptionId in (select id from MerchantCartOptions where 
merchantid = @MerchantIdforMerchantCartOptionPricesByValueRanges)

insert into MerchantCartOptionPricesByValueRanges (MerchantCartOptionId,MerchantZoneId,LowPrice,HighPrice,Price,Code)
select 9,MerchantZoneId,LowPrice,HighPrice,Price,Code
from MerchantCartOptionPricesByValueRanges
where MerchantCartOptionId = 2


--Cart Options include rules
DECLARE @MerchantCartOptionShippingIncludeRules AS INT = 2676;
select * from MerchantCartOptionShippingIncludeRules where 
MerchantCartOptionId in (select id from MerchantCartOptions where 
merchantid = @MerchantCartOptionShippingIncludeRules)

--Cart Options exclude rules
DECLARE @MerchantCartOptionShippingExcludeRules AS INT = 2676;
select * from MerchantCartOptionShippingExcludeRules where 
MerchantCartOptionId in (select id from MerchantCartOptions where 
merchantid = @MerchantCartOptionShippingExcludeRules)
