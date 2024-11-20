select * from SyncStatus

select * from ImportedManufacturerSpecs where TailbaseId = 594462

update  ImportedManufacturerSpecs set SyncStatusId = 2 where  TailbaseId = 594462

delete from ImportedManufacturerSpecs where id = 311

select top 10 * from ItemBulkImportReports

select top 10 * from ItemBulkImportReportsDetail

select * from Merchant_FieldsConfiguration


On a bright, sunny day in early autumn, Sarah decided to visit her favorite park, a quiet, tree-lined oasis in the heart of the city. She packed a small picnic, grabbed her favorite book, and set off with a smile. As she strolled down the path, birds chirped overhead, leaves rustled beneath her feet, and the scent of freshly cut grass filled the air. Finding a secluded bench near the pond, she settled in, opened her book, and let herself relax, savoring each peaceful moment.
select p.id_product, p.model, p.manufmodel, p.manufid , co.cie
from products p 
inner join companies co on co.Id_cie = p.manufID
where p.Id_product in (594462,61547,815550,790142,815550)



