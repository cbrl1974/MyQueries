 select * from MerchantWebsiteTexts where merchant_id = 903 and textcode = 'newslettersignup'
 select * from MerchantWebsiteTexts where textcode = 'newslettersignup' and content_1 like '%ccontact%'
 
	update top (1) MerchantWebsiteTexts 
	set content_1 = 'ccontact|apikey~462bvbfpzwsuq6khfqg5zatv|ccUsername~Cohenshomefurnishings|ccPassword~Cohens124g|idlist~1131857648'
	where merchant_id = 903
	and ID = 25060
	and textcode = 'newslettersignup'

	email|web@cohens.ca
	