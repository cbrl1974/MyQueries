select m.merchant, cbl.* from ConsoleBrandsLimitLogs cbl
inner join merchants m on m.id = cbl.MerchantId
where cbl.merchantId =1448
order by cbl.id desc 


select top 10  * from MerchantPricingOptionsSettings where merchantid = 2417
select * from  MerchantPricingOptions  where merchantid = 2417 and len(itemid) = 5  and isProduct  = 1
select * from MerchantPricingOptions where merchantid = 2417 and  itemid in (11989,680793)

select * from merchantcollections where merchant_id = 2417 and collectionID in(11989)
select * from merchantprods where merchant_id = 2417 and productid not in (select productid from MerchantPricingOptions where merchantid = 2417 and isProduct = 1)
select * from merchantwebsitefeatures where merchant_id = 2417
select * from collections where id = 11989
select * from companies where id_cie = 321
select * from products where id_product = 680793
select * from categories where id_category = 633


update top (24) MerchantPricingOptions
set isProduct = 0 
where merchantid = 2417 
and len(itemid) = 5  and isProduct  = 1

-- update top (6) MerchantPricingOptions 
-- set isproduct = 0 
-- where merchantid = 2417 
-- and len(itemid) = 5  
-- and isProduct  = 1






select * from companies whw