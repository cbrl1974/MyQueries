select * from accentmeubles.BrandMappingDictionary
select * from accentmeubles.CategoryMappingDictionary
select * from accentmeubles.SpecMappingDictionary
select * from accentmeubles.StoresMappingDictionary
select * from accentmeubles.BrandMappingDictionary


  select p.model, p.manufmodel, co.cie, c.category, s.sect, s.spec, sp.productid, sp.SpecValue_1, sp.SpecValue_2
  from specsProd sp 
  join specs s on s.id = sp.specsID_1
  join products p on p.id_product = sp.productid
  join companies co on co.id_cie = p.manufid
  join categories c on c.id_category = p.catid and c.id_langue =1
  where sp.specValue_1  like '%Bespoke%'
  order by s.catid, s.sect, s.spec, sp.productid, sp.SpecValue_1, sp.SpecValue_2