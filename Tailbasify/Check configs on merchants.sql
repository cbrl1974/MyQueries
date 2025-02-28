--**************************Configs
use devtailbasify
DECLARE @MerchantId as int = 1448;
DECLARE @ShopifyMerchantId as int =  (select s.id
from devtailbasify.shopify.shopifyMerchants s
    inner join DevTailbaseCore.dbo.merchants m on m.id = s.MerchantId
where m.id = @MerchantId);

select @ShopifyMerchantId as ShopifyMerchantId, c.id, c.Configuration, sc.ConfigurationValue
from devtailbasify.shopify.ShopifyMerchantConfigurations sc
    inner join devtailbasify.shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = @ShopifyMerchantId


delete top (1) Tailbasify.shopify.ShopifyMerchantConfigurations 
where ShopifyMerchantId = 38 
and ShopifyConfigurationId = 19

update top (1) DevTailbasify.shopify.ShopifyMerchantConfigurations
set ConfigurationValue = 'yes'
where ShopifyMerchantId = 4
    and ShopifyConfigurationId = 23


select *
from DevTailbasify.shopify.ShopifyMerchantConfigurations

delete top (12) DevTailbasify.shopify.ShopifyMerchantConfigurations
 where ShopifyMerchantId = 4
 and ShopifyConfigurationId = 23

 insert into DevTailbasify.shopify.ShopifyMerchantConfigurations
 values
     (4, 23, 'yes')


select *
from devtailbasify.shopify.ShopifyMerchantConfigurations
where shopifyConfigurationid = 22



select *
from shopify.ShopifyMerchantConfigurations
where ShopifyMerchantId = 5

select *
from devtailbasify.shopify.ShopifyConfigurations
where id = 22
order by id

select *
from tailbasify.shopify.ShopifyConfigurations
where id = 22
order by id

-- update top (1) devtailbasify.shopify.ShopifyConfigurations
-- set Configuration  = 'ChannelPublicationIds'
-- where id = 23


