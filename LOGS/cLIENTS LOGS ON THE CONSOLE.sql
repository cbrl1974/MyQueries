Declare @merchantId as int = 3468;
Declare @productid int = 761576;
Declare @today as date = getdate();
Declare @past as date = DATEADD(day, -10, GETDATE()) ;


 select top 5  * from MerchantProducts_ChangeTrackingArchive
 WHERE MERCHANTID = @merchantId
 and [changetime] between @past and @today
 and productid =@productid
 



--select top 50  * from firewall.dbo.LoggerClientEvents
--WHERE MERCHANTID = @merchantId
--AND EventTime between @past and @today
----and UrlPath like '%cmtx%'
--order by eventtime desc

--Check history of price change per product and merchant
--select top 100 * from MerchantProds_ChangeTracking
-- WHERE MERCHANTID = @merchantId
-- and [changetime] between @past and @today
-- and ProductId = @productid
-- order by ChangeTime 


select * from firewall.dbo.


select  id, ipaddress, [timestamp],url_string from firewall.dbo.historical
 where url_string like '%liquidationelectromenagers.com%'
 and [timestamp] between @past and @today
 and ipaddress = '2605:8d80:544:5fc7:ed3c:849b:2a38:79b3'
  order by [timestamp] desc

 select  distinct ipaddress from firewall.dbo.historical
 where url_string like '%liquidationelectromenagers.com%'
 and [timestamp] between '2022-05-02 08:00:03.290' and '2022-05-02 09:15:03.290'
 and url_string like '%HER30F5CSS%'
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




