
DECLARE @MerchantIdforMwarranties AS INT = 1733;
select * from merchantwarranties
where merchantID = @MerchantIdforMwarranties


--Merchant warranties Prices
DECLARE @MerchantIdforMwarrantiesPrices AS INT = 1733;
select * from MerchantWarrantyPrices
where  merchantwarrantyId in (select id from merchantwarranties where merchantID = @MerchantIdforMwarrantiesPrices)


--Merchant warranties filters
DECLARE @MerchantIdforwarrantiesFilters AS INT = 1733;
select * from MerchantWarrantyFilters
where merchantwarrantyId in (select id from merchantwarranties where merchantID = @MerchantIdforwarrantiesFilters)


--Cart Options
DECLARE @MerchantIdforMerchantCartOptions AS INT = 1733;
select * from MerchantCartOptions where 
merchantid = @MerchantIdforMerchantCartOptions

--Cart Options Fixed Rate
DECLARE @MerchantIdforMerchantCartOptionPricesByFixedRate AS INT = 1733;
select * from MerchantCartOptionPricesByFixedRate
where MerchantCartOptionId in (select id from MerchantCartOptions where 
merchantid = @MerchantIdforMerchantCartOptionPricesByFixedRate)

--Cart Options value Ranges
DECLARE @MerchantIdforMerchantCartOptionPricesByValueRanges AS INT = 1733;
select * from MerchantCartOptionPricesByValueRanges
where MerchantCartOptionId in (select id from MerchantCartOptions where 
merchantid = @MerchantIdforMerchantCartOptionPricesByValueRanges)


--Cart Options include rules
DECLARE @MerchantCartOptionShippingIncludeRules AS INT = 1733;
select * from MerchantCartOptionShippingIncludeRules where 
MerchantCartOptionId in (select id from MerchantCartOptions where 
merchantid = @MerchantCartOptionShippingIncludeRules)

--Cart Options exclude rules
DECLARE @MerchantCartOptionShippingExcludeRules AS INT = 1733;
select * from MerchantCartOptionShippingExcludeRules where 
MerchantCartOptionId in (select id from MerchantCartOptions where 
merchantid = @MerchantCartOptionShippingExcludeRules)



