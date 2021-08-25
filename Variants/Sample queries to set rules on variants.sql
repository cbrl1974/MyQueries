exec VariantsSuperGroup 680480

select [dbo].[FastLevenshtein] (
    'SRS-XB40 (Bl)',
    'SRSBTM8 (B)',
    NULL
)

select p.Id_product, p.manufid, p.manufmodel, p.model, sp.SpecValue_1 from products p
inner join SpecsProd sp on sp.productID =  p.Id_product
left join merchantProds mp on mp.ProductID = p.Id_product
where p.manufid = 1110
and p.catid = 633
and p.active = 1 and p.discontinued = 0 and p.specs = 1 
and  sp.SpecValue_1 is not null
and sp.specsID_1 = 27071

select * from companies where cie like '%sonos%'
select * from companies where id_cie = 321

