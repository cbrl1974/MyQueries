-- PLEASE BE VERY CAREFUL ON UPDATING THIS QUERY
-- WHEN RUNNIG THIS QUERY BE SURE THAT YOU ARE SELECTING THE WHERE CLAUSE OR BAD THINGS WILL HAPPEN
DELETE SP
FROM SpecsProd SP
	JOIN (
		SELECT	ISP.ID
				, ROW_NUMBER() OVER(PARTITION BY ISP.ProductId, ISP.SpecId ORDER BY ISP.ID) AS RowN 
		FROM	SpecsProd ISP --INNER SPECS PROD
		WHERE	1 = 1 
			--AND ProductID = 207535 /* UNCOMMENT THIS AND PUT THE PROPER PRODUCT ID TO DELETE REPEATED SPECS FOR A SINGLE PRODUCT */
	) ENUM ON ENUM.ID = SP.ID
WHERE ENUM.RowN > 1 -- THIS COLUMN RowN SHOULD BE ALWAYS 1, IF NOT THEN THE CORRESPONDING SPEC IS A REPEATED ONE, SO WE NEED TO DELETE IT

