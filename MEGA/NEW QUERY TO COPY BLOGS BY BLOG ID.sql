use datatail20130410
DECLARE @MerchantId AS INT = 2791;


select * from MerchantBlogs where merchantid = 2791

select * from  MerchantBlogArticles where id = 6165 --(get the articleid)

select * from MerchantBlogTags where merchantblogid = 253 -- (has to be merchantblogid)

select * from MerchantBlogTexts where merchantblogid = 253 -- (has to be merchantblogid)

select * from MerchantBlogArticlesByCategories where MerchantBlogArticleID = 6165  --(has to be MerchantBlogArticleID)

select * from MerchantBlogArticlesByCategories where MerchantBlogArticleID = 6165  --(has to be MerchantBlogArticleID)

select * from merchantBlogArticlesByTags where MerchantBlogArticleID = 6165  --(has to be MerchantBlogArticleID)

select * from MerchantBlogRelatedArticles  where MerchantBlogArticleID = 6165  --(has to be MerchantBlogArticleID)

select * from MerchantBlogCategories where merchantblogid = 253 -- (has to be merchantblogid)

select * from MerchantBlogAuthors where merchantblogid = 253 -- (has to be merchantblogid)

select * from MerchantBlogSettings where merchantblogid = 253 -- (has to be merchantblogid) 










