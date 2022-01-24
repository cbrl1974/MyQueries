use datatail20130410

select PriceInquiry from Merchants WHERE ID=2482
update top (1) Merchants 
SET PriceInquiry = 1 WHERE ID=2482;

select * from Merchant_FieldsConfiguration  WHERE merchantID=2482


update top (1) Merchant_FieldsConfiguration set ListFieldstoShow = '3,4,5,6,7,8,9,10,11,12,13,16,17,18,19' WHERE merchantID=2482


