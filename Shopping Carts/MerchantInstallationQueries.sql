use datatail20130410

DECLARE @MerchantIdinstallations AS INT = 2812;
select * from merchantinstallations
where merchantid = @MerchantIdinstallations

DECLARE @MerchantIdinstallationsPrices AS INT = 2812;
select * from MerchantInstallationPrices
where merchantinstallationID in (select id from merchantinstallations where merchantid = @MerchantIdinstallationsPrices)


DECLARE @MerchantIdinstallationsFilters AS INT = 2812;
select * from MerchantInstallationFilters
where merchantinstallationID in (select id from merchantinstallations where merchantid = @MerchantIdinstallationsFilters)

DECLARE @MerchantIdinstallationsZones AS INT = 2812;
select * from MerchantInstallationZones
where merchantinstallationID in (select id from merchantinstallations
where merchantid = @MerchantIdinstallationsZones)

DECLARE @MerchantIdZones AS INT = 2812;
select * from merchantzones where merchant_id = @MerchantIdZones

DECLARE @MerchantId AS INT = 2812;
update top (13) MerchantInstallationZones set merchantzoneid = 1162
where merchantinstallationID in (select id from merchantinstallations where merchantid = @MerchantId)

DECLARE @MerchantIdZoneCodes AS INT = 2812;
select * from merchantZoneCodes where merchantZoneId in (select id from merchantzones where merchant_id = @MerchantIdZoneCodes)



update top (1) MerchantInstallationZones
set merchantzoneid = 387
where id = 1229

--delete top (2)  from merchantzones where id in (388,389)

delete top (3) from MerchantShippingPricesByQuantity where merchantshippingid =  484

select * from MerchantShippingPricesByQuantity where merchantzoneid in (select id from merchantzones where merchant_id = @MerchantId)

insert into merchantinstallations values
--(2415,'Furniture installation at $120','',0,0)
--(2415,'Furniture installation at $70','',0,0)
(2415,'Furniture installation at $80','',0,0),
(2415,'Furniture installation at $10','',0,0),
(2415,'Furniture installation at $20','',0,0),
(2415,'Furniture installation at $30','',0,0),
(2415,'Furniture installation at $90','',0,0)

update top (7) merchantinstallations set description_1 = 'Misc Furniture Installation'  where merchantid = 2415





update top (1) merchantinstallations set required = 1,selectedbydefault = 1 where id = 229


--update top (1) merchantinstallations set description_1 = 'Basic installation for electric ranges, washers, dryers or fridges (under 21'')'
where id = 212


select * from merchantzones where merchant_id = 2415
--insert into merchantzones values
(2415,'Installation Area','')

select * from merchantZoneCodes where merchantzoneid = 334
--insert into merchantZoneCodes values
(354,'US','FL','%')

select * from merchantinstallations where merchantid = 2415
select * from MerchantInstallationZones where merchantinstallationid = 187
delete top (1) from MerchantInstallationZones where merchantinstallationid = 187
insert into MerchantInstallationZones values
(187,391,null,75.00),
(187,392,null,75.00),

select * from MerchantInstallationFilters where merchantinstallationID in (254,255,256,257,258,259,260) and catid = 316
select * from merchantinstallations where merchantid = 2415
--insert into MerchantInstallationFilters (merchantinstallationID,catID) values
(260,447)

--delete top(1) from  MerchantInstallationFilters where catid = 316 and  merchantinstallationID = 254

--insert into MerchantInstallationFilters (merchantinstallationID,subcatID) values
(259,2525)
--insert into MerchantInstallationFilters (merchantinstallationID,productID) values

select catid from merchantcats where merchant_id = 1097
select id,catid, id_spec, spec from specs where catid = 41 and Id_langue = 1 order by spec
select productid from SpecsProd where specsID_1 = 15818 and SpecValue_1  in ('23" to 28.9"', '29" to 31.9"', '32" to 34.9"', '35" to 37.9"', '38" or more')


select distinct mp.productID from merchantprods mp
inner join specsprod sp on sp.productID = mp.productid
where mp.merchant_id = 2468
and mp.productid in (select productid from SpecsProd where specsID_1 = 15818 and SpecValue_1  in ('23" to 28.9"', '29" to 31.9"', '32" to 34.9"', '35" to 37.9"', '38" or more'))

select * from categories where category like '%table%' and id_langue = 1



select * from subcategories where subcategory like '%coffee%' and id_langue = 1
select * from categories where id_category  =210