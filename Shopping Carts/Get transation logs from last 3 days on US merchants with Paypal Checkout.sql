
select * from MerchantTransactionLog
where merchant_id in (
	select m.id
	from merchantwebsitefeatures mf
	join merchants m on m.id = mf.merchant_id
	where  mf.featureCode = 'shoppingCartType'
	and  mf.featurevalue like '%onlyppc%'
	and m.active = 1
	and  mf.merchant_id in (select merchant_id  from merchantwebsitefeatures
	where featurevalue    in ('tbplatinum') and featureCode = 'template')
	and m.countryCode = 'US'
	)
    AND creationTimestamp >= DATEADD(DAY, -3, GETDATE())
	and txnservice not like '%PayPal Checkout Order Transaction SANDBOX TEST%'
	union
	select * from MerchantTransactionLog
where merchant_id in (
	select m.id
	from merchantwebsitefeatures mf
	join merchants m on m.id = mf.merchant_id
	where  mf.featureCode = 'hasMultiPayment'
	and  mf.featurevalue like '%onlyppc%'
	and m.active = 1
	and  mf.merchant_id in (select merchant_id  from merchantwebsitefeatures
	where featurevalue    in ('tbplatinum') and featureCode = 'template')
	and m.countryCode = 'US'
	)
    AND creationTimestamp >= DATEADD(DAY, -3, GETDATE())
	and txnservice not like '%PayPal Checkout Order Transaction SANDBOX TEST%'
order by id desc