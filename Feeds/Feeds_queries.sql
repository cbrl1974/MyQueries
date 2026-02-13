use datatail20130410

select distinct m.id, m.merchant, d.feedid, m.active, d.TotalCount, --d.rundate,d.CurrentIndex,
    JSON_VALUE( mf.FeedOptionsJson , '$.IsActive') as isMerchantFeedActive
--,JSON_VALUE( mf.FeedOptionsJson , '$.CustomerId') as CustomerId,
--JSON_VALUE( mf.FeedOptionsJson , '$.ShipTo') as ShipTo
--, mf.FeedOptionsJson
from datatail20130410.feeds.FeedDumps d  WITH (NOLOCK)
    join feeds.merchantfeeds mf on mf.merchantid = d.MerchantId and mf.FeedId = d.feedid
    join merchants m on m.id = d.MerchantId
where  d.RunDate > convert(date,getdate()-1)
    and m.active = 1
-- and d.feedid = 4
--and JSON_VALUE( mf.FeedOptionsJson , '$.IsActive') = 'true'
--and d.totalcount = 0
--and d.MerchantId in (2002)   
group by m.id,m.merchant,d.feedid,m.active, d.TotalCount,mf.FeedOptionsJson
--,d.rundate,d.CurrentIndex, d.TotalCount
order by m.id, d.totalcount


select *
from datatail20130410.feeds.FeedDumps WITH (NOLOCK)
where  RunDate > convert(date,getdate()-1)
order by feedid


--delete top (2) 
--from datatail20130410.feeds.FeedDumps 
--where  RunDate > convert(date,getdate()-1)
--    and feedid = 4
--    and MerchantId in (3577)
--  and totalcount = 0

--Check products information on teh merchant
select mp.merchant_id, p.id_product, co.cie, p.ManufacturerIdentifier, mp.price, mp.reducedPrice
from merchantprods mp
    join products p on p.id_product = mp.ProductID
    join companies co on co.id_Cie = p.manufid
where p.manufid in (3181,3182,1436,3184,4227,4226)
    and mp.merchant_id = 2002


select --top 150 
    [LogID]
      , [Project]
      , [Category]
	  , text
      , [Time]
      , [Severity]
      , [Module]
      , [Location]
FROM [EventReactor].[dbo].[Logs] WITH (NOLOCK)
where category = 'feeds'
    and time > convert(date,getdate()-0)
--and severity <> 2
order by [time] desc


select
    sp.tailbaseid,
    c.category,
    sp.handle,
    sp.SyncStatusId,
    fp.price as BasePrice,
    p.manufmodel,
    mp.productid,
    mp.price as MerchantPrice,
    mp.reducedPrice
from Feeds.ProductBasePrices fp
    join products p
    on p.id_product = fp.productid
    join categories c
    on c.id_category = p.catid
        and c.id_langue = 1
    join merchantProds mp
    on mp.merchant_id = fp.merchantid
        and mp.productid   = fp.productid
    join tailbasify.Shopify.shopifyProducts sp
    on sp.merchantid = fp.merchantid
        and sp.tailbaseid = fp.productid
        and sp.itemtype = 1
where fp.feedid = 9
    and fp.merchantid = 3447
    and p.active = 1
    and p.discontinued = 0
order by fp.productid;


select productid, price, reducedPrice
from merchantProds
where merchant_id = 3447
    and productid in (select productid
    from feeds.ProductBasePrices
    where feedid = 9 and merchantid = 3447)
order by productid

select tailbaseid, handle
from tailbasify.Shopify.shopifyProducts
where merchantid = 3447
    and tailbaseid in (select productid
    from feeds.ProductBasePrices
    where feedid = 9 and merchantid = 3447)
order by tailbaseid

select
    fp.productid,
    fp.price as basePrice,
    p.manufmodel,
    p.active,
    p.discontinued,
    mp.price as merchantPrice,
    mp.reducedPrice,
    sp.handle,
    sp.SyncStatusId
from Feeds.ProductBasePrices fp
    left join products p
    on p.id_product = fp.productid
    left join merchantProds mp
    on mp.merchant_id = fp.merchantid
        and mp.productid = fp.productid
    left join tailbasify.Shopify.shopifyProducts sp
    on sp.merchantid = fp.merchantid
        and sp.tailbaseid = fp.productid
        and sp.itemtype = 1
where fp.feedid = 9
    and fp.merchantid = 3447
order by fp.productid;

select fp.productid, fp.price as basePrice, sp.handle, sp.SyncStatusId
from Feeds.ProductBasePrices fp
    join merchantProds mp
    on mp.merchant_id = fp.merchantid
        and mp.productid = fp.productid
    join tailbasify.Shopify.shopifyProducts sp
    on sp.merchantid = fp.merchantid
        and sp.tailbaseid = fp.productid
        and sp.itemtype = 1
where fp.feedid = 9
    and fp.merchantid = 3447
order by fp.productid;


select mp.productid, p.manufmodel, p.manufid, mp.cost, mp.price, mp.reducedPrice 
, fp.price as priceFromFeed
, JSON_VALUE( AdditionalPricingData , '$.ManufacturerSuggestedRetailPrice') as MSRP
, JSON_VALUE( AdditionalPricingData , '$.MinimumAdvertisedPrice') as MAP
--, fp.AdditionalPricingData
from merchantProds mp
    inner join products p on p.id_product = mp.productid
    left join Feeds.ProductBasePrices fp on mp.productid = fp.productid and mp.merchant_id = fp.MerchantId
where mp.merchant_id = 3025
    and p.manufid in (3181,3182,3184,4226,4227,1436,7587)
    and fp.feedid = 9
    and p.manufid = 7587
order by p.manufID

select *
from feeds.pricingtiers
--and ProductId in (735643)
--and merchantid = 2654





select *
from merchantProds
where merchant_id = 3605 and productid = 733607

select * , JSON_VALUE( options , '$.IsActive'), options
from feeds.feeds
where id = 25



select mf.MerchantId, mf.feedid, mf.FeedOptionsJson,
    JSON_VALUE( mf.FeedOptionsJson , '$.PricingActive') AS PricingActive
from datatail20130410.feeds.merchantfeeds mf
--left join merchants m on m.id = mf.merchantid
where mf.feedid =9
    --and JSON_VALUE( mf.FeedOptionsJson , '$.PricingActive') = 'true'
    and mf.merchantid = 3447
order by mf.merchantid

select *
from merchantProds
where merchant_id = 868058




--UPDATE  mf
--SET FeedOptionsJson = JSON_MODIFY(FeedOptionsJson, '$.DeleteMerchantProds', CONVERT(bit, 0))
--FROM datatail20130410.feeds.merchantfeeds mf
--WHERE mf.feedid = 9
--  AND JSON_VALUE(mf.FeedOptionsJson, '$.DeleteMerchantProds') = 'true'
--  AND merchantid = 761

select *
from feeds.merchantfeeds
where feedid = 25





select mp.productid, p.manufmodel, mp.cost, mp.price, mp.reducedPrice , mp.QtyPerPackage, fp.*
from merchantProds mp
    inner join products p on p.id_product = mp.productid
    left join Feeds.ProductBasePrices fp on mp.productid = fp.productid
where mp.merchant_id = 3614
    --and p.manufid = 2768
    and fp.feedid = 9
    and p.catID = 179
order by merchantid


select *
from feeds.locations
where feedid = 1




Select *
from Feeds.ProductBasePrices
where  feedid = 18
    and productid =873007

select id_product, manufmodel, manufacturerIdentifier, active, discontinued
from products
where id_product = 873007

--update top (1) datatail20130410.feeds.merchantfeeds 
--set FeedOptionsJson = '{"WarehouseId":null,"CustomerId":3691400,"Username":"AD_Tailbase","Password":"Toppings1","ShipTo":"01","FeedId":9,"ManufacturerIds":[3181,3182,3184,4226,4227,1436],"FeedInformations":null,"DownloaderSettings":{},"ConverterSettings":null,"StatusProcessorSettings":{"ShowMissingProducts":true},"PricingModifierSettings":{"PricingType":1,"DefaultPricingSettings":{"Id":0,"Name":"","RegularPriceFormulaValue":180.0,"RegularPriceDefaultCents":99,"ReducedPriceFormulaValue":60.0,"ReducedPriceDefaultCents":37},"DepartmentsPricingSettings":[{"DepartmentId":23,"Name":"Audio Video Furniture","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":58,"Name":"TV Stands","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":248,"Name":"TV Stand Accessories","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":318,"Name":"Entertainment Centers","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":419,"Name":"Entertainment Center Components","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},{"DepartmentId":26,"Name":"Bedroom","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":180,"Name":"Bedding","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":181,"Name":"Bed Components","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":182,"Name":"Chests","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":183,"Name":"Dressers","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":184,"Name":"Dresser Mirrors","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":185,"Name":"Armoires","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":186,"Name":"Nightstands","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":187,"Name":"Benches","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":262,"Name":"Mattresses","RegularPriceFormulaValue":169.0,"RegularPriceDefaultCents":99,"ReducedPriceFormulaValue":100.0,"ReducedPriceDefaultCents":95},{"Id":272,"Name":"Pillows","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":277,"Name":"Vanity Tables and Sets","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":281,"Name":"Mattress Protectors","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":308,"Name":"Bed Frames","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":331,"Name":"Adjustable Bases","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":372,"Name":"Foundations","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":587,"Name":"Beds","RegularPriceFormulaValue":140.0,"RegularPriceDefaultCents":99,"ReducedPriceFormulaValue":89.0,"ReducedPriceDefaultCents":95},{"Id":607,"Name":"Daybeds","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},{"DepartmentId":28,"Name":"Dining Room","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":178,"Name":"Dining Tables","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":179,"Name":"Dining Seating","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":209,"Name":"China Cabinets","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":210,"Name":"Buffets","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":431,"Name":"Kitchen Islands and Carts","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":519,"Name":"Dinettes","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},{"DepartmentId":30,"Name":"Home Accent","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":260,"Name":"Coat Racks","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":261,"Name":"Bar Cabinets","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":282,"Name":"Mirrors","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":294,"Name":"Lamps","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":298,"Name":"Home Decor","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":457,"Name":"Rugs","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":527,"Name":"Decorative Pillows","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":533,"Name":"Sculptures","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":590,"Name":"Bars","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},{"DepartmentId":29,"Name":"Home Office","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":134,"Name":"Office Desks","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":257,"Name":"Bookcases","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":267,"Name":"Office Chairs","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":487,"Name":"Filing Cabinets","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":657,"Name":"Office Desk Components","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},{"DepartmentId":27,"Name":"Kids Bedroom","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":188,"Name":"Kids Bed Components","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":189,"Name":"Kids Dressers","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":190,"Name":"Kids Dresser Mirrors","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":191,"Name":"Kids Nightstands","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":192,"Name":"Kids Desks","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":193,"Name":"Kids Chests","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":194,"Name":"Kids Armoires","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":196,"Name":"Kids Bookshelves","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":197,"Name":"Kids Bedroom Accents","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":407,"Name":"Kids Seating","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":591,"Name":"Kids Beds","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},{"DepartmentId":25,"Name":"Living Room","RegularPriceFormulaValue":175.0,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":60.0,"ReducedPriceDefaultCents":null,"CategoriesPricingSettings":[{"Id":87,"Name":"Fireplaces","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":88,"Name":"Home Theater Seating","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":175,"Name":"Sleepers","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":208,"Name":"Occasional Tables","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":258,"Name":"Accent Cabinets","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":310,"Name":"Sectionals","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":311,"Name":"Sofas","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":312,"Name":"Loveseats","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":313,"Name":"Chairs","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":314,"Name":"Recliners","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":315,"Name":"Ottomans","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":316,"Name":"Accent Chairs","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":319,"Name":"Curios","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":389,"Name":"Lift Chairs","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":473,"Name":"Sectional Components","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":649,"Name":"Futons","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":698,"Name":"Unclassified","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},{"DepartmentId":58,"Name":"Outdoor Furniture","RegularPriceFormulaValue":175.0,"RegularPriceDefaultCents":99,"ReducedPriceFormulaValue":53.0,"ReducedPriceDefaultCents":95,"CategoriesPricingSettings":[{"Id":447,"Name":"Outdoor Seating","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":448,"Name":"Outdoor Tables","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":539,"Name":"Outdoor Dining Sets","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":600,"Name":"Outdoor Accessories","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]}],"GlobalRoundingActive":true,"GlobalRoundingType":1,"GlobalRoundingLastDigit":5,"GlobalModifierActive":false,"GlobalModifier":null,"RegularCostTypeId":1,"ReducedCostTypeId":1,"CollectionPricingType":0,"CollectionDefaultPricingSettings":{"Id":0,"Name":"","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},"CollectionDepartmentsPricingSettings":[{"Id":23,"Name":"Audio Video Furniture","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":26,"Name":"Bedroom","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":28,"Name":"Dining Room","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":30,"Name":"Home Accent","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":29,"Name":"Home Office","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":27,"Name":"Kids Bedroom","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":25,"Name":"Living Room","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null},{"Id":58,"Name":"Outdoor Furniture","RegularPriceFormulaValue":null,"RegularPriceDefaultCents":null,"ReducedPriceFormulaValue":null,"ReducedPriceDefaultCents":null}]},"BrandCategories":[{"BrandName":null,"BrandId":1436,"SelectedDepartments":[29,25,28,26,27],"Categories":[134,257,267,657,175,208,310,315,311,312,313,314,316,473,178,210,209,179,519,180,181,182,183,184,186,187,262,272,372,587,607,188,189,190,191,192,193,591,58]},{"BrandName":null,"BrandId":3181,"SelectedDepartments":[25,29,28,26,27,58],"Categories":[58,318,419,248,88,175,208,258,310,315,311,312,313,314,316,319,389,473,87,649,698,134,257,487,267,657,178,210,209,179,431,519,180,181,182,183,184,186,187,277,308,372,587,607,188,189,190,191,192,193,194,196,197,407,591,260,282,294,298,457,527,533,261,590,448,447,539,600]},{"BrandName":null,"BrandId":3182,"SelectedDepartments":[29,25,28,26,27],"Categories":[134,267,657,175,208,310,315,311,312,313,314,316,473,178,210,209,179,431,180,181,182,183,184,185,186,187,587,188,190,58,318,419,282,457]},{"BrandName":null,"BrandId":3184,"SelectedDepartments":[25,28,26,27],"Categories":[175,310,315,311,312,313,314,316,473,178,210,179,519,181,182,183,184,186,587,188,591]},{"BrandName":null,"BrandId":4226,"SelectedDepartments":[26],"Categories":[262,272,331,372]},{"BrandName":null,"BrandId":4227,"SelectedDepartments":[26],"Categories":[262,272,281,331,372]}],"IsActive":true,"DryRunActiveness":true,"PricingActive":true,"UseCostByCarton":true,"AddFreight":true,"ApplyDfiDiscount":false,"ApplyVolumeDiscount":false,"ApplySurcharge":false,"CollectionPricingActive":true,"ApplyPromotions":false,"DeleteMerchantProds":false,"DeleteProductFeedPricing":false,"DeleteCollectionFeedPricing":false,"AllBrandCatsActive":true,"AllowFeaturedItemsUpdate":false,"KeepMerchantProdWhenOutOfStock":false,"FeedName":"AshleyAPI","InventoryActive":false,"LocationName":null,"LocationNames":null,"AvailableLocations":[],"InventoryQtyOptions":{"IsActive":false,"MinimumQtyAvailable":0,"IncludeNextShipmentQty":false,"NextShipmentMaxDays":0},"AvailableCostTypes":[1],"AvailablePricingTiers":[],"PricingTierId":null,"TierIdentifier":null,"TestingMerchantIdMappings":null}'
--where feedid = 9
--and merchantid = 3227


WITH
    CTE_Duplicates
    AS
    (
        SELECT *,
            ROW_NUMBER() OVER (
                PARTITION BY ProductId,feedid, PriceTypeId, LocationId, PricingTierId, MerchantId
                ORDER BY productbasePriceId
            ) AS rn
        FROM datatail20130410.Feeds.ProductBasePrices
        --WHERE FeedId = 22
        --and productid =296322
    )
select *
FROM CTE_Duplicates
WHERE rn > 1;




WITH
    CTE_ProductsInfo
    AS
    (
        select merchantid, identifier, TotalCount
        from datatail20130410.feeds.FeedDumps  WITH (NOLOCK)
        where  RunDate > convert(date,getdate()-1)
            and feedid = 9
            and Identifier = 'AshleyAPI_Info_Preload'
    )productsInfo,
CTE_ProductsInfo



--Old Feed
select m.id, m.merchant, mf.*
--delete top (20)
from datatail20130410.dbo.MerchantFeeds mf
    join merchants m on m.id = mf.merchant_id
--where merchant_id in  (3569,3586,3510,3541,2384,2771,2264,2046,1785,3490,1922,3171,1574)
where mf.brand = 'Ashley'
    and m.active = 1

select *
from datatail20130410.dbo.MerchantFeeds
where merchant_id in (2976,3613,3614, 3615)
    and brand = 'Ashley'

--delete top (4) from datatail20130410.dbo.MerchantFeeds
--where merchant_id in (2976,3613,3614, 3615) 
--and brand = 'Ashley'



select *
from products
where model like '%WP2188656%'



select m.id, m.merchant
--, JSON_VALUE( mf.FeedOptionsJson , '$.BuyerId') AS BuyerId,
--JSON_VALUE( mf.FeedOptionsJson , '$.ApiKey') AS ApiKey,
--JSON_VALUE( mf.FeedOptionsJson , '$.LocationName') AS LocationName
, mf.*
from feeds.merchantfeeds mf
    join merchants m on m.id = mf.MerchantId
--join feeds.Locations fl on fl.FeedId = mf.feedid and fl.LocationId = mf.loca
where mf.feedid = 18
    and m.active = 1
--and m.merchant not like '%demo%'
--and m.merchant not like '%old%'
order by m.id


select m.id, m.merchant, mf.buyerID, mf.warehouse, mf.apikey
from datatail20130410.dbo.MerchantFeeds mf
    join merchants m on m.id = mf.merchant_id
where brand = 'Coaster'
    and m.active = 1
    and m.merchant not like '%demo%'
    and m.merchant not like '%old%'




--Check Total Counts

WITH
    CTE_ProductsInfo
    AS
    (
        select merchantid, identifier, TotalCount
        from datatail20130410.feeds.FeedDumps  WITH (NOLOCK)
        where  RunDate > convert(date,getdate()-1)
            and feedid = 9
            and Identifier = 'AshleyAPI_Info_Preload'
    ),
    CTE_ProductsPrices
    as
    (
        select merchantid, identifier, TotalCount
        from datatail20130410.feeds.FeedDumps  WITH (NOLOCK)
        where  RunDate > convert(date,getdate()-1)
            and feedid = 9
            and Identifier = 'AshleyAPI_Prices_Preload'
    )

select pi.*, pp.*
from CTE_ProductsInfo pi
    join CTE_ProductsPrices pp on pp.MerchantId = pi.MerchantId
where pi.TotalCount <> pp.TotalCount

select *
from merchantcollections
where merchant_id = 3527 and collectionid in (select productid
    from merchantprods
    where merchant_id = 3527)
select *
from merchantprods
where merchant_id = 3527 and productid = 30642

