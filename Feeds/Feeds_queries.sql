select * from feeds.feeds where id = 9

select * from feeds.merchantFeeds where  feedid = 9 order by merchantid desc
select * from feeds.merchantFeeds where merchantid =589 and feedid = 9
select * from merchantfeeds where merchant_id = 1097


select * from feeds.FeedDumps 
where  RunDate > convert(date,getdate()-1) 

select top 10 * from feeds.JobRun order by time desc


select top 50 * from feeds.FeedDumps
-- where identifier = 'FOA_ProductsInfo'
 order by RunDate desc



--Get Products
SELECT mp.ProductID FROM MerchantProds  mp
INNER JOIN products p on p.Id_product = mp.ProductID
WHERE 	mp.Merchant_ID = 1193
and p.manufID in (6183,3181,3182,3184,4226,4227)


-- **********Delete Products**********
-- delete top (7156) FROM MerchantProds
-- where merchant_id = 1193
-- and productid in (
--     SELECT mp.ProductID FROM MerchantProds  mp
--         INNER JOIN products p on p.Id_product = mp.ProductID
--     WHERE 	mp.Merchant_ID = 1193
--     and p.manufID in (6183,3181,3182,3184,4226,4227)
-- )


-- **********Get Collections**********
SELECT mc.CollectionId, c.brands FROM MerchantCollections  mc
inner join collections c on c.id = mc.collectionid
inner join collection_product cp on cp.collectionID = c.id
INNER JOIN products p on p.Id_product = cp.ProductID
WHERE 	mc.Merchant_ID = 1193
and p.manufID in (6183,3181,3182,3184,4226,4227)

-- **********Delete Collections**********
-- delete top (2440) FROM MerchantCollections
-- where merchant_id = 1193
-- and collectionID in (
--     SELECT mc.CollectionId FROM MerchantCollections  mc
--     inner join collections c on c.id = mc.collectionid
--     inner join collection_product cp on cp.collectionID = c.id
--     INNER JOIN products p on p.Id_product = cp.ProductID
--     WHERE 	mc.Merchant_ID = 1193
--     and p.manufID in (6183,3181,3182,3184,4226,4227)
-- )


-- **********Get Collections**********
select * from  merchantBrands
where merchant_id = 1193 
and cieId in  (6183,3181,3182,3184,4226,4227)


--Delete Brands
-- delete top (6) from merchantBrands 
-- where merchant_id = 1193 
-- and cieId in  (6183,3181,3182,3184,4226,4227)
