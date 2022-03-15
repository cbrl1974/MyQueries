use datatail20130410
Declare @MerchantID as int = 2312;



select productid, featured, featuredtabid from merchantprods
where merchant_id = @MerchantId
and featured > 0

select * from merchantfeaturedtabs where  merchant_id = @MerchantId
and id in (4762,6441,1585,1584)



