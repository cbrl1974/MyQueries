select distinct ir.itemid, ir.itemtype, m.merchant, rt.type, c.category  as 'category'
from ItemRequesters IR
inner join RequesterTypes rt on ir.RequesterTypeId = rt.Id
inner join products p on ir.itemid = p.Id_product
inner join categories c on p.catid = c.Id_category and c.Id_langue = 1
inner join departments d on d.Id_dept = c.deptID and d.id_langue = 1
left join merchants m on ir.RequesterID = m.ID
where ir.itemtype = 1
union all
select  distinct ir.itemid, ir.itemtype, m.merchant, rt.type, d.dept as 'category'
from ItemRequesters IR
inner join RequesterTypes rt on ir.RequesterTypeId = rt.Id
inner join products p on ir.itemid = p.Id_product
inner join collections c on c.id = ir.itemid
inner join collection_product cp on cp.collectionid = c.id 
inner join departments d on d.Id_dept = c.deptID and d.id_langue = 1
inner join merchants m on ir.RequesterID = m.ID
and ir.itemtype = 2
order by itemid desc


