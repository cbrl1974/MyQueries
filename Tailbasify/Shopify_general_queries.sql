

-- Merchants
select 
--*
 id, MerchantId,ShopUrl, SecurityStamp,ApiVersion
 from shopify.shopifyMerchants
  where merchantid = 3336


-- update top (1) MerchantExports
-- set [status] = 1
-- where merchantid = 3398

select * from MerchantExports order by [Status] desc

 --Logs for Converter
select top 200 * from logs  WITH (NOLOCK)
WHERE  merchantid = 3402
AND module = 'Converter'
order by LogTime desc

 --Logs for Synchronizer
select  top(100) * from logs  WITH (NOLOCK)
WHERE  merchantid = 3402
AND module = 'Synchronizer'
order by id desc


--Reports
--Convert Report
select  top(100) *
from Shopify.ShopifyConvertReports h
join Shopify.ShopifyConvertProductReportsDetail d on h.Id = d.ConvertReportId
where h.MerchantId = 3402
order by h.id desc



--Sunc Report
select 
--distinct d.[Status]
top(500) *
from Shopify.ShopifySyncReports h
join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 3336
order by h.id desc

select * from Shopify.ShopifyProductSyncReportsDetail where GraphQLCallInfo like '%7661386399964%'



select top (1) * from  Shopify.ShopifyConvertReports 
select top (1) * from  Shopify.ShopifyProductSyncReportsDetail 

select * from datatail20130410.dbo.merchantCollections where merchant_id = 2217 and collectionID = 22771
delete top (2) from datatail20130410.dbo.merchantCollections where merchant_id = 2217 and collectionID = 22771

select count(1) from datatail20130410.dbo.merchantprods where merchant_id = 3398 and productid in (730869)-- 
select * from shopify.shopifyProducts where  tailbaseid = 10028
select * from shopify.shopifyProducts where handle like  '%ashley-berringer-dining-chair-d199-1%'
select * from products where  model = 'd293-01'

select count(1) from shopify.shopifyProducts where merchantid = 3398 and tailbaseid = 10028
select * from shopify.ShopifyMerchantCollections where tailbaseid = 10028 an
select  * from shopify.ShopifyProducts where MerchantId = 3402 and Handle = 'canadel-chaise-de-salle-a-manger-gourmet-cnn090437u03avc'
select  * from shopify.ShopifyProducts where MerchantId = 2217 and [TitleEn] = 'LG 4.2 cu. ft. Front Loading Washer WM2355CS'
select  * from shopify.ShopifyProducts where MerchantId = 1956 and [ItemType] = 3
select top 10  * from shopify.ShopifyMerchantMetafields
select * from shopify.ShopifyMerchantMetafields
 where ShopifyProductId  in (select id from shopify.shopifyProducts where merchantid = 1448)

select  * from shopify.ShopifyProducts where MerchantId = 3336 and Handle =  'signature-design-by-ashley-mayflyn-tv-stand-w729-68'
select  * from shopify.ShopifyProducts where MerchantId = 3336 and Handle =  'signature-design-by-ashley-tv-stands-media-consoles-and-credenzas-w729-68w100-02'



  

select * from shopify.shopifyProducts where id = 259490

select * from datatail20130410.dbo.merchantcats where merchant_id = 2953
select * from datatail20130410.dbo.products where id_product = 722803
--Configs
select  c.id, c.Configuration, sc.ConfigurationValue from shopify.ShopifyMerchantConfigurations sc
inner join shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = 12




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


