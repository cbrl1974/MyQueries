
select * from merchantwebsitefeatures where featurecode like '%sort%'

select * from merchantwebsitefeatures where merchant_id = 1126

insert into merchantwebsitefeatures values
(1491,'colldefaultsort','(CASE WHEN mc.displayorder IS NULL THEN 1 ELSE 0 END), mc.displayorder, mc.brandHidden ASC, mc.specialbuy DESC,  mc.displayorder, ISNULL(mc.realprice, 9999999) ASC'),
(1491,'searchDefaultSort','(CASE WHEN displayorder IS NULL THEN 1 ELSE 0 END), ISNULL(displayorder, 0)')

 
--delete top (1) merchantwebsitefeatures where merchant_id = 1491 and featurecode = 'colldefaultsort'

