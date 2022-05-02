DECLARE @MerchantID as int = 2985;

BEGIN
SET IDENTITY_INSERT DevTailbaseCore.dbo.merchantshipping ON
insert into
    DevTailbaseCore.dbo.merchantshipping
	(id,merchant_id,name_1,name_2,type,comment,pickupPrice,delayMinimumDays,delayMaximumDays,apiKey,markupAmount,markupType,pickupoldapp,dropShippingProgramID,UnionStrategy)
select
	id,merchant_id,name_1,name_2,type,comment,pickupPrice,delayMinimumDays,delayMaximumDays,apiKey,markupAmount,markupType,pickupoldapp,dropShippingProgramID,UnionStrategy
from
	[DB.PROD].datatail20130410.dbo.merchantshipping
where
    merchant_id = @MerchantID

    SET IDENTITY_INSERT DevTailbaseCore.dbo.merchantshipping OFF




SET IDENTITY_INSERT DevTailbaseCore.dbo.MerchantShippingPrices ON
insert into
    DevTailbaseCore.dbo.MerchantShippingPrices
	(id,merchantShippingId,merchantDepartmentId,catId,subCatId,productId,collectionId,price,lowPrice,highPrice,merchantZoneId,BrandId)
select
	id,merchantShippingId,merchantDepartmentId,catId,subCatId,productId,collectionId,price,lowPrice,highPrice,merchantZoneId,BrandId
from
	[DB.PROD].datatail20130410.dbo.MerchantShippingPrices
where
    merchantshippingid in (select id from merchantshipping where merchant_id = @MerchantID)
SET IDENTITY_INSERT DevTailbaseCore.dbo.MerchantShippingPrices OFF




SET IDENTITY_INSERT DevTailbaseCore.dbo.merchantzones ON
insert into
    DevTailbaseCore.dbo.merchantzones
	(id,merchant_id,name_1,name_2)
select
	id,merchant_id,name_1,name_2
from
	[DB.PROD].datatail20130410.dbo.merchantzones
where
    merchant_id = @MerchantID
SET IDENTITY_INSERT DevTailbaseCore.dbo.merchantzones OFF



SET IDENTITY_INSERT DevTailbaseCore.dbo.merchantzonecodes ON
insert into
    DevTailbaseCore.dbo.merchantzonecodes
	(merchantZoneId,countryCode,stateCode,postalCode)
select
	merchantZoneId,countryCode,stateCode,postalCode
from
	[DB.PROD].datatail20130410.dbo.merchantzonecodes
where
     merchantzoneid in (select id from merchantzones where merchant_id = @MerchantID) 
SET IDENTITY_INSERT DevTailbaseCore.dbo.merchantzonecodes OFF



SET IDENTITY_INSERT DevTailbaseCore.dbo.merchanttaxes ON
insert into
    DevTailbaseCore.dbo.merchanttaxes
	(id,name_1,name_2,merchant_id,amount,taxableItems,RegistrationNumber)
select
	id,name_1,name_2,merchant_id,amount,taxableItems,RegistrationNumber
from
	[DB.PROD].datatail20130410.dbo.merchanttaxes
where
    merchant_id = @MerchantID
SET IDENTITY_INSERT DevTailbaseCore.dbo.merchanttaxes OFF


SET IDENTITY_INSERT DevTailbaseCore.dbo.MerchantStoresTaxes ON
insert into
    DevTailbaseCore.dbo.MerchantStoresTaxes
	(id,merchantTaxId,merchantStoreId)
select
	id,merchantTaxId,merchantStoreId
from
	[DB.PROD].datatail20130410.dbo.MerchantStoresTaxes
where
    merchantTaxId in (select id from merchanttaxes where merchant_id = @MerchantID)
SET IDENTITY_INSERT DevTailbaseCore.dbo.MerchantStoresTaxes OFF




SET IDENTITY_INSERT DevTailbaseCore.dbo.MerchantTaxZones ON
insert into
    DevTailbaseCore.dbo.MerchantTaxZones
	(id,merchantTaxId,countryCode,provinceCode,postalCode)
select
	id,merchantTaxId,countryCode,provinceCode,postalCode
from
	[DB.PROD].datatail20130410.dbo.MerchantTaxZones
where
    merchantTaxId in (select id from merchanttaxes where merchant_id = @MerchantID)
SET IDENTITY_INSERT DevTailbaseCore.dbo.MerchantTaxZones OFF


SET IDENTITY_INSERT DevTailbaseCore.dbo.merchantwarranties ON
insert into
    DevTailbaseCore.dbo.merchantwarranties
	(ID,merchantID,description_1,description_2,imageFilename,documentationFilename,filterType,filterMinimumQuantity,message,IsDefault)
select
	ID,merchantID,description_1,description_2,imageFilename,documentationFilename,filterType,filterMinimumQuantity,message,IsDefault
from
	[DB.PROD].datatail20130410.dbo.merchantwarranties
where
    merchantid = @MerchantID
SET IDENTITY_INSERT DevTailbaseCore.dbo.merchantwarranties OFF



SET IDENTITY_INSERT DevTailbaseCore.dbo.merchantwarrantyprices ON
insert into
    DevTailbaseCore.dbo.merchantwarrantyprices
	(id,MerchantWarrantyID,code,lowPrice,highPrice,cost,startDate,endDate,description_1,description_2,imagefilename,documentationfilename)
select
	id,MerchantWarrantyID,code,lowPrice,highPrice,cost,startDate,endDate,description_1,description_2,imagefilename,documentationfilename
from
	[DB.PROD].datatail20130410.dbo.merchantwarrantyprices
where
    merchantwarrantyid in (select id from merchantwarranties where merchantid = @MerchantID)
SET IDENTITY_INSERT DevTailbaseCore.dbo.merchantwarrantyprices OFF



SET IDENTITY_INSERT DevTailbaseCore.dbo.merchantwarrantyprices ON
insert into
    DevTailbaseCore.dbo.MerchantWarrantyFilters
	(MerchantWarrantyID,catID,brandID,productID,collectionID,code,active,SubCatId)
select
    MerchantWarrantyID,catID,brandID,productID,collectionID,code,active,SubCatId
from
	[DB.PROD].datatail20130410.dbo.MerchantWarrantyFilters
where
    merchantwarrantyId in (select id from merchantwarranties where merchantID = @MerchantID)
SET IDENTITY_INSERT DevTailbaseCore.dbo.merchantwarrantyprices OFF
end;