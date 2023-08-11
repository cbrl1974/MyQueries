select top 10 * from CustomerOrders

SELECT m.id, m.merchant, m.merchant_url, SUM(co.total) AS total_order_sum
FROM  merchants m 
left join CustomerOrders co on m.id = co.merchant_id
where m.id in (
select m.id
from merchantwebsitefeatures mf
join merchants m on m.id = mf.merchant_id
where  mf.featureCode = 'shoppingCartType'
and m.active = 1
and m.merchant_url not like '%tailbase%'
and merchant not like '%tailbase%'
and merchant not like   '%old%'
--571,605,716,848,1099,1107,1175,1532,1663,1699,1719,1735,1761,1764,1773,1781,1798,1804,1812,1817,1842,1903,1911,1922,1931,1941,1955,1956,1958,1962,1971,1976,1986,2042,2046,2087,2129,2137,2203,2216,2217,2221,2258,2290,2339,2341,2433,2456,2478,2506,2514,2524,2536,2542,2569,2570,2607,2627,2631,2643,2654,2660,2680,2682,2692,2704,2724,2752,2761,2763,2779,2793,2795,2802,2815,2821,2843,2845,2852,2858,2887,2914,2916,2938,2959,2967,2982,2985,2993,3025,3033,3065,3083,3096,3108,3139,3142,3165,3189,3198,3215,3224,3227,3236,3242,3272,3290,3296,3305,3313,3331,3334,3336,3338,3339,3367,3372,3373,3374,3375,3385,3388,3390,3392,3397,3399,3401,3407,3416,3418,3423,3427,3428,3429,3442,3445,3449,3450,3454,3455,3461
)
and co.orderTimeStamp between '2023-01-01' and '2023-12-31'
GROUP BY m.id, m.merchant, m.merchant_url
ORDER BY total_order_sum DESC
