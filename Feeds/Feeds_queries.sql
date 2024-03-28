
select id, merchant, merchantpwd from merchants where id in (select MerchantId from feeds.merchantFeeds where feedid = 9)
select id, merchant, merchantpwd from merchants where id = 1448
select * from feeds.feeds where id = 9

update top (1) feeds.feeds
set Options = '{"WarehouseId":null,"CustomerId":0,"Username":null,"Password":null,"ShipTo":null,"FeedId":9,"ManufacturerIds":[3181,3182,3184,4226,4227,6183],"FeedInformations":{"InventoryAvailable":false,"PricingAvailable":true,"ProductCreationAvailable":false,"CollectionPricingAvailable":true,"SpecificationsUpdateAvailable":false,"RelatedProductsUpdateAvailable":false,"MediaUpdateAvailable":false,"CompositeDelimiter":null,"PricingPerMerchant":true,"UseManufIdentifierForActiveness":true,"UseLocationsForPricing":false,"AssociateFeedProductImage":false,"MaxImageSize":4000,"HasProductAvailabilityByMerchant":true,"UseGroupStatusProcessor":false,"HasCollectionActiveness":true},"DownloaderSettings":{},"ConverterSettings":null,"StatusProcessorSettings":{"ShowMissingProducts":true},"PricingModifierSettings":null,"BrandCategories":[{"BrandName":"Signature Design by Ashley","BrandId":3181,"SelectedDepartments":[23,25,29,28,26,27,30,58],"Categories":[58,88,134,175,178,180,181,182,183,184,186,187,188,189,190,191,192,193,194,196,197,208,210,209,258,257,260,277,282,294,298,308,310,315,311,312,313,314,316,318,319,372,389,179,407,419,431,448,447,457,473,487,519,527,533,248,539,587,261,590,591,267,600,87,607,649,657]},{"BrandName":"Millennium","BrandId":3182,"SelectedDepartments":[29,25,28,26,27,23,30],"Categories":[134,175,178,180,181,182,183,184,185,186,187,188,190,208,210,209,58,310,315,311,312,313,314,316,318,179,419,282,431,457,473,587,267,657]},{"BrandName":"Benchcraft","BrandId":3184,"SelectedDepartments":[25,28,26,27],"Categories":[175,178,181,182,183,184,186,188,210,310,315,311,312,313,314,316,179,473,519,587,591]},{"BrandName":"Sierra Sleep","BrandId":4226,"SelectedDepartments":[26],"Categories":[262,272,331,372]},{"BrandName":"Ashley Sleep","BrandId":4227,"SelectedDepartments":[26],"Categories":[262,272,331,372]}],"IsActive":true,"DryRunActiveness":true,"PricingActive":false,"UseCostByCarton":false,"AddFreight":false,"ApplyDfiDiscount":false,"ApplyVolumeDiscount":false,"CollectionPricingActive":false,"DeleteMerchantProds":false,"AllBrandCatsActive":false,"AllowFeaturedItemsUpdate":false,"KeepMerchantProdWhenOutOfStock":false,"FeedName":"Ashley","InventoryActive":false,"LocationName":null,"LocationNames":null,"AvailableLocations":[],"InventoryQtyOptions":{"IsActive":false,"MinimumQtyAvailable":0,"IncludeNextShipmentQty":false,"NextShipmentMaxDays":0},"AvailableCostTypes":[1],"AvailablePricingTiers":[],"PricingTierId":null,"TierIdentifier":null,"TestingMerchantIdMappings":null}'
where id = 9



select * from feeds.MerchantFeeds where  feedid = 9 and merchantid = 1448

update top (1) feeds.MerchantFeeds
set FeedOptionsJson = '{"WarehouseId":null,"CustomerId":3040600,"Username":"Ad_3040600","Password":"Furniture1","ShipTo":"03","FeedId":9,"ManufacturerIds":[3181,3182,3184,4226,4227,6183],"FeedInformations":null,"DownloaderSettings":{},"ConverterSettings":null,"StatusProcessorSettings":{"ShowMissingProducts":true},"PricingModifierSettings":{"PricingType":0,"DefaultPricingSettings":{"Id":0,"Name":"","RegularPriceFormulaValue":3.0,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":2.0,"ReducedPriceDefaultCents":null},"DepartmentsPricingSettings":[{"DepartmentId":23,"Name":"Audio Video Furniture","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":58,"Name":"TV Stands","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":248,"Name":"TV Stand Accessories","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":318,"Name":"Entertainment Centers","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":419,"Name":"Entertainment Center Components","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},{"DepartmentId":26,"Name":"Bedroom","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":180,"Name":"Bedding","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":181,"Name":"Bed Components","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":182,"Name":"Chests","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":183,"Name":"Dressers","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":184,"Name":"Dresser Mirrors","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":185,"Name":"Armoires","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":186,"Name":"Nightstands","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":187,"Name":"Benches","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":262,"Name":"Mattresses","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":272,"Name":"Pillows","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":277,"Name":"Vanity Tables and Sets","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":281,"Name":"Mattress Protectors","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":308,"Name":"Bed Frames","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":331,"Name":"Adjustable Bases","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":372,"Name":"Foundations","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":587,"Name":"Beds","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":607,"Name":"Daybeds","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},{"DepartmentId":28,"Name":"Dining Room","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":178,"Name":"Dining Tables","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":179,"Name":"Dining Seating","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":209,"Name":"China Cabinets","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":210,"Name":"Buffets","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":431,"Name":"Kitchen Islands and Carts","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":519,"Name":"Dinettes","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},{"DepartmentId":30,"Name":"Home Accent","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":260,"Name":"Coat Racks","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":261,"Name":"Bar Cabinets","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":282,"Name":"Mirrors","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":294,"Name":"Lamps","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":298,"Name":"Home Decor","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":457,"Name":"Rugs","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":527,"Name":"Decorative Pillows","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":533,"Name":"Sculptures","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":590,"Name":"Bars","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},{"DepartmentId":29,"Name":"Home Office","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":134,"Name":"Office Desks","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":257,"Name":"Bookcases","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":267,"Name":"Office Chairs","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":487,"Name":"Filing Cabinets","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":657,"Name":"Office Desk Components","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},{"DepartmentId":27,"Name":"Kids Bedroom","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":188,"Name":"Kids Bed Components","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":189,"Name":"Kids Dressers","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":190,"Name":"Kids Dresser Mirrors","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":191,"Name":"Kids Nightstands","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":192,"Name":"Kids Desks","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":193,"Name":"Kids Chests","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":194,"Name":"Kids Armoires","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":196,"Name":"Kids Bookshelves","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":197,"Name":"Kids Bedroom Accents","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":407,"Name":"Kids Seating","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":591,"Name":"Kids Beds","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},{"DepartmentId":25,"Name":"Living Room","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":87,"Name":"Fireplaces","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":88,"Name":"Home Theater Seating","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":175,"Name":"Sleepers","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":208,"Name":"Occasional Tables","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":258,"Name":"Accent Cabinets","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":310,"Name":"Sectionals","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":311,"Name":"Sofas","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":312,"Name":"Loveseats","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":313,"Name":"Chairs","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":314,"Name":"Recliners","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":315,"Name":"Ottomans","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":316,"Name":"Accent Chairs","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":319,"Name":"Curios","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":389,"Name":"Lift Chairs","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":473,"Name":"Sectional Components","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":649,"Name":"Futons","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},{"DepartmentId":58,"Name":"Outdoor Furniture","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":447,"Name":"Outdoor Seating","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":448,"Name":"Outdoor Tables","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":539,"Name":"Outdoor Dining Sets","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":600,"Name":"Outdoor Accessories","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]}],"GlobalRoundingActive":false,"GlobalRoundingType":0,"GlobalRoundingLastDigit":0,"GlobalModifierActive":false,"GlobalModifier":null,"RegularCostTypeId":1,"ReducedCostTypeId":1,"CollectionPricingType":0,"CollectionDefaultPricingSettings":null,"CollectionDepartmentsPricingSettings":null},"BrandCategories":[{"BrandName":null,"BrandId":3181,"SelectedDepartments":[25,29,28,26,27,58],"Categories":[58,318,419,248,88,175,208,258,310,315,311,312,313,314,316,319,389,473,87,649,134,257,487,267,657,178,210,209,179,431,519,180,181,182,183,184,186,187,277,308,372,587,607,188,189,190,191,192,193,194,196,197,407,591,260,282,294,298,457,527,533,261,590,448,447,539,600]},{"BrandName":null,"BrandId":3182,"SelectedDepartments":[29,25,28,26,27],"Categories":[134,267,657,175,208,310,315,311,312,313,314,316,473,178,210,209,179,431,180,181,182,183,184,185,186,187,587,188,190,58,318,419,282,457]},{"BrandName":null,"BrandId":3184,"SelectedDepartments":[25,28,26,27],"Categories":[175,310,315,311,312,313,314,316,473,178,210,179,519,181,182,183,184,186,587,188,591]},{"BrandName":null,"BrandId":4226,"SelectedDepartments":[26],"Categories":[262,272,331,372]},{"BrandName":null,"BrandId":4227,"SelectedDepartments":[26],"Categories":[262,272,281,331,372]}],"IsActive":true,"DryRunActiveness":true,"PricingActive":true,"UseCostByCarton":false,"AddFreight":false,"ApplyDfiDiscount":false,"ApplyVolumeDiscount":false,"CollectionPricingActive":true,"DeleteMerchantProds":false,"AllBrandCatsActive":false,"AllowFeaturedItemsUpdate":true,"KeepMerchantProdWhenOutOfStock":false,"FeedName":"Ashley","InventoryActive":false,"LocationName":null,"LocationNames":null,"AvailableLocations":[],"InventoryQtyOptions":{"IsActive":false,"MinimumQtyAvailable":0,"IncludeNextShipmentQty":false,"NextShipmentMaxDays":0},"AvailableCostTypes":[1],"AvailablePricingTiers":[],"PricingTierId":null,"TierIdentifier":null,"TestingMerchantIdMappings":null}'
where  feedid = 9 and merchantid = 1448


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



SELECT mp.merchant_id, mp.productid, p.manufacturerIdentifier, mp.cost, mp.price, mp.reducedPrice, mp.QtyPerPackage, fb.Price, fb.AdditionalPricingData
FROM MerchantProds mp WITH (NOLOCK)  
INNER JOIN products p on p.Id_product = mp.ProductID
left join feeds.ProductBasePrices fb on fb.MerchantId = mp.Merchant_ID and fb.ProductId = mp.productid
WHERE 	mp.Merchant_ID in (1448,2312)
and p.manufID in (6183, 3181, 3182, 3184, 4226, 4227)
--and mp.cost is null
and  mp.productid = 788603--235293
--and QtyPerPackage != ''
-- and QtyPerPackage > 1

--  update MerchantProds
--  set QtyPerPackage = null
--  where merchant_id = 1448

--**************************Comparing data with 2 merchants using old and new versions Ashley
SELECT 
    mp1.merchant_id AS merchant_id_1448,
    mp1.productid AS productid_1448,
    p1.manufacturerIdentifier AS manufacturerIdentifier_1448,
    mp1.cost AS cost_1448,
    mp1.price AS price_1448,
    mp1.reducedPrice AS reducedPrice_1448,
    mp1.QtyPerPackage AS QtyPerPackage_1448,
    mp2.merchant_id AS merchant_id_2312,
    mp2.productid AS productid_2312,
    p2.manufacturerIdentifier AS manufacturerIdentifier_2312,
    mp2.cost AS cost_2312,
    mp2.price AS price_2312,
    mp2.reducedPrice AS reducedPrice_2312,
    mp2.QtyPerPackage AS QtyPerPackage_2312
FROM 
    MerchantProds mp1
LEFT JOIN 
    MerchantProds mp2 ON mp1.productid = mp2.productid AND mp2.Merchant_ID = 2312
INNER JOIN 
    products p1 ON p1.Id_product = mp1.ProductID AND p1.manufid IN ('6183', '3181', '3182', '3184', '4226', '4227')
LEFT JOIN 
    products p2 ON p2.Id_product = mp2.ProductID AND p2.manufid IN ('6183', '3181', '3182', '3184', '4226', '4227')
WHERE 
    mp1.Merchant_ID = 1448



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

