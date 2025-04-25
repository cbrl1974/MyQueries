use Copernic_verifone

select 	*
from Copernic_verifone.dbo.sales
--where REFNO = '115052909'
--where IPN_PARTNER_CODE is not null
--where REFNO = 252673919
--where  AVANGATE_CUSTOMER_REFERENCE = '47474788'
--where PAYMENTDATE between '2025-04-22' and '2025-04-23'
where PAYMENTDATE > convert(date,getdate()-1)
order by PAYMENTDATE desc


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
WHERE MONTH(PAYMENTDATE) = 4
and ORDERSTATUS = 'COMPLETE'
  AND YEAR(PAYMENTDATE) = YEAR(GETDATE());



select id, FIRSTNAME, LASTNAME, ADDRESS1, city, [STATE], ZIPCODE, country, COUNTRYCODE
from Copernic_verifone.dbo.CustomerInformation
where id =15
order by creationdate desc





select top 10 *
from Copernic_verifone.dbo.Subscriptions
where avangate_customer_reference in (15)

select count(message_id)
from Copernic_verifone.dbo.Subscriptions
--36009


select *
from Copernic_verifone.dbo.SubscriptionsUsers
where CUSTOMER_ID in (15)


select  top 10 * 
from Copernic_verifone.dbo.WebHooksLogs
where 1 = 1
and creationDate > convert(date,getdate()-1)
--and webkook = 'lcn'
--and severity <> 0
--and text like '%6557886%'
--and module = 'HandleIpn'
order by creationDate desc

select  top 50 * 
from Copernic_verifone.dbo.WebHooksLogs
where 1 = 1
and creationDate > convert(date,getdate()-1)
--and webkook = 'lcn'
--and severity <> 0
--and text like '%6557886%'
--and module = 'HandleIpn'
order by creationDate desc
























