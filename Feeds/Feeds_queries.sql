
select id, merchant, merchantpwd from merchants where id in (select MerchantId from feeds.merchantFeeds where feedid = 9)
select id, merchant, merchantpwd from merchants where id = 1448
select * from feeds.feeds where id = 9

update top (1) feeds.feeds
set Options = '{"WarehouseId":null,"CustomerId":0,"Username":null,"Password":null,"ShipTo":null,"FeedId":9,"ManufacturerIds":[3181,3182,3184,4226,4227,6183],"FeedInformations":{"InventoryAvailable":false,"PricingAvailable":true,"ProductCreationAvailable":false,"CollectionPricingAvailable":true,"SpecificationsUpdateAvailable":false,"RelatedProductsUpdateAvailable":false,"MediaUpdateAvailable":false,"CompositeDelimiter":null,"PricingPerMerchant":true,"UseManufIdentifierForActiveness":true,"UseLocationsForPricing":false,"AssociateFeedProductImage":false,"MaxImageSize":4000,"HasProductAvailabilityByMerchant":false,"UseGroupStatusProcessor":false,"HasCollectionActiveness":true},"DownloaderSettings":{},"ConverterSettings":null,"StatusProcessorSettings":{"ShowMissingProducts":true},"PricingModifierSettings":null,"BrandCategories":[{"BrandName":"Signature Design by Ashley","BrandId":3181,"SelectedDepartments":[23,25,29,28,26,27,30,58],"Categories":[58,88,134,175,178,180,181,182,183,184,186,187,188,189,190,191,192,193,194,196,197,208,210,209,258,257,260,277,282,294,298,308,310,315,311,312,313,314,316,318,319,372,389,179,407,419,431,448,447,457,473,487,519,527,533,248,539,587,261,590,591,267,600,87,607,649,657]},{"BrandName":"Millennium","BrandId":3182,"SelectedDepartments":[29,25,28,26,27,23,30],"Categories":[134,175,178,180,181,182,183,184,185,186,187,188,190,208,210,209,58,310,315,311,312,313,314,316,318,179,419,282,431,457,473,587,267,657]},{"BrandName":"Benchcraft","BrandId":3184,"SelectedDepartments":[25,28,26,27],"Categories":[175,178,181,182,183,184,186,188,210,310,315,311,312,313,314,316,179,473,519,587,591]},{"BrandName":"Sierra Sleep","BrandId":4226,"SelectedDepartments":[26],"Categories":[262,272,331,372]},{"BrandName":"Ashley Sleep","BrandId":4227,"SelectedDepartments":[26],"Categories":[262,272,331,372]}],"IsActive":true,"DryRunActiveness":true,"PricingActive":false,"UseCostByCarton":false,"AddFreight":false,"ApplyDfiDiscount":false,"ApplyVolumeDiscount":false,"CollectionPricingActive":false,"DeleteMerchantProds":false,"AllBrandCatsActive":false,"AllowFeaturedItemsUpdate":false,"KeepMerchantProdWhenOutOfStock":false,"FeedName":"Ashley","InventoryActive":false,"LocationName":null,"LocationNames":null,"AvailableLocations":[],"InventoryQtyOptions":{"IsActive":false,"MinimumQtyAvailable":0,"IncludeNextShipmentQty":false,"NextShipmentMaxDays":0},"AvailableCostTypes":[1],"AvailablePricingTiers":[],"PricingTierId":null,"TierIdentifier":null,"TestingMerchantIdMappings":null}'
where id = 9



select * from feeds.MerchantFeeds where  feedid = 9 and merchantid = 1448
select * from MerchantFeeds where merchant_id = 1448 and brand = 'Ashley'
select * from MerchantFeeds where merchant_id = 2312 and brand = 'Ashley'


delete top (1) from MerchantFeeds where merchant_id = 2312 and brand = 'Ashley'


select top 10  * from feeds.FeedDumps  WITH (NOLOCK)
where  RunDate > convert(date,getdate()-1) 
--and MerchantId = 2798
order by RunDate desc, merchantid


-- --Delete records from today
  DELETE top (4) FROM FEEDS.FEEDDUMPS 
  WHERE  RUNDATE > CONVERT(DATE,GETDATE()-1) 
  AND FEEDID = 9
  and merchantid = 1448

   
select * from feeds.ProductBasePrices   WITH (NOLOCK) where feedid = 9 and merchantid = 1448 and productid = 291167
--delete from feeds.ProductBasePrices where feedid = 9 and merchantid = 1448

SELECT 
top 100
 [LogID]
      ,[Project]
      ,[Category]
      ,[Text]
      ,[Time]
      ,[Severity]
      ,[Module]
      ,[Location]
  FROM [EventReactor].[dbo].[Logs] WITH (NOLOCK)
  where category = 'Feeds'
  and text like '%Ashley%'
  and time >= getdate()
  --and logid >= 50766812
  order by [time] desc

  select id_product, model, manufmodel, ManufacturerIdentifier from products where manufmodel like '%3840152%'



SELECT mp.productid, p.manufacturerIdentifier, mp.cost, mp.price, mp.reducedPrice, mp.QtyPerPackage 
FROM MerchantProds mp WITH (NOLOCK)  
INNER JOIN products p on p.Id_product = mp.ProductID
WHERE 	mp.Merchant_ID in (2312,1448)
and p.manufID in (6183, 3181, 3182, 3184, 4226, 4227)
and  mp.productid = 291167--235293
--and QtyPerPackage != ''
-- and QtyPerPackage > 1

--  update MerchantProds
--  set QtyPerPackage = null
--  where merchant_id = 1448



--************Get Products*************
DECLARE @MerchantId AS int = 2312;
DECLARE @ProductCount AS  int = (
SELECT count(1) FROM MerchantProds  mp
INNER JOIN products p on p.Id_product = mp.ProductID
WHERE 	mp.Merchant_ID = @MerchantId
and p.manufID in (6183, 3181, 3182, 3184, 4226, 4227, 6183));


select @ProductCount


-- **********Delete Products**********
 delete top (@ProductCount) FROM MerchantProds
 where merchant_id = @MerchantId 
 and productid in (
    SELECT mp.ProductID FROM MerchantProds  mp
        INNER JOIN products p on p.Id_product = mp.ProductID
    WHERE 	mp.Merchant_ID = @MerchantId 
    and p.manufID in (1436,3181,3182,3184,4226,4227,6183)
 )



-- ************Delete Collections************
DECLARE @MerchantIdForCollections AS int = 2312;
DECLARE @CollectionCountCount AS  int = (
SELECT count(distinct mc.collectionID) as total FROM MerchantCollections  mc
inner join collections c on c.id = mc.collectionid
inner join collection_product cp on cp.collectionID = c.id
INNER JOIN products p on p.Id_product = cp.ProductID
WHERE 	mc.Merchant_ID = @MerchantIdForCollections
and p.manufID in (1436,3181,3182,3184,4226,4227, 6183))


select @CollectionCountCount

 DELETE TOP (@COLLECTIONCOUNTCOUNT) FROM MERCHANTCOLLECTIONS
 WHERE MERCHANT_ID =  @MERCHANTIDFORCOLLECTIONS
 AND COLLECTIONID IN (
    SELECT distinct MC.COLLECTIONID FROM MERCHANTCOLLECTIONS  MC
    INNER JOIN COLLECTIONS C ON C.ID = MC.COLLECTIONID
    INNER JOIN COLLECTION_PRODUCT CP ON CP.COLLECTIONID = C.ID
    INNER JOIN PRODUCTS P ON P.ID_PRODUCT = CP.PRODUCTID
    WHERE 	MC.MERCHANT_ID =  @MERCHANTIDFORCOLLECTIONS
    AND P.MANUFID IN (1436,3181,3182,3184,4226,4227, 6183)
 )




-- ************Brands management************
DECLARE @MerchantIdForBrands AS int = 2312;
DECLARE @BrandsCount AS  int = (
select count(cieId) as total  from  merchantBrands
where merchant_id = @MerchantIdForBrands 
and cieId in  (3181,3182,3184,4226,4227,6183))

select @BrandsCount

 delete top ( @BrandsCount) from  merchantBrands
 where merchant_id = @MerchantIdForBrands
 and  cieId in  (3181,3182,3184,4226,4227, 6183)

 select @BrandsCount

 

----Current Query to get Combined Products
--select p.id_product,p.model,p.manufid,p.manufmodel,mp.lock,mp.featured,mp.reducedPrice,mp.price,mp.cost,c.category,d.dept 
--from products p
--inner join merchantProds mp on mp.productid = p.id_product and mp.merchant_id = 1448
--inner join categories c on c.id_category = p.catid and c.id_langue = 1
--inner join departments d on d.id_dept = c.deptID and d.id_langue = 1		    
--where p.manufid in (1436,3181,3182,3184,4226,4227)
--and p.manufmodel like '%/%'

