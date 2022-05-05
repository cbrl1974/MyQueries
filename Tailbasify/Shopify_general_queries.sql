

-- Merchants
select * from shopify.shopifyMerchants
 where merchantid = 3398

-- update top (1) MerchantExports
-- set [status] = 1
-- where merchantid = 2887

select * from MerchantExports

select top 100 * from logs  WITH (NOLOCK)
WHERE  merchantid = 3398
order by LogTime desc

--Reports
--Convert Report
select top(50) *
from
    Shopify.ShopifyConvertReports h
join
    Shopify.ShopifyConvertProductReportsDetail d on h.Id = d.ConvertReportId
where
    d.Id in (select Id from Shopify.ShopifyProducts where MerchantId = 1202)
order by
    h.id desc


--Sunc Report
select top(50) *
from
    Shopify.ShopifySyncReports h
join
    Shopify.ShopifyProductSyncReportsDetail d on h.Id = d.SyncReportId
where
    d.ShopifyProductId in (select Id from Shopify.ShopifyProducts where MerchantId = 1202)
order by
    h.id desc




--Count on tailbasify
select count(1) from shopify.ShopifyMerchantCollections where merchantid = 1202
select * from shopify.shopifyProducts where merchantid = 1202 and ShopifyGeneratedProductId is not null
select count(1) from shopify.ShopifyProductVariants where ShopifyProductID  in (select id from shopify.shopifyProducts where merchantid = 1202)
select count(1) from shopify.ShopifyMerchantMetafields where ShopifyProductId  in (select id from shopify.shopifyProducts where merchantid = 1202)



--Configs
select  c.id, c.Configuration, sc.ConfigurationValue from shopify.ShopifyMerchantConfigurations sc
inner join shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = 12


select  * from shopify.ShopifyMerchantConfigurations where ShopifyMerchantId = 9
select * from shopify.ShopifyConfigurations order by id



-- Other tables on Tailbasify
select top 10 * from shopify.ShopifyCollectionRuleInputs
select top 10 * from shopify.ShopifyMerchantCollectionImages 
select * from SyncStatus
select * from shopify.shopifyProducts where merchantid = 1448



