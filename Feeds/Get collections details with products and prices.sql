WITH ProductPricing AS (
    SELECT 
        mp.merchant_id, 
        mp.cost,  
        JSON_VALUE(fp.AdditionalPricingData, '$.PurchaseUnitOfMeasure') AS UOM,
        JSON_VALUE(fp.AdditionalPricingData, '$.ItemCode') AS itemcode,
        mp.productid, 
        p.manufacturerIdentifier, 
        mp.price AS merchant_price, 
        mp.QtyPerPackage,  
        fp.price AS feed_price, 
        fp.merchantid, 
        fp.feedid, 
        fp.AdditionalPricingData
    FROM feeds.ProductBasePrices fp
    LEFT JOIN merchantprods mp 
        ON mp.Merchant_ID = fp.MerchantId 
       AND mp.productid = fp.ProductId
    INNER JOIN merchants m 
        ON m.id = fp.MerchantId
    INNER JOIN products p 
        ON p.id_product = fp.productid
    WHERE fp.feedid = 9
      AND fp.MerchantId = 1448
      AND mp.merchant_id IS NOT NULL
),
CollectionProducts AS (
    SELECT * 
    FROM collection_product
),
CollectionDetails AS (
    SELECT DISTINCT 
        mc.collectionid, 
        c.ManufModel, 
        mc.price, 
        mc.reducedPrice,
        mc.merchant_id
    FROM merchantCollections mc
    JOIN collections c 
        ON c.id = mc.collectionId 
    WHERE mc.merchant_id = 1448
)

SELECT 
    pp.*, 
    cd.ManufModel, 
    cd.price AS collection_price, 
    cd.reducedPrice,
    cp.productid AS collection_productid,
	cp.quantity
FROM CollectionDetails cd
JOIN CollectionProducts cp 
    ON cp.collectionID = cd.collectionid
JOIN products p 
    ON p.Id_product = cp.productid
JOIN ProductPricing pp 
    ON pp.productid = cp.productid
WHERE cd.collectionid = 5855
  AND p.manufID IN (3181, 3182, 3184, 4226, 4227)




  
AND cd.collectionid = 6037
AND cd.collectionid = 5855 --table with 4 chairs
AND cd.collectionid = 5089 --table with 2 chairs

