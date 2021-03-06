
INSERT INTO datatail20130410.dbo.merchantprods
SELECT * FROM datatail20130410.dbo.merchantprods where merchant_id = 1012 and productid =463022

select * from MerchantWebsitePages where merchant_id = 961 and id = 8883

INSERT INTO devtailbasecore.dbo.MerchantWebsitePageContent (MerchantWebsitePageId,ContentCode,Content,Id_langue)
SELECT 8647,mp.ContentCode,mp.Content,mp.Id_langue
FROM  datatail20130410.dbo.MerchantWebsitePageContent mp
where mp.merchantwebsitepageid = 8883


select *
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='geocodes'
use datatail20130410
select * from  datatail20130410.dbo.geocodes where postalcode in ('32898','33107','33110','33121','33148','33195','33439','33447','33651','33690','33697')
select * from stagingTailbasecore.dbo.geocodes where postalcode in  ('32898','33107','33110','33121','33148','33195','33439','33447','33651','33690','33697')

--('33690','33697')

DECLARE @county AS varchar(50) = 'Hillsborough';
DECLARE @city AS varchar(50) = 'Tampa';
DECLARE @latitude AS decimal(10,6) = '27.871964';
DECLARE @longitude AS decimal(10,6) = '-82.438841';
DECLARE @postalcode AS nvarchar(50) = '33697';


--Production
insert into datatail20130410.dbo.geocodes (countryCode,countryName,provinceCode,provinceName,city,county,latitude,longitude,postalCode) 
select countryCode, countryName, provinceCode, provinceName, @city,@county,@latitude ,@longitude,@postalcode
from datatail20130410.dbo.geocodes
where id = 888167

--staging
insert into stagingTailbasecore.dbo.geocodes (countryCode,countryName,provinceCode,provinceName,city,county,latitude,longitude,postalCode) 
select countryCode, countryName, provinceCode, provinceName, @city,@county,@latitude ,@longitude,@postalcode
from stagingTailbasecore.dbo.geocodes
where id = 888167