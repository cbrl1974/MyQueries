use Copernic_verifone

select 
    IPN_RESELLER_ID, 
	AVANGATE_CUSTOMER_REFERENCE,EXTERNAL_CUSTOMER_REFERENCE,
	IPN_PARTNER_CODE, ORDERSTATUS,
	*
from Copernic_verifone.dbo.sales
--where REFNO = '115052909'
--where IPN_PARTNER_CODE is not null
--where REFNO = 252673919
--where  AVANGATE_CUSTOMER_REFERENCE = '47474788'
--where saledate between 2014-01-01 and 2015-07-31
where saledate > convert(date,getdate()-1)
order by saledate desc


select count(message_id)
from Copernic_verifone.dbo.sales
--120622

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
where LAST_ORDER_REFERENCE in (115052909)


select *
from Copernic_verifone.dbo.SubscriptionsUsers
where CUSTOMER_ID in (557180423)


select *
from Copernic_verifone.dbo.PaymentCodes

select top 200 *
from Copernic_verifone.dbo.WebHooksLogs
where 1 = 1
and creationDate > convert(date,getdate()-1)
and severity <> 0
--and module = 'HandleIpn'
order by creationDate desc






















