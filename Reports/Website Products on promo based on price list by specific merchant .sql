select pp.productid 'Product ID', pp.type 'Price Type', pp.price 'Price from LG list', pp.StartDate 'StartDate from LG list', pp.EndDate 'EndDate from LG list'
 ,mp.price 'RegularPrice Website', mp.reducedPrice 'reducedPrice Website', mp.reducedPriceStartDate, mp.reducedPriceEndDate 
from productsPrices pp
inner join products p on p.Id_product = pp.productid
inner join merchantProds mp on mp.productid = pp.productid
where p.manufid = 5
and pp.type like '%Promo%'
and pp.country = 'CA'
and p.active = 1
--and pp.endDate >= getdate()
and pp.startdate >= '2023-08-24'
and mp.merchant_id = 3467
and mp.reducedPriceStartDate = pp.StartDate
--and mp.reducedPriceStartDate is not null
order by  pp.startDate, mp.productid

