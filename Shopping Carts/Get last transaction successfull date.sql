--Check last successful transaction date for the merchants 
select l.merchant_id, m.merchant, m.active, max(l.creationTimestamp) as lastCreationOrder
from MerchantTransactionLog l
	join merchants m on m.id = l.merchant_id
	join MerchantWebsiteInformation i on i.merchant_id = m.id and i.infoCode = 'template' and i.infoValue not like '%tailbasify%'
where l.merchant_id in (
	select merchant_id
	from merchantwebsitefeatures
	where featurecode = 'shoppingCartType' 
) and l.customerOrderId is not null
	and l.txnservice not like '%PayPal Checkout Order Transaction SANDBOX TEST%'
	and m.active = 1
group by l.merchant_id,m.merchant,m.active
order by lastCreationOrder desc




--Check last movement transaction date for the merchants 
select l.merchant_id, m.merchant, m.active, max(l.creationTimestamp) as lastCreationOrder
from MerchantTransactionLog l
	join merchants m on m.id = l.merchant_id
	join MerchantWebsiteInformation i on i.merchant_id = m.id and i.infoCode = 'template' and i.infoValue not like '%tailbasify%'
where l.merchant_id in (
	select merchant_id
	from merchantwebsitefeatures
	where featurecode = 'shoppingCartType' 
)
	and l.txnservice not like '%PayPal Checkout Order Transaction SANDBOX TEST%'
	and m.active = 1
group by l.merchant_id,m.merchant,m.active
order by lastCreationOrder desc

