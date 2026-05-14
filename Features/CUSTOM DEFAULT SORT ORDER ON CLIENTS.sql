use stagingtailbasecore

--Custom order to display product in stock first by using Sinray as examples
Declare @merchantId as int = 3142; --
Declare @merchantIdToChange as int = 3468; --?
insert into  merchantWebsitefeatures (merchant_id, featurecode, featureValue) 
select @merchantIdToChange, featurecode, featureValue
from merchantWebsitefeatures
where merchant_id = @merchantId
and featurecode like '%sort%'

select m.id, m.merchant, mf.* from merchantwebsitefeatures mf
join merchants m on m.id = mf.merchant_id
where mf.featurecode like '%Sort%'
and  mf.merchant_id in (select merchant_id  from merchantwebsitefeatures
where featurevalue    in ('tbplatinum') and featureCode = 'template')
order by mf.featurecode

--Check if feature already exists
Declare @merchantId as int = 3361;
select * from merchantwebsitefeatures where merchant_id = @merchantId AND Featurecode like '%sort%'
-- Insert feature
Declare @merchantIdForFeatures as int = 3361;
insert into merchantwebsitefeatures values
(@merchantIdForFeatures,'defaultSort','(CASE WHEN item.displayorder IS NULL THEN 1 ELSE 0 END), ISNULL(item.displayorder, 0), CASE WHEN (item.reducedPrice IS NOT NULL AND (item.reducedPriceEndDate IS NULL or item.reducedPriceEndDate > GETDATE()) and (item.reducedPriceStartDate IS NULL or item.reducedPriceStartDate < GETDATE())) THEN item.reducedPrice WHEN item.price IS NOT NULL THEN item.price ELSE 9999999 END ASC'),
(@merchantIdForFeatures,'colldefaultsort','(CASE WHEN item.displayorder IS NULL THEN 1 ELSE 0 END), ISNULL(item.displayorder, 0), CASE WHEN (item.reducedPrice IS NOT NULL AND (item.reducedPriceEndDate IS NULL or item.reducedPriceEndDate > GETDATE()) and (item.reducedPriceStartDate IS NULL or item.reducedPriceStartDate < GETDATE())) THEN item.reducedPrice WHEN item.price IS NOT NULL THEN item.price ELSE 9999999 END ASC')


-- or update feature
Declare @merchantIdForUpdateFeatures as int = 3361;
update top (1) merchantwebsitefeatures
set featureValue = '(CASE WHEN mp.displayorder IS NULL THEN 1 ELSE 0 END), ISNULL(mp.displayorder, 0), mp.specialbuy DESC, mp.brandHidden DESC, mc.display_order, cat.category, ci.cie ASC, ISNULL(mp.realprice, 9999999) ASC'
where merchant_id = @merchantIdForUpdateFeatures
and featurecode  =  'defaultSort'

SELECT * from merchantwebsitefeatures where merchant_id = 3165 and featurecode like '%search%'

-- Delete feature

DELETE TOP (1) merchantwebsitefeatures WHERE MERCHANT_ID = 3165
AND Featurecode = 'hasCollectionSearch'

DELETE TOP (1) merchantwebsitefeatures WHERE MERCHANT_ID = 3165
AND Featurecode = 'searchDefaultSort'


DELETE TOP (1) merchantwebsitefeatures WHERE MERCHANT_ID = 3165
AND Featurecode = 'hasCollectionsFirstOnSearch'





insert into merchantwebsitefeatures values 
(3165,'hasCollectionsFirstOnSearch',1)

insert into merchantwebsitefeatures values 
(3165,'searchDefaultSort', 'price asc')

insert into merchantwebsitefeatures values 
(3165,'hasCollectionSearch', '')

update top (1) merchantwebsitefeatures
set featureValue = 'price asc'
where merchant_id = 3165 
and featurecode = 'searchDefaultSort'

update top (1) merchantwebsitefeatures
set featureValue = 1
where merchant_id = 3165 
and featurecode = 'hasCollectionsFirstOnSearch'


select * from merchantwebsitepages where merchant_id = 3438 and name = '2026-01-WHR MAY'

select * from merchants where id = 3669





