 DECLARE @TargetId AS INT = 2112
 DECLARE @LiveDomain AS VARCHAR(100) = 'https://www.brandsourcedaigneault.ca/'  -- Example here (keep the '/' at the end)

  
INSERT INTO  [datatail20130410].[bsc].[tempBSSites](Code, [Path], Domain)
SELECT LOWER(M.Merchant_Code), M.Filepath, @LiveDomain 
FROM Merchants M
LEFT JOIN [datatail20130410].[bsc].[tempBSSites] T ON T.Code = M.Merchant_Code
WHERE M.Id = @TargetId
AND T.Code IS NULL


select * from  [datatail20130410].[bsc].[tempBSSites] where code = 'ABSDGN'
