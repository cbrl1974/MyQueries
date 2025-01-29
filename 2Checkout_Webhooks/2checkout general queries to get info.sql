select * from sales  
--where AVANGATE_CUSTOMER_REFERENCE in (118398344)
order by message_id desc
--delete from sales

select id, FIRSTNAME, LASTNAME, ADDRESS1, city, [STATE], ZIPCODE, country, COUNTRYCODE from CustomerInformation 
--where id = 881058379
order by creationdate desc


--delete  from CustomerInformation


select * from Subscriptions where AVANGATE_CUSTOMER_REFERENCE in (557180423)
--delete  from Subscriptions

select * from SubscriptionsUsers where CUSTOMER_ID in (557180423)
--delete from SubscriptionsUsers

select * from PaymentCodes
select * from messages















