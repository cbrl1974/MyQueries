DECLARE @TargetId AS INT = 1680

UPDATE MC 
SET MC.Display_Order = MC_S.Display_Order
FROM	MerchantCats MC
	JOIN MerchantDepartments MD ON MC.MerchantDepartmentId = MD.Id
	LEFT JOIN (
		MerchantCats MC_S
		JOIN MerchantDepartments MD_S ON MC_S.MerchantDepartmentId = MD_S.Id
	) ON MC_S.Merchant_Id = 1210 AND MD_S.DepartmentId = MD.DepartmentId AND MC_S. CatId = MC.CatId
WHERE	MC.Merchant_Id = @TargetId
AND ISNULL(MC.Display_Order, 0) != ISNULL(MC_S.Display_Order, 0)
AND MC_S.Display_Order IS NOT NULL