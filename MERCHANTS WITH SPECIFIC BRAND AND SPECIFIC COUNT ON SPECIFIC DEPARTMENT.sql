select count(mp.productid), m.id, m.merchant from merchants m
inner join merchantprods mp on mp.merchant_id = m.id
inner join products p on p.id_product = mp.productid
inner join categories c on c.id_category = p.catId and c.id_langue =1
inner join Departments d  on d.Id_dept = c.deptID and d.id_langue =1
inner join sectors s on s.Id_sector = d.sectorID and s.id_langue =1
where m.countryCode = 'US'
and p.manufID = 9
and d.Id_dept in (34,35)
and m.active = 1
GROUP BY m.id,m.merchant
HAVING COUNT(mp.productid) >= 20
order by m.merchant







