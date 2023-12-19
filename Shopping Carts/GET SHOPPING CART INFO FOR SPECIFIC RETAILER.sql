 
--Debugging
DECLARE @MerchantIdforDebugForLogs AS INT = 3487;
select top 100 * from merchantwebsiteeventlogs 
where merchantid = @MerchantIdforDebugForLogs
--and module = 'ShoppingCart'
--and time between '2023-12-13 12:30:09.157' and '2023-12-13 12:50:09.157'
order by time desc

select  top 10 * from merchantusers

			SELECT *
			FROM SystemSettings
			WHERE [key] = 'PlatinumDefaultHomePageComponents'


DECLARE @MerchantIdforDebug AS INT = 3487;
select top 150  * from MerchantTransactionLog
where merchant_id = @MerchantIdforDebug
order by id desc

DECLARE @MIDCustomerOrders AS INT = 3487;
select top 100 * from CustomerOrders
where merchant_id = @MIDCustomerOrders
and id = 132832
order by id desc

DECLARE @MerchantIdcustomers AS INT = 3487;
select c.*, ca.* from customers c 
inner join CustomerAddresses ca on ca.customerId = c.id
 where c.merchant_id = 3487
and c.id = 208732
and c.last_name like '%Lebel%'


DECLARE @MerchantIdforcustomerOrdersItems AS INT = 3487;
select top 100 * from CustomerOrderItems
where orderId = 132832
order by id desc

DECLARE @MerchantIdforDebugForActiveCarts AS INT = 3487;
select  top 100 * from ActiveShoppingCarts 
where merchantid = @MerchantIdforDebugForActiveCarts
order by id desc

2023-12-14 11:37:39.680
2023-12-13 12:41:17.247
2023-12-03 18:25:26.457


DECLARE @MIDCustomerOrderPayments AS INT = 3487;
select top 100 p.label, c.* from CustomerOrderPayments c
inner join PaymentIntegrations p on p.id = c.PaymentIntegrationId
where c.orderid = 208732
--where c.orderid in (select id from CustomerOrders where merchant_id = @MIDCustomerOrderPayments )
order by orderid desc


DECLARE @CustomerOrderEmailsHistory AS INT = 3487;
select top 100 * from CustomerOrderEmailsHistory
where orderid in (select customerOrderId from MerchantTransactionLog
where merchant_id = @CustomerOrderEmailsHistory)
order by id desc

select * from customerOrderRequests


DECLARE @MerchantIdforDebugForCartConfigurations AS INT = 3487;
select * from MerchantShoppingCartConfigurations
where merchantid = @MerchantIdforDebugForCartConfigurations


 --********************FEATURES********************
 DECLARE @MerchantIdforFeatures AS INT = 3487;
 select * from merchantWebsiteFeatures where merchant_id = @MerchantIdforFeatures



 --********************texts********************
DECLARE @MerchantIdfortexts AS INT = 3487;
select * from merchantWebsitetexts
where merchant_id = @MerchantIdfortexts
and textcode like '%payment%'


--************Products with prices******************
DECLARE @MerchantIdforProdsWithPrices AS INT = 3487;
select top 1 productid, price, reducedPrice from merchantprods
where merchant_id = @MerchantIdforProdsWithPrices
and price is not null



 --********************Shipping********************

DECLARE @MerchantIdforShipping AS INT = 3487;
DECLARE @ShippingType as varchar(200) = 
	( 
		select featureValue from merchantWebsiteFeatures 
		where merchant_id = @MerchantIdforShipping 
		and featurecode = 'shippingOptionTypes'
	);


select * from merchantshipping where merchant_id =@MerchantIdforShipping

Select @ShippingType as 'ShippingType'

IF @ShippingType like '%merchantShippingByCartTotalItemsValueRange%' 
	select * from MerchantShippingPricesByValueRanges
	where merchantshippingid in (select id from merchantshipping where merchant_id = @MerchantIdforShipping)

else if  @ShippingType like '%merchantShippingByCartTotalItemQuantities%'
	select * from MerchantShippingPricesByQuantity
	where merchantshippingid in (select id from merchantshipping where merchant_id = @MerchantIdforShipping)

else if  @ShippingType like '%merchantShippingByStoreLocationRings%'
	select * from MerchantShippingPricesByStoreLocRings
	where merchantshippingid in (select id from merchantshipping where merchant_id = @MerchantIdforShipping)

else if  @ShippingType like '%merchantShippingByStoreLocationRadio%'
	select * from MerchantShippingPricesByStoreLocRadio
	where merchantshippingid in (select id from merchantshipping where merchant_id = @MerchantIdforShipping)

else if  @ShippingType like '%merchantShippingByItem3%'
	select * from MerchantShippingPrices
	where merchantshippingid in (select id from merchantshipping where merchant_id = @MerchantIdforShipping)

--=========================================================================================================================

DECLARE @merchantshippingIncluderules AS INT = 3487;
select c.category, ms.name_1, msir.* from merchantshippingIncluderules msir
inner join merchantshipping ms on ms.id = msir.MerchantShippingId
left join categories c on c.id_category = msir.catid and c.id_langue = 1
where msir.merchantshippingid in (select id from merchantshipping where merchant_id = @merchantshippingIncluderules)



DECLARE @merchantshippingexcludeRules AS INT = 3487;
select c.category, ms.name_1, mser.* from merchantshippingExcluderules mser
inner join merchantshipping ms on ms.id = mser.MerchantShippingId
inner join categories c on c.id_category = mser.catid and c.id_langue = 1
where mser.merchantshippingid in (select id from merchantshipping where merchant_id = @merchantshippingexcludeRules)


DECLARE @MERCHANTIDFORE0XCLUSIONS as int = 3487;
select * from MerchantShippingExclusions
where MerchantShippingId in (select id from merchantshipping where merchant_id = @MERCHANTIDFORE0XCLUSIONS)



--********************Stores********************
DECLARE @MerchantIdforStores AS INT = 3487;
select * from merchantstores where merchantid = @MerchantIdforStores




--********************Zones********************
DECLARE @MerchantIdforZones AS INT = 3487;
select * from merchantzones where merchant_id =@MerchantIdforZones

select * from merchantzonecodes
where merchantzoneid in (select id from merchantzones where merchant_id =@MerchantIdforZones) 

select * from MerchantZoneRadiusesFromStores
where merchantzoneid in (select id from merchantzones where merchant_id =@MerchantIdforZones)



--********************Taxes********************

DECLARE @MerchantIdforTaxes AS INT = 3487;
select * from merchanttaxes where merchant_id =@MerchantIdforTaxes 

select * from MerchantStoresTaxes
where merchantTaxId in (select id from merchanttaxes where merchant_id =@MerchantIdforTaxes)


select * from MerchantTaxZones
where merchantTaxId in (select id from merchanttaxes where merchant_id =@MerchantIdforTaxes)

DECLARE @MerchantIdforTaxesEXemption AS INT = 3487;
select * from MerchantTaxExemptItems where merchantid = @MerchantIdforTaxesEXemption


--*********************Installations*****************************************
DECLARE @MerchantIdforInstallations AS INT = 3487;
select * from Merchantinstallations where merchantid = @MerchantIdforInstallations


----********************Warranties********************
DECLARE @MerchantIdforWarranties AS INT = 3487;
select * from merchantwarranties where merchantid = @MerchantIdforWarranties
select * from merchantwarrantyprices where merchantwarrantyid in (select id from merchantwarranties where merchantid = @MerchantIdforWarranties)


--********************Cart Options****************************
DECLARE @MerchantIdforCartOptions AS INT = 3487;
select * from merchantCartOptions where merchantid = @MerchantIdforCartOptions


select * from MerchantCartOptionPricesByFixedRate
select * from MerchantCartOptionPricesByValueRanges
select * from MerchantCartOptionGroups
select * from MerchantCartOptionShippingExcludeRules
select * from MerchantCartOptionShippingIncludeRules



--*********************merchantcms****************************************
DECLARE @MerchantIdforcms AS INT = 3487;
select orders, warranties from merchantcms where merchant_id = @MerchantIdforcms




select m.merchant, m.filepath, mt.* from merchantwebsitetexts mt
join merchants m on m.id = mt.merchant_id
 where mt.textcode = 'paymentdetailtest' and mt.content_1 like '%authorize%' and mt.availableinmerchantbean = 1

 
select m.id, m.countryCode, m.merchant_code,m.merchant,m.merchant_url, m.filepath, mf.featurecode, mf.featurevalue, m.active
from merchantwebsitefeatures mf
join merchants m on m.id = mf.merchant_id
where  mf.featureCode = 'shoppingCartType'
and mf.featureValue = 'onlyppc'
and m.active = 1
and m.merchant_url not like '%tailbase%'
and merchant not like '%tailbase%'
and merchant not like   '%old%'
and  mf.merchant_id in (select merchant_id  from merchantwebsitefeatures
where featurevalue    in ('tbplatinum') and featureCode = 'template')
and m.countryCode = 'CA'
and  mf.merchant_id in (select merchant_id  from merchantwebsitefeatures
where featureCode    in ('hasShippingOptionsOnItems'))

select distinct featureValue from merchantWebsiteFeatures
where featurecode = 'shoppingCartType'


select * from merchantwebsitetexts where merchant_id in (3487,3442,3486,3487) and textcode like '%paymentPPCDetailTest%'
