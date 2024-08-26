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