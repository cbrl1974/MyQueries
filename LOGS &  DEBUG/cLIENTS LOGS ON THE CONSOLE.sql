Declare @merchantId as int = 3447;
Declare @productid int = 579507
;
Declare @today as date = getdate();
Declare @past as date = DATEADD(day, -15, GETDATE()) ;

--For Products
 select  * from MerchantProducts_ChangeTrackingArchive
 WHERE MERCHANTID = @merchantId
 and [changetime] between @past and @today
 and productid =@productid
  order by changetime desc

 --select  * from MerchantProducts_ChangeTracking
 --WHERE MERCHANTID = @merchantId
 ----and [changetime] between @past and @today
 ----and productid =@productid
 -- order by changetime desc

SELECT TOP (100) *
  FROM [firewall].[dbo].[LoggerClientEvents]
  where merchantid = 3447
  and urlpath like '%3990425%'
  order by EventId desc

  select id_product, model, manufmodel, manufacturerIdentifier from products  where id_product = 579507
  select * from merchantProds where merchant_id = 3447 and  productid = 579507





  --For Collections
Declare @merchantId as int = 2959;
Declare @collectionId int = 32550;
Declare @today as date = getdate();
Declare @past as date = DATEADD(day, -30, GETDATE()) ;

   select  * from MerchantCollections_ChangeTrackingArchive
 WHERE MERCHANTID = @merchantId
 and [changetime] between @past and @today
 and CollectionId =@collectionId
  order by changetime desc

 select  * from MerchantCollections_ChangeTracking
 WHERE MERCHANTID = @merchantId
 and [changetime] between @past and @today
 and CollectionId = @collectionId
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
 where url_string like '%www.haneyapplianceandsound.ca%'
 and [timestamp] between @past and @today
 and ipaddress = '2605:8d80:544:5fc7:ed3c:849b:2a38:79b3'
  order by [timestamp] desc

select  id, ipaddress, [timestamp],url_string from firewall.dbo.historical
 where url_string like '%www.haneyapplianceandsound.ca%'
 and [timestamp] between '2024-01-02 00:00:03.290' and '2024-01-02 16:00:03.290'
 and ipaddress = '209.121.60.42'
  order by [timestamp] desc

  SELECT 
    o.type_desc AS ObjectType,
    o.name AS ObjectName,
    m.definition AS ObjectDefinition
FROM sys.sql_modules m
JOIN sys.objects o ON m.object_id = o.object_id
WHERE m.definition LIKE '%MerchantProducts_ChangeTrackingArchive%'
ORDER BY ObjectType, ObjectName;






--Historical based on ip address
select top 100 * from firewall.dbo.historical where url_string
ipaddress = '70.69.9.5' order by timestamp desc

select  top 100 * from firewall.dbo.resume where ipaddress = '70.69.9.5' order by timestamp desc
select top 10 * from firewall.dbo.black WHERE MERCHANTID = 155
select top 100 * from firewall.dbo.config
select * from firewall.dbo.WhoIsActive where session_id = 292
select top 100 * from firewall.dbo.online where ipaddress = '70.69.9.5'



