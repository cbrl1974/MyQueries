select top 100 * from [cdc].[dbo_MerchantShipping_CT] lsnData 
INNER JOIN [cdc].[lsn_time_mapping] lsnTime On lsnData.__$start_lsn = lsnTime.start_lsn
where merchant_id = 3227