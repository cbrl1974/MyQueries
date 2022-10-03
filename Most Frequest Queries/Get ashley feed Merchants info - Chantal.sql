select m.id, m.merchant, SUBSTRING(mf.remoteFTPUser, 4, 6) as AccountNumber, m.merchant_url,
(
    CASE WHEN mwf.featurecode = 'shoppingCartType' THEN 'yes' else 'no' end
) as EcommerceSite,
    (
    CASE WHEN ms.dropShippingProgramID = 1 THEN 'yes' else 'no' end
) as DirectExress,
    (
    CASE WHEN count(p.manufid) = 5 THEN 'Ashley Only' else 'Multi MFG' end
) as isAshley,
(
    CASE WHEN mc.RTOConsole = 1 THEN 'yes' else 'no' end
) as isRTO,
    md.city,
    md.statecode,
    md.CountryName,
    replace(REPLACE(mf.lastModified,'{ts ''', ''), '''}','') as lastmodified,
    count(distinct mp.productid) as Ashley_Placements,
    (
        CASE WHEN wf.featurecode = TRIM('defaultsort') and wf.featureValue like '%1436%' THEN 'yes' else 'no' end
    ) as isDefaulted
from merchantfeeds mf
    join merchants m on m.id = mf.merchant_id and mf.brand = 'Ashley'
    inner join merchantProds mp on mp.Merchant_ID = m.id
    left join products p on p.Id_product = mp.ProductID
    left join MerchantDistributorWarehouseLocations md on md.merchantid = mf.merchant_id 
    left join merchantwebsitefeatures mwf on mwf.merchant_id = mf.merchant_id
    and mwf.featurecode = 'shoppingCartType'
    left join merchantwebsitefeatures wf on wf.merchant_id = mf.merchant_id and wf.featurecode = TRIM('defaultsort')
    inner join merchantCms mc on mc.Merchant_id = m.id
    left join merchantshipping ms on ms.dropShippingProgramID = md.DistributorID and ms.dropShippingProgramID = 1  ---added direct express
where mf.brand = 'Ashley'
    and m.active = 1
    and mf.active = 1
    and p.manufID in (1436,3181,3182,3184,4227)
group by m.id, m.merchant,mf.remoteFTPUser,m.merchant_url,mwf.featurecode,ms.dropShippingProgramID,md.city, md.statecode, md.CountryName,mc.RTOConsole, lastmodified, wf.featurecode, wf.featureValue
order by m.id

--Ashley Brands
select * from companies where cie in ('Ashley','Ashley Sleep','Signature Design by Ashley','Benchcraft','Millennium')


select mp.merchant_id, count(mp.productid) from merchantProds mp 
inner join products p on p.Id_product = mp.ProductID
where p.manufID in (1436,3181,3182,3184,4227)
and mp.merchant_id = 589
group by mp.merchant_id

--Complemetary values for the isdefaulted
-- 1) Get the merchants with the feature defaultOrder activated
-- 2) The list of merchants comes from the main query generated above
select * from merchantwebsitefeatures 
where featurecode = 'defaultSort' 
and merchant_id in (589,713,761,763,848,927,938,1034,1083,1090,1099,1110,1140,1202,1252,1315,1410,1448,1450,1496,1498,1511,1516,1546,1560,1574,1606,1617,1641,1697,1715,1719,1725,1735,1749,1751,1761,1762,1764,1767,1773,1785,1789,1798,1807,1812,1813,1817,1822,1842,1866,1892,1922,1931,1941,1955,1958,1962,1965,1967,1971,1976,1988,1997,2002,2029,2046,2071,2087,2103,2110,2129,2137,2175,2179,2186,2202,2209,2215,2216,2221,2232,2264,2281,2290,2296,2312,2324,2326,2330,2332,2339,2341,2347,2378,2380,2386,2417,2441,2458,2464,2506,2508,2512,2514,2524,2536,2538,2540,2542,2562,2569,2587,2589,2607,2621,2625,2627,2631,2635,2637,2672,2676,2680,2682,2704,2734,2738,2758,2763,2769,2771,2777,2779,2795,2798,2814,2823,2843,2852,2860,2868,2899,2910,2913,2916,2918,2923,2929,2932,2934,2936,2940,2953,2959,2965,2967,2969,2971,2976,2980,2989,2993,2995,3007,3009,3025,3033,3035,3041,3043,3045,3054,3062,3074,3077,3090,3099,3108,3124,3133,3139,3154,3162,3165,3183,3195,3204,3224,3227,3233,3236,3242,3252,3265,3272,3281,3284,3290,3305,3307,3313,3319,3332,3333,3336,3338,3340,3347,3361,3363,3369,3372,3374,3375,3379,3384,3385,3387,3388,3392,3397,3400,3401,3402,3406,3407,3411,3416,3427,3429,3431)
and featureValue like '%displayOrder%'

--Get the merchants that have product Ashley with the display order 1 and  having the feature customOrder activated
select  distinct mp.merchant_id, mp.displayOrder  from merchantprods mp 
inner join merchantwebsitefeatures wf on wf.merchant_id = mp.merchant_id and wf.featurecode = TRIM('defaultsort')
inner join products p on p.id_product = mp.productid
where p.manufID in (1436,3181,3182,3184,4227)
and mp.merchant_id in (2953,3025,3361,3338,3369,1606,1761,2635,1641,2179,589,2186,2682,2795,2524,2569,1988)
group by mp.merchant_id, mp.productid, mp.displayOrder
having  mp.DisplayOrder = 1


--********* Manually edit the initial report to  set yes based on the results that comes from the last query




