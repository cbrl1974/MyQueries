--USE StagingTailbaseCore

BEGIN TRAN T1

DECLARE @TargetId INT = 2254
DECLARE @SourceId INT = 1210 -- BRANDSOURCE 
DECLARE @ResetAll INT = 1

DECLARE @tmpSectors TABLE (
	Sector		VARCHAR(200) NOT NULL,
	PRIMARY KEY (Sector)
);

INSERT INTO  @tmpSectors
SELECT		'Furniture'		WHERE 1 = 1
UNION 
SELECT		'Mattresses'	WHERE 1 = 1
UNION 
SELECT		'Living'		WHERE 1 = 0
UNION 
SELECT		'Dining'		WHERE 1 = 0
UNION 
SELECT		'Bedroom'		WHERE 1 = 0
UNION 
SELECT		'Appliances'	WHERE 1 = 1
UNION 
SELECT		'Kitchen'		WHERE 1 = 0
UNION 
SELECT		'Laundry'		WHERE 1 = 0
UNION 
SELECT		'Outdoor Kichen' WHERE 1 = 0
UNION 
SELECT		'Electronics'	WHERE 1 = 0

DELETE FROM MerchantCats WHERE merchant_id = @TargetId AND @ResetAll = 1
DELETE FROM MerchantDepartments WHERE merchant_id = @TargetId AND @ResetAll = 1
DELETE FROM	MerchantSectors WHERE merchant_id = @TargetId AND @ResetAll = 1
DELETE FROM MerchantCatsBrands WHERE merchant_id = @TargetId AND @ResetAll = 1

INSERT INTO MerchantSectors (merchant_id, sector_1, sector_2, display_order)
SELECT		@TargetId, sector_1, sector_2, display_order
FROM		MerchantSectors ms
JOIN		@tmpSectors ts ON ts.Sector = ms.sector_1
WHERE		ms.merchant_id = @SourceId
AND			NOT EXISTS (SELECT 1 FROM MerchantSectors WHERE merchant_id = @TargetId AND sector_1 = ms.sector_1)

INSERT INTO MerchantDepartments (merchant_id, departmentid, department_1, department_2, display_order, merchantsectorid, displaycollection)
select		@TargetId, mds.departmentid, mds.department_1, mds.department_2, mds.display_order, msd.id, mds.displaycollection
from		merchantdepartments mds 
join		merchantsectors mss ON mss.id = mds.merchantsectorid --OR isnull(mds.department_1, '') = 'Mattresses'
join		merchantsectors msd on msd.sector_1 = mss.sector_1
JOIN		@tmpSectors ts ON ts.Sector = mss.sector_1
where		msd.merchant_id = @TargetId
and			mds.merchant_id = @SourceId
and			mss.merchant_id = @SourceId
AND			NOT EXISTS (SELECT 1 FROM MerchantDepartments WHERE merchant_id = @TargetId AND departmentid = mds.departmentid)

-- COPY MATTRESSES DEPT
insert into MerchantDepartments (merchant_id, department_1, department_2, display_order, departmentid, showIconInNavigation, dateCreation, dateModification, showGallery, showTransitionPage, displayCollection)
select		@targetId, department_1, department_2, display_order, departmentid, showIconInNavigation, getdate(), getdate(), showGallery, showTransitionPage, displayCollection
from		merchantDepartments 
where merchant_id = @SourceId and department_1 = 'Mattresses'
AND NOT EXISTS (SELECT 1 FROM MerchantDepartments WHERE merchant_id = @TargetId AND ISNULL(department_1, '') = 'Mattresses')
AND EXISTS (SELECT 1 FROM @tmpSectors WHERE Sector = 'Mattresses')

-- Copy all categories except from the ones from Mattresses
INSERT INTO MerchantCats(merchant_id, catid, manufs, merchantdepartmentid, display_order, category_1, category_2)
select		distinct mdd.merchant_id, mcs.catid, mcs.manufs, mdd.id as merchantdepartmentid, mcs.display_order, mcs.category_1, mcs.category_2
from		merchantdepartments mds 
join		merchantsectors mss ON mss.id = mds.merchantsectorid
join		merchantcats mcs ON mcs.merchantdepartmentid = mds.id and mcs.merchant_id = mds.merchant_id
join		merchantdepartments mdd on mdd.departmentid = mds.departmentid AND isnull(mdd.department_1, '') = isnull(mds.department_1,'') 
join		merchantsectors msd on msd.sector_1 = mss.sector_1
JOIN		@tmpSectors ts ON ts.Sector = mss.sector_1
where		msd.merchant_id = @TargetId
and			mds.merchant_id = @SourceId
and			mdd.merchant_id = @TargetId
and			mss.merchant_id = @SourceId
and not exists (select 1 from merchantcats where merchant_id = msd.merchant_id and catid = mcs.catid)

-- Copy Mattresses categories
INSERT INTO MerchantCats(merchant_id, catid, manufs, merchantdepartmentid, display_order, category_1, category_2)
select		mdd.merchant_id, mcs.catid, mcs.manufs, mdd.id, mcs.display_order, mcs.category_1, mcs.category_2
from		merchantDepartments mds
join		merchantCats mcs on mcs.merchantdepartmentid = mds.id 
join		merchantDepartments mdd on mdd.departmentid = mds.departmentid and isnull(mdd.department_1, '') = isnull(mds.department_1,'') 
--join		merchantCats mcd on mcd.merchant_id = mdd.merchant_id and mcd.catid = mcs.catid 
where		isnull(mdd.department_1, '') = 'Mattresses'
and			mds.merchant_id = @SourceId
and			mdd.merchant_id = @TargetId
and			not exists (select 1 from merchantCats mc where mc.merchant_id = mdd.merchant_id and mc.catid = mcs.catid)
AND EXISTS (SELECT 1 FROM @tmpSectors WHERE Sector = 'Mattresses')

INSERT INTO MerchantCatsBrands (merchant_id, catid, cieid)
SELECT		DISTINCT mc.merchant_id, mc.catid, p.manufid
FROM		categories cat 
JOIN		products p ON p.catid = cat.id_category AND cat.id_langue = 1
JOIN		MerchantCats mc ON mc.catid = cat.id_category 
JOIN		MerchantBrands mb ON mb.merchant_id = mc.merchant_id AND mb.cieid = p.manufid
WHERE		mc.merchant_id = @TargetId
AND NOT EXISTS (SELECT 1 FROM MerchantCatsBrands WHERE merchant_id = mc.merchant_id AND catid = mc.catid AND cieId = p.manufid)

SELECT * FROM MerchantSectors WHERE merchant_id = @TargetId
SELECT		d.id_dept, d.dept, md.* 
FROM		MerchantDepartments md 
LEFT JOIN	Departments d ON d.id_dept = md.departmentId and d.id_langue = 1
WHERE merchant_id = @TargetId
--SELECT * FROM MerchantCats WHERE merchant_id = @TargetId

select		mds.id as deptSource, mdd.id as deptDest
from		merchantdepartments mds 
join		merchantsectors mss ON mss.id = mds.merchantsectorid
join		merchantdepartments mdd on mdd.departmentid = mds.departmentid AND isnull(mdd.department_1, '') = isnull(mds.department_1,'') 
join		merchantsectors msd on msd.sector_1 = mss.sector_1
where		msd.merchant_id = @TargetId
and			mds.merchant_id = @SourceId
and			mdd.merchant_id = @TargetId
and			mss.merchant_id = @SourceId

COMMIT TRAN T1