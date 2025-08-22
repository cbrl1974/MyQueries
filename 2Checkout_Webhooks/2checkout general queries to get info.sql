use Copernic_verifone

select *
from Copernic_verifone.dbo.sales WITH (NOLOCK)
where  PAYMENTDATE > convert(date,getdate()-1)
order by PAYMENTDATE desc



select si.*, sp.*
from salesInformation si WITH (NOLOCK)
join salesProducts sp on sp.REFNO = si.REFNO and sp.ORDERNO = si.ORDERNO
where  PAYMENTDATE > convert(date,getdate()-0)
order by PAYMENTDATE desc


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


select *
from Copernic_verifone.dbo.WebHooksLogs WITH (NOLOCK)
where   CreationDate > convert(date,getdate()-0)
and Severity <> 0
order by CreationDate desc


	