use Copernic_verifone

--select * from Copernic_verifone.dbo.sales WITH (NOLOCK) where REFNO = '260429257'
select si.*
from salesInformation si WITH (NOLOCK)
where si.REFNO = '260429257'
select sp.*
from salesProducts sp WITH (NOLOCK)
where sp.REFNO = '260429257'


select *
from Subscriptions
where LICENSE_CODE = 'GF478DXST5'



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



select top 50
  *
from Copernic_verifone.dbo.WebHooksLogs WITH (NOLOCK)
where   CreationDate > convert(date,getdate()-0)
  and Severity <> 0
order by CreationDate desc

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = N'WebHooksLogs'
--AND TABLE_SCHEMA = N'feeds';

SELECT
  i.name,
  i.type_desc,
  i.is_primary_key,
  ic.key_ordinal,
  c.name AS column_name
FROM sys.indexes i
  JOIN sys.index_columns ic
  ON i.object_id = ic.object_id AND i.index_id = ic.index_id
  JOIN sys.columns c
  ON c.object_id = ic.object_id AND c.column_id = ic.column_id
WHERE i.object_id = OBJECT_ID('dbo.WebHooksLogs')
ORDER BY i.index_id, ic.key_ordinal;









	