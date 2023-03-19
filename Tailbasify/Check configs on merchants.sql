--**************************Configs
DECLARE @MerchantId as int = 1448;
DECLARE @ShopifyMerchantId as int =  (select s.id from shopify.shopifyMerchants s
    inner join DevTailbaseCore.dbo.merchants m on m.id = s.MerchantId
where m.id = @MerchantId);

select @ShopifyMerchantId

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


delete top (1) shopify.ShopifyMerchantConfigurations
 where ShopifyMerchantId = 5
 and ShopifyConfigurationId = 18


insert into shopify.ShopifyMerchantConfigurations values
(5,18,'True')

delete top(2) shopify.ShopifyMerchantConfigurations  where ShopifyMerchantId = 33
