select s.id, m.merchant, s.MerchantId, s.ShopUrl, s.SecurityStamp, s.ApiVersion
from Tailbasify.shopify.shopifyMerchants s
    inner join merchants m on m.id = s.MerchantId
where m.id in (1956)


--Checking by targetting some collection rebates
SELECT  *
FROM Tailbasify.shopify.ShopifyMerchantCollections
WHERE MerchantId = 3209
AND tailbaseID IN ( 
    SELECT TailbaseId 
    FROM Tailbasify.shopify.ShopifyProducts 
    WHERE merchantid = 3209 
    AND itemtype = 3
    )
and SyncStatusId  = 6
and ShopifyGeneratedCollectionId is null




--Checking all collections 
SELECT  *
FROM Tailbasify.shopify.ShopifyMerchantCollections mc
where SyncStatusId  = 6
and ShopifyGeneratedCollectionId is null
and merchantid = 1956 



--First Delete Rule
delete from Tailbasify.shopify.ShopifyCollectionRuleInputs
where ShopifyMerchantCollectionId in (
            SELECT  id
        FROM Tailbasify.shopify.ShopifyMerchantCollections mc
        where SyncStatusId  = 6
        and ShopifyGeneratedCollectionId is null
        and merchantid = 1956 
    )


-- Second Delete ShopifyMerchantCollections
delete from Tailbasify.shopify.ShopifyMerchantCollections
where  SyncStatusId  = 6
and ShopifyGeneratedCollectionId is null
and merchantid = 1956 

