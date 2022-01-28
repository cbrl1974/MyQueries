SELECT lsnTime.tran_begin_time,  lsnTime.tran_end_time, lsnData.*
FROM [cdc].[TaApplianceEpassParentProducts_CT] lsnData INNER JOIN [cdc].[lsn_time_mapping] lsnTime On lsnData.__$start_lsn = lsnTime.start_lsn
order by lsnTime.tran_end_time desc

SELECT lsnTime.tran_begin_time,  lsnTime.tran_end_time, lsnData.*
FROM [cdc].[TaApplianceEpassParentProducts_CT] lsnData INNER JOIN [cdc].[lsn_time_mapping] lsnTime On lsnData.__$start_lsn = lsnTime.start_lsn
order by lsnTime.tran_end_time desc



SELECT lsnTime.tran_begin_time,  lsnTime.tran_end_time, lsnData.*
FROM [cdc].[dbo_merchantTaxes_CT] lsnData 
INNER JOIN [cdc].[lsn_time_mapping] lsnTime On lsnData.__$start_lsn = lsnTime.start_lsn
order by lsnTime.tran_end_time desc



