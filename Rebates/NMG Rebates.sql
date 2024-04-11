 DECLARE @MerchantIdforFeatures AS INT = 3519;
 select * from merchantWebsiteFeatures where merchant_id = @MerchantIdforFeatures
 and featurecode like '%rebates%'

--Get the nmgid(DealerId)
 select id, merchant, nmgid, NmgLocationID from merchants where id in (3499,3519)

--Get the RebateFeedIds for the dealer
 select  * from RebateFeedClients where dealerid in ('2796') and rebatefeedid in ( 1008356, 1008361, 1008357, 1008353, 1008381, 1008151, 1008188, 1008186, 1008243, 1008244, 1008263, 1008261, 1008262, 1008375, 1008382, 1008490, 1008540, 1008555, 1008624)

--Get the rebates for the dealer
 select  rebatefeedid from RebateFeeds 
 where RebateFeedID in ( select rebatefeedid from RebateFeedClients where dealerid in ('2796'))
 and active = 1
 and End_time >= getdate()

   select * from merchantProds where merchant_id = 3519 and productid in (
   select productid from RebateFeedProducts where RebateFeedID in
   (
	   select  rebatefeedid from RebateFeeds 
		 where RebateFeedID in ( 
		 select rebatefeedid from RebateFeedClients where dealerid in ('2796'))
		and active = 1
		and End_time >= getdate()
	)
	)
 select * from merchantrebates where merchant_id = 3499


 select * from rebate

