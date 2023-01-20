--**************************Configs
DECLARE @MerchantId as int = 3335;
DECLARE @ShopifyMerchantId as int =  (select s.id from shopify.shopifyMerchants s
    inner join datatail20130410.dbo.merchants m on m.id = s.MerchantId
where m.id = @MerchantId);

select c.id, c.Configuration, sc.ConfigurationValue
from shopify.ShopifyMerchantConfigurations sc
    inner join shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = @ShopifyMerchantId


select *
from shopify.ShopifyMerchantConfigurations
where ShopifyMerchantId = @ShopifyMerchantId

select *
from shopify.ShopifyConfigurations
order by id