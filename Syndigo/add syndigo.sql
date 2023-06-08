SELECT
STUFF((SELECT ',' + CAST(cieID AS VARCHAR(10))
        FROM merchantBrands
        WHERE merchant_id = 3431
        FOR XML PATH('')), 1, 1, '') AS cieIDs;


insert into MerchantWebsiteFeatures values 
(3431,'syndigoBrands','9,12,38,439,440,462,463,476,500,501,502,505,1024,1354,1409,1414,1436,1454,1470,1529,1818,1832,1945,1946,2185,2577,2620,2843,3025,3055,3143,3181,3182,3184,3408,3582,4226,4227,4394,4985,5139,7482')


select * from TailbaseServices.dbo.ApiClientConfigs where assemblyname = 'DataExportSyndigo'
and clientid in (3459,3458,3467)


select count(1) from merchantProds where merchant_id = 3459
select count(1) from merchantProds where merchant_id = 3458
select count(1) from merchantProds where merchant_id = 3467
select count(1) from merchantProds where merchant_id = 3431

select * from MerchantWebsiteFeatures
where featureCode = 'syndigoBrands'
and merchant_id in (3459,3458,3467,3431,3457)



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




