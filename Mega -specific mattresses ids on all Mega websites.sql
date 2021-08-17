select m.id from merchants m
inner join merchantwebsitefeatures mwf on mwf.merchant_id = m.id
where mwf.featurecode = 'template'
and mwf.featurevalue in  ('tbmega1','tbmega2')

select  m.merchant_code, mp.productID
from merchants m
inner join merchantProds mp on mp.Merchant_ID = m.id
inner join products p on p.id_product = mp.ProductID
where m.id in  (select m.id from merchants m
inner join merchantwebsitefeatures mwf on mwf.merchant_id = m.id
where mwf.featurecode = 'template'
and mwf.featurevalue in  ('tbmega1','tbmega2'))
and mp.catid = 262
and p.manufID in (1946,2180,2185,4786,5201)
order by m.id, m.merchant_code, mp.productID





select id_cie, cie from companies where cie in ('Beautyrest','Concept ZZZ','Sealy','Stearns & Foster','Tempur-Pedic')
