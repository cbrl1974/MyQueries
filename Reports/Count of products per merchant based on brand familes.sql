select * from Companies where id_cie in (2185)

select * from companies where cie like '%tempur%'
select * from companies where cie like '%sealy%'
select * from companies where cie like '%sherwood%'

select distinct m.id, m.merchant, m.merchant_url, m.AccountingID, count(mp.productid) as total
 from merchants m
inner join merchantprods mp on mp.merchant_id = m.id
inner join products p on p.Id_product = mp.productid
inner join companies co on co.id_cie = p.manufid 
where p.manufID in (select id_cie from companies where BrandFamilyId = 7)
AND m.merchant_url not like '%tailbase%'
        AND m.Merchant not like '%demo%'
        AND m.Merchant not like '%internal%'
        AND m.Merchant not like '% old%'
        AND m.Merchant not like '%test%'
        AND m.merchant not like 'E-store'
		AND m.active = 1
        and co.BrandFamilyId = 7
group by m.id, m.merchant, m.merchant_url, m.AccountingID
order by total desc, m.merchant asc 


select count(mp.productid) from merchantProds mp 
inner JOIN products p on p.id_product = mp.ProductID 
inner join companies co on co.Id_cie = p.manufID 
where mp.merchant_id = 3307 
and p.manufID in  (select id_cie from companies where BrandFamilyId = 7)
--and p.manufID = 1947


select * from BrandFamilies