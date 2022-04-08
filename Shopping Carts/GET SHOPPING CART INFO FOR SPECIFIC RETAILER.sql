 
--Debugging
DECLARE @MerchantIdforDebugForLogs AS INT = 1781;
select top 100 * from merchantwebsiteeventlogs 
where merchantid = @MerchantIdforDebugForLogs
--and module = 'ShoppingCart'
order by time desc


DECLARE @MerchantIdforDebug AS INT = 1781;
select top 150  * from MerchantTransactionLog
where merchant_id = @MerchantIdforDebug
order by id desc

DECLARE @MIDCustomerOrders AS INT = 1781;
select top 100 * from CustomerOrders
where merchant_id = @MIDCustomerOrders
and id = 132832
order by id desc

DECLARE @MerchantIdcustomers AS INT = 1781;
select c.*, ca.* from customers c 
inner join CustomerAddresses ca on ca.customerId = c.id
 where c.merchant_id = 1781
and c.id = 208732
and c.last_name like '%Lebel%'


DECLARE @MerchantIdforcustomerOrdersItems AS INT = 1781;
select top 100 * from CustomerOrderItems
where orderId = 132832
order by id desc

DECLARE @MerchantIdforDebugForActiveCarts AS INT = 1781;
select  top 100 * from ActiveShoppingCarts 
where merchantid = @MerchantIdforDebugForActiveCarts
order by id desc


DECLARE @MIDCustomerOrderPayments AS INT = 1781;
select top 100 p.label, c.* from CustomerOrderPayments c
inner join PaymentIntegrations p on p.id = c.PaymentIntegrationId
where c.orderid = 208732
--where c.orderid in (select id from CustomerOrders where merchant_id = @MIDCustomerOrderPayments )
order by orderid desc


DECLARE @CustomerOrderEmailsHistory AS INT = 1781;
select top 100 * from CustomerOrderEmailsHistory
where orderid in (select customerOrderId from MerchantTransactionLog
where merchant_id = @CustomerOrderEmailsHistory)
order by id desc


DECLARE @MerchantIdforDebugForCartConfigurations AS INT = 1781;
select * from MerchantShoppingCartConfigurations
where merchantid = @MerchantIdforDebugForCartConfigurations



 --********************FEATURES********************
 DECLARE @MerchantIdforFeatures AS INT = 1781;
 select * from merchantWebsiteFeatures where merchant_id = @MerchantIdforFeatures


 select * from MerchantInventoryStore where merchant_ID = 1781 and itemID = 715329




 --********************texts********************
DECLARE @MerchantIdfortexts AS INT = 1781;
select * from merchantWebsitetexts
where merchant_id = @MerchantIdfortexts
and textcode like '%payment%'



--************Products with prices******************
-- DECLARE @MerchantIdforProdsWithPrices AS INT = 1781;
-- select top 1 productid, price, reducedPrice from merchantprods
-- where merchant_id = @MerchantIdforProdsWithPrices
-- and price is not null



 --********************Shipping********************
DECLARE @MerchantIdforShipping AS INT = 1781;
select * from merchantshipping where merchant_id =@MerchantIdforShipping



--select  * from MerchantShippingIncludeRules where merchantshippingid in (select id from merchantshipping where merchant_id =@MerchantIdforShipping)
DECLARE @MerchantIdforShippingShippingPricesBYValueRanges AS INT = 1781;
select * from MerchantShippingPricesByValueRanges
where merchantshippingid in (select id from merchantshipping where merchant_id = @MerchantIdforShippingShippingPricesBYValueRanges)

 
DECLARE @MerchantIdforShippingShippingPricesByQuantity AS INT = 1781;
select * from MerchantShippingPricesByQuantity
where merchantshippingid in (select id from merchantshipping where merchant_id =@MerchantIdforShippingShippingPricesByQuantity)


DECLARE @MerchantIdforShippingPricesByStoreLocRings AS INT = 1781;
select * from MerchantShippingPricesByStoreLocRings
where merchantshippingid in (select id from merchantshipping where merchant_id =@MerchantIdforShippingPricesByStoreLocRings)




DECLARE @MerchantIdforShippingPricesByStoreLocRadio AS INT = 1781;
select * from MerchantShippingPricesByStoreLocRadio
where merchantshippingid in (select id from merchantshipping where merchant_id =@MerchantIdforShippingPricesByStoreLocRadio)


--Deprecated
DECLARE @MerchantIdforShippingPricesShippingPrices AS INT = 1781;
select * from MerchantShippingPrices
where merchantshippingid in (select id from merchantshipping where merchant_id = @MerchantIdforShippingPricesShippingPrices)



DECLARE @merchantshippingIncluderules AS INT = 1781;
select c.category, ms.name_1, msir.* from merchantshippingIncluderules msir
inner join merchantshipping ms on ms.id = msir.MerchantShippingId
left join categories c on c.id_category = msir.catid and c.id_langue = 1
where msir.merchantshippingid in (select id from merchantshipping where merchant_id = @merchantshippingIncluderules)



DECLARE @merchantshippingexcludeRules AS INT = 1781;
select c.category, ms.name_1, mser.* from merchantshippingExcluderules mser
inner join merchantshipping ms on ms.id = mser.MerchantShippingId
inner join categories c on c.id_category = mser.catid and c.id_langue = 1
where mser.merchantshippingid in (select id from merchantshipping where merchant_id = @merchantshippingexcludeRules)

DECLARE @MERCHANTIDFORE0XCLUSIONS as int = 1781;
select * from MerchantShippingExclusions
where MerchantShippingId in (select id from merchantshipping where merchant_id = @MERCHANTIDFORE0XCLUSIONS)



--********************Stores********************
DECLARE @MerchantIdforStores AS INT = 1781;
select * from merchantstores where merchantid = @MerchantIdforStores




--********************Zones********************
DECLARE @MerchantIdforZones AS INT = 1781;
select * from merchantzones where merchant_id =@MerchantIdforZones
select * from merchantzonecodes
where merchantzoneid in (select id from merchantzones where merchant_id =@MerchantIdforZones) 
select * from MerchantZoneRadiusesFromStores
where merchantzoneid in (select id from merchantzones where merchant_id =@MerchantIdforZones)



--********************Taxes********************

DECLARE @MerchantIdforTaxes AS INT = 1781;
select * from merchanttaxes where merchant_id =@MerchantIdforTaxes 
select * from MerchantStoresTaxes
where merchantTaxId in (select id from merchanttaxes where merchant_id =@MerchantIdforTaxes)
select * from merchantstores
where merchantid =@MerchantIdforTaxes 
select * from MerchantTaxZones
where merchantTaxId in (select id from merchanttaxes where merchant_id =@MerchantIdforTaxes)

DECLARE @MerchantIdforTaxesEXemption AS INT = 1781;
select * from MerchantTaxExemptItems where merchantid = @MerchantIdforTaxesEXemption

--*********************Installations*****************************************
DECLARE @MerchantIdforInstallations AS INT = 1781;
select * from Merchantinstallations where merchantid = @MerchantIdforInstallations


----********************Warranties********************
DECLARE @MerchantIdforWarranties AS INT = 1781;
select * from merchantwarranties where merchantid = @MerchantIdforWarranties
select * from merchantwarrantyprices where merchantwarrantyid in (select id from merchantwarranties where merchantid = @MerchantIdforWarranties)


--********************Cart Options****************************
DECLARE @MerchantIdforCartOptions AS INT = 1781;
select * from merchantCartOptions where merchantid = @MerchantIdforCartOptions


select * from MerchantCartOptionPricesByFixedRate
select * from MerchantCartOptionPricesByValueRanges
select * from MerchantCartOptionGroups
select * from MerchantCartOptionShippingExcludeRules
select * from MerchantCartOptionShippingIncludeRules



--*********************merchantcms****************************************
DECLARE @MerchantIdforcms AS INT = 1781;
select orders, warranties from merchantcms where merchant_id = @MerchantIdforcms


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
--and  mf.featurevalue like '%onlyppc%'
and m.active = 1
and  mf.merchant_id in (select merchant_id  from merchantwebsitefeatures
where featurevalue    in ('tbplatinum') and featureCode = 'template')
--and m.countryCode = 'CA'
and  mf.merchant_id in (select merchant_id  from merchantwebsitefeatures
where featureCode    in ('hasShippingOptionsOnItems'))


