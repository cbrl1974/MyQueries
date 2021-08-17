select * from merchants where merchant like '%Orsini%' ---111, 222

DECLARE @old_mid AS INTEGER = 111
DECLARE @new_mid AS INTEGER = 222

----------------------------------------------------------------- !!! PLEASE README !!! -----------------------------------------------------------------
-- 1.	!!!! VERY IMPORTANT TO REVIEW DATABASE NAMES BEFORE RUNNING !!!!
-- 2.	MAKE SURE THAT MERCHANTSECTORS, MERCHANTDEPARTMENTS, MERCHANTCATS, MERCHANTPRODS, MERCHANTCOLLECTIONS, MERCHANTBRANDS AND MERCHANTCATSBRANDS 
--		ARE ALL EMPTY FOR THE NEW MERCHANT.
-- 3.	FOR MERCHANTSECTORS, MAKE SURE THAT SECTOR_1 IS NOT NULL AND THAT IS UNIQUE FOR THE OLD MERCHANT
-- 4.	FOR MERCHANTFEATUREDTABS, MAKE SURE THAT TITLE_1 IS NOT NULL AND THAT IS UNIQUE FOR THE OLD MERCHANT
---------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM datatail20130410.dbo.MerchantSectors WHERE Merchant_ID=@new_mid
SELECT * FROM datatail20130410.dbo.MerchantDepartments WHERE Merchant_ID=@new_mid
SELECT * FROM datatail20130410.dbo.MerchantCats WHERE Merchant_ID=@new_mid
SELECT * FROM datatail20130410.dbo.MerchantBrands WHERE Merchant_ID=@new_mid
SELECT * FROM datatail20130410.dbo.MerchantCatsBrands WHERE Merchant_ID=@new_mid
SELECT * FROM datatail20130410.dbo.MerchantFeaturedTabs WHERE Merchant_ID=@new_mid
SELECT * FROM datatail20130410.dbo.MerchantProds WHERE Merchant_ID=@new_mid

SELECT * FROM datatail20130410.dbo.MerchantSectors WHERE Merchant_ID=@old_mid
SELECT * FROM datatail20130410.dbo.MerchantFeaturedTabs WHERE Merchant_ID=@old_mid


---------------- COPYING SECTORS ----------------
DECLARE @old_mid AS INTEGER = 111
DECLARE @new_mid AS INTEGER = 222

INSERT INTO datatail20130410.dbo.MerchantSectors(Merchant_ID,sector_1,sector_2,homeAd,display_order)
SELECT @new_mid,sector_1,sector_2,homeAd,display_order FROM datatail20130410.dbo.MerchantSectors WHERE Merchant_ID=@old_mid


---------------- COPYING DEPARTMENTS ----------------
DECLARE @old_mid AS INTEGER = 111
DECLARE @new_mid AS INTEGER = 222

INSERT INTO	datatail20130410.dbo.MerchantDepartments(Merchant_ID,department_1,department_2,display_order,DepartmentID,collectionID,showIconInNavigation
			,showGallery,showTransitionPage,MerchantSectorID,menuImage,slug,DisplayCollection)
SELECT	@new_mid,md.department_1,md.department_2,md.display_order,md.DepartmentID,md.collectionID,md.showIconInNavigation
		,md.showGallery,md.showTransitionPage,n_ms.ID,md.menuImage,md.slug,md.DisplayCollection
FROM	datatail20130410.dbo.MerchantDepartments md
LEFT JOIN datatail20130410.dbo.MerchantSectors o_ms ON md.Merchant_ID = o_ms.Merchant_ID AND md.MerchantSectorID = o_ms.ID
LEFT JOIN datatail20130410.dbo.MerchantSectors n_ms ON n_ms.Merchant_ID = @new_mid AND n_ms.sector_1 = o_ms.sector_1
WHERE	md.Merchant_ID=@old_mid


---------------- COPYING CATEGORIES ----------------
DECLARE @old_mid AS INTEGER = 111
DECLARE @new_mid AS INTEGER = 222

INSERT INTO	datatail20130410.dbo.MerchantCats(Merchant_ID,catID,Datatail,productId,MerchantDepartmentID,dynamic_pricing,showIconInNavigation,showGallery,showTransitionPage,display_order,slug,category_1,category_2)
SELECT	@new_mid,mc.catID,mc.Datatail,mc.productId,n_md.ID,mc.dynamic_pricing
				,mc.showIconInNavigation,mc.showGallery,mc.showTransitionPage,mc.display_order,mc.slug,mc.category_1,mc.category_2
FROM	datatail20130410.dbo.MerchantCats mc
JOIN	datatail20130410.dbo.MerchantDepartments o_md ON mc.Merchant_ID = o_md.Merchant_ID AND mc.MerchantDepartmentID = o_md.ID 
left JOIN	datatail20130410.dbo.MerchantDepartments n_md ON n_md.Merchant_ID = @new_mid AND n_md.DepartmentID = o_md.DepartmentID 
															AND ISNULL(n_md.department_1,'') = ISNULL(o_md.department_2,'')
															AND n_md.DisplayCollection = o_md.DisplayCollection
WHERE	mc.Merchant_ID=@old_mid
----------


DECLARE @new_mid AS INTEGER = 222
UPDATE mc
SET merchantDepartmentId = md.id
FROM merchantCats mc
JOIN categories c ON mc.catId = c.id_category AND c.id_langue = 1
JOIN departments d ON c.deptId = d.id_dept AND d.id_langue = 1
JOIN merchantDepartments md ON md.departmentId = d.id_dept AND md.merchant_id = mc.merchant_id /* comment out to see all */
WHERE mc.merchant_id = @new_mid
AND mc.merchantDepartmentId IS NULL


---------------- COPYING BRANDS ----------------
DECLARE @old_mid AS INTEGER = 111
DECLARE @new_mid AS INTEGER = 222

INSERT INTO datatail20130410.dbo.MerchantBrands(merchant_id,cieId,description_1,description_2,showLandingPage,slug)
SELECT @new_mid,cieId,description_1,description_2,showLandingPage,slug FROM datatail20130410.dbo.MerchantBrands WHERE Merchant_ID=@old_mid


---------------- COPYING MERCHANTCATSBRANDS ----------------
DECLARE @old_mid AS INTEGER = 111
DECLARE @new_mid AS INTEGER = 222

INSERT INTO datatail20130410.dbo.MerchantCatsBrands(merchant_id,catId,cieId)
SELECT @new_mid,catId,cieId FROM datatail20130410.dbo.MerchantCatsBrands WHERE Merchant_ID=@old_mid


---------------- COPYING MERCHANTFEATURETABS ----------------
DECLARE @old_mid AS INTEGER = 111
DECLARE @new_mid AS INTEGER = 222

INSERT INTO datatail20130410.dbo.MerchantFeaturedTabs(Merchant_ID,Title_1,Title_2,DisplayOrder)
SELECT @new_mid,Title_1,Title_2,DisplayOrder FROM datatail20130410.dbo.MerchantFeaturedTabs WHERE Merchant_ID=@old_mid


---------------- COPYING PRODUCTS ----------------
DECLARE @old_mid AS INTEGER = 111
DECLARE @new_mid AS INTEGER = 222

INSERT INTO	datatail20130410.dbo.MerchantProds(Merchant_ID,MerchantCatId,MerchantDeptId,ProductID,ptr,codeFab,codeProd,catID,cost
			,price,reducedPrice,overridePrice,advPrice,advertised,featured_national,new,refurbished,demo,specialBuy,webonly,storeonly
			,PriceInquiry,PriceQualifier,liquidation,liquidation_storeID,liquidation_qty,lock,VAID,va_1,va_2,qty,specs,description_1,description_2
			,catalogue_national,franchise,specialBuyStartDate,specialBuyEndDate,newStartDate,newEndDate,reducedPriceStartDate,reducedPriceEndDate
			,SpecificModel,fee,featured,departmentFeatured,categoryFeatured,InstallmentPrice,installmentTotalPrice,liquidationPrice,liquidationQualifier
			,videoTitle_1,videoTitle_2,videoLink_1,videoLink_2,FeaturedTabId,priceQualifier_2,brandHidden,DisplayOrder)
SELECT	@new_mid,mp.MerchantCatId,mp.MerchantDeptId,mp.ProductID,mp.ptr,mp.codeFab,mp.codeProd,mp.catID,mp.cost
		,mp.price,mp.reducedPrice,mp.overridePrice,mp.advPrice,mp.advertised,mp.featured_national,mp.new,mp.refurbished,mp.demo,mp.specialBuy,mp.webonly,mp.storeonly
		,mp.PriceInquiry,mp.PriceQualifier,mp.liquidation,mp.liquidation_storeID,mp.liquidation_qty,mp.lock,mp.VAID,mp.va_1,mp.va_2,mp.qty,mp.specs,mp.description_1,mp.description_2
		,mp.catalogue_national,mp.franchise,mp.specialBuyStartDate,mp.specialBuyEndDate,mp.newStartDate,mp.newEndDate,mp.reducedPriceStartDate,mp.reducedPriceEndDate
		,mp.SpecificModel,mp.fee,mp.featured,mp.departmentFeatured,mp.categoryFeatured,mp.InstallmentPrice,mp.installmentTotalPrice,mp.liquidationPrice,mp.liquidationQualifier
		,mp.videoTitle_1,mp.videoTitle_2,mp.videoLink_1,mp.videoLink_2,n_mt.ID,mp.priceQualifier_2,mp.brandHidden,mp.DisplayOrder
FROM	datatail20130410.dbo.MerchantProds mp
LEFT JOIN datatail20130410.dbo.MerchantFeaturedTabs o_mt ON mp.Merchant_ID = o_mt.Merchant_ID AND mp.FeaturedTabId = o_mt.ID
LEFT JOIN datatail20130410.dbo.MerchantFeaturedTabs n_mt ON n_mt.Merchant_ID = @new_mid AND n_mt.Title_1 = o_mt.Title_1
WHERE	mp.Merchant_ID=@old_mid


---------------- COPYING COLLECTIONS ----------------
DECLARE @old_mid AS INTEGER = 111
DECLARE @new_mid AS INTEGER = 222

INSERT INTO	datatail20130410.dbo.MerchantCollections(Merchant_ID,collectionID,ptr,cost,deptID,price,reducedPrice,advPrice,advertised
			,featured_national,new,refurbished,demo,specialBuy,webonly,storeonly,PriceInquiry,PriceQualifier,liquidation
			,liquidation_storeID,liquidation_qty,lock,VAID,va_1,va_2,qty,description_1,description_2,specialBuyStartDate,specialBuyEndDate
			,newStartDate,newEndDate,reducedPriceStartDate,reducedPriceEndDate,SpecificModel,fee,featured,departmentFeatured,InstallmentPrice
			,installmentTotalPrice,videoTitle_1,videoTitle_2,videoLink_1,videoLink_2,FeaturedTabId,priceQualifier_2,brandHidden)
SELECT	@new_mid,mc.collectionID,mc.ptr,mc.cost,mc.deptID,mc.price,mc.reducedPrice,mc.advPrice,mc.advertised
		,mc.featured_national,mc.new,mc.refurbished,mc.demo,mc.specialBuy,mc.webonly,mc.storeonly,mc.PriceInquiry,mc.PriceQualifier,mc.liquidation
		,mc.liquidation_storeID,mc.liquidation_qty,mc.lock,mc.VAID,mc.va_1,mc.va_2,mc.qty,mc.description_1,mc.description_2,mc.specialBuyStartDate,mc.specialBuyEndDate
		,mc.newStartDate,mc.newEndDate,mc.reducedPriceStartDate,mc.reducedPriceEndDate,mc.SpecificModel,mc.fee,mc.featured,mc.departmentFeatured,mc.InstallmentPrice
		,mc.installmentTotalPrice,mc.videoTitle_1,mc.videoTitle_2,mc.videoLink_1,mc.videoLink_2,n_mt.ID,mc.priceQualifier_2,mc.brandHidden
FROM	datatail20130410.dbo.MerchantCollections mc
LEFT JOIN datatail20130410.dbo.MerchantFeaturedTabs o_mt ON mc.Merchant_ID = o_mt.Merchant_ID AND mc.FeaturedTabId = o_mt.ID
LEFT JOIN datatail20130410.dbo.MerchantFeaturedTabs n_mt ON n_mt.Merchant_ID = @new_mid AND n_mt.Title_1 = o_mt.Title_1
WHERE	mc.Merchant_ID=@old_mid


---------------- COPYING googleanalyticscode ----------------
DECLARE @old_mid AS INTEGER = 111
DECLARE @new_mid AS INTEGER = 222

DELETE MWST from MerchantwebsiteTexts MWST where MWST.Merchant_id = @new_mid and MWST.textcode = 'googleanalyticscode'
INSERT INTO MerchantwebsiteTexts(Merchant_id,textCode,Content_1)
select @new_mid, MWST.textCode, MWST.Content_1 from MerchantwebsiteTexts MWST where MWST.Merchant_id = @old_mid and MWST.textcode = 'googleanalyticscode'

