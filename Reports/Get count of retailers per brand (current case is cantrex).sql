USE datatail20130410;

WITH
    DistinctBrands
    AS
    (
        SELECT
            m.id AS merchantid,
            co.cie AS BrandName,
            COALESCE(
            CAST(co.BrandFamilyId AS VARCHAR(50)), 
            CAST(p.manufid AS VARCHAR(50))
        ) AS BrandKey
        FROM merchants m
            JOIN merchantProds mp ON mp.Merchant_ID = m.id
            JOIN products p ON p.id_product = mp.productid
            JOIN companies co ON co.id_cie = p.manufid
        WHERE m.id IN (
        1903,3054,3102,3180,3204,3345,3370,3386,3401,3408,3422,3423,3427,3428,3429,
        3430,3431,3432,3435,3439,3442,3448,3451,3452,3453,3456,3457,3458,3459,3463,
        3468,3473,3476,3479,3486,3487,3488,3489,3490,3491,3493,3495,3496,3500,3506,
        3508,3512,3513,3515,3526,3536,3537,3538,3550,3552,3555,3562,3563,3566,3567,
        3570,3577,3578,3579,3585,3586,3590,3595,3597,3603,3604,3611,3613,3614,3615,3639
    )
        GROUP BY m.id, co.cie, co.BrandFamilyId, p.manufid
    ),
    CollapsedBrands
    AS
    (
        SELECT DISTINCT
            merchantid,
            BrandName,
            BrandKey
        FROM DistinctBrands
    )
SELECT
    BrandKey,
    BrandName,
    COUNT(DISTINCT merchantid) AS TotalRetailersForBrand
FROM CollapsedBrands
GROUP BY BrandKey, BrandName
ORDER BY TotalRetailersForBrand DESC, BrandName;
