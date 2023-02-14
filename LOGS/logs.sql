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
  FROM [EventReactor].[dbo].[Logs]
  where category = 'feeds'
  and logid >= 26292400
  --and text = 'Starting full feed run for feed 7.'
  and text like '%System.ArgumentOutOfRangeException%'
  order by [time] desc


--For Datatail
 select top 100 * from 
  Log_retail 
  order by id desc


