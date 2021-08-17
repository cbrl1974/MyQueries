-- ===========Important the Brand must be unique. Before anything else make sure is that the variable contains an unique value======================== --

DECLARE @Brand VARCHAR(100) SET @Brand ='Samsung'  -- variable with brand name this will be the name of the slug also  
DECLARE @BrandID as int SET @BrandID = (SELECT id_cie from companies where cie = @Brand) -- variable with brand id
select * from companies where id_cie = @BrandID

-----========================================================================================================================== --

DECLARE @OriginalMerchantid AS INT = 163   -- variable with merchant id  to copy from
DECLARE @OriginalContentPageId AS INT = 8697 -- variable with content page id  to copy from

DECLARE @TargetMerchantid AS INT = 1956  -- variable with merchant id  to copy to

--select * from merchantwebsitepages where merchant_id = @TargetMerchantid  -- checking values on merchant to be copied

-- select* from merchantwebsitepages where merchant_id = @OriginalMerchantid and id = @OriginalContentPageId -- checking values on merchant where page will be copied from

--Copy page from original Merchant to target Merchant
--insert into  merchantwebsitepages (merchant_id,name,slug,WebsitePageDesignId,active,lastUpdate,fullCacheablePage,alwaysRecalculate,useV2Rendering)
--select  @TargetMerchantid,name,slug,WebsitePageDesignId,active,lastUpdate,fullCacheablePage,alwaysRecalculate,useV2Rendering 
-- merchantwebsitepages where merchant_id = @OriginalMerchantid and id =  @OriginalContentPageId

--Get New ID inserted and store as variable
DECLARE @NewIdent Int
SET @NewIdent = SCOPE_IDENTITY()

--Update Slug on newly copied merchant page
--update top (1) merchantwebsitepages set slug = concat(@NewIdent, '-', @brand)
--where id = @NewIdent 

--select * from merchantwebsitepages where merchant_id = @TargetMerchantid and id = @NewIdent -- review newly created contetnt page with info updated

-- Copy content of the MerchantWebsitePageContent from one to anotehr
insert into  MerchantWebsitePageContent (MerchantWebsitePageId,ContentCode,Content,Id_langue)
select @NewIdent,ContentCode,Content,Id_langue 
from MerchantWebsitePageContent where MerchantWebsitePageId = @OriginalContentPageId


DECLARE @IDInMerchantBrands as int SET @IDInMerchantBrands = (SELECT  id from merchantbrands where merchant_id = @TargetMerchantid and cieID = @BrandID)

SELECT  * from merchantbrands where merchant_id = @TargetMerchantid and cieID = @BrandID

update top (1) merchantbrands set slug =   concat(@NewIdent, '-', @brand),
showLandingPage = 1
where id = @IDInMerchantBrands



-- Verifying values. PLease comment  all selects, updates and inserts queries before and also the variable @NewIdent declared previously
DECLARE @NewPageIDCopied varchar(100) SET @NewPageIDCopied = (SELECT  max(id) from merchantwebsitepages where merchant_id = @TargetMerchantid)

Select * from merchantwebsitepages where merchant_id = @TargetMerchantid and id = @NewPageIDCopied
Select * from MerchantWebsitePageContent where merchantwebsitepageID =  @NewPageIDCopied
SELECT  * from merchantbrands where merchant_id = @TargetMerchantid and cieID = @BrandID
