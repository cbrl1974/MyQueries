SELECT
STUFF((SELECT ',' + CAST(cieID AS VARCHAR(10))
        FROM merchantBrands
        WHERE merchant_id = 3487
        FOR XML PATH('')), 1, 1, '') AS cieIDs;


select * from MerchantWebsiteFeatures where merchant_id = 3528
insert into MerchantWebsiteFeatures values 
(3496,'syndigoBrands', NULL)


select * from TailbaseServices.dbo.ApiClientConfigs where assemblyname = 'DataExportSyndigo'
and clientid in (3487,3496,3500,3506,3508,3528)



select * from merchantwebsitetexts where merchant_id = 3528


insert into merchantwebsitetexts (merchant_id, textcode, content_1, content_2, id_langue, availableInMerchantBean) values
(3528, 'syndigositeid', 'a9e8953c-a681-5c3a-1283-73bc2098c8e9','ee42ef73-0476-4e65-bcbf-ba1420ed1b1a',1,1)



select * from MerchantWebsiteFeatures
where featureCode = 'syndigoBrands'
and merchant_id in (3450)

--Execute storedProcedure tailbase websites
EXECUTE [dbo].[SP_SyndigoWebsitesProducts]
@merchantId = 3487,
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




