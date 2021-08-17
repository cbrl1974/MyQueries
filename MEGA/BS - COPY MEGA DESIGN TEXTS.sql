DECLARE @TargetId AS INT = 1572
 
DELETE
FROM	MerchantWebsiteTexts
WHERE	Merchant_Id = @TargetId
AND TextCode NOT IN ('askanexpertformemail','contactformemail','homeaboutus','newslettersignup','quoterequestemail')

INSERT INTO MerchantWebsiteTexts(Merchant_Id, TextCode, Content_1, Content_2, Id_Langue)
SELECT	@TargetId, TextCode, Content_1, Content_2, Id_Langue
FROM	MerchantWebsiteTexts
WHERE	Merchant_Id = 1210