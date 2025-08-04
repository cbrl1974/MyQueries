use datatail20130410

select *
from datatail20130410.feeds.FeedDumps  WITH (NOLOCK)
where  RunDate > convert(date,getdate()-1)
--where 1 = 1
    and feedid = 9
    --and MerchantId in (2798,1448)
	--and totalcount = 0
order by feedid,merchantid,RunDate desc

delete top (10) datatail20130410.feeds.FeedDumps 
where  RunDate > convert(date,getdate()-1)
and  feedid = 9 
   and MerchantId in (2798,1448)





	

select mp.merchant_id, mp.cost, mp.productid, mp.price, mp.reducedprice, mp.QtyPerPackage, fp.productid 'Productid_From_Feed', fp.price, fp.merchantid, fp.feedid, fp.AdditionalPricingData
from feeds.ProductBasePrices fp
    left join merchantprods mp on mp.Merchant_ID = fp.MerchantId and mp.productid = fp.ProductId
    inner join merchants m on m.id = fp.MerchantId
where  fp.feedid = 9
    and fp.MerchantId in (1202)
    and fp.productid in (258565,258558)
    and m.active = 1



--delete top (2) datatail20130410.feeds.FeedDumps 
--where  RunDate > convert(date,getdate()-1)
--and  feedid = 9 
--and MerchantId in (1448)



with
    MerchantRunSummary
    as
    (
        select
            d.merchantid,
            count(*) as CountMerchant
        from datatail20130410.feeds.FeedDumps d WITH (NOLOCK)
        where d.RunDate > convert(date, getdate() - 1)
            and d.feedid = 9
        group by d.merchantid
    )

select
    distinct mf.merchantid as merchantOnboarded,
    d.merchantid,
    d.RunDate,
    d.feedid,
    mrs.CountMerchant,
    case 
		when d.CurrentIndex > d.totalcount then 'Complete'
		when mrs.CountMerchant >= 2 then 'Complete'
		else 'Incomplete'
	end as status
from datatail20130410.feeds.FeedDumps d WITH (NOLOCK)
    inner join feeds.MerchantFeeds mf
    on mf.FeedId = d.FeedId and mf.MerchantId = d.MerchantId
    inner join MerchantRunSummary mrs
    on mrs.merchantid = d.merchantid
where d.RunDate > convert(date, getdate() - 1)
    and d.feedid = 9
order by mrs.CountMerchant, mf.merchantid, d.merchantid, d.RunDate desc, d.feedid desc


--Check if all merchants onboarded preload ran
select merchantid
from feeds.MerchantFeeds
where feedid = 9 and merchantid not in ( 
select distinct merchantid
    from feeds.FeedDumps
    where feedid = 9 and RunDate > convert(date,getdate()-1))
order by merchantid



SELECT top 150
    [LogID]
      , [Project]
      , [Category]
	  , text
      , [Time]
      , [Severity]
      , [Module]
      , [Location]
FROM [EventReactor].[dbo].[Logs] WITH (NOLOCK)
where category = 'feeds'
    and time > convert(date,getdate()-0)
order by [time] desc



select *
from datatail20130410.feeds.feeds
where id = 9

select *
from datatail20130410.feeds.merchantfeeds
where feedid = 9
and merchantid = 3401
--where updatefrequency not like '%api%'

select m.id, m.merchant, f.id, f.Name, f.ClassName, mf.MerchantFeedId, mf.FeedOptionsJson,
    JSON_VALUE(mf.FeedOptionsJson, '$.CustomerId') AS CustomerId,
	JSON_VALUE(mf.FeedOptionsJson, '$.ShipTo') AS ShipTo
from datatail20130410.feeds.MerchantFeeds mf
    join feeds.feeds f on f.id = mf.FeedId
	join datatail20130410.feeds.FeedDumps fd on fd.MerchantId = mf.MerchantId
    join merchants m on m.id = mf.MerchantId
    join merchantwebsiteInformation mwi on mwi.merchant_id = m.id and mwi.infoCode = 'template'
where  m.active = 1 
	and totalcount = 0
	and RunDate > convert(date,getdate()-1)
	and mf.feedid = 9
    --and mf.merchantid = 3401
--order by MerchantId


--Old Feed
select m.id, m.merchant, mf.*
--delete top (20)
from datatail20130410.dbo.MerchantFeeds mf
    join merchants m on m.id = mf.merchant_id
--where merchant_id in  (3569,3586,3510,3541,2384,2771,2264,2046,1785,3490,1922,3171,1574)
where mf.brand = 'Ashley'
    and m.active = 1

select *
from datatail20130410.dbo.MerchantFeeds
where merchant_id in (3429) and brand = 'Ashley'



select * from products where model like '%WP2188656%' --208601
--WP2188656

select m.id, m.merchant, m.merchant_url, p.model, p.manufmodel,p.DateCreation  , mp.price, mp.reducedPrice,mp.realPrice
from  products p
inner join merchantProds mp  on p.id_product = mp.productid
inner join merchants m on m.id = mp.merchant_id
and m.countryCode = 'ca'
where mp.productid = 208601
and mp.realprice is not null
and m.active = 1
order by mp.realPrice