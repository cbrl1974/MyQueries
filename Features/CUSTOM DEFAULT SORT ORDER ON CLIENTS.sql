use datatail20130410

select m.id, m.merchant, mf.* from merchantwebsitefeatures mf
join merchants m on m.id = mf.merchant_id
where mf.featurecode like '%sort%'
and  mf.merchant_id in (select merchant_id  from merchantwebsitefeatures
where featurevalue    in ('tbx') and featureCode = 'template')
order by mf.featurecode

Declare @merchantId as int = 2953;
select * from merchantwebsitefeatures where merchant_id = @merchantId AND Featurecode like '%sort%'
(CASE WHEN item.displayorder IS NULL THEN 1 ELSE 0 END), ISNULL(item.displayorder, 0)

insert into merchantwebsitefeatures values
(2953,'defaultSort','(CASE WHEN mc.displayorder IS NULL THEN 1 ELSE 0 END), ISNULL(mc.displayorder, 0), mc.brandHidden ASC, mc.specialbuy DESC,  mc.displayorder, ISNULL(mc.realprice, 9999999) ASC'),
(2510,'colldefaultsort','(CASE WHEN mc.displayorder IS NULL THEN 1 ELSE 0 END), mc.displayorder, mc.brandHidden ASC, mc.specialbuy DESC,  mc.displayorder, ISNULL(mc.realprice, 9999999) ASC')
(2953,'searchDefaultSort','price ASC, category ASC, brand ASC')


update top (1) merchantwebsitefeatures
set featureValue = '(CASE WHEN mp.displayorder IS NULL THEN 1 ELSE 0 END), ISNULL(mp.displayorder, 0), mp.specialbuy DESC, mp.brandHidden DESC, mc.display_order, cat.category, ci.cie ASC, ISNULL(mp.realprice, 9999999) ASC'
where merchant_id = 2953
and featurecode  =  'defaultSort'



DELETE TOP (1) merchantwebsitefeatures WHERE MERCHANT_ID = 2953 AND Featurecode = 'defaultSort'


select * from companies where cie like '%crow%'

--Collections
select mc.collectionid, mc.displayOrder
from merchantcollections mc 
join collections c on c.id = mc.collectionID
where mc.merchant_id = 2510
and c.brands = '2768'

update top (315) merchantcollections
set displayOrder = 1
where merchant_id = 2510
and collectionid in (select mc.collectionid
from merchantcollections mc 
join collections c on c.id = mc.collectionID
where mc.merchant_id = 2510
and c.brands = '2768')

--Products

select mp.productid, mp.displayOrder
from merchantprods mp 
join products p on p.id_product = mp.productid
where mp.merchant_id = 2510
and p.manufid = 2768

update top (956) merchantprods
set displayOrder = 1
where merchant_id = 2510
and productid in (select mp.productid
from merchantprods mp 
join products p on p.id_product = mp.productid
where mp.merchant_id = 2510
and p.manufid = 2768)