DECLARE @TargetId AS INT = 1680
DECLARE @MerchantCode AS VARCHAR(6) 
SELECT @MerchantCode = Merchant_Code FROM Merchants WHERE Id = @TargetId
--SELECT @MerchantCode

DECLARE @CatsByRetailer TABLE (
	Code VARCHAR(6),
	CatIds VARCHAR(MAX)
)

DECLARE @BrandsList AS TABLE (
	Code VARCHAR(6),
	Cie VARCHAR(100)
)

INSERT INTO @CatsByRetailer(Code, CatIds) VALUES
(@MerchantCode, '159,460,40,437,44,39,41,135,466,255,43,266,167,42,227,239,318,58,331,185,181,308,180,587,187,182,607,184,183,372,281,262,186,272,277,429,210,209,519,179,178,431,260,527,298,294,282,457,257,487,267,134,471,194,188,197,591,196,193,192,190,189,191,407,258,316,313,319,421,87,88,389,130,312,75,208,315,314,473,310,175,311')


INSERT INTO @BrandsList(Code, Cie) 
SELECT @MerchantCode AS Code, Cie FROM (VALUES ('Ashley'),('South Shore Nursery'),('Simmons'),('Sealy'),('Concept ZZZ'),('Springwall'),('Whirlpool'),('Maytag'),('KitchenAid'),('Amana'),('GE'),('Samsung'),('Bosch'),('Danby')) AS CC(Cie)



INSERT INTO MerchantDepartments(Merchant_Id,DepartmentId) 
SELECT	XD.Merchant_Id, XD.DeptId
FROM	
	(
		SELECT	DISTINCT M.Id AS Merchant_Id, C.DeptId AS DeptId
		FROM	Categories C
			JOIN @CatsByRetailer CR ON ',' + CR.CatIds + ',' LIKE '%,' + CAST(C.Id_Category AS VARCHAR(10)) + ',%' AND C.Id_Langue = 1
			JOIN Merchants M ON M.Merchant_Code = CR.Code
			JOIN Departments D ON D.Id_Dept = C.DeptId AND D.Id_Langue = 1
	) XD
	LEFT JOIN MerchantDepartments MD ON MD.Merchant_Id = XD.Merchant_Id AND MD.DepartmentId = XD.DeptId
WHERE MD.Id IS NULL

INSERT INTO MerchantCats(Merchant_Id,CatId,MerchantDepartmentId)
SELECT	M.Id AS Merchant_Id, C.Id_Category AS CatId, MD.Id AS MerchantDepartmentId
FROM	Categories C
	JOIN @CatsByRetailer CR ON ',' + CR.CatIds + ',' LIKE '%,' + CAST(C.Id_Category AS VARCHAR(10)) + ',%' AND C.Id_Langue = 1
	JOIN Merchants M ON M.Merchant_Code = CR.Code
	JOIN MerchantDepartments MD ON MD.Merchant_Id = M.Id AND MD.DepartmentId = C.DeptId
	LEFT JOIN MerchantCats MC ON MC. Merchant_Id = M.Id AND MC.CatId = C.Id_Category
WHERE MC.Id IS NULL

INSERT INTO MerchantBrands(Merchant_Id, CieId)
SELECT	DISTINCT M.Id AS Merchant_Id, COALESCE(C.Id_Cie,C2.Id_Cie) AS CieId --, L.Cie, C.Cie, 
FROM	@BrandsList L
	JOIN Merchants M ON M.Merchant_Code = L.Code
	LEFT JOIN [datatail20130410].[bsc].[Temp_BSBrandNames] N ON N.RawBrandName = L.Cie
	LEFT JOIN Companies C ON C.Cie = N.TailbaseBrandName AND C.typeID = 1
	LEFT JOIN Companies C2 ON C2.Cie = L.Cie AND C2.typeID = 1
	LEFT JOIN MerchantBrands MB ON MB.Merchant_Id = M.Id AND MB.CieId = COALESCE(C.Id_Cie,C2.Id_Cie)
WHERE MB.Id IS NULL AND COALESCE(C.Id_Cie,C2.Id_Cie) IS NOT NULL

INSERT INTO MerchantCatsBrands(Merchant_Id, CatId, CieId)
SELECT	DISTINCT M.Id AS Merchant_Id, MC.CatId, MB.CieId
FROM	@CatsByRetailer CR
	JOIN Merchants M ON M.Merchant_Code = CR.Code
	JOIN MerchantCats MC ON MC.Merchant_Id = M.Id 
	JOIN MerchantBrands MB ON MB.Merchant_Id = M.Id
	LEFT JOIN MerchantCatsBrands MCB ON MCB.Merchant_Id = M.Id AND MCB.CatId = MC.CatId AND MCB.CieId = MB.CieId
WHERE	MCB.Merchant_Id IS NULL
	AND EXISTS (
		SELECT 1 
		FROM MerchantCatsBrands CB 
			JOIN Merchants M1 ON M1.Id = CB.Merchant_Id
		WHERE CB.CatId = MC.CatId AND CB.CieId = MB.CieId
			AND M1.Active = 1
	)
	



