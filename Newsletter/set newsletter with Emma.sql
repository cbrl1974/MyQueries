 Declare @id int = 227025;
 Declare @merchantid int = 2502;
 select * from MerchantWebsiteTexts where merchant_id = @merchantid and textcode = 'newslettersignup'

 --sample 
 --select * from MerchantWebsiteTexts where textcode = 'newslettersignup' and content_1 like '%emma%'
 
update top (1) MerchantWebsiteTexts 
set content_1 = 'emma|accountID~1912718|apiKeyPublic~fabba66cb55b34b12719|apiKeyPrivate~145979d588e3eefe1aa2|group_ids~20158350'
where merchant_id = @merchantid
and ID = @id
and textcode = 'newslettersignup'

--emma|accountID~1912718|apiKeyPublic~fabba66cb55b34b12719|apiKeyPrivate~145979d588e3eefe1aa2



Bronto|url~http://app.bronto.com/public/?q=direct_add&fn=Public_DirectAddForm&id=asynikogmlhanztqkasyncstwaovbjk&email=example@example.com&list1=0bc203ec000000000000000000000005da47