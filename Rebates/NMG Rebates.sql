 DECLARE @MerchantIdforFeatures AS INT = 2798;
 select * from merchantWebsiteFeatures where merchant_id = @MerchantIdforFeatures
 and featurecode like '%rebates%'

--Get the nmgid(DealerId)
 select id, merchant, nmgid, NmgLocationID from merchants where id in (3384,3201)

--Get the RebateFeedIds for the dealer
 select  * from RebateFeedClients where dealerid in ('8968')

--Get the rebates for the dealer
 select  * from RebateFeeds 
 where RebateFeedID in (1002517,1002518,1002584,1002651,1002654,1002693,1000159,1000396,1000515,1000587,1005392,1005393,1001559,1001576,1001587,1001606,1001674,1001675,1003234,1003255,1003299,1003365,1003414,1003416,1004581,1000722,1000806,1000894,1001065,1004956,1004969,1005087,1001827,1003036,1003056,1003182,1003183,1001246,1001272,1001321,1001322,1001393,1001394,1001439,1001440,1001459,1001462,1001463,1001472,1001520,1002355,1002428,1002469,1003563,1003656,1004751,1004920,1002229,1002763,1002764,1002808,1002829,1002834,1002863,1002903,1002905,1002906,1002907,1003743)
 and active = 1
 and Start_time > '2022-11-24'
