select * from merchantwebsitepages where merchant_id = 2354


select * from merchantbrands where merchant_id = 2354

update top(1) merchantbrands set slug = null, showLandingPage = 0 where id = 69765 and merchant_id = 2354