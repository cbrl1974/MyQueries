---There are multiple tables related.
use datatail20130410
SELECT * FROM MERCHANTWEBSITEFEATURES WHERE MERCHANT_ID = 2833
SELECT * FROM Distributors -- (need to add 1 record for new shipping program)
SELECT * FROM MerchantsDistributors  -- (Add 1 record that represents the Distributor Program)
SELECT * FROM MerchantDistributorWarehouseLocations -- (Add 1 record, copy from MerchantId = 582)
SELECT * FROM MerchantShipping WHERE Merchant_Id = 1493  -- example with (Fedex)
SELECT * FROM Merchantwebsitetexts WHERE Merchant_Id = 1493 and textcode like '%fedex%' -- example with (Fedex) just in case 
SELECT top 100 * FROM MerchantShipping WHERE dropShippingProgramID = 1
SELECT * FROM MerchantShipping WHERE Merchant_Id = 2833 
select * from MerchantShippingExclusions
select * from merchantzones where merchant_id = 2833 
select * from MerchantZoneRadiusesFromStores where merchantzoneid  in (select id from merchantzones where merchant_id = 2833 )
select * from merchantZoneCodes  where merchantzoneid  in (select id from merchantzones where merchant_id = 2833 )
delete top (1) from MerchantShippingExclusions where merchantshippingid = 702
select * from MerchantShippingPricesByValueRanges where merchantzoneid  in (select id from merchantzones where merchant_id = 2833 )
select * from MerchantShippingPricesByQuantity where merchantzoneid  in (select id from merchantzones where merchant_id = 2833 )
select * from merchantstores where merchantid = 2833
update top (1) MerchantShipping set type = 'internal' where id = 702

insert into merchantshippingExclusions values
(702,701)

DECLARE @shippingRegular AS INT = (select top (1) id from merchantshipping where merchant_id = 2873)

DECLARE @shippingAshley AS INT = (select max(id)  from merchantshipping where merchant_id = 2873)



select @shippingRegular
select @shippingAshley

select * from merchantshipping where merchant_id = 2873






1. [MerchantWebsiteFeatures]
--Add them only when missing, same for other tables
--INSERT INTO merchantWebsiteFeatures (merchant_id,featureCode,featureValue)  VALUES
(2833,'hasShippingOptionsOnItems',null),
(2833,'useDropShipping',null),
(2833,'useShippingDimensions',null)

---****************last Entries*************************
-- update or insert if shippingOptionTypes not yet set
update top ()
(2833,'shippingOptionTypes','merchantShippingByStoreLocationRings,merchantShippingByCartTotalItemsValueRange')

select * from merchantzones where merchant_id = 2833


update top (1) merchantWebsiteFeatures set featurevalue = 'withbluepay-2-steps' where merchant_id = 2833 and featurecode = 'shoppingCartType'


--update top (1) merchantWebsiteFeatures
set featurevalue = 'merchantShippingByStoreLocationRings,merchantShippingByItem3'
where featureCode = 'shippingOptionTypes' and merchant_id = 2833


--2. [MerchantsDistributors]
--INSERT INTO MerchantsDistributors(MerchantID,DistributorID,Id_langue,ItemTag,ItemMessage,Active) VALUES
(2833,1,1,'Express Ship','',1)

---3. 
--ADD SHIPPING OPTIONS Before adding them, check the current information.
--(If Fedex use the the colum "type" and set 'fedex') Normaly is "internal" unless specified
--INSERT INTO MerchantShipping (merchant_id, name_1, name_2, type, comment, pickupPrice, delayMinimumDays, delayMaximumDays, apiKey, markupAmount, markupType, pickupoldapp, dropShippingProgramID)
SELECT 2833, name_1, name_2, type, comment, pickupPrice, delayMinimumDays, delayMaximumDays, apiKey, markupAmount, markupType, pickupoldapp, dropShippingProgramID
FROM MerchantShipping WHERE id = 309

-- 3.a Set zone for Ashley Delivery if different from the normal one
select * from merchantzones where merchant_id = 2833 
--insert into merchantzones values
(2833,'Zone Ashley Express','')

select * from MERCHANTZONECODES where merchantzoneid = 497 
--INSERT INTO MERCHANTZONECODES (merchantzoneid, countrycode, statecode,postalcode) VALUES
(497,'US',NULL,NULL)

--3.b Set the shipping prices based on the shippingoption type choses
select * from merchantshipping where merchant_id = 2833
select * from MerchantShippingPricesByValueRanges where merchantzoneid in (395,396,397)
--insert into MerchantShippingPricesByValueRanges (merchantshippingid, lowprice, highprice, cost, merchantzoneid)  values
(702,null,null,0.00,597)

--4. [merchantshippingprices]

select * from merchantshipping where merchant_id = 2833
select * from merchantzones where merchant_id = 2833
select id_product, model 
from products
 where id_product  in (147480,147485)
--INSERT INTO merchantshippingprices (merchantShippingId,merchantDepartmentId,catId,subCatId,productId,collectionId,price,lowPrice,highPrice,merchantZoneId,BrandId)
SELECT 649,merchantDepartmentId,catId,subCatId,productId,collectionId,price,lowPrice,highPrice,497,BrandId
FROM merchantshippingprices where merchantShippingId = 446

select *
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='merchantshippingprices'

insert into merchantshippingexclusions values
(702,701)


select * from MerchantDistributorWarehouseLocations

SELECT 2873, DistributorID, Name, Address1, Address2, City, StateCode, StateName, ZipCode, CountryCode, CountryName, latitude, longitude
FROM MerchantDistributorWarehouseLocations where merchantID = 2639



--4. [MerchantDistributorWarehouseLocations]
--INSERT INTO MerchantDistributorWarehouseLocations (MerchantID, DistributorID, Name, Address1, Address2, City, StateCode, StateName, ZipCode, CountryCode, CountryName, latitude, longitude)
SELECT 2804, DistributorID, Name, Address1, Address2, City, StateCode, StateName, ZipCode, CountryCode, CountryName, latitude, longitude
FROM MerchantDistributorWarehouseLocations where id = 3

--5. ***Not mandatory**** [MerchantWebsiteTexts] (optional for shipping type != internal)
--INSERT INTO MerchantWebsiteTexts --(merchant_id,textcode,content_1,Id_langue) --
SELECT 1493, textcode,content_1,Id_langue
--FROM MerchantWebsiteTexts WHERE Merchant_id = 582 AND textcode like 'fedexconninfo%'

SELECT * from MerchantWebsiteTexts WHERE Merchant_id = 2664

--Query to extract existing Ashley products that are part of the Ashley Program on a website
select mp.productid from merchantprods mp
inner join DistributorItems di on di.ItemID =mp.productid
where di.DistributorID = 1
and mp.merchant_id = 2873
DECLARE @countAshleyPrds as int = (select mp.productid from merchantprods mp
inner join DistributorItems di on di.ItemID =mp.productid
where di.DistributorID = 1
and mp.merchant_id = 2873)

select @countAshleyPrds


-- Temporary just for TBX cause the tags do not display for each product so we need to use a tag and use the custom file. Check Fremins as example
update top (1699) merchantprods set Elasticsearch_CustomTerm = 'AshleyExpress'
--update top (2073) merchantprods set refurbished = 1
where productid in (select mp.productid from merchantprods mp
inner join DistributorItems di on di.ItemID =mp.productid
where di.DistributorID = 1
and mp.merchant_id = 2833)
and merchant_id = 2833

-- If client asks for a tab with all product of a Program. We set a elastic custom serach and we call it as searchterm based on the custom, term set
select productid, Elasticsearch_CustomTerm from merchantprods where merchant_id = 2833 and Elasticsearch_CustomTerm is not null












