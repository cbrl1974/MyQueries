-- Get Competition from merchant
DECLARE @MerchantID as int = 1900;
select competition from merchants where id = @MerchantID


select * from retailers where id_retailer in (2753,2755,2756)


DECLARE @ProductID as int = 558502;
DECLARE @MerchantID as int = 1900;
select price, reducedPrice from merchantprods where merchant_id = @MerchantID and productid = @ProductID
select top 100 * from webtracking 
where retailerID in (2753,2755,2756)
and productid =  @ProductID
and TrackingDate between '2021-12-09' and '2021-12-10'



