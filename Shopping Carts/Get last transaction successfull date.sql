select l.merchant_id, m.merchant, m.active, max(l.creationTimestamp) as lastCreationOrder
from MerchantTransactionLog l
	join merchants m on m.id = l.merchant_id
where l.merchant_id in (2542,1663,1719,1903,1941,2046,2627,2643,2916,3338,3399,3592,3640,3644,3647)
	and l.customerOrderId is not null
	and l.txnservice not like '%PayPal Checkout Order Transaction SANDBOX TEST%'
group by l.merchant_id,m.merchant,m.active
order by lastCreationOrder desc
