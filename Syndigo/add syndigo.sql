SELECT
STUFF((SELECT ',' + CAST(cieID AS VARCHAR(10))
        FROM merchantBrands
        WHERE merchant_id = 3450
        FOR XML PATH('')), 1, 1, '') AS cieIDs;


insert into MerchantWebsiteFeatures values 
(3450,'syndigoBrands', NULL)


select * from TailbaseServices.dbo.ApiClientConfigs where assemblyname = 'DataExportSyndigo'
and clientid in (3431,3450)


select count(1) from merchantProds where merchant_id = 3459
select count(1) from merchantProds where merchant_id = 3458
select count(1) from merchantProds where merchant_id = 3467
select count(1) from merchantProds where merchant_id = 3431

select * from MerchantWebsiteFeatures
where featureCode = 'syndigoBrands'
and merchant_id in (3450)

--Execute storedProcedure tailbase websites
EXECUTE [dbo].[SP_SyndigoWebsitesProducts]
@merchantId = 3450,
@manufIds = NULL

--or
https://api.tailbase.com/data/ExportWebsitesData/ <Apikey> --V3

https://api.tailbase.com/data/ExportShopifyData/ <Apikey> --Tailbasify



--		 Update top (1) MerchantWebsiteFeatures
--set featurevalue = '9,439,440,462,501,502,505,1024,1308,1436,1445,1497,1694,1860,1900,2017,2029,3685,4272,4546,4606'
--where merchant_id = 3458
--and featurecode = 'syndigoBrands'


SELECT TOP (100) [LogID]
      ,[Project]
      ,[Category]
      ,[Text]
      ,[Time]
      ,[Severity]
      ,[Module]
      ,[Location]
  FROM [EventReactor].[dbo].[Logs]
  where module = 'SyndigoExportData'
  order by [Time] desc




