--**************************Configs
DECLARE @MerchantId as int = 3065;
DECLARE @ShopifyMerchantId as int =  (select s.id from shopify.shopifyMerchants s
    inner join datatail20130410.dbo.merchants m on m.id = s.MerchantId
where m.id = @MerchantId);

select @ShopifyMerchantId as ShopifyMerchantId, c.id, c.Configuration, sc.ConfigurationValue
from shopify.ShopifyMerchantConfigurations sc
    inner join shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = @ShopifyMerchantId

 --delete top (12) shopify.ShopifyMerchantConfigurations
 -- where ShopifyMerchantId = @ShopifyMerchantId
 -- and ShopifyConfigurationId = 18

 --insert into shopify.ShopifyMerchantConfigurations values
 --(5,4, 'English'),
 --(5,1, 'True')


 select * from [DB.PROD].tailbasify.shopify.ShopifyMerchantConfigurations 
 where shopifyConfigurationid = 22

--  update top (1) [DB.PROD].tailbasify.shopify.ShopifyMerchantConfigurations
-- set configurationValue  = '[{"id":"gid://shopify/Publication/118572417159","name":"Online Store"},{"id":"gid://shopify/Publication/118572482695","name":"Point of Sale"},{"id":"gid://shopify/Publication/118572515463","name":"Shop"},{"id":"gid://shopify/Publication/119793057927","name":"Shopify GraphiQL App"}]'
-- where id = 464
-- and shopifyConfigurationid = 22



select *
from shopify.ShopifyMerchantConfigurations
where ShopifyMerchantId = 5

select *
from shopify.ShopifyConfigurations
where id = 22
order by id

select *
from [DB.PROD].tailbasify.shopify.ShopifyConfigurations
where id = 22
order by id

-- update top (1) [DB.PROD].tailbasify.shopify.ShopifyConfigurations
-- set Configuration  = 'ChannelPublicationIds'
-- where id = 22


