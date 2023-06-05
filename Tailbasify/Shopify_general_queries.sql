Declare @action as varchar(200) = 'convert' 

-- Merchants
select
    s.MerchantId,
	case
	when @action = 'update'  then 'https://api.tailbasify.com/'+ s.ApiVersion + '/Shopify/Update/' + s.SecurityStamp 
	WHEN  @action = 'convert' then 'https://api.tailbasify.com/'+ s.ApiVersion + '/Shopify/Converter/Convert/' + s.SecurityStamp 
	WHEN  @action = 'synchronize' then 'https://api.tailbasify.com/'+ s.ApiVersion + '/Shopify/Synchronizer/Synchronize/' + s.SecurityStamp 
	  END AS EndPoint,
	s.id, m.merchant, s.ShopUrl, s.SecurityStamp
from shopify.shopifyMerchants s
    inner join datatail20130410.dbo.merchants m on m.id = s.MerchantId
where m.id = 3242


--===============================================================================================

update MerchantExports
 set [status]  = 1
 where merchantid  = 3096
  --where [status] <> 1

--===============================================================================================


select m.merchant, me.*
from MerchantExports me
    inner join datatail20130410.dbo.merchants m on m.id = me.MerchantId
order by [Status] desc, ModificationDate desc



select top 100  *  from logs  WITH (NOLOCK) order by LogTime desc 


--===============================================================================================

--Logs for Converter
select top 50
    *
from logs  WITH (NOLOCK)
WHERE  merchantid = 571
    AND module = 'Converter'
order by LogTime desc


--Logs for Converter
select top 50
    *
from logs  WITH (NOLOCK)
    where module = 'BaseTailbasifyRepositoryModule'
	and text like '%getby%'
order by LogTime desc

--===============================================================================================

select top(10)
    *
from Shopify.ShopifyConvertReports h WITH (NOLOCK)
    join Shopify.ShopifyConvertProductReportsDetail d on h.id = d.ConvertReportId
where h.MerchantId = 571
    --and d.TailbaseId in (1125613)
order by h.id desc





--===============================================================================================
--Logs for Synchronizer
select top(250)
    *
from logs  WITH (NOLOCK)
WHERE  merchantid = 1958
    AND module = 'Synchronizer'
order by id desc


3040600
Ad_3040600
Furniture1
03
--===============================================================================================

--Sunc Report
select top(10)
    *
from Shopify.ShopifySyncReports h WITH (NOLOCK)
    join Shopify.ShopifyProductSyncReportsDetail d on h.id = d.SyncReportId
where h.MerchantId = 2384
--and GraphQLCallInfo is not null
    and d.ShopifyProductId in (1092388)
order by h.id desc


--===============================================================================================

SELECT TOP 10 * FROM Shopify.ShopifySyncReports WHERE MerchantId = 1842 ORDER BY ID DESC


SELECT * FROM Shopify.ShopifyProducts
WHERE ID IN (SELECT ShopifyProductId FROM Shopify.ShopifyProductSyncReportsDetail WHERE SyncReportId IN (308795))
AND MerchantId = 1842
AND SyncStatusId IN (2,3)
AND ShopifyGeneratedProductId IS NULL




--===============================================================================================
select *
from shopify.shopifyProducts
where merchantid = 1956
and id in (1208247,937,16062,2187,9294,15064,21410,66884,554552,66833,906085,948707)
	--and itemtype = 1 
	--and itemtype = 2 
	--and itemtype = 3 
	--and itemtype = 4 
	and itemtype = 5 
	--and tailbaseid in (494322)
--and handle = 'amana-44cuft-top-load-washer-ntw4519jw'

	-- update  shopify.shopifyProducts
	-- set SyncStatusId = 2
	-- where MerchantId = 3039
	-- --and itemtype = 4 
	-- and productType =  'Beverage Centers'


--===============================================================================================


select 
*
from shopify.ShopifyMerchantCollections
where MerchantId = 2384
--and TitleEn like '%Jennair%'
and ShopifyGeneratedCollectionId is null
and handle  like '%salon%'


select *
FROM shopify.ShopifyMerchantCollections mc
where merchantid = 1956 
and SyncStatusId = 6
and  tailbaseid in (1083289,1083290,1083296)
 and ShopifyGeneratedCollectionId is null





--===============================================================================================

select * from shopify.ShopifyMerchantMetafields 
--where ShopifyProductId = 824735
where ShopifyProductId in (
	select id from shopify.ShopifyProducts
	where merchantid = 1956
	and id =1208247
)


--===============================================================================================


select m.TailbaseId,m.OriginalSource, m.TailbaseIdType, m.SyncStatusId, m.ShopifyGeneratedMediaId, m.LastModificationDate, m.ShopifyMediaStatusId
    from Shopify.ShopifyProductMedia m
where m.shopifyProductID in 
(
    select id
        from shopify.ShopifyProducts
    where MerchantId = 2384
)
and TailbaseId = 679201
and m.SyncStatusId <> 3

-- update Shopify.ShopifyProductMedia
-- set SyncStatusId = 3,
-- ShopifyMediaStatusId = NULL
-- where shopifyProductID in 
-- (
--     select id
--         from shopify.ShopifyProducts
--     where MerchantId = 2384
-- )
-- and SyncStatusId <> 3



-- update shopify.ShopifyProducts
-- set SyncStatusId = 2
--   where MerchantId = 2384
-- 	and ItemType in (1,2)
--  select id
--         from shopify.ShopifyProducts
--     where MerchantId = 2384
-- 	and ItemType in (1,2)

--===============================================================================================

select *
from shopify.ShopifyProductVariants
where ShopifyProductID 
 in (
    select id
        from shopify.shopifyProducts
        where merchantid = 3209 
		--and SyncStatusId = 3
)
order by SyncStatusId


--===============================================================================================

select *
from SyncStatus

--===============================================================================================

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

