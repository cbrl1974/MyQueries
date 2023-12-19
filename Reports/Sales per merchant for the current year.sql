select top 10 * from CustomerOrders

SELECT m.id, m.merchant, m.merchant_url, SUM(co.total) AS total_order_sum
FROM  merchants m 
left join CustomerOrders co on m.id = co.merchant_id
left join MerchantTransactionLog ml on ml.customerOrderId = co.id
where m.id in (
select m.id
from merchantwebsitefeatures mf
join merchants m on m.id = mf.merchant_id
where  mf.featureCode = 'shoppingCartType'
and m.active = 1
and m.merchant_url not like '%tailbase%'
and m.merchant not like '%tailbase%'
and m.merchant not like   '%old%'
)
and co.orderTimeStamp between '2023-01-01' and '2023-12-31'
and ml.txnService not like '%SANDBOX TEST%'
--and m.id = 3487
GROUP BY m.id, m.merchant, m.merchant_url
ORDER BY total_order_sum DESC
