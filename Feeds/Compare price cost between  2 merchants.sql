
WITH ProductBasePricesOnMarksons 
AS
(
	select * from devTailbaseCore.feeds.ProductBasePrices 
	where FeedId = 9
	and merchantid = 3336
),
ProductBasePricesOnDynamicDemo
AS
(
	select * from devTailbaseCore.feeds.ProductBasePrices 
	where FeedId = 9
	and merchantid = 589
)


select  m.productid,  m.price, m.AdditionalPricingData, d.productid,  d.price, d.AdditionalPricingData
from ProductBasePricesOnMarksons m 
inner join ProductBasePricesOnDynamicDemo d on d.productID = m.ProductId
where m.Price <> d.Price


