
SELECT m.id, m.merchant, m.merchant_url, max(co.orderTimeStamp) as lastOrder,
 mwi.infoValue,  -- for cantrex
 SUM(co.total) AS total_order_sum
FROM merchants m
    left join CustomerOrders co on m.id = co.merchant_id
    left join MerchantTransactionLog ml on ml.customerOrderId = co.id    
        join MerchantWebsiteInformation mwi on mwi.merchant_id = m.id -- for cantrex
where m.id in (
select m.id
    from merchantwebsitefeatures mf
        join merchants m on m.id = mf.merchant_id
    where  mf.featureCode = 'shoppingCartType'
        and m.active = 1
        and m.merchant_url not like '%tailbase%'
        and m.merchant not like '%tailbase%'
        and m.merchant not like   '%old%'
        and m.id != 1479
)
AND co.orderTimeStamp BETWEEN DATEADD(YEAR, -1, GETDATE()) AND GETDATE()
    and ml.txnService not like '%SANDBOX TEST%'
    and mwi.infoValue not like '%Tailbasify%'
    and co.[status] !=  'CANCELLED'
GROUP BY m.id, m.merchant, m.merchant_url, mwi.infoValue
ORDER BY total_order_sum desc, lastOrder


