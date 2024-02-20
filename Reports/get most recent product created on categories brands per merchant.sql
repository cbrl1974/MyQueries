Declare @past as date = DATEADD(day, -1, GETDATE());
Declare @merchantID as int = 3506;

select distinct p.id_product as Tailbaseid, p.model,
c.id_category, c.category as category, co.id_cie, co.cie as brand
,s.id_subcategory, s.subcategory as subcategory
, p.datecreation
from products p
inner join categories c on c.id_category = p.catid and c.id_langue = 1
inner join companies co on co.id_cie = p.manufid
inner join merchantBrands mb on mb.cieid = p.manufid
inner join merchantCats mc on mc.catid = p.catid
inner join merchants m on m.id = mb.merchant_id
inner join subcategories s on s.Id_subCategory = p.subcatid and s.id_langue = 1
where m.id = 3506
and p.catid in (select catid from merchantCats where merchant_id = @merchantID)
and p.manufid in (select cieid from merchantBrands where merchant_id = @merchantID)
and p.DateCreation  between @past and getdate()
and p.specs = 1
and p.active = 1
and p.discontinued = 0
and p.model not like '%bdl'
group by  co.id_cie, co.cie, c.id_category, c.category, s.id_subcategory, s.subcategory,
p.DateCreation, p.Id_product, p.model
order by p.datecreation desc