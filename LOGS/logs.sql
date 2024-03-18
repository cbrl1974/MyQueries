SELECT 
TOP (100)
 [LogID]
      ,[Project]
      ,[Category]
      ,[Text]
      ,[Time]
      ,[Severity]
      ,[Module]
      ,[Location]
  FROM [EventReactor].[dbo].[Logs] WITH (NOLOCK)
  where category = 'Feeds'
  and text like '%Ashley%'
  order by [time] desc

  select distinct project from [stagingEventReactor].[dbo].[Logs]


--For Datatail - last 14 months
  select * from 
  Log_retail 
  where logindate >= DATEADD(MONTH, -14, CAST(GETDATE() AS DATE))
  order by id desc


  select top 10 *  from CatalogApiLogs order by id desc


  select top 10  * from InternalEventLogs order by id desc

  select top 10  * from MerchantPosLogs order by id desc



