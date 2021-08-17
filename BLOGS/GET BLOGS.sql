	SELECT 		mba.ID 
						,mba.Title
						,mba.MetaTitle
						,mba.MetaDescription
						,mba.Content
						,mba.ModificationDate AS PostDate
						,'' AS Tags
						,'' AS Categories
						,'' AS CategoryList
						,ISNULL(mba.summaryDescription, mba.metaDescription) AS summaryDescription
						,mbau.ID AS AuthorID
						,mbau.Name AS AuthorName 
						,mbau.Title AS AuthorTitle 
						,mbau.Email AS AuthorEmail 
						,mbau.TwitterProfileLink AS AuthorTwitterProfileLink 
						,mbau.FacebookProfileLink AS AuthorFacebookProfileLink 
						,mbau.Biography AS AuthorBiography
						,'' AS ArticleURL
			FROM 		MerchantBlogArticles mba
			
			INNER JOIN 	Merchants m ON m.id = mba.MerchantID  
			LEFT JOIN 	MerchantBlogArticlesByCategories mbac ON mbac.MerchantBlogArticleID = mba.ID
			LEFT JOIN 	MerchantBlogCategories mbc ON mbc.ID = mbac.MerchantBlogCategoryID AND mbc.Active = 1
			LEFT JOIN 	MerchantBlogArticlesByTags mbat ON mbat.MerchantBlogArticleID = mba.ID 
			LEFT JOIN 	MerchantBlogTags mbt ON mbt.ID = mbat.MerchantBlogTagID AND mbt.Active = 1
			LEFT JOIN 	MerchantBlogAuthors mbau ON mbau.id = mba.MerchantBlogAuthorID 
			LEFT JOIN 	MerchantBlogs mb ON mb.id = mba.merchantBlogID
			WHERE 		mba.MerchantID = 1289
			AND 		mba.Status = 1
			AND 		mba.id_langue = 1
			--AND 		mba.ModificationDate <= GETDATE()
		
			GROUP BY 	mba.ID
						,mba.Title
						,mba.MetaTitle
						,mba.MetaDescription
						,mba.Content
						,mba.ModificationDate
						,mba.summaryDescription
						,mbau.ID
						,mbau.Name 
						,mbau.Title 
						,mbau.Email 
						,mbau.TwitterProfileLink 
						,mbau.FacebookProfileLink 
						,mbau.Biography 
			ORDER BY PostDate DESC