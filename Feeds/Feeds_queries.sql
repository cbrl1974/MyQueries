
select id, merchant, merchantpwd from merchants where id in (select MerchantId from devTailbaseCore.feeds.merchantFeeds where feedid = 9)
select * from devTailbaseCore.feeds.feeds where id =9

select distinct feedid from devTailbaseCore.feeds.merchantFeeds --where  feedid = 1 
where FeedOptionsJson like '%"InventoryQtyOptions":{"IsActive"%'
and merchantid =1097  order by merchantid desc
select * from devTailbaseCore.feeds.merchantFeeds where  feedid = 9
select  top 100 * from devTailbaseCore.feeds.ProductBasePrices where FeedId = 9  and productid = 465275 order by ProductBasePriceId desc
select * from merchantfeeds where merchant_id = 3336
select * from products where manufmodel = 'A8010118'
select manufmodel from devTailbaseCore.dbo.products where Id_product = 552829 

 SELECT mp.productid, p.manufmodel, mp.cost, mp.price, mp.reducedPrice FROM devTailbaseCore.dbo.MerchantProds  mp
INNER JOIN devTailbaseCore.dbo.products p on p.Id_product = mp.ProductID
WHERE 	mp.Merchant_ID = 3336
and p.manufID in (6183, 3181, 3182, 3184, 4226, 4227)
and mp.cost is not null


select * from devTailbaseCore.feeds.FeedDumps
where  RunDate > convert(date,getdate()-1) 
--and MerchantId = 3336
order by merchantid


----Delete records from today
--Delete from devTailbaseCore.feeds.FeedDumps 
--where  RunDate > convert(date,getdate()-1) 
--and FeedId = 9




select * from devTailbaseCore.feeds.ProductBasePrices 
where FeedId = 9
--and productid in (select id_product from products where manufmodel = 'A8000198')
order by ProductBasePriceId desc




--****************** Today 16494
delete  from devTailbaseCore.feeds.ProductBasePrices where FeedId = 9  
and productid = 465275 order by ProductBasePriceId desc

select * from devTailbaseCore.feeds.ProductBasePrices where FeedId = 1   and merchantid is null

select * from products where manufmodel = 'A8010054'

select top 10 * from devTailbaseCore.feeds.JobRun order by time desc
select top 10 * from devTailbaseCore.feeds.JobRunReports  order by id desc
select top 100 * from AsyncTasks


select top 10 * from devTailbaseCore.feeds.JobRun order by time desc


select  *  from feeds.pricetypes


--delete top (7041) devTailbaseCore.dbo.MerchantProds 
--where productid in 
--(
--	 SELECT mp.productid FROM devTailbaseCore.dbo.MerchantProds  mp
--	INNER JOIN devTailbaseCore.dbo.products p on p.Id_product = mp.ProductID
--	WHERE 	mp.Merchant_ID = 3336
--	and p.manufID in (6183, 3181, 3182, 3184, 4226, 4227)
--)
--and merchant_id = 3336



--************Get Products*************
DECLARE @MerchantId AS int = 3336;
DECLARE @ProductCount AS  int = (
SELECT mp.productid, mp.price, mp.reducedPrice FROM MerchantProds  mp
INNER JOIN products p on p.Id_product = mp.ProductID
WHERE 	mp.Merchant_ID = @MerchantId
and p.manufID in (6183, 3181, 3182, 3184, 4226, 4227));


select @ProductCount


-- **********Delete Products**********
-- delete top (@ProductCount) FROM MerchantProds
-- where merchant_id = @MerchantId 
-- and productid in (
--     SELECT mp.ProductID FROM MerchantProds  mp
--         INNER JOIN products p on p.Id_product = mp.ProductID
--     WHERE 	mp.Merchant_ID = @MerchantId 
--     and p.manufID in (1436,3181,3182,3184,4226,4227)
-- )

-- **********Collections management**********
DECLARE @MerchantIdForCollections AS int = 3336;
DECLARE @CollectionCountCount AS  int = (
SELECT count(mc.collectionID) as total FROM MerchantCollections  mc
inner join collections c on c.id = mc.collectionid
inner join collection_product cp on cp.collectionID = c.id
INNER JOIN products p on p.Id_product = cp.ProductID
WHERE 	mc.Merchant_ID = @MerchantIdForCollections
and p.manufID in (1436,3181,3182,3184,4226,4227))


select @CollectionCountCount

-- ************Delete Collections************
-- delete top (@CollectionCountCount) FROM MerchantCollections
-- where merchant_id =  @MerchantIdForCollections
-- and collectionID in (
--     SELECT mc.CollectionId FROM MerchantCollections  mc
--     inner join collections c on c.id = mc.collectionid
--     inner join collection_product cp on cp.collectionID = c.id
--     INNER JOIN products p on p.Id_product = cp.ProductID
--     WHERE 	mc.Merchant_ID =  @MerchantIdForCollections
--     and p.manufID in (1436,3181,3182,3184,4226,4227)
-- )


-- ************Brands management************
DECLARE @MerchantIdForBrands AS int = 3336;
DECLARE @BrandsCount AS  int = (
select count(cieId) as total  from  merchantBrands
where merchant_id = @MerchantIdForBrands 
and cieId in  (1436,3181,3182,3184,4226,4227))


select @BrandsCount

--************Delete Brands************
-- delete top (@BrandsCount) from merchantBrands 
-- where merchant_id = @MerchantIdForBrands  
-- and cieId in  (1436,3181,3182,3184,4226,4227)


-- Update Template
 update top (1) devTailbaseCore.feeds.feeds 
 set options = '{"AddFreight":false,"ApplyDfiDiscount":false,"ApplyVolumeDiscount":false,"WarehouseId":null,"FeedId":9,"ManufacturerIds":[6183,3181,3182,3184,4226,4227],"FeedInformations":{"InventoryAvailable":false,"PricingAvailable":true,"ProductCreationAvailable":false,"CollectionPricingAvailable":true,"SpecificationsUpdateAvailable":false,"RelatedProductsUpdateAvailable":false,"MediaUpdateAvailable":false,"CompositeDelimiter":null,"PricingPerMerchant":true,"UseManufIdentifierForActiveness":false,"UseLocationsForPricing":true,"AssociateFeedProductImage":false,"MaxImageSize":4000,"HasProductAvailabilityByMerchant":false,"UseGroupStatusProcessor":false,"HasCollectionActiveness":false},"DownloaderSettings":{"CustomerId":0},"ConverterSettings":null,"StatusProcessorSettings":{"ShowMissingProducts":true},"PricingModifierSettings":null,"BrandCategories":[{"BrandName":null,"BrandId":6183,"SelectedDepartments":[],"Categories":[]},{"BrandName":null,"BrandId":3181,"SelectedDepartments":[23,29,26,27,58,30,25,28],"Categories":[192,209,407,315,175,487,181,607,587,189,473,258,527,318,178,533,590,447,298,190,184,267,313,319,58,87,193,591,187,310,210,316,519,419,196,539,282,188,311,457,179,448,248,191,308,431,657,314,182,649,88]},{"BrandName":null,"BrandId":3182,"SelectedDepartments":[23,29,26,27,30,25,28],"Categories":[209,315,175,181,587,473,318,178,590,190,184,267,313,58,187,310,210,316,419,282,311,188,457,179,185,431,657,314,182,208,186,134,183,312,180]},{"BrandName":null,"BrandId":3184,"SelectedDepartments":[26,27,25,28],"Categories":[315,175,181,587,473,178,184,313,591,310,210,316,519,188,311,179,314,182,186,183,312]},{"BrandName":null,"BrandId":4226,"SelectedDepartments":[26],"Categories":[262]},{"BrandName":null,"BrandId":4227,"SelectedDepartments":[26],"Categories":[262,272,331,372]}],"IsActive":true,"DryRunActiveness":true,"PricingActive":false,"CollectionPricingActive":false,"DeleteMerchantProds":false,"AllBrandCatsActive":false,"AllowFeaturedItemsUpdate":false,"KeepMerchantProdWhenOutOfStock":false,"FeedName":"Ashley","InventoryActive":false,"LocationName":null,"LocationNames":null,"AvailableLocations":[],"InventoryQtyOptions":{"IsActive":false,"MinimumQtyAvailable":0,"IncludeNextShipmentQty":false,"NextShipmentMaxDays":0},"AvailableCostTypes":[1],"AvailablePricingTiers":[],"PricingTierId":null,"TierIdentifier":null,"TestingMerchantIdMappings":null}'
 where id = 9


-- update top (1) devTailbaseCore.feeds.MerchantFeeds
-- set FeedOptionsJson = '{"AddFreight":false,"ApplyDfiDiscount":false,"ApplyVolumeDiscount":false,"WarehouseId":null,"ClientID":"a31b7b006b324a91be1c4cc502aeb465","CustomerId":3040600,"Username":"Ad_3040600","Password":"Furniture1","ShipTo":"03","FeedId":9,"ManufacturerIds":[1436,3181,3182,3184,4226,4227],"FeedInformations":null,"DownloaderSettings":{},"ConverterSettings":null,"StatusProcessorSettings":{"ShowMissingProducts":true},"PricingModifierSettings":{"PricingType":0,"DefaultPricingSettings":{"Id":0,"Name":null,"RegularPriceFormulaValue":0,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},"DepartmentsPricingSettings":[{"DepartmentId":23,"Name":"Audio Video Furniture","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":58,"Name":"TV Stands","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":248,"Name":"TV Stand Accessories","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":318,"Name":"Entertainment Centers","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":419,"Name":"Entertainment Center Components","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},{"DepartmentId":26,"Name":"Bedroom","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":180,"Name":"Bedding","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":181,"Name":"Bed Components","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":182,"Name":"Chests","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":183,"Name":"Dressers","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":184,"Name":"Dresser Mirrors","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":185,"Name":"Armoires","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":186,"Name":"Nightstands","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":187,"Name":"Benches","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":262,"Name":"Mattresses","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":272,"Name":"Pillows","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":277,"Name":"Vanity Tables and Sets","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":308,"Name":"Bed Frames","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":331,"Name":"Adjustable Bases","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":372,"Name":"Foundations","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":587,"Name":"Beds","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":607,"Name":"Daybeds","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},{"DepartmentId":28,"Name":"Dining Room","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":178,"Name":"Dining Tables","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":179,"Name":"Dining Seating","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":209,"Name":"China Cabinets","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":210,"Name":"Buffets","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":431,"Name":"Kitchen Islands and Carts","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":519,"Name":"Dinettes","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},{"DepartmentId":30,"Name":"Home Accent","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":260,"Name":"Coat Racks","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":261,"Name":"Bar Cabinets","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":282,"Name":"Mirrors","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":294,"Name":"Lamps","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":298,"Name":"Home Decor","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":457,"Name":"Rugs","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":527,"Name":"Decorative Pillows","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":533,"Name":"Sculptures","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":590,"Name":"Bars","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},{"DepartmentId":29,"Name":"Home Office","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":134,"Name":"Office Desks","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":257,"Name":"Bookcases","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":267,"Name":"Office Chairs","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":487,"Name":"Filing Cabinets","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":657,"Name":"Office Desk Components","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},{"DepartmentId":27,"Name":"Kids Bedroom","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":188,"Name":"Kids Bed Components","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":189,"Name":"Kids Dressers","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":190,"Name":"Kids Dresser Mirrors","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":191,"Name":"Kids Nightstands","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":192,"Name":"Kids Desks","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":193,"Name":"Kids Chests","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":194,"Name":"Kids Armoires","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":196,"Name":"Kids Bookshelves","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":197,"Name":"Kids Bedroom Accents","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":407,"Name":"Kids Seating","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":591,"Name":"Kids Beds","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},{"DepartmentId":25,"Name":"Living Room","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":87,"Name":"Fireplaces","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":88,"Name":"Home Theater Seating","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":175,"Name":"Sleepers","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":208,"Name":"Occasional Tables","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":258,"Name":"Accent Cabinets","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":310,"Name":"Sectionals","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":311,"Name":"Sofas","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":312,"Name":"Loveseats","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":313,"Name":"Chairs","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":314,"Name":"Recliners","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":315,"Name":"Ottomans","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":316,"Name":"Accent Chairs","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":319,"Name":"Curios","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":389,"Name":"Lift Chairs","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":473,"Name":"Sectional Components","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":649,"Name":"Futons","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},{"DepartmentId":58,"Name":"Outdoor Furniture","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":447,"Name":"Outdoor Seating","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":448,"Name":"Outdoor Tables","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":539,"Name":"Outdoor Dining Sets","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":600,"Name":"Outdoor Accessories","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]}],"GlobalRoundingActive":false,"GlobalRoundingType":0,"GlobalRoundingLastDigit":0,"GlobalModifierActive":false,"GlobalModifier":null,"RegularCostTypeId":0,"ReducedCostTypeId":0,"CollectionPricingType":0,"CollectionDefaultPricingSettings":{"Id":0,"Name":null,"RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},"CollectionDepartmentsPricingSettings":[{"Id":23,"Name":"Audio Video Furniture","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":26,"Name":"Bedroom","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":28,"Name":"Dining Room","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":30,"Name":"Home Accent","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":29,"Name":"Home Office","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":27,"Name":"Kids Bedroom","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":25,"Name":"Living Room","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":58,"Name":"Outdoor Furniture","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},"BrandCategories":[{"BrandName":null,"BrandId":1436,"SelectedDepartments":[29,25,28,26,27],"Categories":[134,257,267,657,175,208,310,315,311,312,313,314,316,473,178,210,209,179,519,180,181,182,183,184,186,187,262,272,372,587,607,188,189,190,191,192,193,591,58]},{"BrandName":null,"BrandId":3181,"SelectedDepartments":[25,29,28,26,27,58],"Categories":[58,318,419,248,88,175,208,258,310,315,311,312,313,314,316,319,389,473,87,649,134,257,487,267,657,178,210,209,179,431,519,180,181,182,183,184,186,187,277,308,372,587,607,188,189,190,191,192,193,194,196,197,407,591,260,282,294,298,457,527,533,261,590,448,447,539,600]},{"BrandName":null,"BrandId":3182,"SelectedDepartments":[29,25,28,26,27],"Categories":[134,267,657,175,208,310,315,311,312,313,314,316,473,178,210,209,179,431,180,181,182,183,184,185,186,187,587,188,190,58,318,419,282,457]},{"BrandName":null,"BrandId":3184,"SelectedDepartments":[25,28,26,27],"Categories":[175,310,315,311,312,313,314,316,473,178,210,179,519,181,182,183,184,186,587,188,591]},{"BrandName":null,"BrandId":4226,"SelectedDepartments":[26],"Categories":[262,272,331,372]},{"BrandName":null,"BrandId":4227,"SelectedDepartments":[26],"Categories":[262,272,331,372]}],"IsActive":true,"DryRunActiveness":true,"PricingActive":true,"CollectionPricingActive":true,"DeleteMerchantProds":false,"AllBrandCatsActive":true,"AllowFeaturedItemsUpdate":false,"KeepMerchantProdWhenOutOfStock":false,"FeedName":"Ashley","InventoryActive":true,"LocationName":null,"LocationNames":null,"AvailableLocations":[],"InventoryQtyOptions":{"IsActive":true,"MinimumQtyAvailable":0,"IncludeNextShipmentQty":false,"NextShipmentMaxDays":0},"AvailableCostTypes":[],"AvailablePricingTiers":[],"PricingTierId":null,"TierIdentifier":null,"TestingMerchantIdMappings":{}}' 
-- where merchantid =3336 and feedid = 9