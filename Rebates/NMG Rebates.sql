 DECLARE @MerchantIdforFeatures AS INT = 3558;
 select * from merchantWebsiteFeatures where merchant_id = @MerchantIdforFeatures
 and featurecode like '%rebates%'

--Get the nmgid(DealerId)
 select id, merchant, nmgid, NmgLocationID from merchants where id in (3560)

 insert into RebateFeedClients values 
(1138839,51348),
(1138840,51348),
(1138841,51348),
(1138842,51348),
(1139268,51348),
(1126781,51348)

select top 10 * from RebateGroups
select  top 10 * from RebateFeeds where rebategroupid = 1 order by RebateFeedID desc
--where RebateFeedID  in (1138839,1138840,1138841,1138842,1139268,1126781)
select top 10 * from RebateFeedClients
--Get the RebateFeedIds for the dealer
 select  RebateFeedID from RebateFeedClients where 
    dealerID in ('51348')


--Check if there are products on the merchant catalog
  select * from merchantProds 
  where merchant_id = 3560
  and productid in
   ( 
	select productid from RebateFeedProducts where RebateFeedID  in
	 	(		
			1008975,1008976,1008977,1009133,1009274

		)
	)



--dealerid in ('51348')
--Get the rebates for the dealer
 select  rebatefeedid from RebateFeeds 
 where RebateFeedID in ( select rebatefeedid from RebateFeedClients where dealerid in ('51348'))
 and active = 1
 and End_time >= getdate()

   select * from merchantProds where merchant_id = 3519 and productid in (
	select productid from RebateFeedProducts where RebateFeedID in
		(
			select  rebatefeedid from RebateFeeds 
				where RebateFeedID in ( 
				select rebatefeedid from RebateFeedClients where dealerid in ('51348'))
				and active = 1
				and End_time >= getdate()
			)
	)



 select * from NmgRebateProducts where NmgRebateID  in (1008975,1008976,1008977,1009133,1009274)


 select * from merchantrebates where merchant_id in (
 select top 10 id from merchants
  where nmgid is not null order by id desc
  )



