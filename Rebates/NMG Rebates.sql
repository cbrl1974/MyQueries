 use datatail20130410
 
 DECLARE @MerchantIdforFeatures AS INT = 2724;
 select * from merchantWebsiteFeatures where merchant_id = @MerchantIdforFeatures
 and featurecode like '%rebates%'

select * from merchants where id = 2724
select rebate from merchantcms where merchant_id = 2724

--Get the nmgid(DealerId)
 select id, merchant, nmgid, NmgLocationID from merchants where id in (32724560)



select top 10 * from RebateGroups
select  top 10 * from RebateFeeds 
where RebateFeedID  in (1010623)
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

select * from merchantrebates 
where merchant_id =2456
and active = 1
--and name_1 like '%RED HOT SAVINGS%'
--and DisplayStartDate = getdate()
order by DisplayEndDate desc

update top (1) merchantrebates
set active = 1
where id_rebate in (1147394)
and merchant_id = 2456

select * from tailbasify.shopify.ShopifyProducts 
where merchantid = 2456
and tailbaseid = 256216

select * from tailbasify.shopify.ShopifyProducts 
where merchantid = 2456
and tailbaseid in 
	(
		select id_rebate from merchantrebates 
		where merchant_id = 2456
		and active = 1
		and name_1 like '%RED HOT SAVINGS%'
	)

	select  rp.* from merchantprods mp 
	inner join MerchantRebateProducts rp on rp.ProductID = mp.productid 
	where mp.Merchant_ID = 2456
	and rp.RebateID in 
	(
		select id_rebate from merchantrebates 
		where merchant_id = 2456
		and active = 1
		and id_rebate = 1147394
	)



DECLARE @easternNow DATETIME = getdate();

SELECT *
FROM MerchantRebates mr
JOIN MerchantRebateProducts mrp ON mr.Id_Rebate = mrp.RebateId
WHERE 
    mr.Merchant_Id = 2456
    AND mr.Active IS NOT NULL
    AND mr.Active = 1
    AND mr.DisplayStartDate < @easternNow
    AND mr.DisplayEndDate > @easternNow
    AND mr.Name_1 IS NOT NULL
    AND mr.Name_1 <> '';

	select * from merchantrebates where merchant_id = 2217 order by id_rebate desc

	update top (1) merchantrebates 
	set name_2 = '',
	description_1 = '',
	shortdescription_1 = '',
		description_2 = '',
		shortdescription_2 = ''
	where id_rebate = 1167196
	and merchant_id = 2091

	select count(productid) from merchantprods where merchant_id = 3589
	 