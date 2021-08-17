DECLARE @TargetId AS INT = 2302 
DECLARE @GACode AS VARCHAR(20) = 'UA-28408132-2' 

DECLARE @GAScriptStart AS VARCHAR(MAX) = '<script>var _gaUARetailerCode = "'
DECLARE @GAScriptEnd AS VARCHAR(MAX) = '";</script>'
DECLARE @GTMScript AS VARCHAR(MAX) = ''

UPDATE T SET T.content_1 = @GAScriptStart + @GACode + @GAScriptEnd, T.content_2 = @GAScriptStart + @GACode + @GAScriptEnd
FROM Merchants M 
LEFT JOIN MerchantWebsiteTexts T ON T.Merchant_Id = M.Id AND T.TextCode = 'headScript'
WHERE M.Id = @TargetId
AND T.Id IS NOT NULL

INSERT INTO MerchantWebsiteTexts(merchant_id, textcode, content_1, content_2, Id_langue)
SELECT M.Id, 'headScript', @GAScriptStart + @GACode + @GAScriptEnd, @GAScriptStart + @GACode + @GAScriptEnd, 1
FROM Merchants M
LEFT JOIN MerchantWebsiteTexts T ON T.Merchant_Id = M.Id AND T.TextCode = 'headScript'
WHERE M.Id = @TargetId
AND T.Id IS NULL

UPDATE T SET T.content_1 = @GTMScript, T.content_2 = @GTMScript
FROM Merchants M 
LEFT JOIN MerchantWebsiteTexts T ON T.Merchant_Id = M.Id AND T.TextCode = 'googleanalyticscode'
WHERE M.Id = @TargetId
AND T.Id IS NOT NULL

INSERT INTO MerchantWebsiteTexts(merchant_id, textcode, content_1, content_2, Id_langue)
SELECT M.Id, 'googleanalyticscode', @GTMScript, @GTMScript, 1
FROM Merchants M 
LEFT JOIN MerchantWebsiteTexts T ON T.Merchant_Id = M.Id AND T.TextCode = 'googleanalyticscode'
WHERE M.Id = @TargetId
AND T.Id IS NULL

select * from  MerchantWebsiteTexts where merchant_id = 2302 and textcode in ('headScript','googleanalyticscode')

delete top (1)  from  MerchantWebsiteTexts where merchant_id = 2302 and id = 213536
