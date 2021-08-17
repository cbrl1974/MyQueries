--SEARCH EXISTING COLUMNS

SELECT
  sys.columns.name AS ColumnName,
  tables.name AS TableName
FROM
  sys.columns
JOIN sys.tables ON
  sys.columns.object_id = tables.object_id
WHERE
  sys.columns.name like '%PricingModifierCategoriesId%'


  select * from black where ipaddress = '71.251.119.62'
  select * from white where ipaddress = '71.251.119.62'
  select * from TALoyaltyProgramInvoices where invoice = 'BBQ1904'
  select * from TALoyaltyProgramInvoices  order by date desc
  
  select * from TALoyaltyProgramInvoices  order by realdate desc
  select * from TALoyaltyProgramInvoices  order by entrydate desc


--Find column name , characters, datatype etc...
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, CHARACTER_MAXIMUM_LENGTH, NUMERIC_PRECISION, NUMERIC_SCALE
FROM INFORMATION_SCHEMA. COLUMNS
WHERE TABLE_NAME='merchantprods';


select *
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='merchantprods'

select * from merchantwebsitefeatures where featurecode like '%persist%'










