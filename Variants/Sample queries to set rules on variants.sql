exec VariantsSuperGroup 110863

select [dbo].[FastLevenshtein] (
    'SoundLink Bluetooth Mobile Speaker II (S)',
    'SoundLink wireless mobile speaker (B)',
    --'SoundLink Mini',
    NULL
)

select p.id_product, p.manufid, p.manufmodel, p.model, sp.* from products p
inner join SpecsProd sp on sp.productID =  p.Id_product
where p.manufid = 183
and p.catid = 633
and p.active = 1 and p.discontinued = 0 and p.specs = 1 and sp.SpecValue_1 is not null


