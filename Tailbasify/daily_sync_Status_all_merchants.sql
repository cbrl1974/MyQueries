declare @StartTime datetime = getDAte()
declare @EndTime datetime = DATEADD(DAY, 1, @StartTime)
declare @OnlyIfRunning bit = 0
select
    CASE
        WHEN c.MediaDiagnoserElapsedTime IS NULL AND c.ProductsSyncElapsedTime IS NULL AND c.CollectionsSyncElapsedTime IS NULL AND c.ConvertElapsedTime IS NULL THEN 'DID NOT RUN'
        WHEN c.MediaDiagnoserElapsedTime IS NOT NULL AND c.ProductsSyncElapsedTime IS NOT NULL AND c.CollectionsSyncElapsedTime IS NOT NULL AND c.ConvertElapsedTime IS NOT NULL THEN 'COMPLETED'
        WHEN c.MediaDiagnoserElapsedTime IS NULL THEN 'CONVERTING'
        WHEN c.ProductsSyncElapsedTime IS NULL THEN 'SYNCING - MEDIA DIAG'
        WHEN c.CollectionsSyncElapsedTime IS NULL THEN 'SYNCING - PRODUCTS'
        ELSE 'SYNCING - COLLECTIONS'
    END [Status],
    *
from (
    select
        b.MerchantId,
        sm.ShopUrl,
        b.LastActivityEST,
        CAST(b.AdjLastConvertEndTimeEST - b.AdjLastConvertStartTimeEST AS TIME(0)) ConvertElapsedTime,
        CAST(b.AdjLastMediaDiagnoserEndTimeEST - b.AdjLastMediaDiagnoserStartTimeEST AS TIME(0)) MediaDiagnoserElapsedTime,
        CAST(b.AdjLastProductsSyncEndTimeEST - b.AdjLastProductsSyncStartTimeEST AS TIME(0)) ProductsSyncElapsedTime,
        CAST(b.AdjLastCollectionsSyncEndTimeEST - b.AdjLastCollectionsSyncStartTimeEST AS TIME(0)) CollectionsSyncElapsedTime
    from (
        select
            *,
            a.LastConvertStartTimeEST AS AdjLastConvertStartTimeEST,
            CASE WHEN a.LastConvertEndTimeEST > a.LastConvertStartTimeEST THEN a.LastConvertEndTimeEST ELSE GETDATE() END AdjLastConvertEndTimeEST,
            CASE WHEN a.LastConvertStartTimeEST < a.LastMediaDiagnoserStartTimeEST THEN a.LastMediaDiagnoserStartTimeEST END AdjLastMediaDiagnoserStartTimeEST,
            CASE WHEN a.LastConvertStartTimeEST < a.LastMediaDiagnoserStartTimeEST AND a.LastMediaDiagnoserEndTimeEST > a.LastMediaDiagnoserStartTimeEST THEN a.LastMediaDiagnoserEndTimeEST ELSE GETDATE() END AdjLastMediaDiagnoserEndTimeEST,
            CASE WHEN a.LastConvertStartTimeEST < a.LastProductsSyncStartTimeEST THEN a.LastProductsSyncStartTimeEST END AdjLastProductsSyncStartTimeEST,
            CASE WHEN a.LastConvertStartTimeEST < a.LastProductsSyncStartTimeEST AND a.LastProductsSyncEndTimeEST > a.LastProductsSyncStartTimeEST THEN a.LastProductsSyncEndTimeEST ELSE GETDATE() END AdjLastProductsSyncEndTimeEST,
            CASE WHEN a.LastConvertStartTimeEST < a.LastCollectionsSyncStartTimeEST THEN a.LastCollectionsSyncStartTimeEST END AdjLastCollectionsSyncStartTimeEST,
            CASE WHEN a.LastConvertStartTimeEST < a.LastCollectionsSyncStartTimeEST AND a.LastCollectionsSyncEndTimeEST > a.LastCollectionsSyncStartTimeEST THEN a.LastCollectionsSyncEndTimeEST ELSE GETDATE() END AdjLastCollectionsSyncEndTimeEST
        from (
            select
                me.ShopifyMerchantId,
                me.MerchantId,
                me.[Status],
                me.ModificationDate StatusModificationTimeEST,
                DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), co_s.[Time]) AS LastConvertStartTimeEST,
                DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), co_e.[Time]) AS LastConvertEndTimeEST,
                DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), md_s.[Time]) AS LastMediaDiagnoserStartTimeEST,
                DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), md_e.[Time]) AS LastMediaDiagnoserEndTimeEST,
                DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), ps_s.[Time]) AS LastProductsSyncStartTimeEST,
                DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), ps_e.[Time]) AS LastProductsSyncEndTimeEST,
                DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), cs_s.[Time]) AS LastCollectionsSyncStartTimeEST,
                DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), cs_e.[Time]) AS LastCollectionsSyncEndTimeEST,
                DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), l_ac.[Time]) AS LastActivityEST
            from
                dbo.MerchantExports me with(nolock)
            outer apply (
                select top(1) LogTime AS [Time] from dbo.logs with(nolock) where LogTime between @StartTime and @EndTime and merchantid = me.MerchantId and [Text] like '***** Starting converting data (%' order by id desc
            ) co_s
            outer apply (
                select top(1) LogTime AS [Time] from dbo.logs with(nolock) where LogTime between @StartTime and @EndTime and merchantid = me.MerchantId and [Text] like '***** Finished converting data, total time spent%' order by id desc
            ) co_e
            outer apply (
                select top(1) LogTime AS [Time] from dbo.logs with(nolock) where LogTime between @StartTime and @EndTime and merchantid = me.MerchantId and [Text] like 'Starting media diagnose batch#: 1/%' order by id desc
            ) md_s
            outer apply (
                select top(1) LogTime AS [Time] from dbo.logs with(nolock) where LogTime between @StartTime and @EndTime and merchantid = me.MerchantId and [Text] like 'Media diagnose Completed. Total batches:%' order by id desc
            ) md_e
            outer apply (
                select top(1) LogTime AS [Time] from dbo.logs with(nolock) where LogTime between @StartTime and @EndTime and merchantid = me.MerchantId and [Text] like '*** Product Sync Started! Total batches:%' order by id desc
            ) ps_s
            outer apply (
                select top(1) LogTime AS [Time] from dbo.logs with(nolock) where LogTime between @StartTime and @EndTime and merchantid = me.MerchantId and [Text] like '*** Products Sync Completed! Total batches:%' order by id desc
            ) ps_e
            outer apply (
                select top(1) LogTime AS [Time] from dbo.logs with(nolock) where LogTime between @StartTime and @EndTime and merchantid = me.MerchantId and [Text] like '*** Collection Sync Started! Total batches:%' order by id desc
            ) cs_s
            outer apply (
                select top(1) LogTime AS [Time] from dbo.logs with(nolock) where LogTime between @StartTime and @EndTime and merchantid = me.MerchantId and [Text] like '*** Collections Sync Completed! Total batches:%' order by id desc
            ) cs_e
            outer apply (
                select top(1) LogTime AS [Time] from dbo.logs with(nolock) where LogTime between @StartTime and @EndTime and merchantid = me.MerchantId order by id desc
            ) l_ac
            where 
                (@OnlyIfRunning = 0 or me.[Status] != 1)
        ) a
    ) b
    join Shopify.ShopifyMerchants sm on b.ShopifyMerchantId = sm.ID
) c