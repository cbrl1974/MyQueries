DECLARE @merchantid as int = 3527;
DECLARE @action as int = 3;
DECLARE @count as int = (select count(v.id)
from shopify.shopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
	inner join datatail20130410.dbo.merchants m on m.id = sp.merchantid
where 1 = 1
and sp.merchantid =  @merchantid
and sp.SyncStatusId = 4
and v.SyncStatusId <> 4)

--SELECT @count

select sp.merchantid, sp.vendor, sp.ProductType, sp.tailbaseid, sp.handle, sp.SyncStatusId, v.*
from shopify.shopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
	inner join datatail20130410.dbo.merchants m on m.id = sp.merchantid
where 1 = 1
and sp.merchantid =  @merchantid
and sp.SyncStatusId = 4
and v.SyncStatusId <> 4
--and sp.id = 1859406
order by m.id

IF @count > 1
BEGIN
    UPDATE  sp
    SET sp.SyncStatusId = 2
    FROM shopify.shopifyProducts sp
    WHERE sp.id IN (
        SELECT DISTINCT sp2.id
        FROM shopify.shopifyProductVariants v2
        INNER JOIN shopify.shopifyProducts sp2 
            ON sp2.id = v2.ShopifyProductId
        WHERE sp2.merchantid = @merchantid
          AND sp2.SyncStatusId = 4
          AND v2.SyncStatusId <> 4
    );
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
			and s.merchantid =  @merchantid
			and m.active = 1
	order by s.id
END





select *
from Shopify.ShopifySyncReports h WITH (NOLOCK)
	join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where d.ShopifyProductId in (572567)
order by h.id desc

update top (46) shopify.ShopifyProductVariants
set ShopifyGeneratedInventoryItemId = null
where shopifyproductid in (select v.ShopifyProductID
from shopify.shopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
	inner join datatail20130410.dbo.merchants m on m.id = sp.merchantid
where 1 = 1
and sp.merchantid =  3242
and sp.SyncStatusId = 4
and v.SyncStatusId <> 4)

