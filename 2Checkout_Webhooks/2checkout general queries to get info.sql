use Copernic_verifone

select top 50
    *
from Copernic_verifone.dbo.sales
where saledate > convert(date,getdate()-1)
order by saledate desc


select count(message_id)
from Copernic_verifone.dbo.sales

--total sale per day
SELECT
    CONVERT(DATE, SALEDATE) AS SALEDATE,
    Format(SUM(IPN_TOTAL * FX_RATE), 'N2') AS totalSale
FROM Copernic_verifone.dbo.sales
GROUP BY CONVERT(DATE, SALEDATE)
ORDER BY SALEDATE DESC;



select id, FIRSTNAME, LASTNAME, ADDRESS1, city, [STATE], ZIPCODE, country, COUNTRYCODE
from Copernic_verifone.dbo.CustomerInformation
order by creationdate desc





select *
from Copernic_verifone.dbo.Subscriptions
where AVANGATE_CUSTOMER_REFERENCE in (557180423)


select *
from Copernic_verifone.dbo.SubscriptionsUsers
where CUSTOMER_ID in (557180423)


select *
from Copernic_verifone.dbo.PaymentCodes
select *
from messages



select *
from Copernic_verifone.dbo.WebHooksLogs
where 1 = 1
--where creationDate > convert(date,getdate()-1)
and severity <> 0
order by creationDate desc


















