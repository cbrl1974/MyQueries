select m.id,m.merchant_code,m.merchant,m.merchantpwd,m.filepath,m.merchant_url,m.active,mf.featurevalue,mc.serverenvironment
from merchants m
left join merchantWebsiteFeatures mf on mf.merchant_id = m.id and mf.featureCode = 'template'
inner join merchantcms mc on mc.merchant_id = m.id
where m.merchant_code = 'playde'
--where mc.serverEnvironment = 'ewhserver1614'
--where mf.featurevalue = 'nwdynamicprov20_g1'
--where m.filepath = '2001audiovideo'
--where m.id in (536,393) and mf.featurevalue = 'nwdynamicprov20_g1'
--where m.merchant like '%groves%'
--where m.id = 1614
and m.active = 1
