DECLARE @MerchantID INT = 3404;
DECLARE @BrandId INT = 8743;
DECLARE @date DateTime = GETDATE();

select m.id, m.merchant, c.id_cie, c.cie, e.CreationDate from ExclusiveBrandAccessList e
inner join companies c on c.id_cie =e.BrandId
inner join merchants m on m.id = e.MerchantId
order by m.merchant

insert into ExclusiveBrandAccessList values
(@BrandId,@MerchantID, @date)