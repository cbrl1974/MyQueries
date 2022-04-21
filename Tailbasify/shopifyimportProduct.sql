use stagingtailbasecore

select  p.id_product as 'handle',
p.model as 'Title',
p.description_1 as 'Body',
co.cie as 'Vendor',
c.category as 'Type',
'' as Tags,
'false' as 'Published',
'Subcategory' as 'Subcategory',
s.subcategory,
'' as 'Option2 Name',
'' as 'Option2 Value',
'' as 'Option3 Name',
'' as 'Option3 Value',
'' as 'Variant SKU',
sp.SpecValue_1 as 'Variant Grams',
'' as 'Variant Inventory Tracker',
'10' as 'Variant Inventory Qty',
'Continue' as 'Variant Inventory Policy',
'Manual' as 'Variant Fulfillment Service',
isnull(mp.reducedPrice,0) as 'Variant Price',
isnull(mp.price,0) as 'Variant Compare At Price',
'' as 'Variant Requires Shipping',
'' as 'Variant Taxable',
'' as 'Variant Barcode',
'https://imgres.tailbase.com/rzdimg/prods/400/' + cast(mp.productID as varchar) + '_1.jpg' as 'Image Src',
'1' as 'Image Position',
p.model as 'Image Alt Text',
'' as 'Gift Card',
p.manufmodel as 'SEO Title',
p.description_1 as 'SEO Description',
'' as 'Google Shopping / Google Product Category',
'' as 'Google Shopping / Gender',
'' as 'Google Shopping / Age Group',
p.ManufacturerIdentifier as 'Google Shopping / MPN',
'' as 'Google Shopping / AdWords Grouping',
'' as 'Google Shopping / AdWords Labels',
'' as 'Google Shopping / Condition',
'' as 'Google Shopping / Custom Product',
'' as 'Google Shopping / Custom Label 0',
'' as 'Google Shopping / Custom Label 1',
'' as 'Google Shopping / Custom Label 2',
'' as 'Google Shopping / Custom Label 3',
'' as 'Google Shopping / Custom Label 4',
'https://imgres.tailbase.com/rzdimg/prods/400/' + cast(mp.productID as varchar) + '_1.jpg' as 'Variant Image',
'k' as 'Variant Weight Unit',
'0.1300' as 'Variant Tax Code',
isnull(mp.cost,0) as 'Cost per item'
from products p 
inner join merchantprods mp on mp.ProductID = p.id_product
inner join companies co on co.id_cie = p.manufid
inner join categories c on c.id_category = p.catid and c.id_langue = 1
left join subcategories s on s.id_subcategory = p.subcatiD and s.Id_langue=1
inner join SpecsProd sp on sp.productid = mp.ProductID
where mp.merchant_id = 1448
and p.manufid = 9
and sp.specsID_1 in (select id from specs where spec = 'weight')
and sp.SpecValue_1 is not null