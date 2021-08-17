Steps to follow and configure shopping cart in DB

--1.	Get merchant information: full name, filepath, server location, current url, template used, country. The query to use is:
select		distinct m.id,si.ip, si.name asserver,m.merchant_code,m.merchant,m.filepath,m.merchant_url,mwf.featurevalueas template,mwfs.featurevalueassearchtype,m.merchantpwd,m.countrycode
from		serverinfosi
join		merchantcmscmsoncms.serverenvironment=si.serverenvironment
left join		merchantwebsitefeaturesmwfsonmwfs.merchant_id=cms.merchant_idandmwfs.featurecode='searchtype'
left join		merchantwebsitefeaturesmwfonmwf.merchant_id=cms.merchant_id
and			mwf.featurecode='template'
join		merchants m on m.id =cms.merchant_id
where		m.active= 1
and			m.merchantlike'%[Merchant Name]%'
--and m.merchant_code = 'adc20'
orderby	template,server

--2.	Check if website has items with price for testing:
SELECT * FROM merchantProds WHERE merchant_id= 1555 and price is not null order by price asc

--3.	Add website features
--a.	ALWAYS add feature taxRuleForStorePickup=usStoreRate; this is for let the cart automatically use the tax configured using the location of the store when the store pickup option is selected

insert into merchantWebsiteFeatures(merchant_id,featureCode,featureValue)values (1555,'taxRuleForStorePickup','useStoreRate')

--b.	Add feature shippingOptionTypes=[shipping options available]; depending on the delivery option selected you will fill this feature, the options available are: 
-- - externalShippingByFedex
-- - merchantShippingByCartTotalItemQuantities
 --- merchantShippingByCartTotalItemsValueRange
 --- merchantShippingByItem3
 --- merchantShippingByStoreLocationRadio
 --- merchantShippingByStoreLocationRings
  -- * Depending on the delivery option selected you will fill different tables in the DB

For example, in delivery option by radio the query to use is: 

insert into merchantWebsiteFeatures(merchant_id,featureCode,featureValue)values (1555,'shippingOptionTypes','merchantShippingByStoreLocationRadio')
--4.	Add MerchantWebsiteTexts records
--a.	ALWAYS add shopping cart email: shopcartemail=[email of website, if it is not provided use the email configured for quote request], you can get it by using this:
SELECT * FROM MerchantWebsiteTexts WHERE merchant_id=[merchant_id] and textcode like '%quote%'

--And to insert into merchantWebsiteTexts use:
--insert into MerchantWebsiteTexts(merchant_id,textcode,content_1,Id_langue)values ([merchant_id],'shopcartemail','[email]',1)
insert into merchantWebsiteFeatures(merchant_id,featureCode,featureValue) values (1555,'shippingOptionTypes','merchantShippingByStoreLocationRings')

--b.	Configure the API settings for the payment handler specified; depending on the payment handler you will use a different connection string and text code; the payment handler available are (with some examples): 
 -- BluePay (paymentDetail,paymentDetailTest)
insert into MerchantWebsiteTexts(merchant_id,textcode,content_1,Id_langue)values (1555,'paymentDetail','DoDirectPayment|paymentAction~SALE|serverURL~https://secure.bluepay.com/interfaces/bp10emu|useProxy~false|MERCHANT_ID~100178940217|TPS_KEY~IQ49FMUVC24TMDNPHBA0GJQBNSAXLV6D',1)
insert into MerchantWebsiteTexts(merchant_id,textcode,content_1,Id_langue)values (1555,'paymentDetailTest','testACCT~4111111111111111|DoDirectPayment|paymentAction~SALE|serverURL~https://secure.bluepay.com/interfaces/bp10emu|useProxy~false|MERCHANT_ID~100178940217|TPS_KEY~IQ49FMUVC24TMDNPHBA0GJQBNSAXLV6D',1)

-- - Paypal (paymentDetail,paymentDetailTest)
insert into MerchantWebsite Texts(merchant_id,textcode,content_1,Id_langue)values ([merchant_id],paymentDetail,'DoDirectPayment|paymentAction~sale|serverURL~https://api-3t.paypal.com/nvp|useProxy~false|proxyName~|proxyPort~|user~onlinesales_api1.2001audiovideo.com|pwd~NDBMLBULL2J63H6T|signature~AFcWxV21C7fd0v3bYYYRCpSSRl31A2oHaol-dI1CVZjS1refv9JTwdrI|version~58.0',1)
insert into MerchantWebsiteTexts(merchant_id,textcode,content_1,Id_langue)values ([merchant_id],paymentDetailTest,'testACCT~4600032173990879|DoDirectPayment|paymentAction~sale|serverURL~https://api-3t.sandbox.paypal.com/nvp|useProxy~false|proxyName~|proxyPort~|user~sdk-three_api1.sdk.com|pwd~QFZCWN5HZM8VBG7Q|signature~A.d9eRKfd1yVkRrtmMfCFLTqa6M9AyodL0SJkhYztxUi8W9pCXF6.4NI|version~57.0',1)

 --- Paypal Express Checkout (paymentPPEDetail, paymentPPEDetailTest)
insert into MerchantWebsiteTexts(merchant_id,textcode,content_1,Id_langue)values ([merchant_id],'paymentPPEDetail','postURL~https://api-3t.paypal.com/nvp|loginURL~https://www.paypal.com/cgi-bin/webscr?cmd=_express-checkout|merchantUser~TrendFurniture_api1.live.com|merchantPwd~5JKKKYNXEUT3BUJ6|Signature~AiPC9BjkCyDFQXbSkoZcgqH3hpacAvKSgan3OYzZDrdvq.cJzhhfdtfx|verifiedShipAddress~0|pPEVersion~64.3|merchantURL~http://www.trendsfurniturewyoming.com|solutionType~Sole',1)
insert into MerchantWebsiteTexts(merchant_id,textcode,content_1,Id_langue)values ([merchant_id],'paymentPPEDetailTest','postURL~https://api-3t.sandbox.paypal.com/nvp|loginURL~https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout|merchantUser~tailbase_dev-facilitator_api1.tailbase.com|merchantPwd~1377701893|Signature~ACPU7qzY0PGp3tyGnJuJj1JuG5LuA.hMRz1SFtrZCQHXXWsEd5-iQUMp|verifiedShipAddress~0|pPEVersion~64.3|merchantURL~http://TRENDF.tm2.tailbase.com|solutionType~Sole',1)

 --- Netbanx (paymentDetail,paymentDetailTest)
insert into MerchantWebsiteTexts(merchant_id,textcode,content_1,Id_langue)values ([merchant_id],'paymentDetail','DoDirectPayment|Server_URL~https://api.netbanx.com/hosted/v1/orders|KeyID~sonXplus|KeyPassword~B-p1-0-570fb44c-0-302c021478014ec1d531f74ea0ede52ba42289280b96460d0214218a1f4e80afedddc65fe7759c2aab7d249c6ee8|merchantURL~http://www.sonxplus.com',1)
insert into MerchantWebsiteTexts(merchant_id,textcode,content_1,Id_langue)values ([merchant_id],'paymentDetailTest','testFIRSTNAME~sonxtest975|DoDirectPayment|Server_URL~https://api.test.netbanx.com/hosted/v1/orders|KeyID~sonXplus-test|KeyPassword~B-qa2-0-5681ae39-0-302c02141f31095c7dfa9231113cb8e5d2c60a42731acf0202143c2d2c02dc20ff47789aedf32a6f5f5036011668|merchantURL~http://sonxps.pc1.tailbase.com',1)

 --- Beanstream (paymentDetail,paymentDetailTest)
insert into MerchantWebsiteTexts(merchant_id,textcode,content_1,Id_langue)values ([merchant_id],'paymentDetailTest','testFIRSTNAME~aftest197|DoDirectPayment|Server_URL~https://www.beanstream.com/api/v1/payments|Merchant_ID~300210594|API_Passcode~F08EEFFd1Dc74afC935c9BAB961B45e3',1)
insert into MerchantWebsiteTexts(merchant_id,textcode,content_1,Id_langue)values ([merchant_id],'paymentDetail','DoDirectPayment|Server_URL~https://www.beanstream.com/api/v1/payments|Merchant_ID~219480121|API_Passcode~cB0eD39e346b49FEaA6Af267c5c65d4D',1)

--5.	Set stores as store pickup: in the table merchantStores is a field called pickupAvailable, it has to be put as true for the stores we want to be as an option in the cart. Generally they are all stores.
UPDATE MerchantStores SET pickupAvailable= 1,pickupDelayMinimumDays=NULL,pickupDelayMaximumDays=NULL WHERE MerchantID =1555

--a.	Check if all stores configured have geoposition (it is a field in the same table)
SELECT * FROM MerchantStores WHERE MerchantID =1555
--6.	Configure the shipping options; depending on the delivery option specified this step will vary.
--7.	Configure taxes, generally the tax is specified as part of the requirement for the cart, but it is important to know that it is associated to the location of the store and also the zones where the delivery options are available.
--To insert into merchantTaxes table:
INSERT INTO merchantTaxes(name_1,merchant_id,amount,taxableItems)VALUES ('Tax',1555,0.100000,'')

--To insert the Tax Zones:
INSERT INTO MerchantTaxZones(merchantTaxId,countryCode,provinceCode,postalCode)
SELECT mt.id,'US',NULL,NULL
FROM merchantTaxes mt
WHERE mt.merchant_id = 1555

INSERT INTO MerchantStoresTaxes(merchantTaxId,merchantStoreId)
SELECT		DISTINCT mt.ID, ms.id
FROM		merchantstores ms
JOIN		merchanttaxes mt ON mt.merchant_id = ms.merchantid 
JOIN		merchanttaxzones mtz on mtz.merchanttaxid = mt.id 
AND			(mtz.provincecode = ms.province or mtz.provincecode is null)
AND			(mtz.postalcode = ms.postalcode or mtz.postalcode is null)
WHERE		ms.merchantid = 1555 and ms.pickupavailable = 1



--8.	Activate order tool in the console; this can be done by setting true in the table/field MerchantCms.orders.
UPDATE merchantCMS set orders = 1 WHERE merchant_id = 1555

select orders from  merchantCMS  WHERE merchant_id = 1583

--9.	Finally activate the cart: this can be done by adding the feature shoppingCartType=[the type of cart based on the payment handler used]; the type of cart currently available are: 
 -bluepaywithppe
 -Netbanx
 -onlyppe
 -paypal
 -withbeanstream
 -withbeanstream-2-steps
 -withbluepay
 -withbluepay-2-steps
 -withbluepayexpresscheckout
 -withnetbanxv1-2-steps
 -withnetbanxv1-5-steps
 -withpaypal
--For example:


insert into merchantWebsiteFeatures(merchant_id,featureCode,featureValue)values (1555,'shoppingCartType','withbluepay-2-steps')

select * from merchantWebsiteFeatures where merchant_id = 1555 and featurecode = 'shippingOptionTypes'


