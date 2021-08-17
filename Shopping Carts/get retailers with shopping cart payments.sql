--Insert into merchantWebsiteFeatures(merchant_id,featureCode,featureValue)
--values (1443,'shoppingCartType','withbluepay')


--delete from merchantWebsiteFeatures where merchant_id = 1443
--and featureCode = 'shoppingCartType'



SELECT
m.merchant,
m.filepath,
mwf.featurevalue AS ShippingOption,
mwt.featurevalue AS PaymentType
FROM
merchants m
INNER JOIN merchantwebsitefeatures mwf ON mwf.merchant_id = m.id
	AND mwf.featurecode = 'template'
RIGHT JOIN merchantwebsitefeatures mwt ON mwt.merchant_id = m.id
	AND mwt.featurecode = 'hasShippingOptionsOnItems'
where mwf.featurevalue = 'tbvision'
 and mwf.featurecode in('template', 'hasShippingOptionsOnItems')


select * from merchantWebsiteFeatures where merchant_id =  2781