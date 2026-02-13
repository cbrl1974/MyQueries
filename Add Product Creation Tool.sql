Declare @merchantId as int = 3054;
Declare @BrandID as int = 3054;

select * from companies where cie like '%Notre-Dame Agency%'

insert into productCreationToolSettings (merchantId, brandID) VALUES ([merchantId], [brandId])