select m.id,m.merchant_code,m.merchant, o.*, c.first_Name, c.last_name,c.email,c.telephone, ca.address1, ca.address2,ca.city, ca.provincecode, ca.postalcode, ca.countrycode,ca.address2
from customerOrders o
JOIN  merchants m on m.id = o.merchant_id
join customers c on c.id = o.customerId and c.merchant_id = o.merchant_id
join CustomerAddresses ca on ca.customerId = c.id
JOIN MerchantWebsiteFeatures F ON F.Merchant_Id = M.ID AND F.FeatureCode = 'template'
WHERE F.FeatureValue IN ('tbmega1','tbmega2')