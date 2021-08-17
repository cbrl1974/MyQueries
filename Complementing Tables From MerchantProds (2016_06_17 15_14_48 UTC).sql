select * from merchants where merchant like '%just%' ---111, 1254
DECLARE @old_mid AS INTEGER = 111
DECLARE @new_mid AS INTEGER = 1254

---Completando MerchantProds Desde el Antiguo a el Nuevo.
/* important to verify whether the products have been already copied.
DECLARE @old_mid AS INTEGER = 111
DECLARE @new_mid AS INTEGER = 1254
Insert INTO MerchantProds(Merchant_ID,MerchantCatId,MerchantDeptId,ProductID,ptr,codeFab,codeProd,catID,cost
			,price,reducedPrice,overridePrice,advPrice,advertised,featured_national,new,refurbished,demo,specialBuy,webonly,storeonly
			,PriceInquiry,PriceQualifier,liquidation,liquidation_storeID,liquidation_qty,lock,VAID,va_1,va_2,qty,specs,description_1,description_2
			,catalogue_national,franchise,specialBuyStartDate,specialBuyEndDate,newStartDate,newEndDate,reducedPriceStartDate,reducedPriceEndDate
			,SpecificModel,fee,featured,departmentFeatured,categoryFeatured,InstallmentPrice,installmentTotalPrice,liquidationPrice,liquidationQualifier
			,videoTitle_1,videoTitle_2,videoLink_1,videoLink_2,FeaturedTabId,priceQualifier_2,brandHidden,DisplayOrder)
select		 @new_mid,MerchantCatId,MerchantDeptId,ProductID,ptr,codeFab,codeProd,catID,cost
			,price,reducedPrice,overridePrice,advPrice,advertised,featured_national,new,refurbished,demo,specialBuy,webonly,storeonly
			,PriceInquiry,PriceQualifier,liquidation,liquidation_storeID,liquidation_qty,lock,VAID,va_1,va_2,qty,specs,description_1,description_2
			,catalogue_national,franchise,specialBuyStartDate,specialBuyEndDate,newStartDate,newEndDate,reducedPriceStartDate,reducedPriceEndDate
			,SpecificModel,fee,featured,departmentFeatured,categoryFeatured,InstallmentPrice,installmentTotalPrice,liquidationPrice,liquidationQualifier
			,videoTitle_1,videoTitle_2,videoLink_1,videoLink_2,FeaturedTabId,priceQualifier_2,brandHidden,DisplayOrder 
from merchantprods MP_Old 
where MP_Old.Merchant_ID = @old_mid
  and MP_Old.productID not in (select MP_New.ProductID from merchantprods MP_New  where MP_New.merchant_id = @new_mid)
*/
DECLARE @new_mid AS INTEGER = 1254
Select * from MerchantProds MP where MP.merchant_ID = @new_mid


-----Completando MerchantCats (Incompleto) ----------
DECLARE @new_mid AS INTEGER = 1254
--Insert INTO MerchantCats(Merchant_id, Catid)
select MP_New.Merchant_id, MP_new.CatID 
from merchantprods MP_New 
where	MP_new.merchant_ID = @new_mid
	and MP_new.catid NOT in (select MC.CatID from MerchantCats MC where MC.merchant_ID  = @new_mid)
Group by MP_New.Merchant_id, MP_new.CatID
-------------------

DECLARE @new_mid AS INTEGER = 1254
select MC.* from MerchantCats MC where MC.merchant_ID  = @new_mid

------ Completando MerchatDepartments  ------
DECLARE @new_mid AS INTEGER = 1254

Insert into MerchantDepartments(Merchant_ID, DepartmentID)
select @new_mid, Cat.deptID
from MerchantCats MC 
 inner join Categories Cat ON (MC.CatID = Cat.ID_Category and Cat.Id_langue = 1)
where MC.merchant_ID  = @new_mid
  and Cat.deptID NOT IN  (Select MDD.DepartmentID from MerchantDepartments MDD where MDD.Merchant_ID = @new_mid)
Group by Cat.deptID
----------

DECLARE @new_mid AS INTEGER = 1254
select * from merchantDepartments MD where MD.Merchant_ID = @new_mid

-----Complementando MerchantCats ----------
DECLARE @new_mid AS INTEGER = 1254

UPDATE mc
SET merchantDepartmentId = md.id
FROM merchantCats mc
JOIN categories c ON mc.catId = c.id_category AND c.id_langue = 1
JOIN departments d ON c.deptId = d.id_dept AND d.id_langue = 1
JOIN merchantDepartments md ON md.departmentId = d.id_dept AND md.merchant_id = mc.merchant_id /* comment out to see all */
WHERE mc.merchant_id = @new_mid
AND mc.merchantDepartmentId IS NULL
--------


DECLARE @new_mid AS INTEGER = 1254
select MC.* from MerchantCats MC where MC.merchant_ID  = @new_mid

------ Completando MerchantBrands ------
DECLARE @new_mid AS INTEGER = 1254
Insert into MerchantBrands(Merchant_id, CieID)
select @new_mid, Comp.ID_Cie 
from MerchantProds MP 
	inner join Products Prod ON (Prod.Id_Product = MP.productID)
	inner join Companies Comp ON (Comp.ID_CIe = Prod.ManufID)
where 
		MP.merchant_ID = @new_mid 	
 AND	Comp.ID_CIE NOT IN (Select MBB.CieID from merchantBrands MBB where MBB.Merchant_id = @new_mid)
Group BY Comp.ID_Cie
---------

DECLARE @new_mid AS INTEGER = 1254
Select * from merchantBrands MB where merchant_ID = @new_mid

------- Completando MerchantCatBrands -------- 
DECLARE @new_mid AS INTEGER = 1254

--INSERT INTO MerchantCatsBrands(Merchant_ID,CatID,CieID)
select @new_mid, MP.catID, Comp.ID_Cie
from MerchantProds MP 
	inner join Products Prod ON (Prod.Id_Product = MP.productID)
	inner join Companies Comp ON (Comp.ID_CIe = Prod.ManufID)
	Left join MerchantCatsBrands MCB on (MCB.Merchant_ID = MP.Merchant_ID and MCB.CatID = MP.CatID and MCB.CieID = Prod.manufID)
where 
		MP.merchant_ID = @new_mid 	
 and	MCB.CatID is null
Group BY MP.catID, Comp.ID_Cie
---------

DECLARE @new_mid AS INTEGER = 1254
Select * from MerchantCatsBrands where merchant_ID = @new_mid


------- update emails ---
DECLARE @old_mid AS INTEGER = 111
DECLARE @new_mid AS INTEGER = 1254

UPDATE TTTnew set  TTTNew.Content_1 = TTT.Content_1, TTTNew.Content_2 = TTT.Content_2
from MerchantWebsiteTexts TTT 
 inner join MerchantWebsiteTexts TTTNew ON (TTTNEW.merchant_ID = @new_mid and TTTNew.textcode = TTT.textcode) 
where TTT.merchant_id in (@old_mid) and TTT.textcode in ('askanexpertformemail','contactformemail','quoterequestemail','shopcartemail','newslettersignup', 'customformemail','homeaboutus')
-----

-- delete empty categories
DECLARE @new_mid AS INTEGER = 1254
delete from merchantcats 
where merchant_id = @new_mid
and catid in (
    select distinct catid 
    from merchantcats 
    where merchant_id = @new_mid
    and catid not in (
        select distinct catid from merchantprods where merchant_id = @new_mid 
    )
)

--delete empty departments
DECLARE @new_mid AS INTEGER = 1254
delete from merchantdepartments 
where merchant_id = @new_mid
and id in (
    select distinct id 
    from merchantdepartments 
    where merchant_id = @new_mid
    and id not in (
        select distinct MerchantDepartmentID from merchantcats where merchant_id = @new_mid
    )
)

