
select 
sp.handle 'Handle',
sp.TitleEn 'Title',
'Title' as 'Option1 Name',
'Default Title' 'Option1 Value',
'' 'Option2 Name',
'' 'Option2 Value',
'' 'Option3 Name',
'' 'Option3 Value',
v.sku 'SKU',
'' 'HS Code',
'' 'COO',
'Germain Larivière Brossard' 'Location',
0 'Incoming',
0 'Unavailable',
0 'Committed',
0 'Available',
0 'On hand'
from shopify.ShopifyProductVariants v	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid = 3527
--and v.ShopifyProductID in (1851793)
and v.Tracked = 0
and sp.ItemType = 4
UNION
select 
sp.handle 'Handle',
sp.TitleEn 'Title',
'Title' as 'Option1 Name',
'Default Title' 'Option1 Value',
'' 'Option2 Name',
'' 'Option2 Value',
'' 'Option3 Name',
'' 'Option3 Value',
v.sku 'SKU',
'' 'HS Code',
'' 'COO',
'Germain Larivière Laval' 'Location',
0 'Incoming',
0 'Unavailable',
0 'Committed',
0 'Available',
0 'On hand'
from shopify.ShopifyProductVariants v	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid = 3527
and v.Tracked = 0
and sp.ItemType = 4
UNION
select 
sp.handle 'Handle',
sp.TitleEn 'Title',
'Title' as 'Option1 Name',
'Default Title' 'Option1 Value',
'' 'Option2 Name',
'' 'Option2 Value',
'' 'Option3 Name',
'' 'Option3 Value',
v.sku 'SKU',
'' 'HS Code',
'' 'COO',
'Germain Larivière St-Hyacinthe' 'Location',
0 'Incoming',
0 'Unavailable',
0 'Committed',
0 'Available',
0 'On hand'
from shopify.ShopifyProductVariants v	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid = 3527
--and v.ShopifyProductID in (1851793)
and v.Tracked = 0
and sp.ItemType = 4




