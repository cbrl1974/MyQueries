--Refrigeratotrs
select distinct sp.productid, s.catid, c.category,  sp.specsID_1, sp.SpecValue_1 from SpecsProd sp 
inner join specs s on s.id = sp.specsID_1
inner join merchantProds mp on mp.ProductID = sp.productid
inner join categories c on c.Id_category = s.catid and c.Id_langue = 1
where s.catid  = 41
and sp.specsID_1 = 2359
and sp.SpecValue_1 >= '2.5'
and s.Id_langue = 1
and mp.Merchant_ID = 3142
group by sp.productid, s.catid,  c.category,  sp.specsID_1, sp.SpecValue_1
--order by sp.SpecValue_1
union all

--Freezers
select distinct sp.productid, s.catid, c.category,  sp.specsID_1, sp.SpecValue_1 from SpecsProd sp 
inner join specs s on s.id = sp.specsID_1
inner join merchantProds mp on mp.ProductID = sp.productid
inner join categories c on c.Id_category = s.catid and c.Id_langue = 1
where s.catid  = 437
and sp.specsID_1 = 15192
and sp.SpecValue_1 >= '2.5'
and s.Id_langue = 1
and mp.Merchant_ID = 3142
group by sp.productid, s.catid,  c.category,  sp.specsID_1, sp.SpecValue_1
--order by sp.SpecValue_1
union all

--wine storage
select distinct sp.productid, s.catid, c.category,  sp.specsID_1, sp.SpecValue_1 from SpecsProd sp 
inner join specs s on s.id = sp.specsID_1
inner join merchantProds mp on mp.ProductID = sp.productid
inner join categories c on c.Id_category = s.catid and c.Id_langue = 1
where s.catid  = 255
and sp.specsID_1 = 7205
and sp.SpecValue_1 >= '2.5'
and s.Id_langue = 1
and mp.Merchant_ID = 3142
group by sp.productid, s.catid,  c.category,  sp.specsID_1, sp.SpecValue_1
order by sp.SpecValue_1




select * from specs where catid = 437 --20610
select * from specsProd where productid = 706447



select * from categories where category like '%wine%'