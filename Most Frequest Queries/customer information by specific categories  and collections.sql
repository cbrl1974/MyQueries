--for Categories

select co.orderTimeStamp, cat.category, c.first_name, c.last_name,c.email, ca.city, ca.provinceCode,co.total  from CustomerOrderItems coi
inner join products p on p.id_product = coi.itemid
inner join customerorders co on co.customerid = coi.orderid
inner join merchants m on m.id =co.merchant_id
inner join customers c on c.id = co.customerid 
inner join customeraddresses ca on ca.customerid = c.id
inner join categories cat on cat.id_category = p.catid and cat.Id_langue = 1
where p.catid in (58,318)
and m.id = 1097
and co.ordertimeStamp between '2016-01-01' and '2018-01-01'
and first_name != 'test'
order by  cat.category

----for collections

select co.orderTimeStamp, d.dept, c.first_name, c.last_name, c.email,ca.city, ca.provinceCode,co.total  from CustomerOrderItems coi
inner join collections col on col.id = coi.itemid
inner join customerorders co on co.customerid = coi.orderid
inner join merchants m on m.id =co.merchant_id
inner join customers c on c.id = co.customerid 
inner join customeraddresses ca on ca.customerid = c.id
inner join departments d on d.id_dept = col.deptid and d.Id_langue = 1
where d.id_dept in (26,28)
and m.id = 1097
and co.ordertimeStamp between '2016-01-01' and '2018-01-01'
and first_name != 'test'
order by d.dept






