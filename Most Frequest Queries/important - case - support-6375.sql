DECLARE @merchantID int;         
SELECT @merchantID = 2384;         
SELECT @merchantID = id         
FROM merchantshipping      
WHERE merchant_id = @merchantID ;        
SELECT @merchantID AS 'ShippingID';  

select * from MerchantShippingPricesByValueRanges where merchantshippingid in (@merchantID)

insert into MerchantShippingPricesByValueRanges values
(400,0,499.99,79.00,314,NULL),
(400,500,Null,39.00,314,NULL),
(400,0,499.99,99.00,315,NULL),
(400,500,Null,59.00,315,NULL),
(400,0,499.99,129.00,316,NULL),
(400,500,Null,89.00,316,NULL),
(400,0,499.99,129.00,317,NULL),
(400,500,Null,89.00,317,NULL),
(400,0,499.99,169.00,318,NULL),
(400,500,Null,129.00,318,NULL)

update top(1) merchantshipping
set comment = '-$40 Off Delivery For Orders Over $500'
where id = 400




