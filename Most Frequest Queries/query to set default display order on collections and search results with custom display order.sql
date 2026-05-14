

select *
from merchantwebsitefeatures
where merchant_id = 3165

select merchant_id, productid, displayOrder from merchantprods
where merchant_id = 3165

select merchant_id, collectionid, displayOrder from merchantCollections
where merchant_id = 3165




select *
from merchantwebsitefeatures
where featurecode like '%sort%'
    and merchant_id in
(
    select merchant_id
    from merchantwebsitefeatures
    where featurecode
    = 'usesPlatinumLayout'
)
order by featureCode


insert into merchantwebsitefeatures
values
    --(1491, 'colldefaultsort', '(CASE WHEN mc.displayorder IS NULL THEN 1 ELSE 0 END), mc.displayorder, mc.brandHidden ASC, mc.specialbuy DESC,  mc.displayorder, ISNULL(mc.realprice, 9999999) ASC'),
    (3165, 'searchDefaultSort', 'price DESC')


delete top (1) merchantwebsitefeatures
    where merchant_id = 3165
    and featurecode = 'searchDefaultSort'


select *
from merchan
where merchant_id =  3180
 


