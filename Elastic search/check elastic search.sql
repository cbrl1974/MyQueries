EXECUTE dbo.ElasticSearch_Update_Procedure '3065','',1


select * from ElasticSearch_trackedchanges


  select * from ElasticSearch_TrackedChanges 
  order by creationDate
  
  select merchantid, count(merchantid) from ElasticSearch_TrackedChanges 
  group by MerchantId
  order by count(merchantid) desc
  --where merchantid = 2547

   SELECT TOP(600) * 
  FROM Stats.TableStats 
  WHERE SchemaName = 'dbo' AND TableName = 'ElasticSearch_TrackedChanges'
  ORDER BY Id DESC

  select top 50  * from ElasticSearchSettings

  --update top (1) ElasticSearchSettings
  --set value = 4000
  --where textcode = 'UpdaterBatchSize'
  --and id = 21




