select m.id,m.merchant_code,m.merchant,m.merchantpwd,m.filepath,m.merchant_url,m.active,mf.featurevalue,mc.serverenvironment
from merchants m
left join merchantWebsiteFeatures mf on mf.merchant_id = m.id and mf.featureCode = 'template'
inner join merchantcms mc on mc.merchant_id = m.id
--where mc.serverEnvironment = 'ewhserver2795'
--where mf.featurevalue = 'nwdynamicprov20_g1'
--where m.filepath = '2001audiovideo'
--where m.id in (536,393) and mf.featurevalue = 'nwdynamicprov20_g1'
--where m.merchant like '%groves%'
where m.merchant_code = 'bsctst'
--where m.id = 2795
and m.active = 1


--CHECK  IF CLIENT HAVE PRODUCTS WITH PRICES
--use stagingtailbasecore
use datatail20130410
SELECT * FROM merchantProds WHERE merchant_id = 2702  and price is not null order by price asc
--update top (1) merchantprods set storeonly = 0 where merchant_id = 2795 and productid =280399
update top (1) merchantprods set price = 29.99  where merchant_id = 2875 and productid =46733  -- 120.00

select * from products where id_product = 280399

--========================================================================================================================--
--1- ACTIVATE ORDERS FOR CLIENT
SELECT MERCHANT_ID,ORDERS,warranties FROM MERCHANTCMS WHERE MERCHANT_ID = 2795
--UPDATE top (1) merchantCMS
--set orders = 1,
--warranties = 1
--WHERE merchant_id = 2795

--=========================================================================================================================
-- 3- SET SHOPPING CART FEATURES (TAX AND SHOPPING CART TYPE)
select * from merchantwebsitefeatures where merchant_id =2795
--insert into merchantWebsiteFeatures(merchant_id,featureCode,featureValue) values
--(2795,'installationsSettings',null)   --this is a paid tool
--(2795,'hasShippingOptionsOnItems',null), -- need this absolutly for Platinum Shopping carts 
(2795,'taxRuleForStorePickup','useStoreRate'), -- only if it has a special rate for  merchant store
(2795,'useShippingOptionsWithEstimate',null),
(2795,'doesDisplayBillingAddress',''), --- to have the billing address same as the shipping address on the order email confimration and on PPE
(2795,'shippingOptionTypes','merchantShippingByCartTotalItemsValueRange')
--(2795,'shippingOptionTypes','merchantShippingByCartTotalItemsValueRange')
--(2795,'shippingOptionTypes','merchantShippingByStoreLocationRings')
--(2795,'shippingOptionTypes','merchantShippingByCartTotalItemQuantities')
--(2795,'shippingOptionTypes','merchantShippingByItem3')
--(2795,'hasAccordDFinancingByItems','') --- IF HAS ACCORD D
--(2795,'useDropShipping',null)

select distinct featurevalue from merchantWebsiteFeatures  where featurecode = 'shippingOptionTypes'



--GOOGLE RECAPTCHA FOR PLATINUM. FOLLOW INSTRUCTIONS ON THE COLDFUSION CHANNEL
--insert into merchantwebsitetexts (merchant_id,textcode, content_1) values
(2795,'gRecaptchaSecretKey','6LdX6nUUAAAAAKHWWKfg_bFdGqhbYlXxT7fAR5zV'),
(2795,'gRecaptchaSecretKeyTest','6LdX6nUUAAAAAKHWWKfg_bFdGqhbYlXxT7fAR5zV')



--update top (1) merchantwebsitefeatures set featureValue = 'merchantShippingByStoreLocationRings,merchantShippingByCartTotalItemsValueRange'
where merchant_id = 2795 and featurecode = 'shippingOptionTypes'

--select * from merchantwebsitefeatures where merchant_id = 1575
--delete top (1)from merchantwebsitefeatures  where merchant_id = 2795 and featurecode = 'hasShippingOptionsOnItems'
--delete top (1)from merchantwebsitefeatures  where merchant_id = 2795 and featurecode = 'taxRuleForStorePickup'

 use datatail20130410
 --3B DISCOUNTS
select discountsTool from merchantcms where merchant_id = 2795
--select * from merchantWebsiteFeatures where merchant_id = 1905
select * from merchantWebsiteFeatures where merchant_id = 2795
--UPDATE top (1) merchantCMS set discountsTool = 1 WHERE merchant_id = 2795
insert into merchantWebsiteFeatures (merchant_id,featureCode,featureValue) values
(2795,'globalDiscountBeforeTaxes',null),
(2795,'useTaxesDiscounts',null),
(2795,'useGlobalDiscounts',null),
(2795,'useGroupDiscountsV2',null),
(2795,'useGroupDiscounts',null),
(2795,'useItemsDiscounts',null)

--For Mega
--useGlobalDiscounts
--useGroupDiscountsV2
--useItemsDiscounts
--useTaxesDiscounts

delete top (2) from merchantWebsiteFeatures
where merchant_id = 2795
and featurecode in ('useGlobalDiscounts','useGroupDiscounts')



--select * from merchantWebsiteFeatures where merchant_id = 1275

--delete top (1) from merchantWebsiteFeatures where merchant_id = 2795 and featurecode = 'globalDiscountBeforeTaxes'
--delete top (1) from merchantWebsiteFeatures where merchant_id = 2795 and featurecode = 'useTaxesDiscounts'
--delete top (1) from merchantWebsiteFeatures where merchant_id = 2795 and featurecode = 'useGlobalDiscounts'
--delete top (1) from merchantWebsiteFeatures where merchant_id = 2795 and featurecode = 'useGroupDiscounts'
--delete top (1) from merchantWebsiteFeatures where merchant_id = 2795 and featurecode = 'useItemsDiscounts'



--=========================================================================================================================================================

--4. ADDING CONFIGURATION IN MWT (EMAIL)

insert into MerchantWebsiteTexts (merchant_id,textcode,content_1,content_2,id_langue) 
select merchant_id,'shopcartemail',content_1,content_2,id_langue 
from MerchantWebsiteTexts
where
    merchant_id=2795
and
    textcode like '%quote%' 


---4. ADDING CONFIGURATION IN MWT (PAYMENT TYPE)

-- BLUEPAY
--insert into MerchantWebsiteTexts(merchant_id,textcode,content_1,Id_langue) values
(2795,'paymentDetail','DoDirectPayment|paymentAction~SALE|serverURL~https://secure.bluepay.com/interfaces/bp10emu|useProxy~false|MERCHANT_ID~100893135031|TPS_KEY~Q.DTIYDOMJ8ZAPR8C1QAMXOOUDOW8EBX',1),
(2795,'paymentDetailTest','testACCT~4111111111111111|DoDirectPayment|paymentAction~SALE|serverURL~https://secure.bluepay.com/interfaces/bp10emu|useProxy~false|MERCHANT_ID~100178940217|TPS_KEY~IQ49FMUVC24TMDNPHBA0GJQBNSAXLV6D',1)

--BEANSTREAM
--insert into MerchantWebsiteTexts(merchant_id,textcode,content_1,Id_langue)values 
(2795,'paymentDetailTest','testFIRSTNAME~aftest197|DoDirectPayment|Server_URL~https://www.beanstream.com/api/v1/payments|Merchant_ID~300210594|API_Passcode~F08EEFFd1Dc74afC935c9BAB961B45e3',2),
(2795,'paymentDetail','DoDirectPayment|Server_URL~https://www.beanstream.com/api/v1/payments|Merchant_ID~355180018|API_Passcode~EF11162817c14Aa087eeE1f10D72E0C2',1)
 


-- WITH PAYPAL EXPRESS 
--insert into MerchantWebsiteTexts(merchant_id,textcode,content_1,Id_langue)  values
(2795,'paymentPPEDetail','postURL~https://api-3t.paypal.com/nvp|loginURL~https://www.paypal.com/cgi-bin/webscr?cmd=_express-checkout|merchantUser~slamoureux_api1.liquidaxion.com|merchantPwd~QKYB7QXGTHLXZXWW|Signature~AbYcrLqOVDeD4SeLk2ghhh461edPA4L8JHWy9DpoVRsMLfjBHApb8ayz|verifiedShipAddress~0|pPEVersion~64.3|merchantURL~https://www.oconsommateurs.com|solutionType~Sole',1),
(2795,'paymentPPEDetailTest','postURL~https://api-3t.sandbox.paypal.com/nvp|loginURL~https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout|merchantUser~tailbase_dev-facilitator_api1.tailbase.com|merchantPwd~1377701893|Signature~ACPU7qzY0PGp3tyGnJuJj1JuG5LuA.hMRz1SFtrZCQHXXWsEd5-iQUMp|verifiedShipAddress~0|pPEVersion~64.3|merchantURL~http://FUSEAP.pvmtm.tailbase.com|solutionType~Sole',1)

--update top (1) merchantwebsitetexts set content_1 = 'postURL~https://api-3t.sandbox.paypal.com/nvp|loginURL~https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout|merchantUser~tailbase_dev-facilitator_api1.tailbase.com|merchantPwd~1377701893|Signature~ACPU7qzY0PGp3tyGnJuJj1JuG5LuA.hMRz1SFtrZCQHXXWsEd5-iQUMp|verifiedShipAddress~0|pPEVersion~64.3|merchantURL~http://PIERCI.tm1.tailbase.com|solutionType~Sole' where merchant_id = 1432 and textcode = 'paymentPPEDetailTest'
--update top (1) merchantwebsitetexts set content_1 = 'postURL~https://api-3t.paypal.com/nvp|loginURL~https://www.paypal.com/cgi-bin/webscr?cmd=_express-checkout|merchantUser~ranahasan123_api2.hotmail.com|merchantPwd~N4UV55XWPGNT2D5B|Signature~AFcWxV21C7fd0v3bYYYRCpSSRl31A16TUo2YT.CPS1WNtIyFC86ZLsX-|verifiedShipAddress~0|pPEVersion~64.3|merchantURL~http://www.afforditfurnture.net|solutionType~Sole' where merchant_id = 1432 and textcode = 'paymentPPEDetail'


-- - Paypal (paymentDetail,paymentDetailTest)
--insert into MerchantWebsiteTexts(merchant_id,textcode,content_1,Id_langue) values
(2795,'paymentDetail','DoDirectPayment|paymentAction~sale|serverURL~https://api-3t.paypal.com/nvp|useProxy~false|proxyName~|proxyPort~|user~muhammadshayantariq_api1.gmail.com|pwd~GV253VLG4BCKCV4R|signature~AI2r4bL4afmHgInsyYjiPMLWEUrwAT27LELstE6-uM7dEtYlGLLX7b1m|version~58.0',1),
(2795,'paymentDetailTest','testACCT~4600032173990879|DoDirectPayment|paymentAction~sale|serverURL~https://api-3t.sandbox.paypal.com/nvp|useProxy~false|proxyName~|proxyPort~|user~sdk-three_api1.sdk.com|pwd~QFZCWN5HZM8VBG7Q|signature~A.d9eRKfd1yVkRrtmMfCFLTqa6M9AyodL0SJkhYztxUi8W9pCXF6.4NI|version~57.0',1)


-- Authorize.net (paymentDetail,paymentDetailTest)
--insert into MerchantWebsiteTexts(merchant_id,textcode,content_1,Id_langue,availableInMerchantBean)values
--(2795,'paymentDetail','DoDirectPayment|API_Endpoint~https://api.authorize.net/xml/v1/request.api|API_Login_ID~35aRRu8Z|Transaction_Key~65s5mP36HNj8db85|Public_Client_Key~5y3G7Y97ky7D3788RrPNjtyy9B35CVzeJmb9uz66jS34X7XQ4Ak7Y6zLy6nm3XVz',1,1),
--(2795,'paymentDetailTest','testFIRSTNAME~tailbase2020|DoDirectPayment|API_Endpoint~https://apitest.authorize.net/xml/v1/request.api|API_Login_ID~2VJ46hqKz|Transaction_Key~55hk26bpt5JGH8d6|Public_Client_Key~4x84GqDsTq4Fwe4reYQY4V7X74PH8NxsT248NkTC6942psM3uYkjap94yusQJjXn',1,1)

select * FROM MerchantWebsiteTexts WHERE textcode like '%payment%' and merchant_id = 1990

--insert into datatail20130410.dbo.merchantwebsitetexts (merchant_id,textcode,content_1,Id_langue)
select 2795,textcode,content_1,1
from stagingTailbaseCore.dbo.merchantwebsitetexts
where id in (241466,241467)
--===========================================================================================================================================================================================

--4. SETTING STORES AS PICKUP OPTIONS


SELECT id, store,GEOPOSITION, pickupAvailable,pickupDelayMinimumDays,pickupDelayMaximumDays,pickupcomment FROM MerchantStores WHERE MerchantID = 2795
--UPDATE top (1)MerchantStores SET pickupAvailable = 1, pickupDelayMinimumDays = null, pickupDelayMaximumDays = null WHERE MerchantID = 2795
--update top (1) MerchantStores set pickupcomment = '(For certain items, some of the delivery options listed below may not be available. If selected, the extra shipping charges will be automatically refunded)' where id = 5084
update top (1) merchantstores set geoposition = '30.417705, -86.657239' where id = 4813


 --==========================================================================================================================================================
--5. ADDING MERCHANTSHIPPING 
use datatail20130410
SELECT * FROM MerchantShipping WHERE merchant_id = 2795 
--INSERT INTO MerchantShipping(merchant_id,name_1,name_2,type,comment,pickupPrice,delayMinimumDays,delayMaximumDays,apiKey,markupAmount,markupType,pickupoldapp)
VALUES
(2795,'Regular Delivery','Livraison regulière','internal','',NULL,NULL,NULL,NULL,NULL,NULL,0)



update top (1) MerchantShipping set name_1 = 'Drop off only' where id = 539

select * from MERCHANTSHIPPINGPRICESBYSTORELOCRADIO where merchantshippingid = 38
--6. ADDING MERCHANTSHIPPINGPRICESBYSTORELOCRADIO (ONLY FOR 1 MERCHANT 186
--INSERT INTO MerchantShippingPricesByStoreLocRadio(merchantShippingId,merchantStoreId,price,radio)
SELECT	ms.id,st.ID,'0.00','241402'
FROM	MerchantShipping ms
JOIN	MerchantStores st ON st.MerchantID = ms.merchant_id
WHERE	ms.merchant_id = 2795

--=========================================================================================
--  ***NEW****   RULES TO INCLUDE OR EXCLUDE STORE PICKUP  
select * from MerchantStorePickupIncludeRules

select * from  MerchantStorePickupExcludeRules

--=========================================================================================

--insert into MerchantShippingPricesByStoreLocRadio (merchantShippingId,merchantStoreId,price,radio) values
(439,2520,49.95,64373.8)

select top 20* from MerchantShippingPricesByStoreLocRadio where merchantShippingId = 439
--update top (1) MerchantShippingPricesByStoreLocRadio set price = 100.00 where merchantShippingId = 424 and merchantstoreid = 5592

--delete top (1) from MerchantShippingPricesByStoreLocRadio where merchantShippingId = 278

--========================================================================================
--6 b.ADDING MerchantShippingPricesByValueRanges
SELECT top 20* FROM MerchantShippingPricesByValueRanges WHERE merchantShippingId=444

select mz.*, mzc.*, ms.* from merchantzones mz
join merchantZoneCodes mzc on mzc.merchantZoneId = mz.id
join MerchantShippingPricesByValueRanges ms on ms.merchantZoneId = mz.id
and mz.merchant_id = 2795
--and mzc in (560,561,562)


select * from merchantzones where merchant_id = 2795 
--delete top (3)  from merchantzones where id in (407,408,409)
--delete top(3) from merchantzonecodes where merchantzoneid in (407,408,409)
--insert into merchantzones values 
(2795,'Shipping Zone',''),


select * from merchantzones where merchant_id = 2795 

--update top (1) merchantzones set name_1 = 'Zone at 59.99' where id = 572

select  * from merchantzonecodes where merchantzoneid in (58)
select * from MerchantZoneRadiusesFromStores where merchantzoneid in (531)
select * from merchantzonecodes where postalcode is null
select * from merchantstores where merchantid = 2795  

select * from merchantzones where merchant_id = 2795

--INSERT INTO MERCHANTZONECODES (merchantzoneid, countrycode, statecode,postalcode) VALUES
(597,'US','FL',NULL),
(597,'US','GA',NULL),
(597,'US','AL',NULL)

select * from merchantstores where merchantid = 2795
select * from merchantzones where merchant_id = 2795
select * from MerchantZoneRadiusesFromStores where merchantzoneid in (select id from merchantzones where merchant_id = 2795)

delete top (4) from MerchantZoneRadiusesFromStores where merchantzoneid in (select id from merchantzones where merchant_id = 2795)
--INSERT INTO MerchantZoneRadiusesFromStores (merchantzoneid, merchantstoreID, radius) VALUES
(609,4057,100000)

delete





--update top (3) MERCHANTZONECODES set postalcode = '' where merchantzoneid = 332

--delete top  (3) from MERCHANTZONECODES where merchantzoneid = 332


--INSERT INTO MERCHANTZONECODES VALUES
--(170,'CA','ON','M5V%')
select * from merchantzones where merchant_id = 2795  
--select * from merchantzonecodes where merchantzoneid = 597

delete top (3) from merchantzonecodes where merchantzoneid = 597
select * from merchantshipping where merchant_id = 2795
select * from merchantstores where merchantid = 2795  
select * from MerchantShippingPricesByValueRanges where merchantshippingid in (select id from merchantshipping where merchant_id =2795)
delete top (3) from MerchantShippingPricesByValueRanges where merchantshippingid  = 701
insert into MerchantShippingPricesByValueRanges (merchantshippingid,lowPrice,highprice,cost,merchantzoneid) values
(726,'100.00',NULL,'0.00',609),
--insert into MerchantShippingPricesByQuantity (merchantshippingID,merchantzoneID,fromQuantity,toQuantity,basePrice,PerItemPrice) values
(702,597,1,null,0.00,0.00)

delete top (1) MerchantShippingPricesByQuantity where id = 579


insert into merchantshippingincluderules (merchantshippingid,catid,brandid) values
(700,281,3038),
(700,180,3038),
(700,272,3038)

insert into merchantshippingexclusions values
(700,688)


select * from merchantshippingexclusions
--insert into merchantshippingexclusions values
(702,701)

select * from MerchantShippingPricesByQuantity where merchantshippingid in (537,538,539,540)

--insert into MerchantShippingPricesByQuantity (merchantshippingID,merchantzoneID,fromQuantity,toQuantity,basePrice,PerItemPrice) values
(537,426,1,2,59.00,0.00),
(538,426,1,2,144.00,0.00),
(539,426,3,5,80.00,0.00),
(540,426,3,5,175.00,0.00)

--delete top(2) MerchantShippingPricesByValueRanges where id in (321,322)

--update top (2) MerchantShippingPricesByQuantity set toquantity = 10 where id in (321,322)

select * from MerchantShippingPricesByValueRanges where merchantshippingid in (90)
select * from merchantshipping where merchant_id = 2795
select * from merchantzones where merchant_id = 2795
select * from merchantzonecodes where merchantzoneid = 395
select * from merchantstores where merchantid = 2795
--update top(1) MerchantShippingPricesByValueRanges set highPrice = '298.99' where id = 588


select * from MerchantShippingPricesByValueRanges where merchantzoneid in (395,396,397)
--insert into MerchantShippingPricesByValueRanges (merchantshippingid, lowprice, highprice, cost, merchantzoneid)  values
(681,null,null,0.00,531)

--delete top (1) from  MerchantShippingPricesByValueRanges where merchantshippingid = 425


--delete top(2) from MerchantShippingPricesByValueRanges where merchantshippingid = 452


select * from merchantshipping where merchant_id = 2795


select  * from MerchantShippingIncludeRules where merchantshippingid in (687,688,689)

delete top (3) from MerchantShippingIncludeRules  where merchantshippingid  = 689
--insert into MerchantShippingIncludeRules (MerchantShippingId,collectionID) values
(689,22750),
(689,15666),


select collectionid from merchantcollections where merchant_id = 2795 


select * from MerchantShippingExclusions

--delete top (1) from MerchantShippingExclusions where merchantshippingid = 496

--insert into MerchantShippingExclusions values
(522,521)

update top (1) MerchantShippingExclusions set


--========================================================================================
-- 6c .WITH RADIUS 
SELECT * FROM MERCHANTZONERADIUSESFROMSTORES WHERE merchantstoreid IN (6056)
select * from merchantstores where merchantid = 2795
--insert into MERCHANTZONERADIUSESFROMSTORES values
(397,5926,160934),
(397,5927,160934),
(397,5928,160934),
(397,5929,160934),
(397,5930,160934),
(397,5931,160934),
(397,5932,160934) 80467.2

select * from merchantzonecodes where merchantzoneid in (324,325)

select * from merchantzones where merchant_id = 2795


--INSERT INTO MerchantZoneRadiusesFromStores (merchantzoneid, merchantstoreid, radius)
--SELECT		mz.id, ms.id, 40000
--FROM		merchantZones mz 
--JOIN		merchantStores ms ON ms.merchantid = mz.merchant_id 
--WHERE		mz.merchant_id = 2795 
--and			mz.id = 155
--union 
--SELECT		mz.id, ms.id, 72421
--FROM		merchantZones mz 
--JOIN		merchantStores ms ON ms.merchantid = mz.merchant_id 
--WHERE		mz.merchant_id = 1432 
--and			mz.id = 63
--union 
--SELECT		mz.id, ms.id, 143254
--FROM		merchantZones mz 
--JOIN		merchantStores ms ON ms.merchantid = mz.merchant_id 
--WHERE		mz.merchant_id = 1432 
--and			mz.id = 64

--========================================================================================
select * from merchantshipping where merchant_id = 2795
select * from merchantshipping where merchant_id = 2004
select * from merchantstores where merchantid = 2795
--6e .ADDING MerchantShippingPricesByStoreLocRings 
SELECT * FROM MerchantShippingPricesByStoreLocRings where merchantshippingid in (496)

update top (1) MerchantShippingPricesByStoreLocRings 
set pricePerKm = 1.2427
where merchantshippingid = 429 
and merchantstoreid = 5118 
and initialradius = 96562

update top (1) MerchantShippingPricesByStoreLocRings 
set pricebase = 75.00
where merchantshippingid = 378 
and merchantstoreid = 5107 
and initialradius = 50001

--delete top (14) from MerchantShippingPricesByStoreLocRings where merchantshippingid = 496

--update MerchantShippingPricesByStoreLocRings set pricebase = '79.99' where merchantshippingid = 154 and finalradius = '80467'
------------------------------------   Start from here 2017-08-15----------------------------------------------
--insert into MerchantShippingPricesByStoreLocRings (merchantshippingid, merchantstoreid, initialradius, finalradius, pricebase, priceperkm)
SELECT		ship.id, ms.id, '0', '201168', '0.00', 0
FROM		merchantstores ms 
join		merchantshipping ship on ship.merchant_id = ms.merchantid 
where merchantid = 2795
and ms.id = 5866
UNION ALL 
SELECT		ship.id, ms.id, '201167', '402336', '200.00', 0
FROM		merchantstores ms 
join		merchantshipping ship on ship.merchant_id = ms.merchantid 
where merchantid = 2795
and ms.id = 5866
--UNION ALL 
--SELECT		ship.id, ms.id, '16094', '24140', '99.99', 0
--FROM		merchantstores ms 
--join		merchantshipping ship on ship.merchant_id = ms.merchantid 
--where merchantid = 2795
--and ms.id = 5866
--UNION ALL 
--SELECT		ship.id, ms.id, '24141', '32186', '129.99', 0
--FROM		merchantstores ms 
--join		merchantshipping ship on ship.merchant_id = ms.merchantid 
--where merchantid = 2795
--and ms.id = 5866
--UNION ALL 
--SELECT		ship.id, ms.id, '32187', '48280', '149.99', 0
--FROM		merchantstores ms 
--join		merchantshipping ship on ship.merchant_id = ms.merchantid 
--where merchantid = 2795
--and ms.id = 5866

select * from MerchantShippingPricesByStoreLocRings where merchantshippingid in (499)
select * from merchantstores where merchantid = 2795
select * from merchantshipping where merchant_id = 2795
--insert into MerchantShippingPricesByStoreLocRings (merchantshippingid, merchantstoreid, initialradius, finalradius, pricebase, priceperkm)values 
(701,6056,'0', '48281', '99.00', 0),
(701,6056,'48281', '96561', '139.00', 0),
(701,6056,'96562', '160934', '175.00', 0)


select * from MerchantShippingPricesByStoreLocRings where  merchantstoreid = 6058
delete top (3) from MerchantShippingPricesByStoreLocRings where  merchantstoreid = 6058

select top 100 * from MerchantShippingIncludeRules
--insert into MerchantShippingIncludeRules (MerchantShippingId,catID) values
(430,239)

--delete top (1) from MerchantShippingPricesByStoreLocRings where merchantshippingid = 492 and finalradius = 120701

select  top 100 * from MerchantShippingExcludeRules
--insert into MerchantShippingExcludeRules (MerchantShippingId,catID) values
(486,239)

--update top (1) MerchantShippingPricesByStoreLocRings set pricePerKm = 0 where merchantshippingid = 401

--update top (1)MerchantShippingPricesByStoreLocRings set initialRadius = 96562 where merchantshippingid = 429 and finalradius = 241402

select * from MerchantShippingPricesByStoreLocRings where merchantshippingid in (439)

--update top (1) MerchantShippingPricesByStoreLocRings set finalRadius =563270
--where merchantshippingid = 185
--and initialRadius = 48281

select * from MerchantShippingPricesByStoreLocRings where merchantshippingid = 185
select * from merchantstores where merchantid = 2795 


select top 10 * from MerchantShippingPricesByStoreLocRadio


--Trends Furniture	408 S. Douglas Hwy Suite 2	Gillette	WY	82716	USA
--=====================================================================================================================================

--6. ADDING MERCHANTTAXES
SELECT * FROM merchantTaxes WHERE merchant_id = 2795
SELECT * FROM merchantTaxes WHERE merchant_id = 1073
--INSERT INTO merchantTaxes(name_1,name_2,merchant_id,amount,taxableItems) VALUES
('Tax',null,2795,0.07000,null)

--update top (1) merchanttaxes set taxableItems = 'products' where id = 2502
--where merchant_id =2795 and id = 1878


-- GETTING CANADIAN TAXES 
--INSERT INTO merchantTaxes (name_1, name_2, merchant_id, amount)
SELECT		distinct name_1, name_2, 2795, amount
FROM		merchanttaxes mt
join		merchanttaxzones mtz on mtz.merchanttaxid = mt.id 
join		merchantstores ms on ms.merchantid = 2795 
--and			ms.province = mtz.provincecode
WHERE		merchant_id = 155

select * from merchantstorestaxes where merchantstoreid = 4650

--7. ADDING MERCHANTTAXZONES (ONLY FOR MULTIPLE MERCHANTS TAX FROM CANADA)
--INSERT INTO merchanttaxzones (merchanttaxid, countrycode, provincecode, postalcode)
SELECT		distinct dest.id, mtz.countrycode, mtz.provincecode, mtz.postalcode
FROM		merchanttaxes src 
JOIN		merchanttaxes dest on dest.name_1 = src.name_1 
JOIN		merchanttaxzones mtz on mtz.merchanttaxid = src.id 
join		merchantstores ms on ms.merchantid = dest.merchant_id 
--and			ms.province = mtz.provincecode
WHERE		src.merchant_id = 155
and			dest.merchant_id = 2795

--7. ADDING MERCHANTTAXZONES (ONLY FOR 1 MERCHANT TAX)
SELECT * FROM merchantTaxes WHERE merchant_id = 2795
--INSERT INTO MerchantTaxZones(merchantTaxId,countryCode,provinceCode,postalcode) 
SELECT mt.id,'US',null,null
FROM merchantTaxes mt
WHERE mt.merchant_id = 2795

--select * from merchantstores where merchantid = 2795

SELECT * from MerchantTaxZones where merchanttaxid in (2571)

update top (1) MerchantTaxZones set provinceCode = null where id = 24014



select * from MerchantTaxZones where merchanttaxid = 3018
--8. ADDING MERCHANTSTORESTAXES (ONLY FOR 1 MERCHANT TAX)
select * from merchantstorestaxes where merchanttaxid = 2811
select * from merchantstores where merchantId = 2795
select * from merchanttaxes where merchant_id = 2795
select * from merchantstores where merchantid = 2795
select * from MerchantStoresTaxes where merchantStoreId = 6018

update top (1) MerchantStoresTaxes
set merchanttaxid =2811
where merchantStoreId = 5102
--INSERT INTO MerchantStoresTaxes(merchantTaxId,merchantStoreId)
SELECT		DISTINCT mt.ID, ms.id
FROM		merchantstores ms
JOIN		merchanttaxes mt ON mt.merchant_id = ms.merchantid 
JOIN		merchanttaxzones mtz on mtz.merchanttaxid = mt.id 
AND			(mtz.provincecode = ms.province or mtz.provincecode is null)
AND			(mtz.postalcode = ms.postalcode or mtz.postalcode is null)
WHERE		ms.merchantid = 2795 and ms.pickupavailable = 1


-- MERCHANT WARRANTIES

select * from MerchantWarranties where merchantid = 2795
select * from Merchantinstallations where merchantid = 2795


--ACTIVATE THE SHOPPING CART (AFTER IP ADDRESS BEING CHANGED)
--9. ADDING CONFIGURATION IN MWF
use datatail20130410
SELECT * FROM merchantWebsiteFeatures WHERE merchant_id=2795

select * from merchantwebsitefeatures where featurecode = 'shoppingCartType' and featurevalue = 'withbeanstream'
--insert into merchantWebsiteFeatures(merchant_id,featureCode,featureValue) values (2795,'shoppingCartType','withbluepay-2-steps')
--insert into merchantWebsiteFeatures(merchant_id,featureCode,featureValue) values (2795,'shoppingCartType','withbeanstream')
--insert into merchantWebsiteFeatures(merchant_id,featureCode,featureValue) values (2795,'shoppingCartType','withbluepay-2-steps')
--insert into merchantWebsiteFeatures(merchant_id,featureCode,featureValue) values (1477,'shoppingCartType','onlyppe')
--insert into merchantWebsiteFeatures(merchant_id,featureCode,featureValue) values (2795,'shoppingCartType','withpaypal')
--insert into merchantWebsiteFeatures(merchant_id,featureCode,featureValue) values (2795,'shoppingCartType','withbluepay')
--insert into merchantWebsiteFeatures(merchant_id,featureCode,featureValue) values (2795,'shoppingCartType','bluepaywithppe')
--insert into merchantWebsiteFeatures(merchant_id,featureCode,featureValue) values (2795,'shoppingCartType','beanstreamwithppe')
--insert into merchantWebsiteFeatures(merchant_id,featureCode,featureValue) values (2795,'shoppingCartType','withauthorize.net-2-steps')
--insert into merchantWebsiteFeatures(merchant_id,featureCode,featureValue) values (2795,'shoppingCartType','authorize.netwithppe')
--insert into merchantWebsiteFeatures(merchant_id,featureCode,featureValue) values (2795,'shoppingCartType','withauthorize.net')
--insert into merchantWebsiteFeatures(merchant_id,featureCode,featureValue) values (2795,'shoppingCartType','only-submit-as-order')
use datatail20130410
SELECT * FROM merchantWebsiteFeatures  where  featurecode = 'shoppingCartType' and featurevalue like  '%submit%'

delete top (1) from  merchantWebsiteFeatures where merchant_id = 1477 and featurecode = 'shoppingCartType'

update top (1) merchantWebsiteFeatures set featurevalue = 'withauthorize.net' where merchant_id = 2795 and featurecode = 'shoppingCartType'
use datatail20130410
select m.id, m.merchant_code,m.merchant, m.filepath, mf.featurecode, mf.featurevalue
from merchantwebsitefeatures mf
join merchants m on m.id = mf.merchant_id
--where  mf.featureCode like '%authorize%'
where  mf.featureCode = 'shoppingCartType'
and  mf.featurevalue like '%onlyppe%'
and  mf.merchant_id in (select merchant_id  from merchantwebsitefeatures
where featurevalue    in ('nwdynamicv20_a') and featureCode = 'template')
and  mf.merchant_id in (select merchant_id  from merchantwebsitefeatures
where featureCode    in ('hasShippingOptionsOnItems'))



SELECT * FROM merchantwebsitefeatures where merchant_id = 1449 order by creationTimestamp desc

SELECT * FROM merchantwebsitefeatures where featurecode like '%3d%'

























