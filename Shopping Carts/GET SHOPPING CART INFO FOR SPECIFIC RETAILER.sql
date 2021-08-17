 
--Debugging
DECLARE @MerchantIdforDebugForLogs AS INT = 1733;
select top 100 * from merchantwebsiteeventlogs 
where merchantid = @MerchantIdforDebugForLogs
order by time desc


DECLARE @MerchantIdforDebug AS INT = 1733;
select top 200 * from MerchantTransactionLog
where merchant_id = @MerchantIdforDebug
order by id desc


DECLARE @MerchantIdforDebugForActiveCarts AS INT = 1733;
select  top 100 * from ActiveShoppingCarts 
where merchantid = @MerchantIdforDebugForActiveCarts order by id desc


DECLARE @MIDCustomerOrders AS INT = 1733;
select top 100 * from CustomerOrders
where merchant_id = @MIDCustomerOrders
order by id desc

DECLARE @MIDCustomerOrderPayments AS INT = 1733;
select top 100 * from CustomerOrderPayments
where orderid in (select id from CustomerOrders where merchant_id = @MIDCustomerOrderPayments )
order by orderid desc

DECLARE @MerchantIdcustomers AS INT = 1733;
select * from customers where merchant_id = 1733 and id =198362

DECLARE @MerchantIdforcustomerOrdersItems AS INT = 1733;
select top 100 * from CustomerOrderItems  
where orderID in (select  ID from CustomerOrders where merchant_id = @MerchantIdforcustomerOrdersItems )
order by id desc



select * from PaymentIntegrations




DECLARE @CustomerOrderEmailsHistory AS INT = 1733;
select top 100 * from CustomerOrderEmailsHistory
where orderid in (select customerOrderId from MerchantTransactionLog
where merchant_id = @CustomerOrderEmailsHistory)
order by id desc


DECLARE @MerchantIdforDebugForCartConfigurations AS INT = 1733;
select * from MerchantShoppingCartConfigurations
where merchantid = @MerchantIdforDebugForCartConfigurations


 --********************FEATURES********************
 DECLARE @MerchantIdforFeatures AS INT = 1733;
 select * from merchantWebsiteFeatures where merchant_id = @MerchantIdforFeatures 


 --********************texts********************
DECLARE @MerchantIdfortexts AS INT = 1733;
select * from merchantWebsitetexts
where merchant_id = @MerchantIdfortexts
and textcode like '%payment%'

 --********************Shipping********************
DECLARE @MerchantIdforShipping AS INT = 1733;
select * from merchantshipping where merchant_id =@MerchantIdforShipping



--select  * from MerchantShippingIncludeRules where merchantshippingid in (select id from merchantshipping where merchant_id =@MerchantIdforShipping)
DECLARE @MerchantIdforShippingShippingPricesBYValueRanges AS INT = 1733;
select * from MerchantShippingPricesByValueRanges
where merchantshippingid in (select id from merchantshipping where merchant_id = @MerchantIdforShippingShippingPricesBYValueRanges)

select * from merchantshoppingcartconfigurations where merchantid = 1733

 
DECLARE @MerchantIdforShippingShippingPricesByQuantity AS INT = 1733;
select * from MerchantShippingPricesByQuantity
where merchantshippingid in (select id from merchantshipping where merchant_id =@MerchantIdforShippingShippingPricesByQuantity)


DECLARE @MerchantIdforShippingPricesByStoreLocRings AS INT = 1733;
select * from MerchantShippingPricesByStoreLocRings
where merchantshippingid in (select id from merchantshipping where merchant_id =@MerchantIdforShippingPricesByStoreLocRings)



DECLARE @MerchantIdforShippingPricesByStoreLocRadio AS INT = 1733;
select * from MerchantShippingPricesByStoreLocRadio
where merchantshippingid in (select id from merchantshipping where merchant_id =@MerchantIdforShippingPricesByStoreLocRadio)



DECLARE @MerchantIdforShippingPricesShippingPrices AS INT = 1733;
select * from MerchantShippingPrices
where merchantshippingid in (select id from merchantshipping where merchant_id = @MerchantIdforShippingPricesShippingPrices)



DECLARE @merchantshippingIncluderules AS INT = 1733;
select * from merchantshippingIncluderules
where merchantshippingid in (select id from merchantshipping where merchant_id = @merchantshippingIncluderules)



DECLARE @merchantshippingexcludeRules AS INT = 1733;
select * from merchantshippingexcludeRules
where merchantshippingid in (select id from merchantshipping where merchant_id = @merchantshippingexcludeRules )


----********************Warranties********************
DECLARE @MerchantIdforWarranties AS INT = 1733;
select * from merchantwarranties where merchantid = @MerchantIdforWarranties
select * from merchantwarrantyprices where merchantwarrantyid in (select id from merchantwarranties where merchantid = @MerchantIdforWarranties)



--********************Stores********************
DECLARE @MerchantIdforStores AS INT = 1733;
select * from merchantstores where merchantid = @MerchantIdforStores




--********************Zones********************
DECLARE @MerchantIdforZones AS INT = 1733;
select * from merchantzones where merchant_id =@MerchantIdforZones
select * from merchantzonecodes
where merchantzoneid in (select id from merchantzones where merchant_id =@MerchantIdforZones) 
select * from MerchantZoneRadiusesFromStores
where merchantzoneid in (select id from merchantzones where merchant_id =@MerchantIdforZones)



--********************Taxes********************

DECLARE @MerchantIdforTaxes AS INT = 1733;
select * from merchanttaxes where merchant_id =@MerchantIdforTaxes 
select * from MerchantStoresTaxes
where merchantTaxId in (select id from merchanttaxes where merchant_id =@MerchantIdforTaxes)
select * from merchantstores
where merchantid =@MerchantIdforTaxes 
select * from MerchantTaxZones
where merchantTaxId in (select id from merchanttaxes where merchant_id =@MerchantIdforTaxes)

DECLARE @MerchantIdforTaxesEXemption AS INT = 17;
select * from MerchantTaxExemptItems where merchantid = @MerchantIdforTaxesEXemption


--*********************merchantcms****************************************
DECLARE @MerchantIdforcms AS INT = 17;
select orders, warranties from merchantcms where merchant_id =@MerchantIdforcms



--*********************General****************************************
select ms.id,ms.name_1,mv.*, mz.name_1,mc.countryCode,mc.stateCode, mc.postalcode 
from
MerchantShippingPricesByValueRanges mv
--MerchantShippingPricesByQuantity mv
--MerchantShippingPrices mv
join merchantshipping ms on ms.id = mv.merchantshippingID
join merchantzones mz on mz.merchant_id = ms.merchant_id
join merchantzonecodes mc on mc.merchantZoneId = mv.merchantZoneId
where ms.merchant_id = @MerchantId

select * from categories where id_category = 318
select * from companies where id_cie = 7979



select m.merchant, m.filepath, mt.* from merchantwebsitetexts mt
join merchants m on m.id = mt.merchant_id
 where mt.textcode = 'paymentdetailtest' and mt.content_1 like '%authorize%' and mt.availableinmerchantbean = 1

 
select m.id, m.countryCode, m.merchant_code,m.merchant,m.merchant_url, m.filepath, mf.featurecode, mf.featurevalue
from merchantwebsitefeatures mf
join merchants m on m.id = mf.merchant_id
--where  mf.featureCode like '%onlyppe%'
where  mf.featureCode = 'shoppingCartType'
and  mf.featurevalue like '%beanstream%'
and m.active = 1
and  mf.merchant_id in (select merchant_id  from merchantwebsitefeatures
where featurevalue    in ('tbvision') and featureCode = 'template')
--and m.countryCode = 'CA'
and  mf.merchant_id in (select merchant_id  from merchantwebsitefeatures
where featureCode    in ('hasShippingOptionsOnItems'))


DECLARE @MerchantIdfortextsa AS INT = 1733;
select * from merchantWebsitetexts  where merchant_id = @MerchantIdfortextsa and textcode like '%payment%'

DECLARE @MerchantIdfortexts AS INT = 1733;
select * from merchantWebsitetexts  where merchant_id = @MerchantIdfortexts and textcode like '%payment%'

