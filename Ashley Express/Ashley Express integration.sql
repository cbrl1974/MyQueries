
use STAGINGTAILBASECORE
Declare @MerchantID as INT = 2690;
Declare @CurrentShippingID as int = (select  top (1) id from merchantshipping where merchant_id = @MerchantID);
Declare @shippingIDAshleySample as int = (select  top (1) id from merchantshipping where dropShippingProgramID = 1 and type = 'Internal');
Declare @WareHouseIDLocationSample as int = (select  top (1) id from MerchantDistributorWarehouseLocations where stateName = 'Texas');
Declare @totalProdsPartShippingProgram as int = (select count(mp.id) as totalProds from merchantprods mp
inner join DistributorItems di on di.ItemID =mp.productid
where di.DistributorID = 1
and mp.merchant_id = @MerchantID);
Declare @AshleyTagName as varchar(50) = 'AshleyExpress';
Declare @store1 as int = (select top 1 id from merchantstores where merchantid = @MerchantID);
Declare @store2 as int = (select top 1 id from merchantstores where merchantid = @MerchantID order by id desc);

Declare @ZoneID30Miles as int = (select id from merchantzones where name_1 = 'Zone 30 miles' and merchant_id = @MerchantID);
Declare @ZoneID60Miles as int = (select id from merchantzones where name_1 = 'Zone 60 miles' and merchant_id = @MerchantID);
Declare @Zone100Miles as int = (select id from merchantzones where name_1 = 'Zone 100 miles' and merchant_id = @MerchantID);



--1. [MerchantWebsiteFeatures]
--Add them only when missing, same for other tables
INSERT INTO merchantWebsiteFeatures (merchant_id,featureCode,featureValue)  VALUES
(@MerchantID,'hasShippingOptionsOnItems',null),
(@MerchantID,'useDropShipping',null),
(@MerchantID,'useShippingDimensions',null)



--2. [MerchantsDistributors]
INSERT INTO MerchantsDistributors(MerchantID,DistributorID,Id_langue,ItemTag,ItemMessage,Active) VALUES
(@MerchantID,1,1,'Express Ship','',1)



--3. [MerchantDistributorWarehouseLocations]
INSERT INTO MerchantDistributorWarehouseLocations (MerchantID, DistributorID, Name, Address1, Address2, City, StateCode, StateName, ZipCode, CountryCode, CountryName, latitude, longitude)
SELECT @MerchantID, DistributorID, Name, Address1, Address2, City, StateCode, StateName, ZipCode, CountryCode, CountryName, latitude, longitude
FROM MerchantDistributorWarehouseLocations where id = @WareHouseIDLocationSample



--4.  ADD SHIPPING OPTIONS Before adding them, check the current information.
DECLARE @AshleyShippingID AS INT;
INSERT INTO MerchantShipping (merchant_id, name_1, name_2, type, comment, pickupPrice, delayMinimumDays, delayMaximumDays, apiKey, markupAmount, markupType, pickupoldapp, dropShippingProgramID)
SELECT @MerchantID, name_1, name_2, type, comment, pickupPrice, delayMinimumDays, delayMaximumDays, apiKey, markupAmount, markupType, pickupoldapp, dropShippingProgramID
FROM MerchantShipping WHERE id = @shippingIDAshleySample
SET @AshleyShippingID = @@IDENTITY


--Create Zone for Ashley Express
DECLARE @ZoneAshleyExpress AS INT;
INSERT INTO MERCHANTZONES VALUES
(@MerchantID, 'Zone Ashley Express', null)
SET @ZoneAshleyExpress = @@IDENTITY

INSERT INTO MerchantZoneRadiusesFromStores (merchantzoneid, MerchantStoreId, Radius) VALUES
(@ZoneAshleyExpress, @store1, 804500),
(@ZoneAshleyExpress, @store2, 804500)

insert into MerchantShippingPricesByValueRanges (merchantShippingId, cost, merchantzoneid) VALUES
(@AshleyShippingID,0.00,  @ZoneID30Miles),
(@AshleyShippingID,0.00, @ZoneID60Miles),
(@AshleyShippingID,0.00, @Zone100Miles),
(@AshleyShippingID,0.00, @ZoneAshleyExpress)


insert into merchantshippingexclusions values
(@AshleyShippingID,@CurrentShippingID)


-- Temporary just for TBX cause the tags do not display for each product so we need to use a tag and use the custom file.
update top (@totalProdsPartShippingProgram) merchantprods
set Elasticsearch_CustomTerm = @AshleyTagName 
where productid in (select mp.productid from merchantprods mp
inner join DistributorItems di on di.ItemID =mp.productid
where di.DistributorID = 1
and mp.merchant_id = @MerchantID)
and merchant_id = @MerchantID


-- If client asks for a tab with all product of a Program. We set a elastic custom serach and we call it as searchterm based on the custom, term set
select productid, Elasticsearch_CustomTerm from merchantprods where merchant_id = @MerchantID and Elasticsearch_CustomTerm is not null