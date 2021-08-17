DECLARE @MerchantID AS INT = 1362   -- variable with merchant id  to copy from
DECLARE @newMattressesSectorID AS INT = 2052 -- variable with content page id  to copy from

INSERT INTO merchantdepartments (merchant_ID,department_1,department_2,display_order,DepartmentID,collectionID,showIconInNavigation,dateCreation,dateModification,showGallery,tips,showTransitionPage,MerchantSectorID,menuImage,slug,DisplayCollection,CollectionLabel_1,CollectionLabel_2)
SELECT @MerchantID,department_1,department_2,display_order,DepartmentID,collectionID,showIconInNavigation,dateCreation,dateModification,showGallery,tips,showTransitionPage,@newMattressesSectorID ,menuImage,slug,0,CollectionLabel_1,CollectionLabel_2
FROM  merchantdepartments
--where id = 9055
where id in (19929,19930)

DECLARE @MerchantID AS INT = 1362   -- variable with merchant id  to copy from

select * from merchantsectors where merchant_id = @MerchantID
select * from merchantdepartments where merchant_id = @MerchantID

--update top (1) merchantdepartments set displaycollection = 0 where id = 9605


--this is the sample
select * from merchantdepartments where merchant_id = 1210







