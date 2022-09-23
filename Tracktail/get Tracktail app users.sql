
SELECT *
FROM [TrackTailApp].[AspNetUsers]
where Email = 'lcabral@tailbase.com';

SELECT *
FROM [TrackTailApp].AspNetRoles


SELECT *
FROM [TrackTailApp].ClientAccounts
where merchantid = 1202

update top (4) [TrackTailApp].[AspNetUsers]
set ClientId = 224
where Email like '%cityfurniture%'

SELECT *
FROM [TrackTailApp].[AspNetUsers]
where Email like '%tailbase%';

SELECT *
FROM [TrackTailApp].ClientAccounts
where merchantid = 1202

SELECT *
FROM [TrackTailApp].ClientAccounts
where merchantid = 589

SELECT top 100
    *
FROM TrackTailDb.Tracktail_Field
where merchantid = 1202


SELECT top 100
    *
from TrackTailSolutions_Clients
where merchantid = 1448

-- update top (1) TrackTailSolutions_Clients
-- set CountryCode = 'CA'
-- where merchantid = 1448 
-- SELECT * FROM [TrackTailApp].[AspNetRoles]

SELECT u.UserName, r.Name
FROM [TrackTailApp].[aspnetuserroles] ur
    inner join [TrackTailApp].[AspNetRoles] r on r.Id = ur.RoleId
    inner join [TrackTailApp].[AspNetUsers] u on u.id = ur.UserId
where UserId in ('61d59b42-3f86-4ca3-9ddb-3f22774e19ae','6455eae3-3382-4dd7-ac57-f8eb1abc18a3','c52fa2d8-4e9b-4304-af5b-a1ab9b3a87ff','ffd95ac0-7f82-4d6e-9f66-70b2a32f23f6')




SELECT *
FROM [datatail20130410].[TrackTailDb].[Websites]
order by id


sELECT coalesce(max(r.AdminLevel),0) adminlevel
FROM TrackTailApp.AspNetUserRoles ur
    left join TrackTailApp.AspNetRoles r on r.id=ur.RoleId
where ur.UserId='b1ec3b6a-2c45-4cb6-a708-5688e56621a9'

SELECT TOP (10)
    [LogID]
      , [Project]
      , [Category]
      , [Text]
      , [Time]
      , [Severity]
      , [Module]
      , [Location]
FROM [EventReactor].[dbo].[Logs]
where category = 'tracktail'
order by [time] desc

SELECT TCA.[ID]
    , TCA.[MerchantId]
    , DDC.cie
    , TCA.[CieId]
    , TCA.[ProvStateId]
    , TCA.[CountryCode]
    , TCA.[Langue]
    , TCA.[Active]
    , DDM.merchant
    , DDC.website
    , (
        SELECT CASE
                WHEN EXISTS(
                        SELECT TOP 1
            [id]
        FROM MerchantBrands
        WHERE merchant_id = TCA.MerchantId
                        )
                    THEN CAST(1 AS BIT)
                ELSE CAST(0 AS BIT)
                END
        ) AS 'HasWebsite',
    (select top 1
        brand
    from merchantFeeds
    where merchant_id = TCA.[MerchantId] and brand = 'NECO_NE' and active = 1) AS 'NECO_NE_brand',
    (select top 1
        brand
    from MerchantFeedWarehouses
    where merchant_id = TCA.[MerchantId] and active = 1 and brand = 'ADC') AS 'NECO_ADC_brand'
FROM TrackTailSolutions_Clients TCA
    JOIN merchants DDM ON DDM.ID = TCA.MerchantId
    JOIN Companies DDC ON DDC.Id_cie = TCA.CieId
WHERE TCA.ID = 483