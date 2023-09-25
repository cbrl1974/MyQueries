use datatail20130410

--Custom order to display product in stock first by using Sinray as examples
Declare @merchantId as int = 3142; --
Declare @merchantIdToChange as int = 3468; --
insert into  merchantWebsitefeatures (merchant_id, featurecode, featureValue) 
select @merchantIdToChange, featurecode, featureValue
from merchantWebsitefeatures
where merchant_id = @merchantId
and featurecode like '%sort%'

select m.id, m.merchant, mf.* from merchantwebsitefeatures mf
join merchants m on m.id = mf.merchant_id
where mf.featurecode like '%defaultSort%'
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


-- Delete feature
Declare @merchantIdForDeleteFeatures as int = 3361;
DELETE TOP (1) merchantwebsitefeatures WHERE MERCHANT_ID = @merchantIdForDeleteFeatures
AND Featurecode = 'defaultSort'

