

-- ***************Fix For Missing Images***********************
select spm.OriginalSource, spm.ShopifyGeneratedMediaId, spm.TailbaseId, spm.SyncStatusId
from shopify.ShopifyProductMedia spm 
inner join shopify.shopifyProducts sp on sp.id = spm.ShopifyProductId
where sp.MerchantId = 3335
and spm.ShopifyGeneratedMediaId is null
and spm.OriginalSource is not null




-- update top (3088) shopify.ShopifyProductMedia 
-- set SyncStatusId = 2
-- where ShopifyProductId in ( select id from shopify.shopifyProducts where MerchantId = 3335)
-- and ShopifyGeneratedMediaId is null
-- and OriginalSource is not null





select distinct sp.id, sp.tailbaseid, sp.handle, sp.SyncStatusId , sp.ShopifyGeneratedProductId, spm.ShopifyGeneratedMediaId
from [Shopify].[ShopifyProducts] sp
inner join shopify.ShopifyProductMedia spm  on spm.shopifyProductId = sp.id
where sp.merchantid  = 3335
and  spm.ShopifyGeneratedMediaId is null
and spm.OriginalSource is not null



-- update top (1506)[Shopify].[ShopifyProducts]
-- set SyncStatusId  = 2
-- where merchantid  = 3335
-- and id in (select shopifyProductId from shopify.ShopifyProductMedia 
-- where ShopifyGeneratedMediaId is null
-- and OriginalSource is not null)