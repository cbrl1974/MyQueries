

--Get info on the current state of Ashley elasticsearch_CustomTerm
select mp.productId, mp.webonly, mp.elasticsearch_CustomTerm from merchantprods mp
left join DistributorItems di on di.ItemID = mp.productid
where di.DistributorID = 1
and mp.merchant_id = 1817

--Update 
Declare @MerchantID as INT = 1817;
Declare @totalProdsPartShippingProgram as int = (select count(mp.id) as totalProds from merchantprods mp
inner join DistributorItems di on di.ItemID =mp.productid
where di.DistributorID = 1
and mp.merchant_id = @MerchantID);
Declare @AshleyTagName as varchar(50) = 'AshleyExpress';


update top (@totalProdsPartShippingProgram) merchantprods
set Elasticsearch_CustomTerm = @AshleyTagName
where productid in (select mp.productid from merchantprods mp
inner join DistributorItems di on di.ItemID =mp.productid
where di.DistributorID = 1
and mp.merchant_id = @MerchantID)
and merchant_id = @MerchantID


select mp.productId, mp.webonly, mp.elasticsearch_CustomTerm from merchantprods mp
left join DistributorItems di on di.ItemID = mp.productid
where di.DistributorID = 1
and mp.merchant_id = @MerchantID

