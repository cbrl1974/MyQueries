use firewall

select top 1 catID, COUNT(1)
from (
    select *, SUBSTRING(url_string, initpos, endpos - initpos) catID
    from (
        select *, CHARINDEX('-', url_string, initpos + 1) endpos
        from (
            select url_string, (CHARINDEX('/catalog/23025-salon/', url_string, 1) + 21) initpos
            from historical 
            where 
                url_string like 'http://www.meublesloren.com/%'
                and
                url_string like '%/catalog/23025-salon/[0-9]%'
                and
                [timestamp] BETWEEN '2021-06-07' and '2021-07-07'
        ) a
    ) b
) c
group by catID
order by 2 desc
;

