SELECT * FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME like '%blog%'


SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = N'shopifyMerchantConfigurations'

SELECT
  sys.columns.name AS ColumnName,
  tables.name AS TableName
FROM
  sys.columns
JOIN sys.tables ON
  sys.columns.object_id = tables.object_id
WHERE
  sys.columns.name like '%blog%'

