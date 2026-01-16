----------------------------------------------------------------- !!! PLEASE README !!! -----------------------------------------------------------------
--YOU NEED TO RUN THIS SCRIPT FROM PVM703

-- 1.	!!!! VERY IMPORTANT TO REVIEW DATABASE NAMES AND SCRIPTS BEFORE RUNNING !!!!
-- 2.	MAKE SURE THAT MERCHANTSECTORS, MERCHANTDEPARTMENTS, MERCHANTCATS, MERCHANTPRODS, MERCHANTCOLLECTIONS, MERCHANTBRANDS AND MERCHANTCATSBRANDS
--		ARE ALL EMPTY FOR THE NEW MERCHANT.
-- 3.	FOR MERCHANTSECTORS, MAKE SURE THAT SECTOR_1 IS NOT NULL AND THAT IS UNIQUE FOR THE MERCHANT
-- 4.	FOR MERCHANTFEATUREDTABS, MAKE SURE THAT TITLE_1 IS NOT NULL AND THAT IS UNIQUE FOR THE MERCHANT
---------------------------------------------------------------------------------------------------------------------------------------------------------

DECLARE @MerchantId INT = 3648;

-- enable setting an auto incremented field
SET IDENTITY_INSERT StagingTailbaseCore.dbo.merchants ON

-- selecting the merchant from prod and inserting into staging
insert into
    StagingTailbaseCore.dbo.merchants
	(id, merchant_code, merchant, merchantPwd, developer, filepath, competition, DateCreation, DateModification, franchise, RetailerID, management_url, liquidation, rebate_center, flyer_management, ad_management, strategicWatch, adTracking, webTracking, specificDescriptions, specificCollDescriptions, FeaturedProducts, membersGroup, countryCode, merchant_url, relatedProducts, NeedsTailbaseIds, PriceInquiry, SpecificModel, ClientDownload, ClientUpload, active, jobPosting, NmgID, NmgGroup, NmgBB, MerchantParentId, NmgLocationID, HasWarehouses, InsightlyID, cloudflareId, DefaultLogo, oldMerchantId)
select
	id, merchant_code, merchant, merchantPwd, developer, filepath, competition, DateCreation, DateModification, franchise, RetailerID, management_url, liquidation, rebate_center, flyer_management, ad_management, strategicWatch, adTracking, webTracking, specificDescriptions, specificCollDescriptions, FeaturedProducts, membersGroup, countryCode, merchant_url, relatedProducts, NeedsTailbaseIds, PriceInquiry, SpecificModel, ClientDownload, ClientUpload, active, jobPosting, NmgID, NmgGroup, NmgBB, MerchantParentId, NmgLocationID, HasWarehouses, InsightlyID, cloudflareId, DefaultLogo, oldMerchantId
from
	[DB.PROD].datatail20130410.dbo.merchants
where
    id = @MerchantId

-- disable setting an auto incremented field
SET IDENTITY_INSERT StagingTailbaseCore.dbo.merchants OFF


-- selecting the merchant CMS record from prod and inserting into staging
insert into
    StagingTailbaseCore.dbo.MerchantCMS
	(Merchant_id, Newsletter, Aboutus, TermsPolicy, merchantstore, contactform, askexpert, quoterequest, sShowImage, sShowLink, sShowText, relatedProducts, SeoText, storedetailsformat, sShowImageMinLimit, sShowImageMaxLimit, storetemplate, updateProduction, newslettertype, LiquidationManagement, HomeAds, HomeAdsLink, orders, warranties, requestemailmessage, requestsubmitmessage, showManufacturerPrice, MaxProductCount, storetemplate_2, serverEnvironment, languages, mcontentpages, HotDeals, featuredItemTabs, websiteScripts, productLock, uploadVideoReview, RTOConsole, NmgRebates, altAdText, NmgRebateActive, NmgRebateDefaultShow, RebateMultiFiles, AdsTimers, adsVideoLink, viewRebateDetail, brandLandingPages, openTransitionPages, pageHeaderCode, transitionPages, taxManagement, discountsTool, brandLandingPageCustomTemplate, UseBrandHidden, hasProductTags, hasDingAndDent, hasURLEmbedVideo, hasLoginPasswordPage, hasFlyerImagesManagement, transitionPageCustomTemplate, itemReviews, feedManagement, hasLexicons, hasBlog, slideShowPositionChange, hasOPR, hasDefaultPushCents, defaultPushCents, seoManagement, hasURLMapping, HoursToKeepClaimedQuotesInStoreInbox, autoPushEmail, useDescriptiveTitle, htmlAdText, responsiveAdParamKeys, sShowResponsiveBreakpoints, hasShippingInCMTX)
select
	Merchant_id, Newsletter, Aboutus, TermsPolicy, merchantstore, contactform, askexpert, quoterequest, sShowImage, sShowLink, sShowText, relatedProducts, SeoText, storedetailsformat, sShowImageMinLimit, sShowImageMaxLimit, storetemplate, updateProduction, newslettertype, LiquidationManagement, HomeAds, HomeAdsLink, orders, warranties, requestemailmessage, requestsubmitmessage, showManufacturerPrice, MaxProductCount, storetemplate_2, serverEnvironment, languages, mcontentpages, HotDeals, featuredItemTabs, websiteScripts, productLock, uploadVideoReview, RTOConsole, NmgRebates, altAdText, NmgRebateActive, NmgRebateDefaultShow, RebateMultiFiles, AdsTimers, adsVideoLink, viewRebateDetail, brandLandingPages, openTransitionPages, pageHeaderCode, transitionPages, taxManagement, discountsTool, brandLandingPageCustomTemplate, UseBrandHidden, hasProductTags, hasDingAndDent, hasURLEmbedVideo, hasLoginPasswordPage, hasFlyerImagesManagement, transitionPageCustomTemplate, itemReviews, feedManagement, hasLexicons, hasBlog, slideShowPositionChange, hasOPR, hasDefaultPushCents, defaultPushCents, seoManagement, hasURLMapping, HoursToKeepClaimedQuotesInStoreInbox, autoPushEmail, useDescriptiveTitle, htmlAdText, responsiveAdParamKeys, sShowResponsiveBreakpoints, hasShippingInCMTX
from
	[DB.PROD].datatail20130410.dbo.MerchantCMS
where Merchant_id = @MerchantId


-- selecting the merchant features records from prod and inserting into staging
insert into
    StagingTailbaseCore.dbo.merchantWebsiteFeatures
	(Merchant_id, featureCode, featureValue)
select
	Merchant_id, featureCode, featureValue
from
	[DB.PROD].datatail20130410.dbo.merchantWebsiteFeatures
where Merchant_id = @MerchantId


-- selecting the merchant texts records from prod and inserting into staging
insert into
    StagingTailbaseCore.dbo.MerchantWebsiteTexts
	(merchant_id, textcode, content_1, content_2, Id_langue, DisplayStartDate, DisplayEndDate, CreationDate, ModificationDate, BatchId, availableInMerchantBean, EditableByMerchant, DisplayName)
select
	merchant_id, textcode, content_1, content_2, Id_langue, DisplayStartDate, DisplayEndDate, CreationDate, ModificationDate, BatchId, availableInMerchantBean, EditableByMerchant, DisplayName
from
	[DB.PROD].datatail20130410.dbo.MerchantWebsiteTexts
where Merchant_id = @MerchantId


-- enable setting an auto incremented field
SET IDENTITY_INSERT StagingTailbaseCore.dbo.MerchantStores ON

-- STORES selecting the merchant texts records from prod and inserting into staging
insert into
    StagingTailbaseCore.dbo.MerchantStores
	([ID], [MerchantID], [store], [address], [city], [province], [postalCode], [country], [phone], [fax], [email], [maplink], [DateCreation], [DateModification], [displayOrder], [GeoPosition], [detailsinternal], [pickupAvailable], [pickupDelayMinimumDays], [pickupDelayMaximumDays], [pickupComment], [details_1], [details_2], [serviceZoneDistance], [MerchantChildID], [StoreParentID], [tagEmails], [externalCode], [quoteRequestIgnore], [websiteIgnore], [customHoursDetails_1], [customHoursDetails_2])
select
	[ID], [MerchantID], [store], [address], [city], [province], [postalCode], [country], [phone], [fax], [email], [maplink], [DateCreation], [DateModification], [displayOrder], [GeoPosition], [detailsinternal], [pickupAvailable], [pickupDelayMinimumDays], [pickupDelayMaximumDays], [pickupComment], [details_1], [details_2], [serviceZoneDistance], [MerchantChildID], [StoreParentID], [tagEmails], [externalCode], [quoteRequestIgnore], [websiteIgnore], [customHoursDetails_1], [customHoursDetails_2]
from
	[DB.PROD].datatail20130410.dbo.MerchantStores
where MerchantID = @MerchantId

-- disable setting an auto incremented field
SET IDENTITY_INSERT StagingTailbaseCore.dbo.MerchantStores OFF


DELETE FROM StagingTailbaseCore.dbo.MerchantSectors WHERE Merchant_ID = @MerchantId
DELETE FROM StagingTailbaseCore.dbo.MerchantDepartments WHERE Merchant_ID = @MerchantId
DELETE FROM StagingTailbaseCore.dbo.MerchantCats WHERE Merchant_ID = @MerchantId
DELETE FROM StagingTailbaseCore.dbo.MerchantBrands WHERE Merchant_ID = @MerchantId
DELETE FROM StagingTailbaseCore.dbo.MerchantCatsBrands WHERE Merchant_ID = @MerchantId
DELETE FROM StagingTailbaseCore.dbo.MerchantFeaturedTabs WHERE Merchant_ID = @MerchantId
DELETE FROM StagingTailbaseCore.dbo.MerchantProds WHERE Merchant_ID = @MerchantId
DELETE FROM StagingTailbaseCore.dbo.MerchantCollections WHERE Merchant_ID = @MerchantId


---------------- COPYING SECTORS ----------------
INSERT INTO StagingTailbaseCore.dbo.MerchantSectors
	(Merchant_ID,sector_1,sector_2,homeAd,display_order)
SELECT @MerchantId, sector_1, sector_2, homeAd, display_order
FROM [DB.PROD].datatail20130410.dbo.MerchantSectors
WHERE Merchant_ID=@MerchantId


---------------- COPYING DEPARTMENTS ----------------
INSERT INTO	StagingTailbaseCore.dbo.MerchantDepartments
	(Merchant_ID,department_1,department_2,display_order,DepartmentID,collectionID,showIconInNavigation
	,showGallery,showTransitionPage,MerchantSectorID,menuImage,slug,DisplayCollection)
SELECT @MerchantId, md.department_1, md.department_2, md.display_order, md.DepartmentID, md.collectionID, md.showIconInNavigation
		, md.showGallery, md.showTransitionPage, n_ms.ID, md.menuImage, md.slug, md.DisplayCollection
FROM [DB.PROD].datatail20130410.dbo.MerchantDepartments md
	LEFT JOIN [DB.PROD].datatail20130410.dbo.MerchantSectors o_ms ON md.Merchant_ID = o_ms.Merchant_ID AND md.MerchantSectorID = o_ms.ID
	LEFT JOIN StagingTailbaseCore.dbo.MerchantSectors n_ms ON n_ms.Merchant_ID = @MerchantId AND n_ms.sector_1 = o_ms.sector_1
WHERE	md.Merchant_ID=@MerchantId


---------------- COPYING CATEGORIES ----------------
INSERT INTO	StagingTailbaseCore.dbo.MerchantCats
	(Merchant_ID,catID,Datatail,productId,MerchantDepartmentID,dynamic_pricing,showIconInNavigation,showGallery,showTransitionPage,display_order,slug,category_1,category_2)
SELECT @MerchantId, mc.catID, mc.Datatail, mc.productId, n_md.ID, mc.dynamic_pricing
				, mc.showIconInNavigation, mc.showGallery, mc.showTransitionPage, mc.display_order, mc.slug, mc.category_1, mc.category_2
FROM [DB.PROD].datatail20130410.dbo.MerchantCats mc
	JOIN [DB.PROD].datatail20130410.dbo.MerchantDepartments o_md ON mc.Merchant_ID = o_md.Merchant_ID AND mc.MerchantDepartmentID = o_md.ID
	left JOIN StagingTailbaseCore.dbo.MerchantDepartments n_md ON n_md.Merchant_ID = @MerchantId AND n_md.DepartmentID = o_md.DepartmentID
		AND ISNULL(n_md.department_1,'') = ISNULL(o_md.department_1,'')
		AND n_md.DisplayCollection = o_md.DisplayCollection
WHERE	mc.Merchant_ID=@MerchantId



UPDATE mc SET merchantDepartmentId = md.id
FROM StagingTailbaseCore.dbo.merchantCats mc
	JOIN StagingTailbaseCore.dbo.categories c ON mc.catId = c.id_category AND c.id_langue = 1
	JOIN StagingTailbaseCore.dbo.departments d ON c.deptId = d.id_dept AND d.id_langue = 1
	JOIN StagingTailbaseCore.dbo.merchantDepartments md ON md.departmentId = d.id_dept AND md.merchant_id = mc.merchant_id /* comment out to see all */
WHERE mc.merchant_id = @MerchantId
	AND mc.merchantDepartmentId IS NULL



---------------- COPYING BRANDS ----------------
INSERT INTO StagingTailbaseCore.dbo.MerchantBrands
	(merchant_id,cieId,description_1,description_2,showLandingPage,slug)
SELECT @MerchantId, cieId, description_1, description_2, showLandingPage, slug
FROM [DB.PROD].datatail20130410.dbo.MerchantBrands
WHERE Merchant_ID=@MerchantId


---------------- COPYING MERCHANTCATSBRANDS ----------------
INSERT INTO StagingTailbaseCore.dbo.MerchantCatsBrands
	(merchant_id,catId,cieId)
SELECT @MerchantId, catId, cieId
FROM [DB.PROD].datatail20130410.dbo.MerchantCatsBrands
WHERE Merchant_ID=@MerchantId


---------------- COPYING MERCHANTFEATURETABS ----------------
INSERT INTO StagingTailbaseCore.dbo.MerchantFeaturedTabs
	(Merchant_ID,Title_1,Title_2,DisplayOrder)
SELECT @MerchantId, Title_1, Title_2, DisplayOrder
FROM [DB.PROD].datatail20130410.dbo.MerchantFeaturedTabs
WHERE Merchant_ID=@MerchantId


---------------- COPYING PRODUCTS ----------------
INSERT INTO	StagingTailbaseCore.dbo.MerchantProds
	(Merchant_ID,MerchantCatId,MerchantDeptId,ProductID,ptr,codeFab,codeProd,catID,cost
	,price,reducedPrice,overridePrice,advPrice,advertised,featured_national,new,refurbished,demo,specialBuy,webonly,storeonly
	,PriceInquiry,PriceQualifier,liquidation,liquidation_storeID,liquidation_qty,lock,VAID,va_1,va_2,qty,specs,description_1,description_2
	,catalogue_national,franchise,specialBuyStartDate,specialBuyEndDate,newStartDate,newEndDate,reducedPriceStartDate,reducedPriceEndDate
	,SpecificModel,fee,featured,departmentFeatured,categoryFeatured,InstallmentPrice,installmentTotalPrice,liquidationPrice,liquidationQualifier
	,videoTitle_1,videoTitle_2,videoLink_1,videoLink_2,FeaturedTabId,priceQualifier_2,brandHidden,DisplayOrder)
SELECT @MerchantId, mp.MerchantCatId, mp.MerchantDeptId, mp.ProductID, mp.ptr, mp.codeFab, mp.codeProd, mp.catID, mp.cost
		, mp.price, mp.reducedPrice, mp.overridePrice, mp.advPrice, mp.advertised, mp.featured_national, mp.new, mp.refurbished, mp.demo, mp.specialBuy, mp.webonly, mp.storeonly
		, mp.PriceInquiry, mp.PriceQualifier, mp.liquidation, mp.liquidation_storeID, mp.liquidation_qty, mp.lock, mp.VAID, mp.va_1, mp.va_2, mp.qty, mp.specs, mp.description_1, mp.description_2
		, mp.catalogue_national, mp.franchise, mp.specialBuyStartDate, mp.specialBuyEndDate, mp.newStartDate, mp.newEndDate, mp.reducedPriceStartDate, mp.reducedPriceEndDate
		, mp.SpecificModel, mp.fee, mp.featured, mp.departmentFeatured, mp.categoryFeatured, mp.InstallmentPrice, mp.installmentTotalPrice, mp.liquidationPrice, mp.liquidationQualifier
		, mp.videoTitle_1, mp.videoTitle_2, mp.videoLink_1, mp.videoLink_2, n_mt.ID, mp.priceQualifier_2, mp.brandHidden, mp.DisplayOrder
FROM [DB.PROD].datatail20130410.dbo.MerchantProds mp
	JOIN StagingTailbaseCore.dbo.Products p ON p.id_product = mp.productID
	LEFT JOIN [DB.PROD].datatail20130410.dbo.MerchantFeaturedTabs o_mt ON mp.Merchant_ID = o_mt.Merchant_ID AND mp.FeaturedTabId = o_mt.ID
	LEFT JOIN StagingTailbaseCore.dbo.MerchantFeaturedTabs n_mt ON n_mt.Merchant_ID = @MerchantId AND n_mt.Title_1 = o_mt.Title_1
WHERE	mp.Merchant_ID=@MerchantId


---------------- COPYING COLLECTIONS ----------------
INSERT INTO	StagingTailbaseCore.dbo.MerchantCollections
	(Merchant_ID,collectionID,ptr,cost,deptID,price,reducedPrice,advPrice,advertised
	,featured_national,new,refurbished,demo,specialBuy,webonly,storeonly,PriceInquiry,PriceQualifier,liquidation
	,liquidation_storeID,liquidation_qty,lock,VAID,va_1,va_2,qty,description_1,description_2,specialBuyStartDate,specialBuyEndDate
	,newStartDate,newEndDate,reducedPriceStartDate,reducedPriceEndDate,SpecificModel,fee,featured,departmentFeatured,InstallmentPrice
	,installmentTotalPrice,videoTitle_1,videoTitle_2,videoLink_1,videoLink_2,FeaturedTabId,priceQualifier_2,brandHidden)
SELECT @MerchantId, mc.collectionID, mc.ptr, mc.cost, mc.deptID, mc.price, mc.reducedPrice, mc.advPrice, mc.advertised
		, mc.featured_national, mc.new, mc.refurbished, mc.demo, mc.specialBuy, mc.webonly, mc.storeonly, mc.PriceInquiry, mc.PriceQualifier, mc.liquidation
		, mc.liquidation_storeID, mc.liquidation_qty, mc.lock, mc.VAID, mc.va_1, mc.va_2, mc.qty, mc.description_1, mc.description_2, mc.specialBuyStartDate, mc.specialBuyEndDate
		, mc.newStartDate, mc.newEndDate, mc.reducedPriceStartDate, mc.reducedPriceEndDate, mc.SpecificModel, mc.fee, mc.featured, mc.departmentFeatured, mc.InstallmentPrice
		, mc.installmentTotalPrice, mc.videoTitle_1, mc.videoTitle_2, mc.videoLink_1, mc.videoLink_2, n_mt.ID, mc.priceQualifier_2, mc.brandHidden
FROM [DB.PROD].datatail20130410.dbo.MerchantCollections mc
	JOIN StagingTailbaseCore.dbo.collections c ON c.ID = mc.collectionID
	LEFT JOIN [DB.PROD].datatail20130410.dbo.MerchantFeaturedTabs o_mt ON mc.Merchant_ID = o_mt.Merchant_ID AND mc.FeaturedTabId = o_mt.ID
	LEFT JOIN StagingTailbaseCore.dbo.MerchantFeaturedTabs n_mt ON n_mt.Merchant_ID = @MerchantId AND n_mt.Title_1 = o_mt.Title_1
WHERE	mc.Merchant_ID=@MerchantId
