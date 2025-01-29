select m.merchant, cbl.* from ConsoleBrandsLimitLogs cbl
inner join merchants m on m.id = cbl.MerchantId
where cbl.merchantId =1448
order by cbl.id desc 


select top 10  * from MerchantPricingOptionsSettings where merchantid = 2417
select * from  MerchantPricingOptions  where merchantid = 2417 and len(itemid) = 5  and isProduct  = 1
select * from merchantcollections where merchant_id = 2417 and collectionID in( 32424,31998)
select * from merchantwebsitefeatures where merchant_id = 2417
select * from collections where id = 32424
select * from companies where id_cie = 3181

-- update top (6) MerchantPricingOptions 
-- set isproduct = 0 
-- where merchantid = 2417 
-- and len(itemid) = 5  
-- and isProduct  = 1




