select m.id as merchantID,m.merchant_code,m.merchant,m.filepath,m.merchant_url,m.active,mf.featurevalue,mc.serverenvironment,mwt.id merchantWebsiteTextsID,mwt.content_1,mwt.content_2
from merchants m
left join merchantWebsiteFeatures mf on mf.merchant_id = m.id and mf.featureCode = 'template'
inner join merchantcms mc on mc.merchant_id = m.id
inner join merchantwebsitetexts mwt on mwt.merchant_id = m.id
--where mc.serverEnvironment = 'ewhserver1696'
--where mf.featurevalue = 'nwdynamicprov20_g1'
--where m.filepath = '2001audiovideo'
--where m.id in (536,393) and mf.featurevalue = 'nwdynamicprov20_g1'
where m.merchant like '%jindal%'
--where m.id = 1337
and m.active = 1
and textcode like '%newsletter%'

select * from MerchantWebsiteTexts where merchant_id = 2254 and id = 210120
MailChimp|apikey~b336ec3af84e9388c082b6708ba91a43-us13|id~6b4933e19c

update top (1) MerchantWebsiteTexts set content_1 = 'MailChimp|apikey~55ddb3ef77512295d86979a44e5a10e1-us10|id~eef4b59a0e'
 where merchant_id = 2254 and id = 210120

update top (1) MerchantWebsiteTexts set content_2 = 'MailChimp|apikey~55ddb3ef77512295d86979a44e5a10e1-us10|id~eef4b59a0e'
 where merchant_id = 2254 and id = 210120