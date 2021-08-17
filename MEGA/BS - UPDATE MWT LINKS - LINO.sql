DECLARE @TargetId AS INT = 1679

DECLARE @MIds TABLE (
	Id INT
)

INSERT INTO @MIds(Id) VALUES (@TargetId)

;WITH LinksData AS (
	SELECT	CASE WHEN SUBSTRING(T5.PreId1, 1, 2) = 'co' THEN 'co' ELSE '' END AS IdPrefix1,
			CASE WHEN SUBSTRING(T5.PreId2, 1, 2) = 'co' THEN 'co' ELSE '' END AS IdPrefix2,
			REPLACE(T5.PreId1, 'co', '') AS Id1,
			REPLACE(T5.PreId2, 'co', '') AS Id2,
			*
	FROM (
		SELECT	CASE WHEN T4.Page1_ED > 0 THEN SUBSTRING(T4.Rest1, 1, Page1_ED - 1) END Page1,
				CASE WHEN T4.Page2_ED > 0 THEN SUBSTRING(T4.Rest2, 1, Page2_ED - 1) END Page2,
				CASE WHEN T4.Page1_ED > 0 THEN SUBSTRING(T4.Rest1, Page1_ED + 1, Id1_ED - Page1_ED - 1) END PreId1,
				CASE WHEN T4.Page2_ED > 0 THEN SUBSTRING(T4.Rest2, Page2_ED + 1, Id2_ED - Page2_ED - 1) END PreId2,
				SUBSTRING(T4.Rest1, Id1_ED + 1, 8000) Slug1,
				SUBSTRING(T4.Rest2, Id2_ED + 1, 8000) Slug2,
				*
		FROM (
			SELECT	ISNULL(CHARINDEX('/', T3.Rest1, 1), 0) Page1_ED, /* Page Type End Delimiter */
					ISNULL(CHARINDEX('/', T3.Rest2, 1), 0) Page2_ED, /* Page Type End Delimiter */
					ISNULL(CHARINDEX('-', T3.Rest1, 1), 0) Id1_ED, /* ID End Delimiter */
					ISNULL(CHARINDEX('-', T3.Rest2, 1), 0) Id2_ED, /* ID End Delimiter */
					*
			FROM (
				SELECT	CASE WHEN ISNULL(T2.Content1,'') != '' THEN SUBSTRING(T2.Content1, 1, Domain1_ED - 1) END Domain1,
						CASE WHEN ISNULL(T2.Content2,'') != '' THEN SUBSTRING(T2.Content2, 1, Domain2_ED - 1) END Domain2,
						SUBSTRING(T2.Content1, Domain1_ED + 1, 2) Lang1,
						SUBSTRING(T2.Content2, Domain2_ED + 1, 2) Lang2,
						SUBSTRING(T2.Content1, Domain1_ED + 4, 8000) Rest1,
						SUBSTRING(T2.Content2, Domain2_ED + 4, 8000) Rest2,
						*
				FROM (
					SELECT	
							ISNULL(CHARINDEX('/', T1.Content1, 8), 0) Domain1_ED, /* Domain End Delimiter */
							ISNULL(CHARINDEX('/', T1.Content2, 8), 0) Domain2_ED, /* Domain End Delimiter */
							*
					FROM (
						SELECT	CAST(T.Content_1 AS VARCHAR(MAX)) Content1, 
								CAST(T.Content_2 AS VARCHAR(MAX)) Content2,
								M.*,
								T.Textcode,
								T.Id AS TId,
								CMS.languages AS ValidLanguages
						FROM	@MIds Ids 
							JOIN Merchants M ON M.Id = Ids.Id 
							JOIN MerchantCMS CMS ON CMS.Merchant_id = M.Id
							JOIN MerchantWebsiteTexts T ON T.Merchant_Id = M.Id
						WHERE T.Textcode like '%Link'
					) T1
					WHERE ( 
						ISNULL(T1.Content1, '') != ''
						OR
						ISNULL(T1.Content2, '') != ''
					)
				) T2
			) T3
			WHERE (
				T3.ValidLanguages IN ('en,fr', 'fr,en')
				AND
				(
					T3.Rest1 LIKE 'catalog/%' OR T3.Rest1 LIKE 'blog/%'
					OR
					T3.Rest2 LIKE 'catalog/%' OR T3.Rest2 LIKE 'blog/%'
				)
				OR
				T3.ValidLanguages IN ('en')
				AND
				(
					T3.Rest1 LIKE 'catalog/%' OR T3.Rest1 LIKE 'blog/%'
				)
				OR
				T3.ValidLanguages IN ('fr')
				AND
				(
					T3.Rest2 LIKE 'catalog/%' OR T3.Rest2 LIKE 'blog/%'
				)
			)
		) T4
	) T5
)

UPDATE MT
SET MT.Content_1 = REPLACE(REPLACE(D.merchant_url + '/' + D.Lang1 + '/' + D.Page1 + '/' + D.IdPrefix1 + CAST(COALESCE(MDr1.Id, BAr1.Id) AS VARCHAR(50)) + '-' + D.Slug1, '//', '/'), ':/', '://'),
	MT.content_2 = REPLACE(REPLACE(D.merchant_url + '/' + D.Lang2 + '/' + D.Page2 + '/' + D.IdPrefix2 + CAST(COALESCE(MDr2.Id, BAr2.Id) AS VARCHAR(50)) + '-' + D.Slug2, '//', '/'), ':/', '://')

--SELECT	D.TId,
--		D.merchant_url,
--		D.Domain1,
--		D.Domain2,
--		D.Lang1,
--		D.Lang2,
--		D.Page1,
--		D.Page2,
--		D.IdPrefix1,
--		D.IdPrefix2,
--		COALESCE(MDr1.Id, BAr1.Id),
--		COALESCE(MDr2.Id, BAr2.Id),
--		D.Slug1,
--		D.Slug2,
--		COALESCE(MD1.Merchant_Id, BA1.MerchantId),
--		COALESCE(MD2.Merchant_Id, BA2.MerchantId),
--		REPLACE(REPLACE(D.merchant_url + '/' + D.Lang1 + '/' + D.Page1 + '/' + D.IdPrefix1 + CAST(COALESCE(MDr1.Id, BAr1.Id) AS VARCHAR(50)) + '-' + D.Slug1, '//', '/'), ':/', '://') NewContent1,
--		REPLACE(REPLACE(D.merchant_url + '/' + D.Lang2 + '/' + D.Page2 + '/' + D.IdPrefix2 + CAST(COALESCE(MDr2.Id, BAr2.Id) AS VARCHAR(50)) + '-' + D.Slug2, '//', '/'), ':/', '://') NewContent2,
--		MT.*
		
FROM	MerchantWebsiteTexts MT
	JOIN LinksData D ON D.TId = MT.Id
	JOIN MerchantCMS CMS ON CMS.Merchant_Id = D.Id
	LEFT JOIN MerchantDepartments MD1 ON MD1.Id = D.Id1 AND D.Page1 = 'catalog'
	LEFT JOIN MerchantDepartments MD2 ON MD2.Id = D.Id2 AND D.Page2 = 'catalog'
	LEFT JOIN MerchantDepartments MDr1 ON MDr1.Merchant_Id = D.Id AND MDr1.DepartmentId = MD1.DepartmentId AND MDr1.DisplayCollection = MD1.DisplayCollection 
	LEFT JOIN MerchantDepartments MDr2 ON MDr2.Merchant_Id = D.Id AND MDr2.DepartmentId = MD2.DepartmentId AND MDr2.DisplayCollection = MD2.DisplayCollection 
	LEFT JOIN MerchantBlogArticles BA1 ON BA1.Id = D.Id1 AND D.Page1 = 'blog' AND BA1.Id_langue = 1
	LEFT JOIN MerchantBlogArticles BA2 ON BA2.Id = D.Id2 AND D.Page2 = 'blog' AND BA2.Id_langue = 2
	LEFT JOIN MerchantBlogArticles BAr1 ON BAr1.MerchantID = D.Id AND BAr1.Title = BA1.Title AND BAr1.Id_langue = BA1.Id_langue
	LEFT JOIN MerchantBlogArticles BAr2 ON BAr2.MerchantID = D.Id AND BAr2.Title = BA2.Title AND BAr2.Id_langue = BA2.Id_langue
WHERE 
	(
		CMS.Languages IN ('en,fr', 'fr,en')
		AND
		(
			REPLACE(D.merchant_url, '/', '') != REPLACE(D.Domain1, '/', '')
			OR
			REPLACE(D.merchant_url, '/', '') != REPLACE(D.Domain2, '/', '')
		)
		OR
		CMS.Languages IN ('en')
		AND
		(
			REPLACE(D.merchant_url, '/', '') != REPLACE(D.Domain1, '/', '')
		)
		OR
		CMS.Languages IN ('fr')
		AND
		(
			REPLACE(D.merchant_url, '/', '') != REPLACE(D.Domain2, '/', '')
		)
	) 
	OR	
	(
		CMS.Languages IN ('en,fr', 'fr,en')
		AND
		(
			D.Id1 != COALESCE(MDr1.Id, BAr1.Id)
			OR
			D.Id2 != COALESCE(MDr2.Id, BAr2.Id)
		)
		OR
		CMS.Languages IN ('en')
		AND
		(
			D.Id1 != COALESCE(MDr1.Id, BAr1.Id)
		)
		OR
		CMS.Languages IN ('fr')
		AND
		(
			D.Id2 != COALESCE(MDr2.Id, BAr2.Id)
		)
	)