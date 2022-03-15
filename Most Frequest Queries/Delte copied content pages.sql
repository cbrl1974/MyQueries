select * from merchantwebsitepages where id = 16237

delete top (1) from merchantwebsitepages where id = 16237

select * from merchantwebsitepagecontent where merchantwebsitepageid = 16237

delete top (144) from merchantwebsitepagecontent where merchantwebsitepageid = 16237


select * from merchantbrands where merchant_id = 2312 and cieid = 999

update top (1) merchantbrands set showLandingpage = 0, slug = NULL where merchant_id = 2312 and cieid = 999