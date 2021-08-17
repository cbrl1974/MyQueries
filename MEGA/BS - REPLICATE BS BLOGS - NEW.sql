BEGIN TRAN T1
DECLARE @TargetId AS INT = 1680
DECLARE @HasAppliances AS INT = 1
DECLARE @HasFurniture AS INT = 0
DECLARE @HasMattresses AS INT = 0

DECLARE @MerchantSourceId INT = 1210;
DECLARE @ResetAll BIT = 0;

DECLARE @MerchantDestIds TABLE (
    Id INT NOT NULL,
	Code VARCHAR(20) NULL,
	Appliances BIT NULL,
	Furniture BIT NULL,
	Mattresses BIT NULL,
    PRIMARY KEY (Id)
);

DECLARE @ArticleIds TABLE (
    Id INT NOT NULL,
	Sector VARCHAR(100) NULL, 
    PRIMARY KEY (Id)
);

-- Insert merchant ids to update
INSERT INTO @MerchantDestIds (id, code, appliances, furniture, mattresses)
SELECT ID, merchant_code AS code, @HasAppliances AS appliances, @HasFurniture AS furniture, @HasMattresses AS mattresses FROM merchants WHERE ID = @TargetId

-- Insert articles to replicate
INSERT INTO @ArticleIds (Id, sector)
SELECT 1274 AS articleId, 'Appliances' AS sector 
UNION ALL 
SELECT 1271 AS articleId, 'Appliances' AS sector 
UNION ALL 
SELECT 1439 AS articleId, 'Appliances' AS sector 
UNION ALL 
SELECT 1419 AS articleId, 'Appliances' AS sector 
UNION ALL 
SELECT 1255 AS articleId, 'Furniture' AS sector 
UNION ALL 
SELECT 1260 AS articleId, 'Furniture' AS sector 
UNION ALL 
SELECT 1265 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1273 AS articleId, 'Appliances' AS sector 
UNION ALL 
SELECT 1277 AS articleId, 'Furniture' AS sector 
UNION ALL 
SELECT 1293 AS articleId, 'Furniture' AS sector 
UNION ALL 
SELECT 1306 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1307 AS articleId, 'Furniture' AS sector 
UNION ALL 
SELECT 1308 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1309 AS articleId, 'Appliances' AS sector 
UNION ALL 
SELECT 1310 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1311 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1312 AS articleId, 'Appliances' AS sector 
UNION ALL 
SELECT 1313 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1314 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1315 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1316 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1317 AS articleId, 'Furniture' AS sector 
UNION ALL 
SELECT 1318 AS articleId, 'Appliances' AS sector 
UNION ALL 
SELECT 1319 AS articleId, 'Furniture' AS sector 
UNION ALL 
SELECT 1320 AS articleId, 'Appliances' AS sector 
UNION ALL 
SELECT 1321 AS articleId, 'Furniture' AS sector 
UNION ALL 
SELECT 1322 AS articleId, 'Furniture' AS sector 
UNION ALL 
SELECT 1323 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1324 AS articleId, 'Appliances' AS sector 
UNION ALL 
SELECT 1325 AS articleId, 'Appliances' AS sector 
UNION ALL 
SELECT 1326 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1327 AS articleId, 'Furniture' AS sector 
UNION ALL 
SELECT 1328 AS articleId, 'Furniture' AS sector 
UNION ALL 
SELECT 1329 AS articleId, 'Appliances' AS sector 
UNION ALL 
SELECT 1425 AS articleId, 'Furniture' AS sector 
UNION ALL 
SELECT 1432 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1435 AS articleId, 'Furniture' AS sector 
UNION ALL 
SELECT 1438 AS articleId, 'Appliances' AS sector 
UNION ALL 
SELECT 1458 AS articleId, 'Furniture' AS sector 
UNION ALL 
SELECT 1470 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1471 AS articleId, 'Furniture' AS sector 
UNION ALL 
SELECT 1472 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1473 AS articleId, 'Appliances' AS sector 
UNION ALL 
SELECT 1474 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1475 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1476 AS articleId, 'Appliances' AS sector 
UNION ALL 
SELECT 1477 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1478 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1479 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1480 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1481 AS articleId, 'Furniture' AS sector 
UNION ALL 
SELECT 1482 AS articleId, 'Appliances' AS sector 
UNION ALL 
SELECT 1483 AS articleId, 'Furniture' AS sector 
UNION ALL 
SELECT 1484 AS articleId, 'Appliances' AS sector 
UNION ALL 
SELECT 1485 AS articleId, 'Furniture' AS sector 
UNION ALL 
SELECT 1486 AS articleId, 'Furniture' AS sector 
UNION ALL 
SELECT 1487 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1488 AS articleId, 'Appliances' AS sector 
UNION ALL 
SELECT 1489 AS articleId, 'Appliances' AS sector 
UNION ALL 
SELECT 1490 AS articleId, 'Mattresses' AS sector 
UNION ALL 
SELECT 1491 AS articleId, 'Furniture' AS sector 
UNION ALL 
SELECT 1492 AS articleId, 'Furniture' AS sector 
UNION ALL 
SELECT 1493 AS articleId, 'Appliances' AS sector 

-- Reset tables 
-- MerchantBlogArticlesByCategories
DELETE
FROM		MerchantBlogArticlesByCategories
WHERE		@ResetAll = 1
AND			MerchantBlogArticleId IN ( 
	SELECT mba.Id
	FROM @MerchantDestIds m
	JOIN MerchantBlogArticles mba ON mba.merchantId = m.id 
)
-- MerchantBlogArticlesByTags
DELETE
FROM		MerchantBlogArticlesByTags
WHERE		@ResetAll = 1
AND			MerchantBlogArticleId IN ( 
	SELECT mba.Id
	FROM @MerchantDestIds m
	JOIN MerchantBlogArticles mba ON mba.merchantId = m.id 
)
-- MerchantBlogCategories
DELETE		mbc
FROM		MerchantBlogCategories mbc
JOIN		@MerchantDestIds m ON m.id = mbc.merchantId
WHERE		@ResetAll = 1
-- MerchantBlogTags
DELETE		mbc
FROM		MerchantBlogTags mbc
JOIN		@MerchantDestIds m ON m.id = mbc.merchantId
WHERE		@ResetAll = 1
-- MerchantBlogSocialTagInfo
DELETE		mbsti
FROM		MerchantBlogSocialTagInfo mbsti
JOIN		MerchantBlogs mb ON mb.id = mbsti.merchantBlogId 
JOIN		@MerchantDestIds m ON m.id = mb.merchantId 
WHERE		@ResetAll = 1
-- MerchantBlogSocialArticleTagInfo
DELETE		ti
FROM		MerchantBlogSocialArticleTagInfo ti 
JOIN		MerchantBlogs mb ON mb.id = ti.merchantBlogId 
JOIN		@MerchantDestIds m ON m.id = mb.merchantId 
WHERE		@ResetAll = 1
--MerchantBlogSettings
DELETE		ti
FROM		MerchantBlogSettings ti 
JOIN		MerchantBlogs mb ON mb.id = ti.merchantBlogId 
JOIN		@MerchantDestIds m ON m.id = mb.merchantId 
WHERE		@ResetAll = 1
--MerchantBlogArticles
DELETE		mba
FROM		MerchantBlogArticles mba 
JOIN		@MerchantDestIds m ON m.id = mba.merchantId 
WHERE		@ResetAll = 1
--MerchantBlogs
DELETE		mb
FROM		MerchantBlogs mb 
JOIN		@MerchantDestIds m ON m.id = mb.merchantId 
WHERE		@ResetAll = 1

-- Insert blogs
INSERT INTO MerchantBlogs (merchantid, name, description, urlkey, creationdate, modificationdate)
SELECT		DISTINCT mdest.id as merchantid, mb.name, mb.description, mb.urlkey, getdate() as creationdate, getdate() as modificationdate
FROM		@MerchantDestIds mdest
JOIN		MerchantBlogs mb ON 1 = 1 
WHERE		mb.merchantid = @MerchantSourceId
AND NOT EXISTS (SELECT 1 FROM MerchantBlogs mb2 WHERE mb2.MerchantID = mdest.id AND mb2.Name = mb.Name)

-- Insert articles to merchantblogarticles
INSERT INTO MerchantBlogArticles (merchantid, title, metatitle, metadescription, content, status, CategoriesForSearch, TagsForSearch, id_langue, merchantblogid, RepresentativeImageName, SummaryDescription, ExternalCode, CreationDate, ModificationDate)
SELECT		DISTINCT mdest.id as merchantid, 
			mba.title, 
			mba.metatitle, 
			mba.MetaDescription, 
			mba.content, 
			mba.status, 
			mba.CategoriesForSearch, 
			mba.TagsForSearch, 
			mba.id_langue, 
			mbdest.id as merchantblogid, 
			mba.RepresentativeImageName, 
			mba.SummaryDescription, 
			mba.ExternalCode,
			mba.CreationDate,
			mba.ModificationDate
FROM		@merchantDestIds mdest 
JOIN		MerchantBlogs mbsource ON 1 = 1
JOIN		MerchantBlogs mbdest ON mbdest.name = mbsource.name AND mbdest.MerchantID = mdest.Id
JOIN		MerchantBlogArticles mba ON mba.MerchantBlogID = mbsource.Id 
JOIN		@ArticleIds artId ON artId.Id = mba.Id
JOIN		merchantWebsiteFeatures lang ON lang.merchant_id = mdest.Id AND lang.featureCode = 'languages'
WHERE		mbsource.merchantid = @MerchantSourceId
AND			(
	mdest.appliances = 1 AND artId.Sector = 'Appliances'
	OR 
	mdest.furniture = 1 AND artId.Sector = 'Furniture'
	OR 
	mdest.mattresses = 1 AND artId.Sector = 'Mattresses'
)
AND			(
	lang.featureValue = 'en' AND mba.Id_langue = 1
	OR 
	lang.featureValue = 'fr' AND mba.Id_langue = 2
	OR 
	lang.featureValue <> 'fr' AND lang.featureValue <> 'en' AND (mba.Id_langue = 1 OR mba.Id_langue = 2)
)
AND			NOT EXISTS ( SELECT 1 FROM MerchantBlogArticles mba2 WHERE mba2.merchantId = mdest.id AND mba2.MerchantBlogID = mbdest.ID AND mba2.Id_langue = mba.Id_langue AND mba2.ExternalCode = mba.ExternalCode AND mba2.Title = mba.Title )

-- Insert categories
INSERT INTO MerchantBlogCategories (merchantid, category, active, id_langue, merchantblogid)
SELECT		DISTINCT mdest.id as merchantid, mbcat.category, mbcat.active, mbcat.id_langue, mbdest.id as merchantBlogId
FROM		@MerchantDestIds mdest 
JOIN		MerchantBlogs mbsource ON 1 = 1
JOIN		MerchantBlogs mbdest ON mbdest.name = mbsource.name AND mbdest.MerchantID = mdest.id
JOIN		merchantBlogCategories mbcat ON mbcat.MerchantID = @MerchantSourceId
AND			NOT EXISTS ( SELECT 1 FROM MerchantBlogCategories mbc2 WHERE mbc2.MerchantID = mdest.id AND mbc2.Id_langue = mbcat.Id_langue AND mbc2.Category = mbcat.Category )

-- Insert Tags
INSERT INTO MerchantBlogTags (merchantid, tag, active, id_langue, merchantblogid)
SELECT		DISTINCT mdest.id as merchantid, mbcat.tag, mbcat.active, mbcat.id_langue, mbdest.id as merchantBlogId
FROM		@MerchantDestIds mdest 
JOIN		MerchantBlogs mbsource ON 1 = 1
JOIN		MerchantBlogs mbdest ON mbdest.name = mbsource.name AND mbdest.MerchantID = mdest.id
JOIN		merchantBlogTags mbcat ON mbcat.MerchantID = @MerchantSourceId
AND			NOT EXISTS ( SELECT 1 FROM MerchantBlogTags mbc2 WHERE mbc2.MerchantID = mdest.id AND mbc2.Id_langue = mbcat.Id_langue AND mbc2.Tag = mbcat.Tag )

-- Insert articles by categories
INSERT INTO MerchantBlogArticlesByCategories (MerchantBlogCategoryID, MerchantBlogArticleID)
SELECT		DISTINCT mbcdest.id AS merchantblogcategoryId, mbdest.id as merchantblogarticleid
FROM		@MerchantDestIds mdest 
JOIN		MerchantBlogCategories mbcdest ON mbcdest.MerchantID = mdest.id 
JOIN		MerchantBlogCategories mbcsource ON mbcsource.Category = mbcdest.Category AND mbcsource.Id_langue = mbcdest.Id_langue
JOIN		MerchantBlogArticles mbdest ON mbdest.MerchantID = mdest.id 
JOIN		MerchantBlogArticles mbsource ON mbsource.MerchantID = mbcsource.MerchantID AND mbsource.Title = mbdest.Title AND mbsource.ExternalCode = mbdest.ExternalCode AND mbsource.Id_langue = mbdest.Id_langue
JOIN		MerchantBlogArticlesByCategories mbac ON mbac.merchantBlogArticleId = mbsource.Id AND mbac.merchantBlogCategoryId = mbcsource.Id
WHERE		mbcsource.MerchantID = @MerchantSourceId
AND			NOT EXISTS ( SELECT 1 FROM MerchantBlogArticlesByCategories mbac2 WHERE mbac2.MerchantBlogArticleID = mbdest.id AND mbac2.MerchantBlogCategoryID = mbcdest.id )

-- Insert articles by tags
INSERT INTO MerchantBlogArticlesByTags (MerchantBlogTagID, MerchantBlogArticleID)
SELECT		DISTINCT mbcdest.id AS merchantblogTagId, mbdest.id as merchantblogarticleid
FROM		@MerchantDestIds mdest 
JOIN		MerchantBlogTags mbcdest ON mbcdest.MerchantID = mdest.id 
JOIN		MerchantBlogTags mbcsource ON mbcsource.Tag = mbcdest.Tag AND mbcsource.Id_langue = mbcdest.Id_langue
JOIN		MerchantBlogArticles mbdest ON mbdest.MerchantID = mdest.id 
JOIN		MerchantBlogArticles mbsource ON mbsource.MerchantID = mbcsource.MerchantID AND mbsource.Title = mbdest.Title AND mbsource.ExternalCode = mbdest.ExternalCode AND mbsource.Id_langue = mbdest.Id_langue
JOIN		MerchantBlogArticlesByTags mbac ON mbac.merchantBlogArticleId = mbsource.Id AND mbac.merchantBlogTagId = mbcsource.Id
WHERE		mbcsource.MerchantID = @MerchantSourceId
AND			NOT EXISTS ( SELECT 1 FROM MerchantBlogArticlesByTags mbac2 WHERE mbac2.MerchantBlogArticleID = mbdest.id AND mbac2.MerchantBlogTagID = mbcdest.id )

-- Insert blog settings
INSERT INTO MerchantBlogSettings(MerchantBlogID, ShowArticleTitle, ShowArticleSummaryDescription, ShowBlogSocialTags, UseBlogAuthorProfile, NumberOfRelatedArticles, UseRSSFeed, AllowNewsletterSubscription, ShowRepresentativeImageIfAvailable, RepresentativeImageWidth, RepresentativeImageHeight)
SELECT		DISTINCT mbdest.id as merchantBlogId, mbs.ShowArticleTitle, mbs.ShowArticleSummaryDescription, mbs.ShowBlogSocialTags, mbs.UseBlogAuthorProfile, mbs.NumberOfRelatedArticles, mbs.UseRSSFeed, mbs.AllowNewsletterSubscription, mbs.ShowRepresentativeImageIfAvailable, mbs.RepresentativeImageWidth, mbs.RepresentativeImageHeight
FROM		@MerchantDestIds mdest 
JOIN		MerchantBlogs mbdest ON mbdest.merchantid = mdest.id 
JOIN		MerchantBlogs mbsource ON mbsource.name = mbdest.name 
JOIN		MerchantBlogSettings mbs ON mbs.merchantblogid = mbsource.id 
WHERE		mbsource.merchantid = @MerchantSourceId 
AND			NOT EXISTS ( SELECT 1 FROM MerchantBlogSettings mbs2 WHERE mbs2.merchantBlogId = mbdest.id )

-- Insert blog social tag info
INSERT INTO MerchantBlogSocialTagInfo (MerchantBlogId, OGSiteName)
SELECT		DISTINCT mbdest.id AS merchantblogId, m.merchant AS OGSiteName
FROM		@MerchantDestIds mdest
JOIN		MerchantBlogs mbdest ON mbdest.merchantid = mdest.id 
JOIN		MerchantBlogs mbsource ON mbsource.name = mbdest.name 
JOIN		Merchants m ON m.id = mdest.id
WHERE		mbsource.merchantid = @MerchantSourceId
AND			NOT EXISTS ( SELECT 1 FROM MerchantBlogSocialTagInfo mbsti2 WHERE mbsti2.merchantBlogId = mbdest.id )

-- Insert blog social article tag info
INSERT INTO MerchantBlogSocialArticleTagInfo (MerchantBlogID, MerchantBlogArticleID, Id_langue, MerchantBlogAuthorID, OGType, OGUrl, OGTitle, OGDescription, PinterestKeywords, OGImage, OGImageWidth, OGImageHeight, ArticlePublishedTime)
SELECT		DISTINCT mbdest.id AS MerchantBlogId
			, mbadest.id AS MerchantBlogArticleId
			, mbadest.id_langue
			, mbadest.MerchantBlogAuthorId
			, mbsati.OGType
			, REPLACE(REPLACE(mbsati.OGUrl, msource.merchant_url, ISNULL(tmpBSSites.domain, merdest.merchant_url)), '//', '/') AS OGUrl
			, mbsati.OGTitle
			, mbsati.OGDescription
			, mbsati.PinterestKeywords
			, mbsati.OGImage
			, mbsati.OGImageWidth
			, mbsati.OGImageHeight
			, mbsati.ArticlePublishedTime 
FROM		@MerchantDestIds mdest
JOIN		MerchantBlogs mbdest ON mbdest.merchantid = mdest.id 
JOIN		MerchantBlogs mbsource ON mbsource.name = mbdest.name 
JOIN		Merchants merdest ON merdest.id = mdest.id
JOIN		Merchants msource ON msource.id = mbsource.merchantId 
JOIN		MerchantBlogArticles mbasource ON mbasource.merchantBlogId = mbsource.id 
JOIN		MerchantBlogArticles mbadest ON mbadest.merchantBlogId = mbdest.id AND mbadest.title = mbasource.title AND mbadest.id_langue = mbasource.id_langue AND mbadest.externalCode = mbasource.externalCode 
JOIN		MerchantBlogSocialArticleTagInfo mbsati ON mbsati.merchantBlogArticleId = mbasource.id AND mbsati.MerchantBlogId = mbsource.id AND mbsati.id_langue = mbasource.id_langue
LEFT JOIN	 [datatail20130410].[bsc].[tempBSSites] tmpBSSites ON tmpBSSites.code = merdest.merchant_code
WHERE		mbsource.merchantid = @MerchantSourceId
AND			NOT EXISTS ( SELECT 1 FROM MerchantBlogSocialArticleTagInfo mbsati2 WHERE mbsati2.MerchantBlogArticleID = mbadest.id )

SELECT		*
FROM		merchants m 
JOIN		@MerchantDestIds mdest ON mdest.id = m.id 

COMMIT TRAN T1
