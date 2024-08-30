-- This query will generate the data you need to make the stores display on each product, specially if it was not onbarded initially. Inventory related. Remove the filter for the productid currently in place and add or remove the stores based on the loations that the merchant have, minus the one in place.
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
'Branchaud Amos' 'Location',
0 'Incoming',
0 'Unavailable',
0 'Committed',
0 'Available',
0 'On hand'
from shopify.ShopifyProductVariants v	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid = 3497
and v.ShopifyProductID in (1804678)
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
'Branchaud Écono Buckingham' 'Location',
0 'Incoming',
0 'Unavailable',
0 'Committed',
0 'Available',
0 'On hand'
from shopify.ShopifyProductVariants v	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid = 3497
and v.ShopifyProductID in (1804678)
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
'Branchaud Écono Val d''Or' 'Location',
0 'Incoming',
0 'Unavailable',
0 'Committed',
0 'Available',
0 'On hand'
from shopify.ShopifyProductVariants v	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid = 3497
and v.ShopifyProductID in (1804678)
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
'Branchaud Maniwaki' 'Location',
0 'Incoming',
0 'Unavailable',
0 'Committed',
0 'Available',
0 'On hand'
from shopify.ShopifyProductVariants v	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid = 3497
and v.ShopifyProductID in (1804678)
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
'Branchaud Mont-Laurier' 'Location',
0 'Incoming',
0 'Unavailable',
0 'Committed',
0 'Available',
0 'On hand'
from shopify.ShopifyProductVariants v	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid = 3497
and v.ShopifyProductID in (1804678)
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
'Branchaud Rouyn-Noranda' 'Location',
0 'Incoming',
0 'Unavailable',
0 'Committed',
0 'Available',
0 'On hand'
from shopify.ShopifyProductVariants v	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid = 3497
and v.ShopifyProductID in (1804678)
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
'Branchaud  Val d''Or' 'Location',
0 'Incoming',
0 'Unavailable',
0 'Committed',
0 'Available',
0 'On hand'
from shopify.ShopifyProductVariants v	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid = 3497
and v.ShopifyProductID in (1804678)






