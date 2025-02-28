SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME like '%blog%'






SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = N'merchantcms'






SELECT
  sys.columns.name AS ColumnName,
  tables.name AS TableName
FROM
  sys.columns
JOIN sys.tables ON
  sys.columns.object_id = tables.object_id
WHERE
  sys.columns.name like '%tracktail%'

  select top 10 * from MerchantProductInfo where merchantid = 645
    select id_cie, tracktail, productmall  from Companies where id_cie in (1513,2551,6169,6620,7878,7905)
	select * from companies where cie like '%ta appliance%'
	select top 10 * from users where id_cie  in (1513,2551,6169,6620,7878,7905)
	select * from categories where id_category in (36,389)and id_langue = 1

	update top (2) categories 
	set tracktail = 1
	where id_category in (36,389)




SELECT 
    OBJECT_NAME(OBJECT_ID) AS ProcedureName,
    definition
FROM 
    sys.sql_modules
WHERE 
    definition LIKE '%hasactiverebate%'
    AND OBJECTPROPERTY(OBJECT_ID, 'IsProcedure') = 1;

	SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'cieid'
AND (TABLE_SCHEMA LIKE '%Tracktail%' OR TABLE_NAME LIKE '%Tracktail%');



--Query to get all columns except specific ones
DECLARE @cols NVARCHAR(MAX)
SELECT @cols = STRING_AGG(name, ', ')
FROM sys.columns
WHERE object_id = OBJECT_ID('merchantCMS') 
AND name <> 'storetemplate'
AND name <> 'storetemplate_2'

DECLARE @query NVARCHAR(MAX)
SET @query = 'SELECT TOP 1 ' + @cols + ' FROM merchantCMS WHERE merchant_id = 1448'

EXEC sp_executesql @query


