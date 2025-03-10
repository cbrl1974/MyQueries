use Copernic_verifone

select top 50
    *
from sales
where saledate > convert(date,getdate()-1)
order by saledate desc

--total sale per day
SELECT 
    CONVERT(DATE, SALEDATE) AS SALEDATE, 
    Format(SUM(IPN_TOTAL * FX_RATE), 'N2') AS totalSale
FROM sales
GROUP BY CONVERT(DATE, SALEDATE)
ORDER BY SALEDATE DESC;



select id, FIRSTNAME, LASTNAME, ADDRESS1, city, [STATE], ZIPCODE, country, COUNTRYCODE
from CustomerInformation
order by creationdate desc





select *
from Subscriptions
where AVANGATE_CUSTOMER_REFERENCE in (557180423)


select *
from SubscriptionsUsers
where CUSTOMER_ID in (557180423)


select *
from PaymentCodes
select *
from messages

select *
from WebHooksLogs
where creationDate > convert(date,getdate()-1)
--and severity <> 0
order by creationDate desc


















