use Copernic_verifone

select * from Copernic_verifone.dbo.sales 
where  PAYMENTDATE > convert(date,getdate()-1)
order by PAYMENTDATE desc

select * from salesInformation
where  PAYMENTDATE > convert(date,getdate()-1)
and  ORDERNO =  183000
order by PAYMENTDATE desc


select s.PAYMENTDATE,  sp.* from Copernic_verifone.dbo.salesProducts sp
join Copernic_verifone.dbo.salesInformation  s on s.REFNO = sp.REFNO
where  s.PAYMENTDATE > convert(date,getdate()-1)
order by s.PAYMENTDATE desc








select count(message_id)
from Copernic_verifone.dbo.sales
--188828

--total sale per day
SELECT
    CONVERT(DATE, PAYMENTDATE) AS PAYMENTDATE,
    Format(SUM(IPN_TOTAL * FX_RATE), 'N2') AS totalSale
FROM Copernic_verifone.dbo.sales
where ORDERSTATUS = 'COMPLETE'
GROUP BY CONVERT(DATE, PAYMENTDATE)
ORDER BY PAYMENTDATE DESC;

--Total sales for the month
	SELECT
    FORMAT(SUM(IPN_TOTAL * FX_RATE), 'N2') AS totalSaleForApril
FROM Copernic_verifone.dbo.sales
WHERE MONTH(PAYMENTDATE) = 5
and ORDERSTATUS = 'COMPLETE' 
  AND YEAR(PAYMENTDATE) = YEAR(GETDATE());



select id, FIRSTNAME, LASTNAME, ADDRESS1, city, [STATE], ZIPCODE, country, COUNTRYCODE
from Copernic_verifone.dbo.CustomerInformation
--where id =15
order by creationdate desc



select  license_code  'License Code',
license_product_code  'License Product Code',
EXPIRATION_DATE 'Expiration Date', 
Status, 
NEXT_RENEWAL_PRICE,
NEXT_RENEWAL_DATE
from Copernic_verifone.dbo.Subscriptions
where status = 'ACTIVE'
order by message_id desc

select count(message_id)
from Copernic_verifone.dbo.Subscriptions
--110644


select *
from Copernic_verifone.dbo.SubscriptionsUsers
where CUSTOMER_ID in (15)


select  top 50 * 
from Copernic_verifone.dbo.WebHooksLogs
where 1 = 1
and creationDate > convert(date,getdate()-5)
--and webkook = 'lcn'
and severity <> 0
--and text like '%6557886%'
--and module = 'HandleIpn'
order by creationDate desc

select  top 50  * 
from Copernic_verifone.dbo.WebHooksLogs
where 1 = 1
and creationDate > convert(date,getdate()-1)
--and webkook = 'lcn'
--and severity <> 0
--and text like '%6557886%'
--and module = 'HandleIpn'
order by creationDate desc

