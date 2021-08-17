use stagingTailbasecore
DECLARE @MerchantId AS INT = 1190;

select * from MerchantShoppingCartConfigurations where merchantid = @MerchantId


-- General Settings Tab
select * from merchantWebsitetexts  where merchant_id = @MerchantId and textcode = 'shopcartemail'

--Payment Integration Tab
select merchant_id, content_1 as paymentStringEn,  content_1 as paymentStringFr, id_langue from merchantWebsitetexts  where merchant_id = @MerchantId and textcode = 'paymentPPEDetail'
select merchant_id, content_1 as paymentStringEn,  content_1 as paymentStringFr, id_langue  from merchantWebsitetexts  where merchant_id = @MerchantId and textcode = 'paymentPPEDetailTest'
select merchant_id, content_1 as paymentStringEn,  content_1 as paymentStringFr, id_langue  from merchantWebsitetexts  where merchant_id = @MerchantId and textcode = 'paymentDetail'
select merchant_id, content_1 as paymentStringEn,  content_1 as paymentStringFr, id_langue  from merchantWebsitetexts  where merchant_id = @MerchantId and textcode = 'paymentDetailTest'



--Shipping Zones
declare @ZoneIDs table (id int);
insert into @ZoneIDs (id)  select id from merchantzones where merchant_id = @MerchantId;
select * from merchantzones where id in ( select id from @ZoneIDs)
select * from merchantzoneCodes where merchantZoneID  in ( select id from @ZoneIDs)
select * from MerchantZoneRadiusesFromStores  where merchantZoneID  in (select id from @ZoneIDs)


--Shipping Options
declare @ShippingIDs table (id int);
insert into @ShippingIDs (id)  select id from merchantShipping where merchant_id = @MerchantId;
select * from merchantShipping where id in (select id from @ShippingIds) 
select * from MerchantShippingPricesByValueRanges where merchantshippingid in (select id from @ShippingIds)
