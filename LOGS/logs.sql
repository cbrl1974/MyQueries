SELECT 
TOP (500)
 [LogID]
      ,[Project]
      ,[Category]
      ,[Text]
      ,[Time]
      ,[Severity]
      ,[Module]
      ,[Location]
  FROM [EventReactor].[dbo].[Logs]
  where category like '%services%'
  and module = 'CameleonImport'
  --and text like '%571%'
  order by [time] desc


--For Datatail - last 14 months
  select * from 
  Log_retail 
  where logindate >= DATEADD(MONTH, -14, CAST(GETDATE() AS DATE))
  order by id desc


  select top 10 *  from CatalogApiLogs order by id desc


