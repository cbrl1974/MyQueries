use Tailbasify

--CHECK EXPORTS
select  me.MerchantId,merchant, me.Status, me.ModificationDate, me.ShopifyMerchantId
from tailbasify.dbo.MerchantExports me WITH (NOLOCK)
    inner join datatail20130410.dbo.merchants m on m.id = me.MerchantId
	inner join tailbasify.shopify.ShopifyMerchants sm on sm.MerchantId = me.MerchantId
	--and  me.MerchantId = 1956
	and sm.ApiVersion is not null
order by [Status] desc, me.ModificationDate desc

--CHECK FOR DUPLICATES OR UNFINISHED VARIANTS SYNCS
select sp.merchantid, sp.SyncStatusId, v.*
from shopify.ShopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
	where 1 = 1
    and sp.merchantid not in (3209,2798,1956)
	and sp.merchantid  = 3523
and v.ShopifyGeneratedVariantId is null
--and sp.SyncStatusId = 4
order by sp.MerchantId

--DELETE UNFINISHED OR DUPLICATES
delete top (50) from  shopify.ShopifyProductVariants
where id in (select v.id
from shopify.ShopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
	where 1 = 1
	and sp.merchantid  = 2384
and v.ShopifyGeneratedVariantId is null
)

--CHECK SYNC FLOW
select distinct  merchantid, text,logtime, category module 
from logs  WITH (NOLOCK) 
WHERE  merchantid = 3527
and LogTime > convert(date,getdate()-0)
order by LogTime desc 

--CHECK SYNC LOGS
select *
from Shopify.ShopifySyncReports h WITH (NOLOCK)
    join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
    where d.ShopifyProductId in (2921873)
order by h.id desc


--CHECK FOR INFO ON VARIANT
select * from shopify.ShopifyProductVariants where id = 3344786



--Update = 1
--Convert only = 2 
--Synchronize only = 3

Declare @action as int = 3;

-- Merchants
select
    s.MerchantId, s.id, m.merchant,
	case
	when @action = 1  then 'https://api.tailbasify.com/'+ s.ApiVersion + '/api/Shopify/Update/' + s.SecurityStamp 
	WHEN  @action = 2 then 'https://api.tailbasify.com/'+ s.ApiVersion + '/api/Converter/Convert/' + s.SecurityStamp 
	WHEN  @action = 3 then 'https://api.tailbasify.com/'+ s.ApiVersion + '/api/Synchronizer/Synchronize/' + s.SecurityStamp 
	  END AS EndPoint,
	 s.ShopUrl, s.SecurityStamp, s.AccessToken, ApiKey
from shopify.shopifyMerchants s
    inner join datatail20130410.dbo.merchants m on m.id = s.MerchantId
	and s.merchantid = 3523
	and m.active = 1
order by s.id