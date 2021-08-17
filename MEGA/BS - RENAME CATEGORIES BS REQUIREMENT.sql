DECLARE @TargetId AS INT = 1680

-- UPDATE CATEGORIES BS REQUIREMENT
UPDATE MC SET MC.category_1 = BC.NewCategoryEN, MC.category_2 = BC.NewCategoryFR
FROM MerchantCats MC
JOIN  [datatail20130410].[bsc].[Temp_BS_Cats] BC ON MC.catID = BC.CategoryID
WHERE MC.Merchant_ID = @TargetId
AND
(
	BC.NewCategoryEN IS NOT NULL
	OR
	BC.NewCategoryFR IS NOT NULL
)


-- UPDATE DEPARTMENTS BS REQUIREMENT
DECLARE @BSDepartments TABLE (
	ID INT,
	NewDepartmentEN VARCHAR(50),
	NewDepartmentFR VARCHAR(50)
)

INSERT INTO @BSDepartments VALUES 
(25, NULL, 'Salon')

UPDATE MD SET MD.department_1 = BD.NewDepartmentEN, MD.department_2 = BD.NewDepartmentFR
FROM MerchantDepartments MD
JOIN @BSDepartments BD ON MD.DepartmentID = BD.ID
WHERE MD.Merchant_ID = @TargetId
AND
(
	BD.NewDepartmentEN IS NOT NULL
	OR
	BD.NewDepartmentFR IS NOT NULL
)
	