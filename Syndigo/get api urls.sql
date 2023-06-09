select m.id, m.merchant, 
case
when m.id = 1958 then concat('https://api.tailbase.com/data/ExportShopifyData/', c.Id)
else 
concat('https://api.tailbase.com/data/ExportWebsitesData/', c.Id)
end as endpoint
from TailbaseServices.dbo.ApiClientConfigs c
inner join merchants m on m.id = c.ClientId
where c.assemblyname = 'DataExportSyndigo'
and c.FtpUser = 'CantrexFTP'