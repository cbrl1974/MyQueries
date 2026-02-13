select * from accentmeubles.BrandMappingDictionary
select * from accentmeubles.CategoryMappingDictionary
select * from accentmeubles.SpecMappingDictionary
select * from accentmeubles.StoresMappingDictionary
select * from accentmeubles.BrandMappingDictionary
select * from accentmeubles.ProductHistoryData where isactive = 0

select co.cie,ap.* from accentmeubles.ProductHistoryData ap
join products p on p.id_product = ap.tailbaseid
join companies co on co.id_cie = p.manufid
where isactive = 0
--where p.manufid = 111

update top (417) accentmeubles.ProductHistoryData
set SyncDate = '2026-01-02 00:00:00'
where tailbaseid in (select ap.tailbaseid from accentmeubles.ProductHistoryData ap
join products p on p.id_product = ap.tailbaseid
join companies co on co.id_cie = p.manufid
where isactive = 0)



select * from companies where cie like '%bosch%'

select id_product, active , discontinued, manufID from products where id_product =788154

select * from productsprices where ProductID = 788154 order by creationdate desc

update top (1) productsprices
set startdate = '2026-01-12 00:00:00',
enddate = '2026-04-12 00:00:00'
where id = 1572120
and productid = 788154
and Country = 'ca'


  select p.model, p.manufmodel, co.cie, c.category, s.sect, s.spec, sp.productid, sp.specsID_1, sp.SpecValue_1, sp.SpecValue_2
  from specsProd sp 
  join specs s on s.id = sp.specsID_1
  join products p on p.id_product = sp.productid
  join companies co on co.id_cie = p.manufid
  join categories c on c.id_category = p.catid and c.id_langue =1
  where sp.specValue_1  like '%benchmark%'
  and p.manufid = 502
  order by s.catid, s.sect, s.spec, sp.productid, sp.SpecValue_1, sp.SpecValue_2

  select * from companies where cie like '%Silhouette%'




  --For
  select distinct co.id_cie, co.cie, 'Bespoke', sp.specsID_1
  from specsProd sp 
  join specs s on s.id = sp.specsID_1
  join products p on p.id_product = sp.productid
  join companies co on co.id_cie = p.manufid
  join categories c on c.id_category = p.catid and c.id_langue =1
  where sp.specValue_1  like '%Bespoke%'
  and p.manufid = 9
  group by co.id_cie, co.cie,  sp.specsID_1
  order by co.id_cie , co.cie, sp.specsID_1


  SELECT
    c.category       AS Category,
    sp.specsID_1      AS SpecId,
    s.spec           AS SpecName,
    COUNT(*)         AS Items
FROM specsProd sp
JOIN specs s      ON s.id = sp.specsID_1
JOIN products p   ON p.id_product = sp.productid
JOIN categories c ON c.id_category = p.catid AND c.id_langue = 1
WHERE p.manufid = 502
  AND 
        LOWER(sp.specValue_1) LIKE '%benchmark%'
GROUP BY
    c.category, sp.specsID_1, s.spec
ORDER BY
    c.category, Items DESC, sp.specsID_1;

