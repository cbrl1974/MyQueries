
DECLARE @MerchantIdforMwarranties AS INT = 3445;
select * from merchantwarranties
where merchantID = @MerchantIdforMwarranties

update top (1) merchantwarranties
set filtertype = 'item'
where id = 1424


--Merchant warranties Prices
DECLARE @MerchantIdforMwarrantiesPrices AS INT = 3445;
select * from MerchantWarrantyPrices
where  merchantwarrantyId in (select id from merchantwarranties where merchantID = @MerchantIdforMwarrantiesPrices)


--Merchant warranties filters
DECLARE @MerchantIdforwarrantiesFilters AS INT = 3445;
select * from MerchantWarrantyFilters
where merchantwarrantyId in (select id from merchantwarranties where merchantID = @MerchantIdforwarrantiesFilters)




