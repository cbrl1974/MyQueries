select * from WebsitePageDesigns
-- 29 Design X


select * from merchantwebsitepages where websitepagedesignID = 29 and merchant_id = 1427

--insert into merchantwebsitepages (merchant_id,name,slug,WebsitePageDesignId,active,fullCacheablePage,alwaysRecalculate,useV2Rendering) values
--(633,'Define Your Style Savings Event','define-your-style-savings-event',29,1,0,0,1),
--(800,'Define Your Style Savings Event','define-your-style-savings-event',29,1,0,0,1),
--(848,'Define Your Style Savings Event','define-your-style-savings-event',29,1,0,0,1),
--(879,'Define Your Style Savings Event','define-your-style-savings-event',29,1,0,0,1),
--(887,'Define Your Style Savings Event','define-your-style-savings-event',29,1,0,0,1),
--(894,'Define Your Style Savings Event','define-your-style-savings-event',29,1,0,0,1),
--(1083,'Define Your Style Savings Event','define-your-style-savings-event',29,1,0,0,1),
--(1106,'Define Your Style Savings Event','define-your-style-savings-event',29,1,0,0,1),
--(1402,'Define Your Style Savings Event','define-your-style-savings-event',29,1,0,0,1),
--(1427,'Define Your Style Savings Event','define-your-style-savings-event',29,1,0,0,1),
--(1433,'Define Your Style Savings Event','define-your-style-savings-event',29,1,0,0,1),
--(1578,'Define Your Style Savings Event','define-your-style-savings-event',29,1,0,0,1),
--(1582,'Define Your Style Savings Event','define-your-style-savings-event',29,1,0,0,1),
--(1632,'Define Your Style Savings Event','define-your-style-savings-event',29,1,0,0,1),
--(1674,'Define Your Style Savings Event','define-your-style-savings-event',29,1,0,0,1),
--(1675,'Define Your Style Savings Event','define-your-style-savings-event',29,1,0,0,1),
--(1727,'Define Your Style Savings Event','define-your-style-savings-event',29,1,0,0,1),
--(1789,'Define Your Style Savings Event','define-your-style-savings-event',29,1,0,0,1)

select mwp.id, CONCAT(m.merchant_url, '/','en','/','cp-', mwp.slug) as url from merchantwebsitepages mwp
inner join merchants m on m.id = mwp.merchant_id
 where mwp.merchant_id in (920,887,1686,966,1727,1083,1370,1660,1573,633,1196,1582,894,1402,1502,1106,1433,1674,1632,1675,1578,848,879,800,1313)
and mwp.websitepagedesignID = 29 
and mwp.name = 'Buy More Save More'

select * from MerchantWebsitePageContent where merchantwebsitepageid = 6591

select * from WebsitePageDesignContent where WebsitePageDesignId = 29


delete top (3) from MerchantWebsitePageContent where id in (389227)

--insert into  MerchantWebsitePageContent values
--(8487,'ListingItem1ProductType','product',1)