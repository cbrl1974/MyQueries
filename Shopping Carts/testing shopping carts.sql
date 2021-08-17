DECLARE @Merchant_ID AS INT = 996
select ms.id, ms.geoposition,mz.id zone_ID,mz.name_1 as zone_name,msh.id as shippingID,msh.name_1 as shipping_name,mwf.featureCode,mwf.featureValue 
from merchants m
inner join merchantStores ms on ms.merchantID = m.id
inner join merchantzones mz on mz.merchant_id = m.id
inner join merchantShipping msh on msh.merchant_id = m.id
inner join merchantwebsitefeatures mwf on mwf.merchant_id = m.id
where m.id = @Merchant_ID
and mwf.featureCode = 'shippingOptionTypes'
 


DECLARE @merchantZoneID AS INT = 25
DECLARE @merchantShippingId AS INT = 25
select * from merchantzoneCodes where merchantZoneID = @merchantZoneID 
select * from MerchantShippingPricesByValueRanges where merchantShippingID = @merchantShippingId
select * from MerchantShippingPricesByStoreLocRadio where merchantSHippingId = @merchantShippingId
select * from MerchantShippingPricesByStoreLocRings where merchantSHippingId = @merchantShippingId
select * from  MerchantShippingIncludeRules where merchantSHippingId = @merchantShippingId
select * from  MerchantShippingExcludeRules where merchantSHippingId = @merchantShippingId


