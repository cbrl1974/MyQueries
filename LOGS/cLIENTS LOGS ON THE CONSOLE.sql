Declare @merchantId as int = 3468;
Declare @productid int = 362891;
Declare @today as date = getdate();
Declare @past as date = DATEADD(day, -10, GETDATE()) ;

 select  * from MerchantProducts_ChangeTrackingArchive
 WHERE MERCHANTID = @merchantId
 and [changetime] between @past and @today
 and productid =@productid
  order by changetime desc

  --Debugging
DECLARE @MerchantIdforDebugForLogs AS INT = 3468;
select * from merchantwebsiteeventlogs 
where merchantid = @MerchantIdforDebugForLogs
and text like '%liquidation%'
order by time desc

DECLARE @MerchantIdforDebugForLogs AS INT = 3468;
select * from merchantwebsiteeventlogs 
where merchantid = @MerchantIdforDebugForLogs
and time between '2023-07-13 13:36:37.207' and '2023-08-07 15:10:35.317'
and server != 'servername'
order by time desc


2023-08-07 10:20:51.557
2023-08-02 17:03:04.127
2023-08-02 12:00:18.053
2023-08-01 15:29:56.843
2023-08-01 18:38:26.923
2023-07-13 13:36:37.207

select * from merchantwebsitetexts where merchant_id = 3468
select * from merchantWebsiteFeatures where featurecode like '%storeIdTypeIdToProcessInventory%'
hasLanguageDetection
languages
preferredLanguage
select * from merchantWebsiteFeatures where merchant_id = 3468
select * from merchantStoresInventory where merchantid = 3468
insert into merchantWebsiteFeatures values
(3468,'preferredLanguage','fr')

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




