
WITH ProductBasePricesOnMarksons 
AS
(
	select * from devTailbaseCore.feeds.ProductBasePrices 
	where FeedId = 9
	and merchantid = 3336
),
ProductBasePricesOnMarksonsWebsite
AS
(
	select productid, cost from devTailbaseCore.dbo.merchantProds
	where merchant_id = 3336
)


select  m.productid,  m.price, m.AdditionalPricingData, mp.cost
from ProductBasePricesOnMarksons m 
inner join ProductBasePricesOnMarksonsWebsite mp on mp.productID = m.ProductId
where m.Price <> mp.cost


