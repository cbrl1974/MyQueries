select top 500  * from firewall.dbo.LoggerClientEvents
WHERE MERCHANTID = 1781
AND EventTime between '2021-10-07' and '2021-10-08'
order by eventtime desc

--Check history of price change per product and merchant
select top 100 * from MerchantProds_ChangeTracking
 WHERE MERCHANTID = 1781
 and [changetime] between '2021-10-07' and '2021-10-08'
 order by ChangeTime 

 select top 5  * from MerchantProducts_ChangeTrackingArchive
 WHERE MERCHANTID = 1781
 and [changetime] between '2021-10-01' and '2021-10-15'
 and productid =641062
 



select * from firewall.dbo.


select  * from firewall.dbo.historical
 where url_string like '%meublesetdavantage.ca%'
 and [timestamp] between '2021-10-07 22:00:00.000' and '2021-10-07 23:00:00.000'
 and ipaddress = '192.222.167.103'
 order by [timestamp] desc

 select  distinct ipaddress from firewall.dbo.historical
 where url_string like '%www.stereoplus.com%'
 and [timestamp] between '2021-09-16 10:15:00.000' and '2021-09-16 10:30:00.000'
 group by ipaddress
 --order by [timestamp] 



--Historical based on ip address
select top 100 * from firewall.dbo.historical where url_string
ipaddress = '70.69.9.5' order by timestamp desc

select  top 100 * from firewall.dbo.resume where ipaddress = '70.69.9.5' order by timestamp desc
select top 10 * from firewall.dbo.black WHERE MERCHANTID = 155
select top 100 * from firewall.dbo.config
select * from firewall.dbo.WhoIsActive where session_id = 292
select top 100 * from firewall.dbo.online where ipaddress = '70.69.9.5'




