use tailbasify

select sm.merchantid, m.merchant, sm.ShopUrl, sm.accesstoken, m.active
--, concat('https://api.tailbasify.com/v2/api/Shopify/Update/',sm.securityStamp)
,securityStamp, sm.appurl, concat('https://admin.shopify.com/store/', LEFT(ShopUrl, CHARINDEX('.',ShopUrl) - 1), '/apps/shopify-graphiql-app')  AS subdomain, sm.ApiVersion
from shopify.shopifyMerchants sm
	inner join datatail20130410.dbo.merchants m on m.id = sm.MerchantId
where m.active = 1
and sm.ApiVersion != ''
	and m.id in (2217)

	select * from shopify.shopifyMerchants where merchantid = 3650
		select * from shopify.shopifyMerchants where merchantid = 3546



----**************EXPORT STATUS**************
select me.MerchantId, merchant, me.Status, me.ModificationDate, me.ShopifyMerchantId
from tailbasify.dbo.MerchantExports me WITH (NOLOCK)
	inner join datatail20130410.dbo.merchants m on m.id = me.MerchantId
	inner join tailbasify.shopify.ShopifyMerchants sm on sm.MerchantId = me.MerchantId
		and m.active = 1
order by [Status] desc, me.ModificationDate desc

select * from MerchantExports order by merchantid
 
-- ************* Reset sync status
update MerchantExports
 set [status]  = 1
 where merchantid in (3388)

 select  distinct top 150 * 
from logs  WITH (NOLOCK)
 WHERE  merchantid in (3388) 
order by id desc

select sp.merchantid,sp.id, sp.tailbaseid, sp.handle, sp.syncstatusid, sv.*
from Shopify.ShopifyProducts  sp
join SHopify.ShopifyProductVariants sv on sv.shopifyProductid = sp.id
where merchantid = 3497
and sp.tailbaseid =  897824 


 update top (91) Shopify.ShopifyProducts 
 set SyncStatusId = 2
 --,ShopifyDescriptionDigest = null
 where vendor = 'Forno'
and merchantid = 2217
and translationStatusId = 1



SELECT sp.MerchantId, sp.Id, sp.Handle, sp.Vendor, sp.SyncStatusId
, sp.TranslationStatusId, sp.ShopifyDescriptionDigest
,sv.*
FROM Shopify.ShopifyProducts sp
join shopify.ShopifyProductVariants sv on sv.ShopifyProductID = sp.id
WHERE MerchantId = 2217 AND Vendor = 'Forno'
  AND Handle = 'forno-refrigerateur-custodia-a-congelateur-inferieur-de-24-pouces-103-pi-cu-ffffd1766-24-rs';







select  distinct top 50 * 
from logs  WITH (NOLOCK)
order by id desc



select top 10  *
from Shopify.ShopifySyncReports h WITH (NOLOCK)
	join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where d.ShopifyProductId in (4093108)
order by h.id desc


SELECT TOP 30 d.ShopifyProductId, d.Operation, d.Status, d.Text, d.GraphQLCallInfo
FROM Shopify.ShopifyProductSyncReportsDetail d
JOIN Shopify.ShopifySyncReports r ON r.Id = d.SyncReportId
WHERE r.MerchantId = 2217
  AND d.ShopifyProductId IN (4093108, 4093109, 4129061, 4129067)
ORDER BY d.Id DESC;




select shopifyProductid, price, compareatprice ,syncstatusid from Shopify.ShopifyProductVariants where ShopifyProductID = 3812331

select merchantid,id, tailbaseid, handle, syncstatusid, translationStatusId from Shopify.ShopifyProducts 
where vendor = 'Forno'
and merchantid = 2217
and translationStatusId = 1


select sp.*, sv.*
from Shopify.ShopifyProductVariants sv
join shopify.ShopifyProducts sp on sp.id = sv.shopifyProductid
where sp.vendor = 'Forno'
and sp.merchantid = 2217
and sp.translationStatusId = 1


--update top  (100) Shopify.ShopifyProducts 
--set syncstatusid = 2 
--where  merchantid = 2217
--and translationStatusId = 1
--and vendor = 'Forno'










select distinct top 200
	*
from logs  WITH (NOLOCK)
WHERE  merchantid = 3477--3096--1911 --3242
	--and category = 'Statistics'
	and module = 'Converter'
    --and logtime > convert(date,getdate()-1)
order by LogTime desc


select distinct top 1
	*
from logs  WITH (NOLOCK)
WHERE  merchantid = 3527--3096--1911 --3242
	and category = 'Statistics'
and module = 'Synchronizer'
    and logtime > convert(date,getdate()-1)
order by LogTime desc

--**************CONVERT REPORTS**************

select top(10)
	*
from Shopify.ShopifyConvertReports h WITH (NOLOCK)
	join Shopify.ShopifyConvertProductReportsDetail d on h.id = d.ConvertReportId
where h.MerchantId = 3477
	and d.TailbaseId in (776077 )
order by h.id desc



--**************SYNC REPORTS**************


select  distinct top 50 * 
from logs  WITH (NOLOCK)
 WHERE  merchantid in (3629) 
order by id desc



--update top (1) shopify.ShopifyMerchantCollections
--set syncstatusid  = 1 
--where id = 299253


SELECT 
spv.TailbaseId          AS VariantTailbaseId,
       sp.TailbaseId           AS ParentProductTailbaseId,
       sp.SyncStatusId,
       sp.handle,
       spv.Price, spv.CompareAtPrice , mp.price, mp.reducedPrice, spv.SyncStatusId
FROM   shopify.ShopifyProductVariants spv
JOIN   shopify.ShopifyProducts sp ON spv.ShopifyProductID = sp.Id
JOIN datatail20130410.dbo.merchantProds mp on mp.productid = sp.TailbaseId and sp.MerchantId = mp.merchant_id
WHERE  sp.MerchantId = 3606
and sp.vendor like '%ashley%'
AND    spv.TailbaseId in (select productid from datatail20130410.dbo.merchantProds where merchant_id = 3606 )


select productid, price, reducedPrice, lock from datatail20130410.dbo.merchantProds where merchant_id = 2798


select top 10 sp.id, sp.handle, sp.SyncStatusId, h.StartTime, h.EndTime, d.GraphQLCallInfo, d.Text
from Shopify.ShopifySyncReports h WITH (NOLOCK)
	join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
	join Shopify.ShopifyProducts sp on sp.id = d.ShopifyProductId
where h.MerchantId = 2798
order by h.id desc

--**************COLLECTION REPORTS**************
select top 10
	*
from Shopify.ShopifyCollectionSyncReportsDetail
where SyncReportId in (select id
	from Shopify.ShopifySyncReports
	where merchantid = 3629 )
	and ShopifyCollectionId = 299253
order by id desc;







--**************DEBUG**************

SELECT TOP 10
	*
FROM Shopify.ShopifySyncReports
WHERE MerchantId = 3447
	and endtime >= getdate()
ORDER BY ID DESC


SELECT *
FROM Shopify.ShopifyProducts
where MerchantId = 3527 
and itemtype = 4



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
and sp.tailbaseid in (817765,
912657)
and sp.handle = 'germain-lariviere-mobiliers-modulaires-fixe-916947'




select sp.merchantid, sp.id, sp.handle, spv.tailbaseid as VariantTailbaseId, spv.SyncStatusId as VariantSyncStatusId, vm.*
from shopify.ShopifyProducts sp
join shopify.ShopifyProductVariants spv on spv.ShopifyProductId = sp.Id
left join shopify.ShopifyProductVariantMetafields vm
  on vm.ShopifyProductVariantId = spv.Id
 and vm.KeyName in ('Specs', 'HtmlSpecs')
where sp.merchantid = 3527
  and sp.handle = 'germain-lariviere-mobiliers-modulaires-fixe-916947';

  update top (2) shopify.shopifyProducts set SyncStatusId = 2 where id in (2168522)

  update top (2)  shopify.ShopifyProductVariants
  set syncstatusid = 2 
  where id in (2365790,
4806285)




  update vm
set TranslationStatusId = 1
from shopify.ShopifyProductVariantMetafields vm
inner join shopify.ShopifyProductVariants spv on spv.Id = vm.ShopifyProductVariantId
inner join shopify.ShopifyProducts sp on sp.Id = spv.ShopifyProductId
where sp.MerchantId = 3527
  and sp.Handle = 'germain-lariviere-mobiliers-modulaires-fixe-916947'
  and vm.KeyName = 'Specs'
  and vm.Namespace = 'tbsfy_Specs'
  and vm.ShopifyGeneratedMetafieldId is not null;











select * from shopify.ShopifyProductVariantMetafields where ShopifyProductVariantId in (7822053,9525800)






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
where sp.MerchantId  = 3388
and sp.tailbaseid  = 912142
--and sp.handle = 'signature-design-by-ashley-visola-p802-7-pc-outdoor-dining-set'
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
where sp.merchantid =  2087
--and sp.ID = 1845631
and sp.tailbaseid in(   690958) 

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
select productid, price, reducedPrice, lock from datatail20130410.dbo.merchantProds where merchant_id = 2798 and productid = 903661
select * from  datatail20130410.dbo.BlacklistedItems where merchantid = 3527 and itemid = 903661
select

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
3263235

update shopify.ShopifyProducts
set SyncStatusId = 2 
where id in (3263235)


update shopify.ShopifyProductVariants
set SyncStatusId = 2 
where shopifyProductId in (3263235)





WITH LatestMerchantLogs AS
(
    SELECT
        l.MerchantID, l.text, l.logtime, l.MODULE, l.category,
        ROW_NUMBER() OVER (
            PARTITION BY l.MerchantId
            ORDER BY l.LogTime DESC
        ) AS RN
    FROM logs l WITH (NOLOCK)
    WHERE l.MerchantId IN
    (
		3608,2384,1817,3650,2724,571,3620,1175,3572,3527,3605,3629,2692,3535,3533,3509,3523,2186
    )
)
SELECT
    *,
    DATEDIFF(MINUTE, LogTime, GETDATE()) AS MinutesAgo,
    DATEDIFF(HOUR, LogTime, GETDATE()) AS HoursAgo
FROM LatestMerchantLogs
WHERE RN = 1
ORDER BY LogTime DESC;


SELECT productId, Price, ReducedPrice, ReducedPriceStartDate, ReducedPriceEndDate, RealPrice, Fee
FROM   datatail20130410.dbo.fn_GetMerchantProductsWithCollectionProducts(3527)
WHERE  productId = 903661;


SELECT vp.ProductId, vp.VariantId, vp.Approved
FROM   datatail20130410.dbo.VariantProducts vp
WHERE  vp.VariantId IN (
         SELECT VariantId FROM datatail20130410.dbo.VariantProducts WHERE ProductId = 903661
       )
ORDER BY vp.ProductId;


select * from datatail20130410.dbo.variants where id = 337302