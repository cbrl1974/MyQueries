-- Count product changes on Tailbasify
use datatail20130410
Declare @today as date = getdate();
Declare @past as date = DATEADD(day, -2, GETDATE()) ;

--For Products
 select m.id, m.merchant,  count(a.productid)  as totalProducts
 --m.id, m.merchant,  a.productid, a.changetype, a.ChangeByApp, a.changetime, count(a.productid) 
 from datatail20130410.dbo.MerchantProducts_ChangeTrackingArchive a
 join datatail20130410.dbo.merchants m on m.id = a.merchantid
 join datatail20130410.dbo.merchantwebsiteinformation mw on mw.merchant_id = m.id
 WHERE a.changetime between @past and @today
 and mw.infovalue like '%Tailbasify%'
 and m.active = 1
 and m.merchant not like '% old%'
  and m.merchant not like '%demo%'
  --and m.id = 2087
  and m.id not in (3209,2798,1448,589,1193)
  group by  m.id, m.merchant
  order by count(a.productid) desc



-- Detailed product changes on Tailbasify

Declare @today as date = getdate();
Declare @past as date = DATEADD(day, -1, GETDATE()) ;

--For Products
 select m.id, m.merchant,  a.productid, c.category, co.cie, a.Price, a.Price, a.ReducedPrice, a.ReducedPriceBefore, a.changetype, a.ChangeByApp, a.changetime 
 from datatail20130410.dbo.MerchantProducts_ChangeTrackingArchive a
 join datatail20130410.dbo.merchants m on m.id = a.merchantid
 join datatail20130410.dbo.merchantwebsiteinformation mw on mw.merchant_id = m.id
 join products p on p.id_product = a.ProductId
 join companies co on co.id_cie = p.manufid
 join categories c on c.id_category = p.catid and c.id_langue = 1
 WHERE a.changetime between @past and @today
 and mw.infovalue like '%Tailbasify%'
 and m.active = 1
 and m.merchant not like '% old%'
  and m.merchant not like '%demo%'
  and m.id not in (3209,2798,1448,589,1193)
  --and m.id = 2087
  group by  m.id, m.merchant,  a.productid, c.category, co.cie, a.Price, a.Price, a.ReducedPrice, a.ReducedPriceBefore, a.changetype, a.ChangeByApp, a.changetime 
  order by a.changetime desc


  --Check changes on products for tailbasify
  
Declare @today as date = getdate();
Declare @past as date = DATEADD(day, -1, GETDATE()) ;


  select m.id, m.merchant,  c.category, co.cie, p.DateModification, p.SpecsModifDate, p.DatePhotoModification
 from datatail20130410.dbo.merchants m 
 join datatail20130410.dbo.merchantprods mp on mp.merchant_id = m.id
 join products p on p.id_product = mp.ProductId
 join companies co on co.id_cie = p.manufid
 join categories c on c.id_category = p.catid and c.id_langue = 1
 join datatail20130410.dbo.merchantwebsiteinformation mw on mw.merchant_id = m.id
 where p.DateModification between @past and @today
  and mw.infovalue like '%Tailbasify%'
 and m.active = 1
 and m.merchant not like '% old%'
  and m.merchant not like '%demo%'
  and m.id not in (3209,2798,1448,589,1193)
  --and m.id = 2087
  group by m.id, m.merchant,  c.category, co.cie, p.DateModification, p.SpecsModifDate, p.DatePhotoModification
  order by p.DateModification desc