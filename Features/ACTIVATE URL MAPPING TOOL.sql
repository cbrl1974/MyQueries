use datatail20130410
SELECT DISTINCT FEATURECODE FROM MERCHANTWEBSITEFEATURES ORDER BY FEATURECODE
use datatail20130410
select hasURLMapping from merchantcms where merchant_id = 2456

update top (1) merchantcms set hasURLMapping = 1 where merchant_id = 2456


select merchant_id,hasURLMapping from merchantcms where hasURLMapping = 1

select * from merchantwebsitefeatures where merchant_id = 2456