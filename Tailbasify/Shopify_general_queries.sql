

-- Merchants
select 
--*
 id, MerchantId,ShopUrl, SecurityStamp,ApiVersion
 from shopify.shopifyMerchants
  where merchantid = 3398


-- update top (1) MerchantExports
-- set [status] = 1
-- where merchantid = 3398

select * from MerchantExports order by [Status] desc

 --Logs for Converter
select top 200 * from logs  WITH (NOLOCK)
WHERE  merchantid = 3398
AND module = 'Converter'
order by LogTime desc

 --Logs for Synchronizer
select top 200 * from logs  WITH (NOLOCK)
WHERE  merchantid = 3398
AND module = 'Synchronizer'
order by id desc



--Reports
--Convert Report
select  top(50) *
from Shopify.ShopifyConvertReports h
join Shopify.ShopifyConvertProductReportsDetail d on h.Id = d.ConvertReportId
where h.MerchantId = 3398
order by h.id desc



--Sunc Report
select 
--distinct d.[Status]
top(500) *
from Shopify.ShopifySyncReports h
join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 3398
--AND d.ShopifyProductId = 279112
and h.StartTime > '2022-06-15 15:20:51.260'
order by h.id desc



select top (1) * from  Shopify.ShopifyConvertReports 
select top (1) * from  Shopify.ShopifyProductSyncReportsDetail 

select * from datatail20130410.dbo.merchantCollections where merchant_id = 2217 and collectionID = 22771
delete top (2) from datatail20130410.dbo.merchantCollections where merchant_id = 2217 and collectionID = 22771

select count(1) from datatail20130410.dbo.merchantprods where merchant_id = 3398 and productid in (730869)-- 
select * from shopify.shopifyProducts where  tailbaseid = 10028


select count(1) from shopify.shopifyProducts where merchantid = 3398 and tailbaseid = 10028
select * from shopify.ShopifyMerchantCollections where tailbaseid = 10028 an
select  * from shopify.ShopifyProducts where MerchantId = 2217 and Handle = 'crown-mark-sheffield-3-drawer-nightstand-b1100-2'
select  * from shopify.ShopifyProducts where MerchantId = 2217 and [TitleEn] = 'LG 4.2 cu. ft. Front Loading Washer WM2355CS'
select  * from shopify.ShopifyProducts where MerchantId = 1956 and [ItemType] = 3
select top 10  * from shopify.ShopifyMerchantMetafields
select * from shopify.ShopifyMerchantMetafields
 where ShopifyProductId  in (select id from shopify.shopifyProducts where merchantid = 1448)



  

select * from shopify.shopifyProducts where id = 280504

--Configs
select  c.id, c.Configuration, sc.ConfigurationValue from shopify.ShopifyMerchantConfigurations sc
inner join shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = 13



select  * from shopify.ShopifyMerchantConfigurations
select * from shopify.ShopifyConfigurations order by id



-- Other tables on Tailbasify
select top 10 * from shopify.ShopifyCollectionRuleInputs
select top 10 * from shopify.ShopifyMerchantCollectionImages 
select * from SyncStatus
select * from shopify.shopifyProducts where merchantid = 1448

--Convert STATUS:
ConvertedOnly = 1,
ConvertedAndCompared = 2,
ConversionFailed = 3,
ConversionSuccess = 4

Sync Ctatus:
-- 1	Insert
-- 2	Update
-- 3	Delete
-- 4	Synced
-- 5	DeleteSynced



 




