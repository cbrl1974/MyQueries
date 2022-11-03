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
and merchantid = 3096 

update top (1) Tailbasify.shopify.ShopifyMerchantCollections
set SyncStatusId = 1
where MerchantId = 1956
and id = 11237


--
update top (172) Tailbasify.shopify.ShopifyMerchantCollections
set SyncStatusId = 1
where SyncStatusId  = 6
and MerchantId = 1956
and ShopifyGeneratedCollectionId is null



--First Delete Rule
delete from Tailbasify.shopify.ShopifyCollectionRuleInputs
where ShopifyMerchantCollectionId in (8195,7864,7867,7881,7878,7871,7870,7868,7873,7874,7866,7876,7875,7872,7880,8194,7865,7879,7877)


-- Second Delete ShopifyMerchantCollections
delete from Tailbasify.shopify.ShopifyMerchantCollections
where id in (8195,7864,7867,7881,7878,7871,7870,7868,7873,7874,7866,7876,7875,7872,7880,8194,7865,7879,7877)

