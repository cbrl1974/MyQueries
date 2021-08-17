use datatail20130410

select * from merchantwebsitefeatures where merchant_id = 1450
select * from merchantwebsitefeatures where featurecode like '%ads%'
insert into merchantwebsitefeatures values
(1450,'hasInlineAdsOnProductListPage',null),
(1450,'adsFrequency',6)

--Console Procedure
--In the future to activate this feature which is not available on all templates you just have to go to “Ad Spots Management“ and once you get to the page you just need to click at the top right corner where it says “Create“.
--Once there you have a drop down menu with the “Random Ads“ you just select and create. 