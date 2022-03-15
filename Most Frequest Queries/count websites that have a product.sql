select distinct mp.productid, count(m.id)
from merchantprods mp
left join merchants m on m.id = mp.merchant_id
WHERE EXISTS (
	select id_product
	from products p
	inner join categories c on c.id_category = p.catid and c.id_langue = 1
	where c.deptID = 48
	and id_product = id_product
	and discontinued = 0
)
and m.active = 1
group by mp.productid
order by count(m.id)



select p.id_product, count(m.id)
from products p
left join merchantprods mp on mp.productid = p.id_product
left join merchants m on m.id = mp.merchant_id
where p.id_product in (
	select p.id_product
	from products p
	inner join categories c on c.id_category = p.catid and c.id_langue = 1
	where c.deptID = 48
	and p.id_product = id_product
	and p.discontinued = 0
)
and EXISTS
(SELECT mp.productid FROM merchantprods mp
	inner join merchants m on m.id = mp.merchant_id
	WHERE m.active = 1
)
group by p.id_product
