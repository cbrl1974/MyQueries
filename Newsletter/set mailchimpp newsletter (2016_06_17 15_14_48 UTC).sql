Declare @MerchantID as int = 2814

select * from merchantwebsitetexts where merchant_id = @MerchantID  and textcode = 'newslettersignup'


update top (1) merchantwebsitetexts
set content_1 = 'MailChimp|apikey~70101ab022b6ad6615a49da1d8444c07-us2|id~ff9458cee3'
--, content_2 = 'MailChimp|apikey~323517431820b132d038920ea4bd5209-us18|id~e84bd667b5'
 where merchant_id = @MerchantID  and textcode = 'newslettersignup'

select content_1 from merchantwebsitetexts where textcode = 'newslettersignup' 


select distinct SUBSTRING(content_1,0,CHARINDEX('|',content_1,0)) as Splitted from merchantwebsitetexts where textcode = 'newslettersignup' 