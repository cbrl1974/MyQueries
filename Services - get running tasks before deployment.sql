SELECT DATEADD(minute, interval, LastIntervalExecution) at TIME zone 'utc' at TIME zone 'US eastern standard time' 'NextRun (Eastern timezone)'
        ,CASE 
                WHEN DATEADD(minute, interval, LastIntervalExecution) BETWEEN (getdate() at TIME zone 'US eastern standard time') at TIME zone 'utc'
                        AND (dateadd(minute, 10, getdate()) at TIME zone 'US eastern standard time') at TIME zone 'utc'
                        THEN 'runs in '+convert(nvarchar(10),Datediff(minute,(getdate() at TIME zone 'US eastern standard time'),DATEADD(minute, interval, LastIntervalExecution at time zone 'UTC')))+' minutes' 
                ELSE 'Running!' END 'Should You Deploy?'
        ,AssemblyClass,AssemblyMethodName,*
FROM TailbaseServices.dbo.AsyncTasks
WHERE STATE = 3
        OR DATEADD(minute, interval, LastIntervalExecution) BETWEEN (getdate() at TIME zone 'US eastern standard time') at TIME zone 'utc'
                AND (dateadd(minute, 10, getdate()) at TIME zone 'US eastern standard time')
order by 1

--BestBuyCanadaScraper
update top (1) Tailbaseservices.dbo.asynctasks
set State = 1
where id = '556bccba-7c26-4732-9da0-82d9d80cc1c1'
