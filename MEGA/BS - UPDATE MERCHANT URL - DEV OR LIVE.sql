DECLARE @TargetId AS INT = 1680
DECLARE @Env AS VARCHAR(10) = 'DEV' --'DEV' OR 'LIVE'

UPDATE M SET M.Merchant_Url = CASE WHEN @Env = 'LIVE' THEN S.Domain ELSE 'http://' + lower(M.Merchant_Code) + '.tm3.tailbase.com/' END
FROM Merchants M
	JOIN [datatail20130410].[bsc].[tempBSSites] S ON S.Code = M.Merchant_Code
WHERE 
	M.Id = @TargetId


	select Merchant_Url from Merchants where id = 1680



	