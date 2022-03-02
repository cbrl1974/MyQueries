select * from shopify.shopifyMerchants where merchantid = 2798
select * from shopify.shopifyProducts where merchantid = 2798 and vendor = 'blomberg' and tailbaseID = 
select * from MerchantExports where merchantid = 2798
select * from shopify.ShopifyConvertReports where merchantid = 2798 order by EndTime desc

select * from shopify.ShopifySyncReports where merchantid = 2798
select * from shopify.shopifyProducts where merchantid = 2798
select top 10 * from logs order by LogTime desc

select * from SyncStatus

select  * from DevTailbaseCore.dbo.TaApplianceEpassParentProducts
select  * from DevTailbaseCore.dbo.TaApplianceEpassChildProducts
select * from shopify.shopifyProducts where merchantid = 2887
