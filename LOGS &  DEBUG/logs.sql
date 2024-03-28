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


SELECT TOP (100) *
FROM [firewall].[dbo].[LoggerClientEvents]
where merchantid = 1448
order by EventId desc



--For Datatail - last 14 months
select * from 
Log_retail 
where logindate >= DATEADD(MONTH, -14, CAST(GETDATE() AS DATE))
order by id desc

select top 10 *  from CatalogApiLogs order by id desc

select top 10  * from InternalEventLogs order by id desc

select top 10  * from MerchantPosLogs order by id desc

SELECT TOP (100) *
FROM [firewall].[dbo].[WhoIsActive]
order by start_time desc


select top 400 * from merchantwebsiteeventlogs 
where merchantid = 3487
order by time desc


select top 150  * from MerchantTransactionLog
where merchant_id = @MerchantIdforDebug
order by id desc

