use datatail20130410

--ACTIVATE PRICE QUALIFIER
select RTOConsole from merchantcms  where merchant_id = 2472
update top (1) merchantcms set  RTOConsole = 1 where merchant_id = 2472


select PriceInquiry from merchants  where id = 2472
update top (1) merchants set PriceInquiry = 0 where id = 2472



select * from merchantwebsitefeatures  where Merchant_id = 2472
insert into merchantwebsitefeatures values
(2472,'hasPriceInquiry', null)

select merchant_id, productid, pricequalifier from merchantprods where merchant_id = 2472 order by pricequalifier desc
update top (1) merchantprods set pricequalifier = null where merchant_id = 2472 and productid = 595310