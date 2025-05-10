--**************************Configs
use tailbasify
DECLARE @MerchantId as int = 3477;
DECLARE @ShopifyMerchantId as int =  (select s.id
from tailbasify.shopify.shopifyMerchants s
    inner join datatail20130410.dbo.merchants m on m.id = s.MerchantId
where m.id = @MerchantId);

select @ShopifyMerchantId as ShopifyMerchantId, c.id, c.Configuration, sc.ConfigurationValue
from tailbasify.shopify.ShopifyMerchantConfigurations sc
    inner join tailbasify.shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = @ShopifyMerchantId

select sm.id, m.active, sm.MerchantId, sm.ShopUrl, sm.AccessToken from shopify.ShopifyMerchants sm
inner join datatail20130410.dbo.merchants m on m.id = sm.MerchantId
where sm.id not in (select ShopifyMerchantId from tailbasify.shopify.ShopifyMerchantConfigurations
where ShopifyConfigurationId = 22)
and m.active = 1
order by sm.merchantid desc

insert into tailbasify.shopify.ShopifyMerchantConfigurations
 values
     (19, 22, '[{"id":"gid://shopify/Publication/88933007592","name":"Online Store"},{"id":"gid://shopify/Publication/89588891880","name":"Shopify GraphiQL App"}]')




delete top (1) Tailbasify.shopify.ShopifyMerchantConfigurations 
where ShopifyMerchantId = 38 
and ShopifyConfigurationId = 19

update top (1) tailbasify.shopify.ShopifyMerchantConfigurations
set ConfigurationValue = 'yes'
where ShopifyMerchantId = 4
    and ShopifyConfigurationId = 23


select *
from tailbasify.shopify.ShopifyMerchantConfigurations

delete top (12) tailbasify.shopify.ShopifyMerchantConfigurations
 where ShopifyMerchantId = 4
 and ShopifyConfigurationId = 23

 
select *
from tailbasify.shopify.ShopifyMerchantConfigurations
where shopifyConfigurationid = 22



select *
from shopify.ShopifyMerchantConfigurations
where ShopifyMerchantId = 5

select *
from tailbasify.shopify.ShopifyConfigurations
where id = 22
order by id

select *
from tailbasify.shopify.ShopifyConfigurations
where id = 22
order by id

-- update top (1) tailbasify.shopify.ShopifyConfigurations
-- set Configuration  = 'ChannelPublicationIds'
-- where id = 23


