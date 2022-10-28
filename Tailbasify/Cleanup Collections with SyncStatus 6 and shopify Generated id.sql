select s.id, m.merchant, s.MerchantId, s.ShopUrl, s.SecurityStamp, s.ApiVersion
from devtailbasify.shopify.shopifyMerchants s
    inner join merchants m on m.id = s.MerchantId
where m.id in (1956)


select  m.merchant, me.*
from devtailbasify.dbo.MerchantExports me
 inner join merchants m on m.id = me.MerchantId
order by [Status] desc

--Checking by targetting some collection rebates
SELECT  *
FROM devtailbasify.shopify.ShopifyMerchantCollections
WHERE MerchantId = 1956
AND tailbaseID IN ( SELECT TailbaseId FROM devtailbasify.shopify.ShopifyProducts WHERE merchantid = 1956 AND itemtype = 3)
and SyncStatusId  = 6
and ShopifyGeneratedCollectionId is null

--Case test: id: 11237; Title:Fisher Paykel 5 Year Warranty Offer had a syncstatus 6!


--Checking all collections 
SELECT  *
FROM devtailbasify.shopify.ShopifyMerchantCollections mc
where SyncStatusId  = 6
and MerchantId = 1956
and ShopifyGeneratedCollectionId is null

--
update top (172) devtailbasify.shopify.ShopifyMerchantCollections
set SyncStatusId = 1
where SyncStatusId  = 6
and MerchantId = 1956
and ShopifyGeneratedCollectionId is null



--First Delete Rule
delete from devtailbasify.shopify.ShopifyCollectionRuleInputs
where ShopifyMerchantCollectionId in ( 
    SELECT  id
    FROM devtailbasify.shopify.ShopifyMerchantCollections mc
    where SyncStatusId  = 6
    and MerchantId = 1956
    and ShopifyGeneratedCollectionId is null
)

-- Second Delete ShopifyMerchantCollections
delete from devtailbasify.shopify.ShopifyMerchantCollections
    where MerchantId = 1956 
    and id in (SELECT id
    FROM devtailbasify.shopify.ShopifyMerchantCollections mc
    where SyncStatusId  = 6
    and MerchantId = 1956
    and ShopifyGeneratedCollectionId is null
)
