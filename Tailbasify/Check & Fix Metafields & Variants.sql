use Tailbasify
--========= Check and fix for 
select *
from shopify.shopifyMerchants
where merchantid = 3650
--2569: 95BCBF1F-8727-4EEE-B6E0-9EF1FD6961E0



SELECT sp.merchantid, m.merchant, sp.id, sp.tailbaseid, sp.syncstatusid, sp.handle, 
sp.ShopifyGeneratedProductId, mp.price, mp.reducedPrice, me.Status,
	v.id,sp.options, v.Options, v.SyncStatusId, v.ShopifyGeneratedVariantId, v.InventoryLevel
FROM [Shopify].[ShopifyProducts] sp  WITH (NOLOCK)
	--join shopify.ShopifyMerchantMetafields v on v.shopifyProductId = sp.id
	join shopify.ShopifyProductVariants v on v.shopifyProductId = sp.id
	join MerchantExports me on me.MerchantId = sp.MerchantId
	join datatail20130410.dbo.merchants m on m.id = sp.merchantid
	join datatail20130410.dbo.merchantProds mp on mp.merchant_id = sp.merchantid and mp.productid = sp.tailbaseid and sp.itemtype = 1
where sp.SyncStatusId = 2
	and v.syncstatusId <> 4
	and me.Status = 1
	and m.active = 1
	and m.id =3372
--and sp.id = 3519754


select h.MerchantId, d.ShopifyProductId, d.text, h.StartTime, h.endtime, d.GraphQLCallInfo
from Shopify.ShopifySyncReports h WITH (NOLOCK)
	join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where d.ShopifyProductId in (3457514)
order by h.id desc


select distinct *
from logs  WITH (NOLOCK)
WHERE  merchantid = 3527
	and LogTime > convert(date,getdate()-0)
order by LogTime desc



update top (10) [Shopify].[ShopifyProducts]
  set SyncStatusId = 2
  where id in (SELECT sp.id
FROM [Shopify].[ShopifyProducts] sp
	--join shopify.ShopifyMerchantMetafields v on v.shopifyProductId = sp.id
	join shopify.ShopifyProductVariants v on v.shopifyProductId = sp.id
	join MerchantExports me on me.MerchantId = sp.MerchantId
	join datatail20130410.dbo.merchants m on m.id = sp.merchantid
where sp.SyncStatusId = 4
	and v.syncstatusId <> 4
	and m.id = 3372)


	delete top (3) shopify.ShopifyProductVariants
	where id in (SELECT v.id
FROM [Shopify].[ShopifyProducts] sp
	--join shopify.ShopifyMerchantMetafields v on v.shopifyProductId = sp.id
	join shopify.ShopifyProductVariants v on v.shopifyProductId = sp.id
	join MerchantExports me on me.MerchantId = sp.MerchantId
	join datatail20130410.dbo.merchants m on m.id = sp.merchantid
where sp.SyncStatusId = 4
	and v.syncstatusId = 2
	and m.id = 3527)










 update top(5) shopify.ShopifyProductVariants
 set SyncStatusId = 3
 where id in (4156370,4156371,4096838,4130454,4156372)


-- update top(1) shopify.ShopifyProducts
-- set SyncStatusId = 2
-- where id = 3520200




select productid, price, reducedPrice
from devtailbasecore.dbo.merchantProds
where merchant_id = 2216
	and productid = 493008

select *
from devtailbasecore.dbo.companies
where cie like '%Malouf%'




