SELECT * from MerchantWebsiteTexts where merchant_id = 420
--and textcode like 'homepagead%'
and textcode like 'homepagess%'

SELECT * from MerchantWebsiteTexts where merchant_id = 1058
--and textcode like 'homepagead%'
and textcode like 'homepagess%'

 -- update textcode homepagead --
update MerchantWebsiteTexts set content_1 ='http://www.barlowappliances.com'
where ID = 32104
and merchant_id = 1058

update MerchantWebsiteTexts set content_1 ='http://www.barlowappliances.com'
where ID = 32106
and merchant_id = 1058

 -- insert textcode homepagess --
insert into MerchantWebsiteTexts (merchant_id, textcode, content_1)
values (1058,'HOMEPAGESS1ALTTEXT','')

insert into MerchantWebsiteTexts (merchant_id, textcode, content_1)
values (1058,'HOMEPAGESS1LINK','http://www.barlowappliances.com/en/pg-ns_dlp?nsck=808baf1cf27aa14a5bf25ce7e4a260ef')

insert into MerchantWebsiteTexts (merchant_id, textcode, content_1)
values (1058,'HOMEPAGESS2ALTTEXT','')

insert into MerchantWebsiteTexts (merchant_id, textcode, content_1)
values (1058,'HOMEPAGESS2LINK','http://www.barlowappliances.com/en/pg-ns_dlp?nsck=f6afb4b0a01ef34a6bd86aa1d6d406cf')

insert into MerchantWebsiteTexts (merchant_id, textcode, content_1)
values (1058,'HOMEPAGESS3ALTTEXT','')

insert into MerchantWebsiteTexts (merchant_id, textcode, content_1)
values (1058,'HOMEPAGESS3LINK','http://www.barlowappliances.com/en/pg-ns_dlp?nsck=b5634e27a57bd04d4eb87bd5f0c623af')





