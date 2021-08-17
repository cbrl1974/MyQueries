select * from merchantwebsitetexts where merchant_id = 1741 and content_1 like '%kgandr.tm3.tailbase.com%'
select * from merchantwebsitetexts where merchant_id = 1678 and content_2 like '%ksfntc.tm3.tailbase.com%'

update top (37) merchantwebsitetexts set content_1 = replace (cast(content_1 as varchar(1000)),'http://www.brandsource.ca/','http://abssvg.pvmtm.tailbase.com')  -- replace last string with domain name
--select replace (cast(content_1 as varchar(1000)),'http://www.brandsource.ca/','http://abssvg.pvmtm.tailbase.com') --- just for select
--from merchantwebsitetexts --- just for select
where merchant_id = 2254 --change merchant_id
and content_1 like '%http://www.brandsource.ca/%'

update top (33) merchantwebsitetexts set content_2 = replace (cast(content_2 as varchar(1000)),'http://www.brandsource.ca/','http://abssvg.pvmtm.tailbase.com')  -- replace last string with domain name
--select replace (cast(content_2 as varchar(1000)),'http://www.brandsource.ca/','http://abssvg.pvmtm.tailbase.com') --- just for select
--from merchantwebsitetexts --- just for select
where merchant_id = 2254
and content_2 like '%http://www.brandsource.ca/%'


http://kardri.pvmtm.tailbase.com/en/searchitemresults?searchterm=on+sale|cie~1487~111