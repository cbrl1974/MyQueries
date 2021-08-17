select c.id_category, c.category, c.deptid, d.dept, s.id_sector, s.sector, c.id_langue from categories c
inner join departments d on d.id_dept = c.deptid and d.id_langue = c.id_langue
inner join sectors s on s.id_sector = c.Id_sector and s.Id_langue = c.Id_langue
and c.category != ''
order by c.id_category, c.id_langue