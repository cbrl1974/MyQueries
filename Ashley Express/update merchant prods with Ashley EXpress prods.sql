
--Get all current merchants that have Ashley EXpress
select m.id, m.merchant 
from merchantshipping ms
inner join merchants m on m.id = ms.merchant_id
where ms.dropshippingProgramid = 1
and m.active = 1

Declare @MerchantIDInfo as INT = 3069;
--Get info on the current state of Ashley elasticsearch_CustomTerm
select mp.productId, mp.elasticsearch_CustomTerm, mp.liquidation, mp.webonly, mp.refurbished, mp.new, mp.storeonly, mp.specialbuy
from merchantprods mp
left join DistributorItems di on di.ItemID = mp.productid
where di.DistributorID = 1
and mp.merchant_id = @MerchantIDInfo

--Update 
Declare @MerchantID as INT = 3069;
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


select mp.productId, mp.elasticsearch_CustomTerm from merchantprods mp
left join DistributorItems di on di.ItemID = mp.productid
where di.DistributorID = 1
and mp.merchant_id = @MerchantID

