select * from feeds.feeds where id = 9

-- Update Template
-- update top (1) feeds.feeds 
-- set options = '{"FeedId":9,"ManufacturerIds":[1436,3181,3182,3184,4226,4227],"FeedInformations":{"InventoryAvailable":false,"PricingAvailable":false,"ProductCreationAvailable":false,"CollectionPricingAvailable":false,"SpecificationsUpdateAvailable":false,"RelatedProductsUpdateAvailable":false,"MediaUpdateAvailable":false,"CompositeDelimiter":null,"PricingPerMerchant":false,"UseManufIdentifierForActiveness":false,"UseLocationsForPricing":true,"AssociateFeedProductImage":false,"MaxImageSize":4000,"HasProductAvailabilityByMerchant":false,"UseGroupStatusProcessor":false,"HasCollectionActiveness":false},"DownloaderSettings":{},"ConverterSettings":null,"StatusProcessorSettings":{"ShowMissingProducts":true},"PricingModifierSettings":null,"BrandCategories":null,"IsActive":false,"DryRunActiveness":false,"PricingActive":false,"CollectionPricingActive":false,"DeleteMerchantProds":false,"AllBrandCatsActive":false,"AllowFeaturedItemsUpdate":false,"KeepMerchantProdWhenOutOfStock":false,"FeedName":null,"InventoryActive":false,"LocationName":null,"LocationNames":null,"AvailableLocations":[],"InventoryQtyOptions":{"IsActive":false,"MinimumQtyAvailable":0,"IncludeNextShipmentQty":false,"NextShipmentMaxDays":0},"AvailableCostTypes":[],"AvailablePricingTiers":[],"PricingTierId":null,"TierIdentifier":null,"TestingMerchantIdMappings":{}}'
-- where id = 9

select * from feeds.merchantFeeds where  feedid = 9 order by merchantid desc
select * from feeds.merchantFeeds where merchantid =589 and feedid = 9
select * from merchantfeeds where merchant_id = 1097


select * from feeds.FeedDumps 
where  RunDate > convert(date,getdate()-1) 
order by merchantid


select top 20 * from feeds.FeedDumps 
where  feedid = 9
order by RunDate desc, merchantid


--Delete records from today
Delete from feeds.FeedDumps 
where  RunDate > convert(date,getdate()-1) 
and FeedId = 9

select top 10 * from feeds.JobRun order by time desc


select top 50 * from feeds.FeedDumps
-- where identifier = 'FOA_ProductsInfo'
 order by RunDate desc



--************Get Products*************
DECLARE @MerchantId AS int = 3336;
DECLARE @ProductCount AS  int = (
SELECT count(mp.ProductID) as total FROM MerchantProds  mp
INNER JOIN products p on p.Id_product = mp.ProductID
WHERE 	mp.Merchant_ID = @MerchantId
and p.manufID in (1436,3181,3182,3184,4226,4227));


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
