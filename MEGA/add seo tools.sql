select seoManagement from merchantcms where merchant_id = 2639 
update top (1) merchantcms set seoManagement = 1 where merchant_id = 2639

select * from merchantwebsitefeatures where merchant_id = 2639 and featurecode = 'hasSEO'
insert into merchantwebsitefeatures values
(2639,'hasSEO','')

update top (1) merchantwebsitefeatures set featurevalue = NULL where merchant_id = 2639 and featurecode = 'hasSEO'

update url
http://sitnsl.pvm813.tailbase.com/en/?reset=me2
http://sitnsl.pvm812.tailbase.com/en/?reset=me2

