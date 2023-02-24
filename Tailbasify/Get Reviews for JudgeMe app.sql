DECLARE @MerchantID as int = 1911;
DECLARE @TotalLimit as int = 20000;

SELECT  distinct 
    --top (@TotalLimit) --limits the download time. Remove or comment this line if you all
    r.id,
     r.ReviewTitle as 'title',
    r.ReviewText as 'body',
    r.OverallRating AS rating,    
	CONVERT(VARCHAR(33), r.CreationDate, 126) AS 'review_date',
	CASE WHEN ru.Nickname IS NULL
		THEN 'Anonymous'
	ELSE
		ru.Nickname
	END AS 'reviewer_name',
    '' as 'reviewer_email',
    prods.productid as 'product_id',
    s.handle as 'product_handle',
    '' as 'reply',
    '' as 'picture_urls'	
FROM Reviews r
INNER JOIN ReviewsUsers ru ON r.ReviewsUserID = ru.id
INNER JOIN [dbo].[fn_GetMerchantProductsWithCollectionProducts](@MerchantID) prods ON prods.productid = r.ItemID
INNER JOIN Merchants m ON m.ID = prods.MerchantId
INNER JOIN tailbasify.shopify.shopifyProducts s on s.tailbaseid = prods.productid and s.itemtype = 1
WHERE r.Id_langue = 1
and r.ReviewTitle is not null 
and r.ReviewTitle != ''
and r.ReviewText is not null  
and r.ReviewText != ''
order by review_date desc, product_id
