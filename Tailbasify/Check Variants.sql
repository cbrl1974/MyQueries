select sp.merchantid, sp.vendor, sp.ProductType, sp.tailbaseid, sp.handle, sp.SyncStatusId, v.*
from shopify.shopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid =  3242
and sp.SyncStatusId = 4
and v.SyncStatusId <> 4

update top (109) shopify.shopifyProducts
set SyncStatusId = 2
where id in (select sp.id
from shopify.shopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid =  3242
and sp.SyncStatusId = 4
and v.SyncStatusId <> 4) 
and merchantid = 3242


select *
from Shopify.ShopifySyncReports h WITH (NOLOCK)
	join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where d.ShopifyProductId in (1121558)
order by h.id desc
