DECLARE @TargetId AS INT = 1679

--UPDATE T1 SET T1.Content_2 = REPLACE(T1.Content2,'http://'+ lower(T1.Merchant_Code) +'.tm3.tailbase.com/',T1.Merchant_Url)
--UPDATE T1 SET T1.Content_2 = REPLACE(T1.Content2,'http://www.brandsource.ca/',T1.Merchant_Url)
--UPDATE T1 SET T1.Content_2 = REPLACE(T1.Content2,'http://www.tailbase.com',T1.Merchant_Url)
--SELECT	REPLACE(T1.Content2,'http://'+ lower(T1.Merchant_Code) +'.tm3.tailbase.com/',T1.Merchant_Url), *
--SELECT	REPLACE(T1.Content2,'http://www.brandsource.ca/',T1.Merchant_Url), *
SELECT	REPLACE(T1.Content1,'http://'+ lower(T1.Merchant_Code) +'.tm3.tailbase.com/',T1.Merchant_Url), T1.TextCode,
			T1.Content_1, 
			T1.Content_2
FROM (
	SELECT	M.*,
			T.TextCode,
			T.Content_1, 
			T.Content_2, 
			CAST(T.Content_1 AS VARCHAR(MAX)) Content1, 
			CAST(T.Content_2 AS VARCHAR(MAX)) Content2
	FROM Merchants M
		JOIN MerchantWebsiteTexts T ON T.Merchant_Id = M.Id
	--WHERE M.Id = @TargetId
) T1
WHERE T1.Content1 LIKE '%revlocal.com%'

