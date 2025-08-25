select  mc.collectionid, cp.productid, cp.quantity, mp.cost, mp.price, mp.reducedPrice,
mc.cost, mc.price, mc.reducedPrice
from merchantcollections mc
join collection_product cp  on cp.collectionid = mc.collectionid  
join  merchantprods mp on mp.productid = cp.productid and mc.Merchant_ID = mp.merchant_id
where mc.merchant_id = 589 
and mc.collectionid = 17740


select productid, cost, price, reducedprice from merchantprods where merchant_id = 589 and productid in
(select productid from collection_product where collectionid = 17740)

select productid from collection_product where collectionid = 17740