	WITH Ashley_CTE (id, merchant, AccountNumber,merchant_url, EcommerceSite, DirectExress, isAshley, city, statecode, CountryName, lastmodified)  AS
	(
		select distinct m.id, m.merchant, SUBSTRING(mf.remoteFTPUser, 4, 6) as AccountNumber,m.merchant_url,
		(
			CASE WHEN mwf.featurecode = 'shoppingCartType' THEN 'yes' else 'no' end
		) as EcommerceSite,
		(
			CASE WHEN ms.dropShippingProgramID = 1 THEN 'yes' else 'no' end
		) as DirectExress,
		(
			CASE WHEN count(p.manufid) = 5 THEN 'Ashley Only' else 'Multi MFG' end
		) as isAshley,
		md.city, 
		md.statecode, 
		md.CountryName, 
		replace(REPLACE(mf.lastModified,'{ts ''', ''), '''}','') as lastmodified
	from merchantfeeds mf
	join merchants m on m.id = mf.merchant_id and mf.brand = 'Ashley'
	inner join merchantProds mp on mp.Merchant_ID = m.id
	left join products p on p.Id_product = mp.ProductID
	left join MerchantDistributorWarehouseLocations md on md.merchantid = mf.merchant_id 
	left join merchantwebsitefeatures mwf on mwf.merchant_id = mf.merchant_id  and mwf.featurecode = 'shoppingCartType'
	left join merchantshipping ms on ms.dropShippingProgramID = md.DistributorID
	where mf.brand = 'Ashley'
	and m.active = 1
	and mf.active = 1
    and p.manufID in (1436,3181,3182,3184,4227)
	and ms.dropShippingProgramID = 1  ---added direct express
	group by m.id, m.merchant,mf.remoteFTPUser,m.merchant_url,mwf.featurecode,ms.dropShippingProgramID,md.city, md.statecode, md.CountryName, lastmodified
	
),
count_Ashley_Products_CTE (id, total) AS
(
    select mp.merchant_id as id, count(distinct mp.productid ) as total
    from merchantProds MP 
    inner join products p on p.id_product = mp.ProductID
        where mp.merchant_id in (select distinct m.id 
	from merchantfeeds mf
	join merchants m on m.id = mf.merchant_id and mf.brand = 'Ashley'
	inner join merchantProds mp on mp.Merchant_ID = m.id
	left join merchantbrands mb on mb.merchant_id = mf.merchant_id and mb.cieid in (1436,3181,3182,3184,4227)
	left join MerchantDistributorWarehouseLocations md on md.merchantid = mf.merchant_id 
	left join merchantwebsitefeatures mwf on mwf.merchant_id = mf.merchant_id  and mwf.featurecode = 'shoppingCartType'
	left join merchantshipping ms on ms.dropShippingProgramID = md.DistributorID
	where mf.brand = 'Ashley'
	and m.active = 1
	and mf.active = 1
    )
    group by Merchant_ID
)

select a.id, a.merchant, a.AccountNumber, a.EcommerceSite, a.DirectExress, a.isAshley, a.city, a.statecode, a.CountryName, a.lastmodified, b.total
from Ashley_CTE a
inner join count_Ashley_Products_CTE b on b.id = a.id
order by a.lastmodified desc





--Ashley Brands
select * from companies where cie in ('Ashley','Ashley Sleep','Signature Design by Ashley','Benchcraft','Millennium')

