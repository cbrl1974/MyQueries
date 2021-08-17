DECLARE @TargetId AS INT = [merchantid]

UPDATE M SET M.relatedProducts = 1
--SELECT	*
FROM	Merchants M
WHERE	M.Id = @TargetId
