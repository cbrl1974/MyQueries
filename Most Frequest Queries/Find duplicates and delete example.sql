select  *
FROM  merchantpricingoptions
where merchantid = 2312 


select max(id) as id, itemid, pricingfrequencyID, term, isProduct, total
from merchantpricingoptions
where merchantid = 2312 
group by itemid, pricingfrequencyID, term, isProduct, total


delete from merchantpricingoptions
where id in (select id from (select max(id) as id, itemid, pricingfrequencyID, term, isProduct, total
from merchantpricingoptions
where merchantid = 2312 
group by itemid, pricingfrequencyID, term, isProduct, total
) a )


--(88164 row(s) affected)