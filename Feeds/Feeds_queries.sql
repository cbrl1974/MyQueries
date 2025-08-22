use datatail20130410

select *
from datatail20130410.feeds.FeedDumps  WITH (NOLOCK)
where  RunDate > convert(date,getdate()-1)
    and feedid = 4
    --and MerchantId in (1751)
    -- and    totalcount = 0
order by feedid,merchantid,RunDate desc


 delete top (20) datatail20130410.feeds.FeedDumps 
 where  RunDate > convert(date,getdate()-1)
     and feedid = 9
     --and MerchantId in (3385)
	  and totalcount = 0






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
    and severity <> 2
order by [time] desc

select *
from datatail20130410.Feeds.ProductBasePrices
where feedid = 4
    and ProductId = 733607

select *
from feeds.PriceTypes
select *
from feeds.PricingTiers

select id_product, model, manufModel, photo, active, discontinued, ManufacturerIdentifier
from products
where id_product = 456991
--733607
select *
from merchantProds
where merchant_id = 3605 and productid = 733607

select *
from datatail20130410.feeds.feeds
where id = 21


select mf.MerchantId, mf.FeedOptionsJson, m.active
from datatail20130410.feeds.merchantfeeds mf
left join merchants m on m.id = mf.merchantid
where mf.feedid = 21
and merchantid = 3418
order by mf.merchantid



select distinct m.id as merchantID, p.id_product, p.manufModel, co.cie, c.category,  fp.price, mp.cost, mp.price, mp.reducedPrice,
  --JSON_VALUE( fp.AdditionalPricingData , '$.Promotions.Value') AS PromoPricing,
    --JSON_VALUE( fp.AdditionalPricingData , '$.ManufacturerSuggestedRetailPrice') AS MSRP,
  --JSON_VALUE( fp.AdditionalPricingData , '$.Freight') AS Freight,
  --  JSON_VALUE( fp.AdditionalPricingData , '$.ItemsPerCase') AS ItemsPerCase,
 fp.AdditionalPricingData 
from Feeds.ProductBasePrices fp
join products p on p.id_product = fp.productid
join companies co on co.id_cie = p.manufid 
join categories c on c.id_category = p.catid and c.id_langue = 1
join merchantProds mp on mp.productid = p.id_product
join merchants m on m.id = mp.merchant_id and fp.productid = p.id_product
where fp.feedid =27
--and p.manufid = 7587
--and p.id_product  in (809498,809507,809508 )
and m.id = 3242
and p.active = 1
and p.discontinued = 0
and p.photo = 1
and p.specs = 1
and c.category like '%adjustable%'
group by m.id , p.id_product, p.manufModel, co.cie, c.category,  fp.price, mp.cost, mp.price, mp.reducedPrice,
 fp.AdditionalPricingData 


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
where merchant_id in (2763,3281,3242,2347,2936,3598,3509,1099,3514,2175,2627,2542,2993,2232,3471,3392,2071,3090,1817,1798,3384,3512,2932,2980,2738,3077,3574,3391,3390,2186,3535,2562,2281,3429,2769,3363,2464,2029,2777,3604,3608,3591,1606,3062,3603)
    and brand = 'Ashley'

--delete top (41) from datatail20130410.dbo.MerchantFeeds
--where merchant_id in (2763,3281,3242,2347,2936,3598,3509,1099,3514,2175,2627,2542,2993,2232,3471,3392,2071,3090,1817,1798,3384,3512,2932,2980,2738,3077,3574,3391,3390,2186,3535,2562,2281,3429,2769,3363,2464,2029,2777,3604,3608,3591,1606,3062,3603) 
--and brand = 'Ashley'



select *
from products
where model like '%WP2188656%'
--208601
--WP2188656

select m.id, m.merchant, m.merchant_url, p.model, p.manufmodel, p.DateCreation  , mp.price, mp.reducedPrice, mp.realPrice
from products p
    inner join merchantProds mp on p.id_product = mp.productid
    inner join merchants m on m.id = mp.merchant_id
        and m.countryCode = 'ca'
where mp.productid = 208601
    and mp.realprice is not null
    and m.active = 1
order by mp.realPrice


 select mf.MerchantId
                ,m.merchant 'Merchant'
                ,m.active 'IsMerchantActive'
                ,(select max(Time) from feeds.JobRun where FeedId=mf.FeedId and DryRun=0) 'LastSource'
                ,(select max(Time) from feeds.JobRun where MerchantFeedId=mf.MerchantFeedId and DryRun=0) 'LastRun'
                ,mf.FeedOptionsJson
                from feeds.MerchantFeeds mf
                join merchants m on mf.MerchantId=m.ID
                where mf.FeedId = 9
                order by 2;
                
                select id 'MerchantId', merchant+' ('+convert(nvarchar(10),id)+')' 'Merchant' from merchants where id not in (
                select mf.MerchantId
                from feeds.MerchantFeeds mf
                where mf.FeedId = 9
                )  and active=1
                order by 2;




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
