 
--Debugging
DECLARE @MerchantIdforDebugForLogs AS INT = 3429;
select top 100 * from merchantwebsiteeventlogs 
where merchantid = @MerchantIdforDebugForLogs
--and module = 'ShoppingCart'
--and time between '2023-12-13 12:30:09.157' and '2023-12-13 12:50:09.157'
order by time desc

select  top 10 * from merchantusers

			SELECT *
			FROM SystemSettings
			WHERE [key] = 'PlatinumDefaultHomePageComponents'


DECLARE @MerchantIdforDebug AS INT = 3429;
select top 150  * from MerchantTransactionLog
where merchant_id = @MerchantIdforDebug
order by id desc

DECLARE @MIDCustomerOrders AS INT = 3429;
select top 100 * from CustomerOrders
where merchant_id = @MIDCustomerOrders
--and id = 132832
order by id desc

DECLARE @MerchantIdcustomers AS INT = 3429;
select c.*, ca.* from customers c 
inner join CustomerAddresses ca on ca.customerId = c.id
 where c.merchant_id = 3429
and c.id = 208732
and c.last_name like '%Lebel%'


DECLARE @MerchantIdforcustomerOrdersItems AS INT = 3429;
select top 100 * from CustomerOrderItems
where orderId = 132832
order by id desc

DECLARE @MerchantIdforDebugForActiveCarts AS INT = 3429;
select  top 100 * from ActiveShoppingCarts 
where merchantid = @MerchantIdforDebugForActiveCarts
order by id desc


DECLARE @MIDCustomerOrderPayments AS INT = 3429;
select top 50 p.label, co.orderTimeStamp, c.* from CustomerOrderPayments c
inner join PaymentIntegrations p on p.id = c.PaymentIntegrationId
inner join CustomerOrders co on co.id = c.OrderId
where co.merchant_id = @MIDCustomerOrderPayments 
order by orderid desc


DECLARE @CustomerOrderEmailsHistory AS INT = 3429;
select top 100 * from CustomerOrderEmailsHistory
where orderid in (select customerOrderId from MerchantTransactionLog
where merchant_id = @CustomerOrderEmailsHistory)
order by id desc

--Get the ip address here from teh paymentData json
select top 50 * from customerOrderRequests where merchantid = 3429 order by CreationTimestamp desc

-- <cfset this.ORDER_STATUS_CREATED = "C">
-- <cfset this.ORDER_STATUS_PENDING = "P">
-- <cfset this.ORDER_STATUS_SUCCESS = "S">
-- <cfset this.ORDER_STATUS_FAILED = "F">


--Historical, --use  ip address here from the paymentData on the customerOrderRequests table to filtre the results.
select  id, ipaddress, [timestamp],url_string from firewall.dbo.historical
 where url_string like '%eastcoastfurnishings.com%'
 and [timestamp] between '2024-11-13 15:00:13.453' and '2024-11-13 16:45:13.453'
 and ipaddress = '2a09:bac3:1b5f:1973::289:77'
  order by [timestamp] desc

select * from 

DECLARE @MerchantIdforDebugForCartConfigurations AS INT = 3527;
select * from MerchantShoppingCartConfigurations
where merchantid = @MerchantIdforDebugForCartConfigurations

delete top (1)  MerchantShoppingCartConfigurations where id = 935

select * from 


 --********************FEATURES********************
 DECLARE @MerchantIdforFeatures AS INT = 3429;
 select * from merchantWebsiteFeatures where merchant_id = @MerchantIdforFeatures
 select distinct featureCode from merchantWebsiteFeatures where featureCode like '%items%'

1932
3025
3151
3165
3385

 --********************texts********************
DECLARE @MerchantIdfortexts AS INT = 3429;
select * from merchantWebsitetexts
where merchant_id = @MerchantIdfortexts
and textcode like '%payment%'

update top (1) merchantWebsitetexts
set content_1 = 'mrbeesfurniture@yahoo.com'
where id = 295547


--************Products with prices******************
DECLARE @MerchantIdforProdsWithPrices AS INT = 3429;
select top 1 productid, price, reducedPrice from merchantprods
where merchant_id = @MerchantIdforProdsWithPrices
and price is not null



 --********************Shipping********************

DECLARE @MerchantIdforShipping AS INT = 3429;
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


	select * from MerchantShippingPricesByValueRanges
	where merchantshippingid = 1355

	update top (1) MerchantShippingPricesByValueRanges
	set lowPrice = 0 where id = 1256

--=========================================================================================================================

DECLARE @merchantshippingIncluderules AS INT = 3429;
select c.category, ms.name_1, msir.* from merchantshippingIncluderules msir
inner join merchantshipping ms on ms.id = msir.MerchantShippingId
left join categories c on c.id_category = msir.catid and c.id_langue = 1
where msir.merchantshippingid in (select id from merchantshipping where merchant_id = @merchantshippingIncluderules)



DECLARE @merchantshippingexcludeRules AS INT = 3429;
select c.category, ms.name_1, mser.* from merchantshippingExcluderules mser
inner join merchantshipping ms on ms.id = mser.MerchantShippingId
inner join categories c on c.id_category = mser.catid and c.id_langue = 1
where mser.merchantshippingid in (select id from merchantshipping where merchant_id = @merchantshippingexcludeRules)


DECLARE @MERCHANTIDFORE0XCLUSIONS as int = 3429;
select * from MerchantShippingExclusions
where MerchantShippingId in (select id from merchantshipping where merchant_id = @MERCHANTIDFORE0XCLUSIONS)



--********************Stores********************
DECLARE @MerchantIdforStores AS INT = 3429;
select * from merchantstores where merchantid = @MerchantIdforStores




--********************Zones********************
DECLARE @MerchantIdforZones AS INT = 3429;
select * from merchantzones where merchant_id =@MerchantIdforZones

select * from merchantzonecodes
where merchantzoneid in (select id from merchantzones where merchant_id =@MerchantIdforZones) 

select * from MerchantZoneRadiusesFromStores
where merchantzoneid in (select id from merchantzones where merchant_id =@MerchantIdforZones)



--********************Taxes********************

DECLARE @MerchantIdforTaxes AS INT = 3429;
select * from merchanttaxes where merchant_id = @MerchantIdforTaxe

select * from MerchantStoresTaxes
where merchantTaxId in (select id from merchanttaxes where merchant_id =@MerchantIdforTaxes)


select * from MerchantTaxZones
where merchantTaxId in (select id from merchanttaxes where merchant_id =@MerchantIdforTaxes)

DECLARE @MerchantIdforTaxesEXemption AS INT = 3429;
select * from MerchantTaxExemptItems where merchantid = @MerchantIdforTaxesEXemption


--*********************Installations*****************************************
DECLARE @MerchantIdforInstallations AS INT = 3429;
select * from Merchantinstallations where merchantid = @MerchantIdforInstallations


----********************Warranties********************
DECLARE @MerchantIdforWarranties AS INT = 3429;
select * from merchantwarranties where merchantid = @MerchantIdforWarranties
select * from merchantwarrantyprices where merchantwarrantyid in (select id from merchantwarranties where merchantid = @MerchantIdforWarranties)


--********************Cart Options****************************
DECLARE @MerchantIdforCartOptions AS INT = 3429;
select * from merchantCartOptions where merchantid = @MerchantIdforCartOptions


select * from MerchantCartOptionPricesByFixedRate
select * from MerchantCartOptionPricesByValueRanges
select * from MerchantCartOptionGroups
select * from MerchantCartOptionShippingExcludeRules
select * from MerchantCartOptionShippingIncludeRules



--*********************merchantcms****************************************
DECLARE @MerchantIdforcms AS INT = 3429;
select orders, warranties from merchantcms where merchant_id = @MerchantIdforcms




select m.merchant, m.filepath, mt.* from merchantwebsitetexts mt
join merchants m on m.id = mt.merchant_id
 where mt.textcode = 'paymentdetailtest' and mt.content_1 like '%authorize%' and mt.availableinmerchantbean = 1

select m.id, m.countryCode, m.merchant_code,m.merchant,m.merchant_url, m.filepath, mf.featurecode, mf.featurevalue, m.active
from merchantwebsitefeatures mf
join merchants m on m.id = mf.merchant_id
join merchantwebsiteinformation mwi on mwi.merchant_id = m.id
where  mf.featureCode = 'shoppingCartType'
and mf.featureValue = 'withauthorize.net'
and m.active = 1
and m.merchant_url not like '%tailbase%'
and merchant not like '%tailbase%'
and merchant not like   '%old%'
and  mf.merchant_id in (select merchant_id  from merchantwebsitefeatures
where featurevalue    in ('tbplatinum') and featureCode = 'template')
and mwi.infovalue not like '%tailbasify%' 
--and m.countryCode = 'CA'
--and  mf.merchant_id in (select merchant_id  from merchantwebsitefeatures
--where featureCode    in ('hasShippingOptionsOnItems'))

select distinct featureValue from merchantWebsiteFeatures
where featurecode = 'shoppingCartType'


select * from merchantwebsitetexts where merchant_id in (3429,3442,3486,3429) and textcode like '%paymentPPCDetailTest%'
