
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




