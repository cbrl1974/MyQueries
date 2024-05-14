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
  sys.columns.name like '%auto%'

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