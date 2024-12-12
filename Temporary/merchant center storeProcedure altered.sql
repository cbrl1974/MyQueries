SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[services_data_GoogleShoppingCenter]
    (
    @merchantid int,
    @id_langue int,
    @RemovePossibleOffenders bit,
    @Liquidation bit,
    @IgnoreCollectionGtinCheck bit
)
AS BEGIN
    --exec services_data_GoogleShoppingCenter 1097,1,1,0,0

    SET NOCOUNT ON;

    DECLARE @MerchantUrl VARCHAR(255);
    DECLARE @CountryCode VARCHAR(2);

    SELECT
        @MerchantUrl = m.merchant_url,
        @CountryCode = m.countryCode
    FROM
        merchants m
    WHERE
        m.ID = @merchantid;

    SET
        @MerchantUrl = (
            CASE
                WHEN right(@MerchantUrl, 1) = '/' THEN @MerchantUrl
                ELSE @MerchantUrl + '/'
            END
        );

    DECLARE @CurrencyCode VARCHAR(3) = (
        CASE
            WHEN @CountryCode = 'CA' THEN 'CAD'
            WHEN @CountryCode = 'US' THEN 'USD'
            ELSE ''
        END
    );

    -- Merchant Feature: `hasStoreInventory`
    DECLARE @UsesStoreInventory BIT = (
        SELECT
            count(1)
        FROM
            merchantWebsiteFeatures
        WHERE
            merchant_ID = @merchantid
            AND featureCode = 'hasStoreInventory'
    );

    -- Merchant Feature: `merchantShippingByItem%`
    DECLARE @UsesMerchantShippingByItem BIT = (
        SELECT
            count(1)
        FROM
            merchantWebsiteFeatures
        WHERE
            merchant_ID = @merchantid
            AND featureCode = 'shippingOptionTypes'
            AND featureValue LIKE 'merchantShippingByItem%'
    );

    -- Merchant Feature: `merchantShippingByItem%`
    -- Note: We should maybe always Inlcude since there is no way to send fees to Google Feed
    DECLARE @isShoppingcartPriceIncludesFees BIT = (
        SELECT
            count(1)
        FROM
            merchantWebsiteFeatures
        WHERE
            merchant_ID = @merchantid
            AND featureCode = 'shoppingCartPriceIncludesFees'
    );

    -- Merchant Shipping: has records in `dbo.MerchantShippingPrices`
    DECLARE @hasProductShippingPrices BIT = (
        SELECT
            count(1)
        FROM
            (
                SELECT
                    top 1 ms.id
                FROM
                    MerchantShipping ms
                    LEFT JOIN MerchantShippingPrices msp ON ms.id = msp.merchantShippingId
                WHERE
                    merchant_id = @merchantid
                    AND msp.productId IS NOT NULL
            ) X
    );

    -- Uses Product Shipping Prices if:
    -- has feature `merchantShippingByItem%` AND has records in `dbo.MerchantShippingPrices`
    DECLARE @UsesProductShippingPrice BIT = (
        -- "bitwise AND" (&)
        @UsesMerchantShippingByItem & @hasProductShippingPrices
    );

    DECLARE @UsesCollectionInventory BIT = (
        SELECT
            count(1)
        FROM
            (
                SELECT
                    top 1 mis.merchant_ID
                FROM
                    MerchantInventoryStore mis
                WHERE
                    merchant_ID = @merchantid
                    AND itemtype = 2
            ) X
    );

    -- Merchant Shipping: has records in `dbo.MerchantShippingPrices`
    DECLARE @hasCollectionShippingPrice BIT = (
        SELECT
            count(1)
        FROM
            (
                SELECT
                    top 1 ms.id
                FROM
                    MerchantShipping ms
                    LEFT JOIN MerchantShippingPrices msp ON ms.id = msp.merchantShippingId
                WHERE
                    merchant_id = @merchantid
                    AND msp.collectionId IS NOT NULL
            ) X
    );

    -- Uses Collection Shipping Prices if:
    -- has feature `merchantShippingByItem%` AND has records in `dbo.MerchantShippingPrices`
    DECLARE @UsesCollectionShippingPrice BIT = (
        -- "bitwise AND" (&)
        @UsesMerchantShippingByItem & @hasCollectionShippingPrice
    );

    IF OBJECT_ID('TempDB..#MerchantProducts', 'U') IS NOT NULL DROP TABLE #MerchantProducts;
    IF OBJECT_ID('TempDB..#MerchantCollections', 'U') IS NOT NULL DROP TABLE #MerchantCollections;
    IF OBJECT_ID('TempDB..#MerchantItems', 'U') IS NOT NULL DROP TABLE #MerchantItems;
    IF OBJECT_ID('TempDB..#SpecValues', 'U') IS NOT NULL DROP TABLE #SpecValues;
    IF OBJECT_ID('TempDB..#ItemInventory', 'U') IS NOT NULL DROP TABLE #ItemInventory;
    IF OBJECT_ID('TempDB..#ItemShipping', 'U') IS NOT NULL DROP TABLE #ItemShipping;

    SELECT
        p.Id_product 'id',
        p.model 'model',
        p.catID 'CategoryId',
        cat.deptID 'DepartmentId',
        0 'IsCollection',
        1 'ItemType',
        coalesce(
            nullif(
                CONVERT(
                    NVARCHAR(4000),
                    CASE
                        WHEN @id_langue = 1 THEN p.descriptiveTitleUSA_1
                        ELSE p.descriptiveTitle_2
                    END
                ),
                ''
            ),
            nullif(
                CONVERT(
                    NVARCHAR(4000),
                    CASE
                        WHEN @id_langue = 1 THEN p.descriptiveTitle_1
                        ELSE p.descriptiveTitle_2
                    END
                ),
                ''
            )
        ) 'descriptiveTitle',
        CONVERT(
            nvarchar(4000),
            CASE
                WHEN @id_langue = 1 THEN p.description_1
                WHEN @id_langue = 2
                AND p.description_2 IS NOT NULL THEN p.description_2
                ELSE p.description_1
            END
        ) 'description',
        '(' + cat.category + ' - ' + subcat.subcategory + ')' 'category',
        gsm.googleCatID 'google_product_category',
        gsm.googleCat 'product_type',
        c.cie 'brand',
        p.manufId 'BrandId',
        (
            @MerchantUrl --Language of the url such as "en/" or "fr/"
            + CASE
                WHEN @id_langue = 2 THEN 'fr/produit/'
                ELSE 'en/product/'
            END --product or collection plus ID such as "107220-"
            + CONVERT(NVARCHAR(100), p.id_product) + '-' --Company part of the URL without spaces such as "SignatureDesign-"
            + dbo.MakeAlphaNumeric(c.cie) + '-' --Model part of the URL
            + dbo.MakeAlphaNumericHyphenized(p.model)
        ) 'link',
        RTRIM(
            CONVERT(
                NVARCHAR(100),
                (
                    CASE
                        WHEN (mp.price > mp.realPrice OR mp.reducedprice > mp.realPrice) THEN
                            -- we have 2 prices that are different, so let's pick the highest one as regular one
                            IIF(mp.price > mp.reducedprice, mp.price, mp.reducedprice)
                        ELSE
                            -- we only have 1 price so we use it as the only price.
                            mp.realPrice
                    END
                    +
                    IIF(@isShoppingcartPriceIncludesFees = 1, ISNULL(mp.fee, 0), 0) -- add the fee if the feature is set
                )
            ) + (' ' + @CurrencyCode)
        ) 'price',
        RTRIM(
            CONVERT(
                NVARCHAR(100),
                nullif(
                    (
                        CASE
                            WHEN (mp.price > mp.realPrice OR mp.reducedprice > mp.realPrice) THEN
                                -- we have 2 prices that are different, so let's pick the lowest one as reduced one
                                IIF(mp.price < mp.reducedprice, mp.price, mp.reducedprice)
                            ELSE
                                -- we only have 1 price so we don't have a reduced one.
                                NULL
                        END
                        +
                        IIF(@isShoppingcartPriceIncludesFees = 1, ISNULL(mp.fee, 0), 0) -- add the fee if the feature is set
                    ),
                    0
                )
            ) + (' ' + @CurrencyCode)
        ) 'reducedprice',
        dbo.MakeAlphaNumericHyphenized(p.model) 'mpn',
        CASE
            WHEN mp.refurbished = 1 THEN 'refurbished'
            ELSE 'new'
        END 'condition',
        (
                    SELECT
                        dbo.GROUP_CONCAT( 
                        CASE
                        -- Rename first image (_1.jpg) to _400X400_1.jpg
                        WHEN x.rownum = 1 THEN REPLACE(x.imagelink, '_1.jpg', '_400X400_1.jpg')
                        -- Rename second image (_2.jpg) to _400X400_2.jpg
                        WHEN x.rownum = 2 THEN REPLACE(x.imagelink, '_2.jpg', '_400X400_2.jpg')
                        -- Default case for filenames that do not match
                        ELSE x.imagelink
                    END
                ) AS imagelink
            FROM
                (
                    SELECT
                        ROW_NUMBER() OVER (
                            ORDER BY
                                len(filename) ASC
                        ) 'rownum',
                        'http://feed.datatail.com/prodImg/' + FileName 'imagelink'
                    FROM
                        ItemImagesHD
                    WHERE
                        TYPE = 1
                        AND ItemID = mp.productid
                        -- AND width <= 400
                        -- AND height <= 400
                ) x
            WHERE
                (
                    x.rownum IN (1, 2)
                    AND mp.catID NOT IN (
                        1,
                        2,
                        3,
                        67,
                        239,
                        297,
                        627
                    )
                )
                OR(
                    x.rownum IN (2, 3)
                    AND mp.catID IN (
                        1,
                        2,
                        3,
                        67,
                        239,
                        297,
                        627
                    )
                ) --If its a TV, dont return the first image as it often gets rejected by google.
        ) 'ImagesToParse',
        mp.storeonly,
        p.subCatID
    INTO
        #MerchantProducts
    FROM
        merchantprods mp
        LEFT JOIN products p ON mp.productid = p.id_product
        LEFT JOIN companies c ON p.manufid = c.id_cie
        LEFT JOIN Categories cat ON cat.id_category = p.catid
        AND cat.id_langue = @id_langue
        LEFT JOIN Subcategories subcat ON subcat.id_subCategory = p.subcatid
        AND subcat.id_langue = @id_langue
        CROSS APPLY (
            SELECT
                TOP 1 id,
                catid,
                subcatid,
                googleCatID,
                googlecat
            FROM
                GoogleShoppingMapping
            WHERE
                p.subCatID = subCatID
                OR (
                    subcatid IS NULL
                    AND p.catID = catID
                )
            ORDER BY
                subCatID DESC
        ) gsm
    WHERE
        mp.merchant_id = @merchantid
        AND (
            @Liquidation = 0
            OR mp.liquidation = 1
        );

    SELECT
        id,
        model,
        NULL 'CategoryId',
        DepartmentId,
        1 'IsCollection',
        2 'ItemType',
        descriptiveTitle,
        description,
        Category,
        google_product_category,
        product_type,
        brand,
        BrandId,
        (
            @MerchantUrl --Language of the url such as "en/" or "fr/"
            + CASE
                WHEN @id_langue = 2 THEN 'fr/ensemble/'
                ELSE 'en/collection/'
            END --product or collection plus ID such as "107220-"
            + CONVERT(NVARCHAR(100), id) + '-' --Company part of the URL without spaces such as "SignatureDesign-"
            + dbo.MakeAlphaNumerichyphenized(brand) + '-' --Model part of the URL
            + dbo.MakeAlphaNumerichyphenized(model)
        ) 'link',
        price,
        reducedprice,
        dbo.MakeAlphaNumerichyphenized(model) 'mpn',
        condition,
        ImagesToParse,
        storeonly,
        0 'subCatID'
    INTO
        #MerchantCollections
    FROM
        (
            SELECT
                mc.collectionID 'id',
                CASE
                    WHEN @id_langue = 1 THEN c.collection_1
                    ELSE c.collection_2
                END 'model',
                CASE
                    WHEN @id_langue = 1 THEN c.descriptiveTitle_1
                    ELSE c.descriptiveTitle_2
                END 'descriptiveTitle',
                CONVERT(
                    varchar(4000),
                    CASE
                        WHEN @id_langue = 1 THEN c.description_1
                        WHEN @id_langue = 2
                        AND c.description_2 IS NOT NULL THEN c.description_2
                        ELSE c.description_1
                    END
                ) 'description',
                '( ' + dept.collection_label + ' )' 'Category',
                googleCatID 'google_product_category',
                googleCat 'product_type',
                CASE
                    WHEN c.brands IS NOT NULL THEN (
                        SELECT
                            dbo.GROUP_CONCAT(ci.cie)
                        FROM
                            companies ci
                        WHERE
                            ci.Id_cie IN (
                                SELECT
                                    number
                                FROM
                                    intlist_to_tbl(c.brands)
                            )
                    )
                    ELSE NULL
                END 'brand',
                --We dont need BrandId for collection right now...
                0 'BrandId',
                RTRIM(
                    CONVERT(
                        NVARCHAR(100),
                        (
                            CASE
                                WHEN (mc.price > mc.realPrice OR mc.reducedprice > mc.realPrice) THEN
                                    -- we have 2 prices that are different, so let's pick the highest one as regular one
                                    IIF(mc.price > mc.reducedprice, mc.price, mc.reducedprice)
                                ELSE
                                    -- we only have 1 price so we use it as the only price.
                                    mc.realPrice
                            END
                            +
                            IIF(@isShoppingcartPriceIncludesFees = 1, ISNULL(mc.fee, 0), 0) -- add the fee if the feature is set
                        )
                    ) + (' ' + @CurrencyCode)
                ) 'price',
                RTRIM(
                    CONVERT(
                        NVARCHAR(100),
                        nullif(
                            (
                                CASE
                                    WHEN (mc.price > mc.realPrice OR mc.reducedprice > mc.realPrice) THEN
                                        -- we have 2 prices that are different, so let's pick the lowest one as reduced one
                                        IIF(mc.price < mc.reducedprice, mc.price, mc.reducedprice)
                                    ELSE
                                        -- we only have 1 price so we don't have a reduced one.
                                        NULL
                                END
                                +
                                IIF(@isShoppingcartPriceIncludesFees = 1, ISNULL(mc.fee, 0), 0) -- add the fee if the feature is set
                            ),
                            0
                        )
                    ) + (' ' + @CurrencyCode)
                ) 'reducedprice',
                CASE
                    WHEN mc.refurbished = 1 THEN 'refurbished'
                    ELSE 'new'
                END 'condition',
                (
                    SELECT
                        dbo.GROUP_CONCAT( 
                        CASE
                        -- Rename first image (_1.jpg) to _400X400_1.jpg
                        WHEN x.rownum = 1 THEN REPLACE(x.imagelink, '_1.jpg', '_400X400_1.jpg')
                        -- Rename second image (_2.jpg) to _400X400_2.jpg
                        WHEN x.rownum = 2 THEN REPLACE(x.imagelink, '_2.jpg', '_400X400_2.jpg')
                        -- Default case for filenames that do not match
                        ELSE x.imagelink
                    END
                ) AS imagelink
                    FROM
                        (
                            SELECT
                                ROW_NUMBER() OVER (
                                    ORDER BY
                                        len(filename) ASC
                                ) 'rownum',
                                'http://feed.datatail.com/collImg/' + FileName 'imagelink'
                            FROM
                                ItemImagesHD
                            WHERE
                                TYPE = 2
                                AND ItemID = mc.collectionID
                                -- AND width = 400
                                -- AND height = 400
                        ) x
                    WHERE
                        x.rownum <= 2
                ) 'ImagesToParse',
                c.deptid 'DepartmentId',
                mc.storeonly
            FROM
                MerchantCollections mc
                LEFT JOIN collections c ON c.id = mc.collectionid
                LEFT JOIN GoogleShoppingMapping gsm ON c.deptID = gsm.collectionDeptID
                LEFT JOIN departments dept ON c.deptid = dept.id_dept
                AND dept.id_langue = @id_langue
            WHERE
                mc.merchant_id = @merchantid
        ) colz;

    ;

    SELECT
        sp.productId,
        s.spec,
        CASE
            WHEN @id_langue = 1 THEN sp.SpecValue_1
            WHEN @id_langue = 2
            AND sp.SpecValue_2 IS NOT NULL THEN sp.SpecValue_2
            ELSE sp.SpecValue_1
        END specvalue
    INTO
        #SpecValues
    FROM
        SpecsProd sp
        JOIN Specs s ON s.id = sp.specsID_1
    WHERE
        sp.productID IN (
            SELECT
                id
            FROM
                #MerchantProducts
        )
        AND s.spec IN (
            'Color',
            'UPC#',
            'Material',
            'Size'
        );

    ;

    SELECT
        *
    INTO
        #MerchantItems
    FROM
        (
            SELECT
                *,
                NULL productID,
                NULL 'Color',
                NULL 'UPC#',
                NULL 'Material',
                NULL 'Size'
            FROM
                #MerchantCollections mc

            UNION
            ALL

            SELECT
                *
            FROM
                #MerchantProducts mp
                LEFT JOIN #SpecValues sv on mp.id = sv.productID
                pivot(
                    max(sv.specvalue) FOR sv.spec IN (
                        [Color],
                        [UPC#],
                        [Material],
                        [Size]
                    )
                ) AS piv
        ) I;

    SELECT
        mi.id,
        mi.ItemType,
        CASE
            WHEN (
                @UsesStoreInventory = 0
                OR x.inventory > 0
            )
            AND mi.storeonly = 0 THEN 'in stock'
            ELSE 'out of stock'
        END AS 'availability'
    INTO
        #ItemInventory
    FROM
        #MerchantItems mi
        OUTER APPLY (
            SELECT
                sum(isnull(qty, 0)) inventory
            FROM
                MerchantInventoryStore mis
            WHERE
                mi.id = mis.itemID
                AND mi.ItemType = mis.itemType
                AND mis.merchant_ID = @merchantid
        ) x;

    SELECT
        mi.id,
        mi.ItemType,
        rtrim(
            CONVERT(nvarchar(50), nullif(x.price, 0)) + (' ' + @CurrencyCode)
        ) AS 'shippingcost'
    INTO
        #ItemShipping
    FROM
        #MerchantItems mi
        OUTER APPLY (
            SELECT
                max(price) price
            FROM
                MerchantShippingPrices msp
                LEFT JOIN merchantshipping ms ON msp.merchantShippingId = ms.id
            WHERE
                ms.merchant_id = @merchantid
                AND (
                    (
                        @UsesProductShippingPrice = 1
                        AND msp.productId = mi.id
                        AND mi.ItemType = 1
                    )
                    OR (
                        @UsesCollectionShippingPrice = 1
                        AND msp.collectionId = mi.id
                        AND mi.ItemType = 2
                    )
                )
        ) x;

    SET NOCOUNT OFF;

    SELECT
        mi.id,
        model,
        CategoryId,
        DepartmentId,
        IsCollection,
        descriptiveTitle,
        description,
        category,
        google_product_category,
        product_type,
        brand,
        BrandId,
        link,
        price,
        reducedprice,
        mpn,
        condition,
        ImagesToParse,
        @CountryCode countrycode,
        storeonly,
        [Color],
        [UPC#],
        [Material],
        [Size],
        [availability],
        shippingcost
    FROM
        #MerchantItems mi
        JOIN #ItemInventory i on mi.id = i.id and mi.ItemType = i.ItemType
        JOIN #ItemShipping s on mi.id = s.id and mi.ItemType = s.ItemType
    WHERE
        @RemovePossibleOffenders = 0
        OR (
            1 = 1
            AND mi.description <> ''
            AND mi.google_product_category <> ''
            AND mi.product_type <> ''
            AND mi.price <> ''
            AND (
                mi.[UPC#] <> ''
                OR mi.IsCollection = @IgnoreCollectionGtinCheck
            ) --Collections don't have GTINs but we still display them.
            AND mi.ImagesToParse <> ''
        );


    select merchant, merchant_url
    from merchants
    where id=@merchantid
END
GO
