

-- Merchants
select  s.id, m.merchant, s.MerchantId,s.ShopUrl, s.SecurityStamp,s.ApiVersion
 from shopify.shopifyMerchants s
 inner join  devTailbaseCore.dbo.merchants m on m.id = s.MerchantId
where m.id = 1202

update top (1) MerchantExports
set [status] = 1
where merchantid = 1202

select * from MerchantExports order by [Status] desc

 --Logs for Converter
select top 200 * from logs  WITH (NOLOCK)
WHERE  merchantid = 1202
AND module = 'Converter'
order by LogTime desc

 --Logs for Synchronizer
select  top(50) * from logs  WITH (NOLOCK)
WHERE  merchantid = 1202
AND module = 'Synchronizer'
--AND text like '%235625%'
order by id desc

select 
--distinct d.[Status]
top(3) *
from Shopify.ShopifyConvertReports h WITH (NOLOCK)
join Shopify.ShopifyConvertProductReportsDetail d on h.id = d.ConvertReportId
where h.MerchantId = 1202
--and ShopifyProductId in (235625,236600,245032)
order by h.id desc


--Sunc Report
select 
--distinct d.[Status]
top(3) *
from Shopify.ShopifySyncReports h WITH (NOLOCK)
join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 1202
and ShopifyProductId in (235625,236600,245032)
order by h.id desc

select * from Shopify.ShopifyProductSyncReportsDetail where GraphQLCallInfo like '%7661386399964%'



select top (1) * from  Shopify.ShopifyConvertReports 
select top (1) * from  Shopify.ShopifyProductSyncReportsDetail 

select * from datatail20130410.dbo.merchantCollections where merchant_id = 1202 and collectionID = 22771
select * from datatail20130410.dbo.merchantcats where merchant_id = 1202
select top 10 * from datatail20130410.dbo.categories where merchant_id = 1202
select count(1) from datatail20130410.dbo.merchantprods where merchant_id = 1202 and productid in (625714)-- 
select * from shopify.shopifyProducts where  tailbaseid = 10028
select * from shopify.shopifyProducts where handle like  '%ashley-berringer-dining-chair-d199-1%'
select * from products where  model = 'd293-01'

select * from shopify.shopifyProducts where merchantid = 1202 and tailbaseid  = '625714'
select * from datatail20130410.dbo.merchantprods where merchant_id = 1202 and productid in (603870)
select * from shopify.ShopifyMerchantCollections where tailbaseid = 603870 an
select  * from shopify.ShopifyProducts where MerchantId = 1202 and Handle = 'elran-canape-fixe-sadie-sadie-10226-fix-06-sofa'
select  * from shopify.ShopifyProducts where MerchantId = 1202 and [TitleEn] = 'LG 4.2 cu. ft. Front Loading Washer WM2355CS'
select  * from shopify.ShopifyProducts where MerchantId = 1202 and [ItemType] = 3
select * from shopify.shopifyProducts where merchantid = 1202 and tailbaseid  in (603870)
select top 10  * from shopify.ShopifyMerchantMetafields
select * from shopify.shopifyProducts where merchantid = 1202 and tags like '%model%'
select * from shopify.ShopifyMerchantMetafields
 where ShopifyProductId  in (select id from shopify.shopifyProducts where merchantid = 1448)

select  * from shopify.ShopifyProducts where MerchantId = 3336 and Handle =  'signature-design-by-ashley-mayflyn-tv-stand-w729-68'
select  * from shopify.ShopifyProducts where MerchantId = 3336 and Handle =  'signature-design-by-ashley-tv-stands-media-consoles-and-credenzas-w729-68w100-02'

 

--Configs
select  c.id, c.Configuration, sc.ConfigurationValue from shopify.ShopifyMerchantConfigurations sc
inner join shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = 1




select  * from shopify.ShopifyMerchantConfigurations where ShopifyConfigurationId = 8
select * from shopify.ShopifyConfigurations order by id



-- Other tables on Tailbasify
select top 10 * from shopify.ShopifyCollectionRuleInputs
select top 10 * from shopify.ShopifyMerchantCollectionImages 
select * from SyncStatus
select * from shopify.shopifyProducts where merchantid = 1448

--Convert STATUS:
-- ConvertedOnly = 1,
-- ConvertedAndCompared = 2,
-- ConversionFailed = 3,
-- ConversionSuccess = 4

-- Sync Status:
-- 1	Insert
-- 2	Update
-- 3	Delete
-- 4	Synced
-- 5	DeleteSynced


select distinct m.ShopifyProductId from shopify.shopifyProducts s 
inner join shopify.shopifyProductMedia m on m.shopifyProductid = s.ID
where s.MerchantId = 3336
and s.ItemType in (1,2)
and m.ShopifyGeneratedMediaId is null

 

select  * from shopify.ShopifyProducts where  Handle = 'Crown Mark 1-Drawer Vanity Set 2208SET-ESP'


SELECT * FROM Shopify.ShopifyMerchantCollections 
WHERE SyncStatusId = 3 
AND ShopifyGeneratedCollectionId IS NULL 
AND MerchantId = 1956


select * from datatail20130410.dbo.merchantrebates where merchant_id = 1956 and id_rebate = 1072518

kitchenaid-cook-up-the-savings-offer


