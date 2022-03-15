DECLARE @init as int = 172999900;
--DECLARE @end as int = @init + 1000;
DECLARE @end as int = 180301958;
DECLARE @webtrackingData TABLE(id INT, productid INT, advPrice DECIMAL(19,2), retailerid int, TrackingDate DATE);
 

insert into @webtrackingData (id, productid, advPrice, retailerid, TrackingDate)  
select id, productid, advPrice, retailerid, TrackingDate from DatatailHistoricals.dbo.WebTracking
where id BETWEEN @init and @end

--select * from @webtrackingData

select w.productid, p.model, c.id_category, c.category, r.retailer, w.trackingdate from @webtrackingData w
inner join products p on p.id_product = w.productid
inner join categories c on c.id_category = p.catid and c.id_langue = 1
inner join retailers r on r.id_retailer = w.retailerid and r.countryId = 36
where p.catID = 41
and p.manufid in (9,462,439,1768,2017,2029)



