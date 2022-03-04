use datatail20130410
DECLARE @MerchantId AS INT = 1832;


select * from MerchantBlogs where merchantid = @MerchantId

select * from  MerchantBlogArticles where merchantid = 3388 --(get the articleid)

select * from MerchantBlogTags where merchantblogid = 261 -- (has to be merchantblogid)

select * from MerchantBlogTexts where merchantblogid = 261 -- (has to be merchantblogid)

select * from MerchantBlogArticlesByCategories 
where MerchantBlogArticleID in (select id from  MerchantBlogArticles where merchantid = 3388)  --(has to be MerchantBlogArticleID)

select * from MerchantBlogArticlesByCategories
where MerchantBlogArticleID in (select id from  MerchantBlogArticles where merchantid = 3388) --(has to be MerchantBlogArticleID)

select * from merchantBlogArticlesByTags
where MerchantBlogArticleID in (select id from  MerchantBlogArticles where merchantid = 3388) --(has to be MerchantBlogArticleID)

select * from MerchantBlogRelatedArticles  
where MerchantBlogArticleID in (select id from  MerchantBlogArticles where merchantid = 3388) --(has to be MerchantBlogArticleID)

select * from MerchantBlogCategories where merchantblogid = 261 -- (has to be merchantblogid)

select * from MerchantBlogAuthors where merchantblogid = 261 -- (has to be merchantblogid)

select * from MerchantBlogSettings where merchantblogid = 226 -- (has to be merchantblogid) 










