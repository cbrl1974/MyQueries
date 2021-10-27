DECLARE @MerchantIdforDebug AS INT = 1097;
DECLARE @dateStart as datetime  = '2021-03-21 20:20:00';
DECLARE @dateEnd as datetime  = '2021-03-21 20:40:00'
DECLARE @websiteUrl as varchar(500) = '%www.alliancefurnishings.com%'
DECLARE @ipAddress as varchar(200) = '24.247.2553.234'

----Website log
select top 200 * from merchantwebsiteeventlogs 
where merchantid = @MerchantIdforDebug
and time between @dateStart and @dateEnd
--and [text] like '%49316%'
order by time desc

--Orders
DECLARE @MerchantIdforDebug AS INT = 1097;
DECLARE @dateStart as datetime  = '2021-03-21 20:20:00';
DECLARE @dateEnd as datetime  = '2021-03-21 20:40:00'
select top 150  * from MerchantTransactionLog
where merchant_id = @MerchantIdforDebug
and creationTimestamp between @dateStart and @dateEnd
and requestSent like '%1097-20210321%'
order by id desc

--Order
DECLARE @OrderID AS INT = 120297;
select * from customerOrders where id = @OrderID
--Customer
DECLARE @customerID as int = 188259
select * from customers where id = @customerID
--Customer Address
select * from CustomerAddresses where customerID = @customerID


--Products purchased
DECLARE @OrderID AS INT = 120297;
select * from CustomerOrderItems
where orderID =@OrderID

--Order Email
select * from CustomerOrderEmailsHistory
where orderid =  @OrderID



select  top 500 * from firewall.dbo.historical
 WHERE url_string like '%www.alliancefurnishings.com%'
 and [timestamp] between '2021-03-20 17:40:13.477' and '2021-03-23 20:09:27.943'
 --and ipaddress like  '%24.247.253%'
 order by [timestamp]



