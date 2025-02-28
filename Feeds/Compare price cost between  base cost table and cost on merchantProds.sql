
WITH ProductBasePricesOnWebsite
AS
(
	select * from datatail20130410.feeds.ProductBasePrices 
	where FeedId = 9
	and merchantid = 3447
),
CostOnmerchantProdsOnWebsite
AS
(
	select productid, cost from datatail20130410.dbo.merchantProds
	where merchant_id = 3447
)


select  m.productid,  m.price as CostONbasePrices, m.AdditionalPricingData, mp.cost as CostOnMerchantWebsite
from ProductBasePricesOnWebsite m 
inner join CostOnmerchantProdsOnWebsite mp on mp.productID = m.ProductId
where m.Price <> mp.cost


