use firewall

select top 1 productid, COUNT(1)
from (
    select *, SUBSTRING(url_string, initpos, endpos - initpos) productid
    from (
        select *, CHARINDEX('-', url_string, initpos + 1) endpos
        from (
            select url_string, (CHARINDEX('/catalog/', url_string, 1) + 9) initpos
            from historical 
            where 
                url_string like 'http://www.domon.com/%'
                and
                url_string like '%/catalog/[0-9]%-%'
                and
                [timestamp] BETWEEN '2021-06-07' and '2021-07-07'
        ) a
    ) b
) c
group by productid
order by 2 desc
;