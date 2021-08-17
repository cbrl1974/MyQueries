select distinct cp.productID, p.model, co.cie, c.category, m.merchant
from products p, MerchantProds mp, MerchantCollections mc, collection_product cp, Categories c, companies co, merchants m
where mc.Merchant_ID = 49
and mc.Merchant_ID = m.ID
and cp.productID = p.Id_product
and cp.collectionID = mc.collectionID
and p.manufID = co.Id_cie
and p.catID = c.Id_category
and c.Id_langue = 1
and cp.productID not in (select productID from MerchantProds where Merchant_ID = 49)

select * from MerchantCollections where Merchant_ID = 49
select * from collection_product where collectionID = 3952