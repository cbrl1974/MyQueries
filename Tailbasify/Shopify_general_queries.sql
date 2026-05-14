use tailbasify

--Update = 1
--Convert only = 2 
--Synchronize only = 3

Declare @action as int = 3;

-- Merchants
select
	s.MerchantId, s.id, m.merchant,
	case
	when @action = 1  then 'https://api.tailbasify.com/'+ s.ApiVersion + '/api/Shopify/Update/' + s.SecurityStamp 
	WHEN  @action = 2 then 'https://api.tailbasify.com/'+ s.ApiVersion + '/api/Converter/Convert/' + s.SecurityStamp 
	WHEN  @action = 3 then 'https://api.tailbasify.com/'+ s.ApiVersion + '/api/Synchronizer/Synchronize/' + s.SecurityStamp 
	  END AS EndPoint,
	s.ShopUrl, s.SecurityStamp, s.AccessToken, ApiKey
from shopify.shopifyMerchants s
	inner join datatail20130410.dbo.merchants m on m.id = s.MerchantId
		and s.merchantid = 3227
		and m.active = 1
order by s.id


select sm.merchantid, m.merchant, m.active, sm.appurl, concat('https://admin.shopify.com/store/', LEFT(ShopUrl, CHARINDEX('.',ShopUrl) - 1), '/apps/shopify-graphiql-app')  AS subdomain, sm.ApiVersion
from shopify.shopifyMerchants sm
	inner join datatail20130410.dbo.merchants m on m.id = sm.MerchantId
where m.active = 1
	and m.id = 3227

select *
from shopify.shopifyMerchants
where merchantid = 2692







----**************EXPORT STATUS**************
select me.MerchantId, merchant, me.Status, me.ModificationDate, me.ShopifyMerchantId
from tailbasify.dbo.MerchantExports me WITH (NOLOCK)
	inner join datatail20130410.dbo.merchants m on m.id = me.MerchantId
	inner join tailbasify.shopify.ShopifyMerchants sm on sm.MerchantId = me.MerchantId
		and m.active = 1
order by [Status] desc, me.ModificationDate desc





-- ************* Reset sync status
update MerchantExports
 set [status]  = 1
 where merchantid  = 3621

----**************LOGS**************
select *
from logsType




select  distinct top 250 * 
from logs  WITH (NOLOCK)
--where text like '%failed%'
WHERE  merchantid =2042
	and LogTime > convert(date,getdate()-10)
order by LogTime desc


select top 10 * from Shopify.ShopifyProductVariantMetafields order by ShopifyProductVariantId desc
select top 10 * from Shopify.ShopifyMerchantMetafields order by ShopifyProductId desc




select *
from Shopify.ShopifySyncReports h WITH (NOLOCK)
	join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where d.ShopifyProductId in (3508473)
order by h.id desc





select merchant_id, collectionID, count(collectionID)
from datatail20130410.dbo.merchantcollections
where merchant_id = 2087 and collectionid = 34449
group by merchant_id, collectionID
having count(collectionID) > 1




select distinct *
from logs  WITH (NOLOCK)
where Text like '%Failed%'
	and LogTime > convert(date,getdate()-0)
	and MerchantID != null
order by LogTime desc



SELECT DISTINCT
	a.*,
	j.MetafieldsToBeUpdated
FROM logs a WITH (NOLOCK)
CROSS APPLY OPENJSON(a.text)
WITH (
    MetafieldsToBeUpdated nvarchar(100) '$.MetafieldsToBeUpdated'
) j
WHERE a.merchantid = 1804
	AND a.LogTime > CONVERT(date, GETDATE() - 10)
	AND a.Category = 'Statistics'
	AND a.module = 'Converter'
ORDER BY a.LogTime DESC;



select distinct top 100
	*
from logs  WITH (NOLOCK)
WHERE  merchantid = 3096--3096--1911 --3242
	and category = 'Statistics'
	and module = 'Converter'
order by LogTime desc


select distinct top 50
	*
from logs  WITH (NOLOCK)
WHERE  merchantid = 3402--3096--1911 --3242
	and category = 'Statistics'
--and module = 'Synchronizer'
order by LogTime desc

--**************CONVERT REPORTS**************

select top(10)
	*
from Shopify.ShopifyConvertReports h WITH (NOLOCK)
	join Shopify.ShopifyConvertProductReportsDetail d on h.id = d.ConvertReportId
where h.MerchantId = 3447
	and d.TailbaseId in (33010)
order by h.id desc



--**************SYNC REPORTS**************
select *
from shopify.ShopifyProducts
where merchantid = 3527
and itemtype = 1
--and tags like '%MPN%'
	and handle = 'whirlpool-secheuse-electrique-de-74-pi-cu-avec-option-wrinkle-shield-ywed5720rw'
	--and id =3545082

select top  10 *
from shopify.ShopifyProductVariants where ShopifyProductID in (select id
from shopify.ShopifyProducts
where merchantid = 3527
and itemtype = 1)





select *
from shopify.ShopifyMerchantCollections
where merchantid = 3638






select top 50 *
from Shopify.ShopifySyncReports h WITH (NOLOCK)
	join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where d.ShopifyProductId in (3545082)
--and GraphQLCallInfo like '%create%'
order by h.id desc

--**************COLLECTION REPORTS**************
select top 10
	*
from Shopify.ShopifyCollectionSyncReportsDetail
where SyncReportId in (select id
	from Shopify.ShopifySyncReports
	where merchantid = 3096 and CAST(StartTime AS DATE) = '2024-08-21')
	and ShopifyCollectionId = 18646
order by id desc;






--**************DEBUG**************

SELECT TOP 10
	*
FROM Shopify.ShopifySyncReports
WHERE MerchantId = 3447
	and endtime >= getdate()
ORDER BY ID DESC


SELECT max(id)
FROM Shopify.ShopifyProducts
where MerchantId = 3388 and ItemType = 1
WHERE ID IN (SELECT ShopifyProductId
	FROM Shopify.ShopifyProductSyncReportsDetail
	WHERE SyncReportId IN (3537205))
	AND MerchantId = 1202
--AND SyncStatusId IN (2)
--AND ShopifyGeneratedProductId IS NULL



--**************PRODUCTS**************
select
	distinct sp.merchantid,merchant.merchant, count(distinct sp.id)
from shopify.shopifyProducts sp WITH (NOLOCK)
	join Shopify.ShopifyProductVariants m on m.ShopifyProductId = sp.ID
	join Shopify.ShopifyMerchantMetafields  mt on mt.ShopifyProductId = sp.ID
	join Shopify.ShopifyProductMedia media on media.ShopifyProductId = sp.ID
	join MerchantExports me on me.MerchantId = sp.MerchantId
	join datatail20130410.dbo.merchants merchant on merchant.id = sp.MerchantId and merchant.id = me.MerchantId
	join shopify.ShopifyMerchants sm on sm.MerchantId = sp.MerchantId and sm.MerchantId = me.MerchantId
	where sp.syncstatusid = 4
	and (media.syncstatusid in (1,2)
	or m.syncstatusid  in (1,2)
	or mt.syncstatusid  in (1,2) )
	and merchant.active = 1
	and sm.ApiVersion = 'v2'
	--and sp.MerchantId = 2087
	group by sp.merchantid,merchant.merchant
	order by  count(distinct sp.id)




select sp.merchantid, sp.vendor, sp.ProductType, sp.tailbaseid, sp.handle, sp.SyncStatusId, v.*
from shopify.ShopifyMerchantMetafields v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid = 3527
and [keyname] like '%variant%'
-- and v.SyncStatusId = 1
and sp.itemtype = 1


DECLARE @MERCHANTid AS INT = 3478
SELECT 
    sp.Id AS ProductId,
    sp.SyncStatusId AS ProductSyncStatus,
    sp.TitleEn AS ProductTitle,
    'Variant' AS ChildType,
    spv.Id AS ChildId,
    spv.SyncStatusId AS ChildSyncStatus,
    spv.Sku
FROM Shopify.ShopifyProducts sp
INNER JOIN Shopify.ShopifyProductVariants spv ON sp.Id = spv.ShopifyProductId
WHERE sp.MerchantId = @MERCHANTid
  AND sp.SyncStatusId = 4
  AND spv.SyncStatusId IN (1, 2)
UNION ALL
-- METAFIELDS
SELECT 
    sp.Id AS ProductId,
    sp.SyncStatusId AS ProductSyncStatus,
    sp.TitleEn AS ProductTitle,
    'Metafield' AS ChildType,
    smm.Id AS ChildId,
    smm.SyncStatusId AS ChildSyncStatus,
    smm.KeyName AS Sku
FROM Shopify.ShopifyProducts sp
INNER JOIN Shopify.ShopifyMerchantMetafields smm ON sp.Id = smm.ShopifyProductId
WHERE sp.MerchantId = @MERCHANTid
  AND sp.SyncStatusId = 4
  AND smm.SyncStatusId IN (1, 2)
UNION ALL
-- MEDIA
SELECT 
    sp.Id AS ProductId,
    sp.SyncStatusId AS ProductSyncStatus,
    sp.TitleEn AS ProductTitle,
    'Media' AS ChildType,
    spm.Id AS ChildId,
    spm.SyncStatusId AS ChildSyncStatus,
    spm.ShopifyGeneratedMediaId AS Sku
FROM Shopify.ShopifyProducts sp
INNER JOIN Shopify.ShopifyProductMedia spm ON sp.Id = spm.ShopifyProductId
WHERE sp.MerchantId = @MERCHANTid
  AND sp.SyncStatusId = 4
  AND spm.SyncStatusId IN (1, 2)
ORDER BY ChildType, ProductId;





select distinct *
from logs  WITH (NOLOCK)
WHERE  merchantid = 3527
	and LogTime > convert(date,getdate()-0)
order by LogTime desc



--**************COLLECTIONS**************

select *
FROM shopify.ShopifyMerchantCollections mc
where mc.merchantid = 3096
	and syncstatusid <> 6
--and TitleEn like '%mod%'
order by id desc




--**************METAFIELDS**************

select top 250
	m.*
from shopify.ShopifyMerchantMetafields m
	inner join shopify.shopifyProducts sp on sp.id = m.ShopifyProductId
where 1= 1
	and m.ShopifyProductId in (2337851)






--**************MEDIA**************

select sp.id, sp.MerchantId, sp.handle, sp.tailbaseid, sp.SyncStatusId, m.*
from Shopify.ShopifyProductMedia m
	inner join shopify.shopifyProducts sp on sp.id = m.ShopifyProductId
where sp.MerchantId  = 3065
and sp.handle = 'signature-design-by-ashley-visola-p802-7-pc-outdoor-dining-set'
--and m.SyncStatusId not in (1,2,4)
	--and m.ShopifyProductId in (select id
	--from shopify.shopifyProducts
	--where merchantid = 3638 and SyncStatusId =2)
--and sp.MerchantId  = 3096
order by m.MediaContentTypeId,m.tailbaseid, m.DisplayOrder

delete top (3) Shopify.ShopifyProductMedia
where id in (18411735,
18409105,
18409106) 

--update top (7) Shopify.ShopifyProductMedia
--set SyncStatusId = 1,
--ShopifyGeneratedMediaId = null
--where ShopifyProductId in (select id
--from shopify.shopifyProducts
--where merchantid = 3096
--and SyncStatusId != 4)







--**************VARIANTS**************

select sp.merchantid, sp.id, sp.tags, sp.tailbaseid, sp.TitleEn, sp.handle, sp.SyncStatusId
, v.*
from shopify.ShopifyProductVariants v
	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
where sp.merchantid =  3527
--and sp.ID = 1845631
and sp.tailbaseid in(867660,690831) 
and sp.tags like '%inventory%'
--and sp.handle = 'smeg-retro-style-melangeur-de-600-w-blf03blus'


select *
from datatail20130410.dbo.merchantstoresInventory
where merchantid = 3527
and itemid in(867660,690831) 




select * from shopify.ShopifyProducts where ID = 3610746
select * from shopify.ShopifyProductVariants where ShopifyProductID = 3610746

select * from datatail20130410.dbo.MerchantInstallations i
join datatail20130410.dbo.MerchantInstallationZones p on p.MerchantInstallationID = i.id
join datatail20130410.dbo.MerchantInstallationFilters f on f.MerchantInstallationId = i.id
where i.merchantID = 3621

select * from datatail20130410.dbo.companies where id_cie = 505



select * from shopify.shopifyProducts where merchantid = 3650 and tailbaseid = 736317
select * from datatail20130410.dbo.merchantProds where merchant_id = 3650 and productid = 736317

delete top (1) shopify.ShopifyProductVariants  where id = 4230296








-- delete top (30599) from shopify.ShopifyProductVariants
-- where id in (select v.id
--from shopify.ShopifyProductVariants v
--	inner join shopify.shopifyProducts sp on sp.id = v.ShopifyProductId
--    where sp.merchantid =  1956
--	and v.SyncStatusId <> 4
--	and v.ShopifyGeneratedVariantId is null)


--**************SyncStatus**************

select *
from SyncStatus



--Convert STATUS:
-- ConvertedOnly = 1,
-- ConvertedAndCompared = 2,
-- ConversionFailed = 3,
-- ConversionSuccess = 4

-- Sync Status:
-- 1	Insert
-- 2	Update
-- 3	Delete
-- 4	Synced
-- 5	DeleteSynced


--Translation Status
    -- Translate = 1
    -- Translated = 2
    -- None = 3


	--==
