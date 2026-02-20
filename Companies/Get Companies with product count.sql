select co.id_cie, co.cie, co.typeID, t.type, count(p.id_product) as productCount
from companies co
    join Cie_types t on t.Id_type = co.typeid and t.Id_langue = 1
    left join products p on p.manufid = co.id_cie
group by co.id_cie, co.cie, co.typeID, t.type

