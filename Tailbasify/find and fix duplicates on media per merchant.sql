select 
    m.Id as MediaId,
    m.ShopifyProductId,
    m.TailbaseId,
    m.MediaContentTypeId,
    m.DisplayOrder,
    row_number() over (
        partition by m.ShopifyProductId, m.TailbaseId, m.MediaContentTypeId, m.DisplayOrder
        order by m.Id
    ) as rn
from Shopify.ShopifyProductMedia m
inner join shopify.shopifyProducts sp 
    on sp.id = m.ShopifyProductId
where sp.MerchantId = 3559
  and m.ShopifyProductId in (
        select id
        from shopify.shopifyProducts
        where merchantid = 3559 
          and SyncStatusId = 1
    )
order by m.ShopifyProductId, m.TailbaseId, m.MediaContentTypeId, m.DisplayOrder, m.Id;

;with Duplicates as (
    select 
        m.Id,
        row_number() over (
            partition by m.ShopifyProductId, m.TailbaseId, m.MediaContentTypeId, m.DisplayOrder
            order by m.Id
        ) as rn
    from Shopify.ShopifyProductMedia m
    where m.ShopifyProductId in (
        select id
        from shopify.shopifyProducts
        where MerchantId = 3559
          and SyncStatusId = 1
    )
)
delete from Shopify.ShopifyProductMedia
where Id in (
    select Id from Duplicates where rn > 1
);