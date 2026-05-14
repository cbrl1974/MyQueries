--**************************Configs
use devtailbasify
DECLARE @MerchantId as int = 2798;
DECLARE @ShopifyMerchantId as int =  (select s.id
from devtailbasify.shopify.shopifyMerchants s
    inner join devtailbasecore.dbo.merchants m on m.id = s.MerchantId
where m.id = @MerchantId);

select @ShopifyMerchantId as ShopifyMerchantId, c.id, c.Configuration, sc.ConfigurationValue
from devtailbasify.shopify.ShopifyMerchantConfigurations sc
    inner join devtailbasify.shopify.ShopifyConfigurations c on c.Id = sc.ShopifyConfigurationId
where ShopifyMerchantId = @ShopifyMerchantId

select * from devtailbasify.shopify.ShopifyMerchantConfigurations where ShopifyConfigurationId = 24 and ConfigurationValue = 'True'

select * from shopify.ShopifyMerchants where id in (22,110,112,113,114,115,76,116)

select *
from shopify.shopifyMerchants
where merchantid = 2798

select MerchantId, status from devtailbasify.dbo.MerchantExports where merchantid = 2798 

update top (1) devtailbasify.dbo.MerchantExports
set status = 1
where merchantid = 2798




insert into devtailbasify.shopify.ShopifyMerchantConfigurations
values
    (112, 26, 'SpecificTitleEn')




--delete top (1) devtailbasify.shopify.ShopifyMerchantConfigurations 
--where ShopifyMerchantId = 38 
--and ShopifyConfigurationId = 19

update top (1) devdevtailbasify.shopify.ShopifyMerchantConfigurations
set ConfigurationValue = 'False'
where ShopifyMerchantId = 5
    and ShopifyConfigurationId = 27


select *
from devtailbasify.shopify.ShopifyMerchantConfigurations

--delete top (12) devtailbasify.shopify.ShopifyMerchantConfigurations
-- where ShopifyMerchantId = 4
-- and ShopifyConfigurationId = 23


select *
from devtailbasify.shopify.ShopifyMerchantConfigurations
where shopifyConfigurationid = 26

select *
from shopify.ShopifyMerchants
where id in (6,100)

select *
from shopify.ShopifyMerchantConfigurations
where ShopifyConfigurationId = 9

select *
from devtailbasify.shopify.ShopifyConfigurations
where id = 26
order by id



--update top (1) devtailbasify.shopify.ShopifyConfigurations
--set Configuration  = 'ChannelPublicationIds'
--where id = 23

select mp.merchant_id, mp.productid, mp.reducedPrice, mp.price
 , sp.id, sp.handle, sp.SyncStatusId, v.Price, v.CompareAtPrice, v.SyncStatusId
from devtailbasecore.dbo.merchantProds mp
    join shopify.shopifyProducts sp on sp.merchantid = mp.merchant_id and sp.tailbaseid = mp.productid
    join shopify.shopifyProductVariants v on v.ShopifyProductID = sp.id
where mp.merchant_id =3607
    and sp.handle = 'tempur-pedic-tempur-neck-bed-pillow-15325144'
    and v.price is null
order by mp.price

select *
from devtailbasecore.dbo.categories
where category like '%pillow%' and id_langue = 1
select *
from devtailbasecore.dbo.merchantcats
where merchant_id = 3607 and catid = 272
select id_product, model, manufmodel, modelkey, manufacturerIdentifier
from devtailbasecore.dbo.products
where id_product = 397938
select specifi
from devtailbasecore.dbo.merchantprods
where productid = 397938 and merchant_id = 3607


