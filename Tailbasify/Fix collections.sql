

--Fix collections
select *
from shopify.ShopifyMerchantCollections
where MerchantId = 3335 and tailbaseID in (select TailbaseId from shopify.shopifyProducts where MerchantId = 3335 and ItemType = 2)
and tailbaseID = 1081732

select *
from shopify.shopifyProducts
where merchantid = 3335 
and tailbaseid  in (25235)


select * from datatail20130410.dbo.merchantRebates where merchant_id = 3335 and id_rebate =1081732
and active = 1 order by DisplayEndDate desc

select *
from shopify.ShopifyCollectionRuleInputs
where ShopifyMerchantCollectionId = 6890

--First Delete Rule
-- delete top (1)  from shopify.ShopifyCollectionRuleInputs where ShopifyMerchantCollectionId =6890
-- --Second Delete ShopifyMerchantCollections
-- delete top (1)  from shopify.ShopifyMerchantCollections where MerchantId = 3335 and id = 6890
