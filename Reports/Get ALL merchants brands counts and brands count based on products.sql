
WITH TailbasiFyMerchants AS (
    select distinct mi.id , mi.merchant, mi.AccountingID
    from merchants mi
    where mi.active = 1
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
select tm.id , tm.merchant, tm.AccountingID, mbc.cieid 'Count of Merchant Brands', pbc.manufid 'Count of Distinct brands from products'
from TailbasiFyMerchants tm
inner join merchantBrandsCount mbc on mbc.merchant_id = tm.id
inner join productsBrandsCount pbc on pbc.merchant_id = tm.id
order by tm.id












