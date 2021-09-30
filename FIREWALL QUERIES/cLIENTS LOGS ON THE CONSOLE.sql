select top 500  * from firewall.dbo.LoggerClientEvents
WHERE MERCHANTID = 1175
AND EventTime between '2021-09-16' and '2021-09-17'
order by eventtime desc

--Check history of price change per product and merchant
select top 100 * from MerchantProds_ChangeTracking
 where merchantid = 1175 
 and [changetime] between '2021-09-10' and '2021-09-30'
 order by ChangeTime 



select * from firewall.dbo.


select  * from firewall.dbo.historical
 where url_string like '%www.stereoplus.com%'
 and [timestamp] between '2021-09-16 10:15:00.000' and '2021-09-16 10:45:00.000'
 and ipaddress = '72.0.250.194'
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




