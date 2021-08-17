
select * from stagingTailbasecore.dbo.MerchantBoxSolutions where  MerchantBoxTypeId in (1,15)
select * from stagingTailbasecore.dbo.MerchantBoxTypes where id in (1,15)
select * from stagingTailbasecore.dbo.MerchantBoxes where merchant_id =  2798 and MerchantBoxTypeId = 15

delete top (1) from stagingTailbasecore.dbo.MerchantBoxTypes where id = 15





SELECT Id,
MerchantId,
ConfigCode,
ConfigValue
FROM MerchantWebsiteConfigs
WHERE MerchantId = 2798
AND ConfigCode = 'layoutComponents'

select * from merchantwebsitefeatures where featurevalue like '%heyday%'

SELECT t.id, t.boxType, t.displayName
FROM MerchantBoxTypes t
INNER JOIN MerchantBoxSolutions s ON s.merchantBoxTypeId = t.id 
LEFT JOIN merchantWebsiteFeatures mf_ia ON mf_ia.featurevalue = t.boxtype 
AND mf_ia.merchant_id=2798

WHERE s.solution = 'tbplatinum'

ORDER BY t.displayName



--Declare @NewMerchantBoxTypeId as int;
--insert into MerchantBoxTypes (boxType,imgWidth,imgHeight,displayName,boxTypeGroup,groupDisplayName) values
--('flx/homePageSlideshow',2000,720,'Platinum Component Home Page Slideshow',NULL,NULL)
--SET @NewMerchantBoxTypeId = @@IDENTITY

--insert into MerchantBoxSolutions (MerchantBoxTypeId,solution,maximumNumber,desktopWidth,desktopHeight,landscapeWidth,landscapeHeight,portraitWidth,portraitHeight,mobileWidth,mobileHeight) values
--(@NewMerchantBoxTypeId,'tbplatinum',12,1500,540,2000,720,1000,360,960,960)

--update top(1) MerchantBoxSolutions
--set solution = 'tbplatinum'
--where  MerchantBoxTypeId = 15

update top (1) MerchantBoxTypes
set boxtype = 'flx/homePageSlideshow'
where id = 15















