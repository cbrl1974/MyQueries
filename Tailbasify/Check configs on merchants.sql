--**************************Configs
use devtailbasify
DECLARE @MerchantId as int = 1448;
DECLARE @ShopifyMerchantId as int =  (select s.id
from devtailbasify.shopify.shopifyMerchants s
    inner join devtailbasecore.dbo.merchants m on m.id = s.MerchantId
where m.id = @MerchantId);

select @ShopifyMerchantId as ShopifyMerchantId, c.id, c.Configuration, sc.ConfigurationValue
from devtailbasify.shopify.ShopifyMerchantConfigurations sc
    inner join devtailbasify.shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = @ShopifyMerchantId

select *
from shopify.shopifyMerchants
where merchantid = 1448




--insert into tailbasify.shopify.ShopifyMerchantConfigurations
-- values
--     (100, 27, 'true')




--delete top (1) tailbasify.shopify.ShopifyMerchantConfigurations 
--where ShopifyMerchantId = 38 
--and ShopifyConfigurationId = 19

update top (1) devtailbasify.shopify.ShopifyMerchantConfigurations
set ConfigurationValue = 'False'
where ShopifyMerchantId = 5
    and ShopifyConfigurationId = 27


select *
from tailbasify.shopify.ShopifyMerchantConfigurations

--delete top (12) tailbasify.shopify.ShopifyMerchantConfigurations
-- where ShopifyMerchantId = 4
-- and ShopifyConfigurationId = 23

 
select *
from tailbasify.shopify.ShopifyMerchantConfigurations
where shopifyConfigurationid = 22

select * from shopify.ShopifyMerchants where id in (6,100)

select *
from shopify.ShopifyMerchantConfigurations
where ShopifyConfigurationId = 20

select *
from devtailbasify.shopify.ShopifyConfigurations
--where id = 22
order by id



 --update top (1) tailbasify.shopify.ShopifyConfigurations
 --set Configuration  = 'ChannelPublicationIds'
 --where id = 23

 select mp.merchant_id, mp.productid,mp.reducedPrice, mp.price
 ,sp.id, sp.handle, sp.SyncStatusId, v.Price, v.CompareAtPrice, v.SyncStatusId  
 from datatail20130410.dbo.merchantProds mp 
 join shopify.shopifyProducts sp on sp.merchantid = mp.merchant_id and sp.tailbaseid = mp.productid
 join shopify.shopifyProductVariants v on v.ShopifyProductID = sp.id 
 where mp.merchant_id =3607
 and sp.handle = 'tempur-pedic-tempur-neck-bed-pillow-15325144'
 and v.price is null
 order by mp.price

 select * from datatail20130410.dbo.categories where category like '%pillow%' and id_langue = 1
 select * from datatail20130410.dbo.merchantcats where merchant_id = 3607 and catid = 272
 select id_product, model, manufmodel,modelkey, manufacturerIdentifier from datatail20130410.dbo.products where id_product = 397938
  select specifi from datatail20130410.dbo.merchantprods where productid = 397938 and merchant_id = 3607


