--**************************Configs
DECLARE @MerchantId as int = 1448;
DECLARE @ShopifyMerchantId as int =  (select s.id from shopify.shopifyMerchants s
    inner join devTailbaseCore.dbo.merchants m on m.id = s.MerchantId
where m.id = @MerchantId);

select @ShopifyMerchantId as ShopifyMerchantId, c.id, c.Configuration, sc.ConfigurationValue
from shopify.ShopifyMerchantConfigurations sc
    inner join shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = @ShopifyMerchantId

-- delete top (1) shopify.ShopifyMerchantConfigurations
--  where ShopifyMerchantId = @ShopifyMerchantId
--  and ShopifyConfigurationId = 18

-- insert into shopify.ShopifyMerchantConfigurations values
-- (5,18, 'True')



--select *
--from shopify.ShopifyMerchantConfigurations
--where ShopifyMerchantId = @ShopifyMerchantId

select *
from shopify.ShopifyConfigurations
order by id


