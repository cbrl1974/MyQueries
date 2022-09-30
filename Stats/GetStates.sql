SELECT TOP(600) * 
FROM Stats.TableStats 
WHERE SchemaName = 'dbo' AND TableName = 'ElasticSearch_TrackedChanges'
ORDER BY Id DESC


SELECT distinct TableName
FROM Stats.TableStats 
WHERE SchemaName = 'dbo' 
--AND TableName = 'ElasticSearch_TrackedChanges'
ORDER BY TableName DESC