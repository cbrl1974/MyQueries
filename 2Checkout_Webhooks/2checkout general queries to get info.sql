use Copernic_verifone  

--select * from Copernic_verifone.dbo.sales WITH (NOLOCK) where REFNO = '260429257'
select si.* from salesInformation si WITH (NOLOCK) where si.REFNO = '260429257'
select sp.* from salesProducts sp WITH (NOLOCK) where sp.REFNO = '260429257'

--delete from Copernic_verifone.dbo.sales  where refno = '260417056'
delete from Copernic_verifone.dbo.salesInformation  where refno = '260429257'
delete from Copernic_verifone.dbo.salesProducts  where refno = '260429257'


select  * from Subscriptions where LICENSE_CODE = 'GF478DXST5'

delete from Copernic_verifone.dbo.SubscriptionsUsers where LICENSE_CODE = 'GF478DXST5'
delete from Copernic_verifone.dbo.Subscriptions where LICENSE_CODE = 'GF478DXST5'




select
    CONVERT(DATE, s.PAYMENTDATE) AS PAYMENTDATE,
    Format(SUM(sp.IPN_TOTAL * s.FX_RATE), 'N3') AS totalSale
from Copernic_verifone.dbo.salesProducts sp WITH (NOLOCK)
    join Copernic_verifone.dbo.salesInformation  s on s.REFNO = sp.REFNO
where s.ORDERSTATUS = 'COMPLETE'
GROUP BY CONVERT(DATE, s.PAYMENTDATE)
ORDER BY PAYMENTDATE DESC;


--total sale per day
SELECT
    CONVERT(DATE, PAYMENTDATE) AS PAYMENTDATE,
    Format(SUM(IPN_TOTAL * FX_RATE), 'N3') AS totalSale
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

*


select  top 50  *
from Copernic_verifone.dbo.WebHooksLogs WITH (NOLOCK)
where   CreationDate > convert(date,getdate()-0)
--and text like '%260283197%'
--and text like '%user%'
and module = 'HandleIpn'
--and location = 'WebhooksController.cs:77' 
--and Severity <> 0
order by CreationDate desc

select * from Subscriptions  where MESSAGE_ID = 255682429211
delete from SubscriptionsUsers where LICENSE_CODE = '5747C0FBYW'
delete from Subscriptions  where MESSAGE_ID = 255682429211






	