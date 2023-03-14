--**************************Configs
DECLARE @MerchantId as int = 3443;
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



--insert into shopify.ShopifyMerchantConfigurations values
--(34,15,'True'),
--(34,16,'True')

--delete top(2) shopify.ShopifyMerchantConfigurations  where ShopifyMerchantId = 33
