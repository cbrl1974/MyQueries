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
  and logid >= 26304898
and text like '%System.ArgumentOutOfRangeException%'
  --and text = 'Starting full feed run for feed 7.'
  order by [time] desc


--For Datatail - last 14 months
  select * from 
  Log_retail 
  where logindate >= DATEADD(MONTH, -14, CAST(GETDATE() AS DATE))
  order by id desc


