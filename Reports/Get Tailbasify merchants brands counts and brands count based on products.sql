
WITH TailbasiFyMerchants AS (
    select distinct mi.merchant_id , m.merchant
    from MerchantWebsiteInformation mi
    inner join merchants m on m.id = mi.merchant_id
    where m.active = 1
    and mi.infoValue like '%Tailbasify%'
),
merchantBrandsCount AS (
  SELECT merchant_id, count(cieid) as cieid
  from merchantBrands
  group by merchant_id
),
productsBrandsCount AS (
    select mp.merchant_id, count(distinct p.manufid) as manufid
    from products p 
    inner join merchantprods mp on mp.productid = p.Id_product
    group by mp.merchant_id
)
select tm.merchant_id , tm.merchant, mbc.cieid 'Count of Merchant Brands', pbc.manufid 'Count of Distinct brands from products'
from TailbasiFyMerchants tm
inner join merchantBrandsCount mbc on mbc.merchant_id = tm.merchant_id
inner join productsBrandsCount pbc on pbc.merchant_id = tm.merchant_id
order by tm.merchant_id









