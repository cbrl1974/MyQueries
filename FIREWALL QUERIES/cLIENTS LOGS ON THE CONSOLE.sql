select top 500  * from firewall.dbo.LoggerClientEvents
WHERE MERCHANTID =1097
order by eventtime desc

--Check history of price change per product and merchant
select top 100 * from MerchantProds_ChangeTracking where merchantid = 1097 and productid in (628953,628624,674897) order by 


select top 10 * from firewall.dbo.black WHERE MERCHANTID = 155

select * from firewall.dbo.historical


select * from firewall.dbo.WhoIsActive where session_id = 292

select top 100 * from firewall.dbo.online where ipaddress = '70.69.9.5' -- my ipaddress

select top 100 * from firewall.dbo.config

--Historical based on ip address
select top 100 * from firewall.dbo.historical where url_string
ipaddress = '70.69.9.5' order by timestamp desc

select  top 100 * from firewall.dbo.resume where ipaddress = '70.69.9.5' order by timestamp desc





