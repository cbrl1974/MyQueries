DECLARE @MerchantId INT = 1706
DECLARE @LanguageId INT = 1

SELECT 		Id 
			,Position 
			,PartCode 
			,Value 
			,DisplayText
			,PartId
			,ImageSourceId
			,ImageSource
			,ModificationDate
FROM 		(
	SELECT		sse.Id
				,sse.Position
				,ssep.PartCode
				,ssep.Description AS DisplayText
				,ssep.Id AS PartId 
				,ssew.ImageSourceId 
				,ssew.ImageSource
				,CASE WHEN ssep.PartCode = 'image' THEN 
					CASE WHEN ib.FileName IS NOT NULL THEN 
						'toolSSURLImagePath' + CAST(sse.MerchantId AS VARCHAR(100)) + '/' + ib.FileName
						ELSE 'toolSSURLImagePath' + tt.Text
						END
					ELSE CASE WHEN sse.Id_langue = 1 THEN mwt.content_1 ELSE mwt.content_2 END
					END AS Value
				,CASE WHEN ssep.PartCode = 'image' THEN 
						CASE WHEN ib.FileName IS NOT NULL THEN 
						ib.ModificationDate
						ELSE GETDATE()
						END 
					ELSE mwt.ModificationDate
					END AS modificationdate
	FROM		MerchantSSElements sse
	JOIN		MerchantSSElementsInWebsite ssew ON ssew.MerchantSSElementId = sse.Id 
	JOIN		MerchantSSElementParts ssep ON ssep.Id = ssew.MerchantSSPartId 
	JOIN		MerchantWebsiteTexts mwt ON mwt.Id = ssew.MerchantWebsiteTextId 
	LEFT JOIN	MerchantImageBank ib ON ib.merchantId = sse.MerchantId AND ssew.ImageSource = 'merchantimagebank' AND ssew.ImageSourceId = ib.Id
	LEFT JOIN	MerchantTemplateTexts tt ON ssew.ImageSource = 'tbimagebank' AND ssew.ImageSourceId = tt.Id
	WHERE		sse.MerchantId = @MerchantId 
	AND			sse.Id_langue = @LanguageId 
) AS tmp 
ORDER BY 	Position, Id, PartCode


