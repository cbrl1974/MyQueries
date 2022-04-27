SELECT TOP (100) [LogID]
      ,[Project]
      ,[Category]
      ,[Text]
      ,[Time]
      ,[Severity]
      ,[Module]
      ,[Location]
  FROM [EventReactor].[dbo].[Logs]
  where category = 'feeds'
  order by [time] desc



Using the first API key we found, merchant[589], ApiKey[5AF700257D5F4A4F8A22F96D18]