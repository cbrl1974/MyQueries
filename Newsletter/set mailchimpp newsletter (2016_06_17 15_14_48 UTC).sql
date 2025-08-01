Declare @MerchantID as int = 3587

select * from merchantwebsitetexts where merchant_id = @MerchantID  and textcode = 'newslettersignup'


update top (1) merchantwebsitetexts
set content_1 = 'MailChimp|apikey~90f457aa8628e21a1f75aa907159e8b2-us1|id~92de533cff'
, content_2 = 'MailChimp|apikey~90f457aa8628e21a1f75aa907159e8b2-us1|id~92de533cff'
 where merchant_id = @MerchantID  and textcode = 'newslettersignup'
 --email|dfw@donsfurniturewhse.com

 select * from merchantwebsitetexts where merchant_id = @MerchantID  and textcode = 'newslettersignup'

select content_1 from merchantwebsitetexts where textcode = 'newslettersignup' 


select distinct SUBSTRING(content_1,0,CHARINDEX('|',content_1,0)) as Splitted from merchantwebsitetexts where textcode = 'newslettersignup' 