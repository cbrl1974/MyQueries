select productid, featured, featuredtabid from merchantprods where merchant_id = 1760
and featuredtabid is not null and featuredtabid not in (select id from merchantfeaturedtabs where merchant_id = 1760)


select * from merchantfeaturedtabs where merchant_id = 1760

update top (1) merchantprods
set featured = 0,
FeaturedTabId = NULL
 where merchant_id = 1760
 and productid = 637911
