select distinct m.merchant, SUBSTRING(mf.remoteFTPUser, 4, 6) as AccountNumber,m.merchant_url,
	(
		CASE WHEN mwf.featurecode = 'shoppingCartType' THEN 'yes' else 'no' end
	) as EcommerceSite,
	(
		CASE WHEN ms.dropShippingProgramID = 1 THEN 'yes' else 'no' end
	) as DirectExress,
	(
		CASE WHEN count(mb.cieid) = 5 THEN 'Ashley Only' else 'Multi MFG' end
	) as isAshley,
	md.city, 
	md.statecode, 
	md.CountryName, 
	--CONVERT(varchar, mf.lastModified, 131) as lastmodified
	replace(REPLACE(mf.lastModified,'{ts ''', ''), '''}','') as lastmodified,
	count(mp.productid) as placements
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
and ms.dropShippingProgramID = 1  ---added direct express
group by m.merchant,mf.remoteFTPUser,m.merchant_url,mwf.featurecode,ms.dropShippingProgramID,mb.cieid,md.city, md.statecode, md.CountryName,lastmodified, placements
order by lastmodified desc


select * from merchantwebsitefeatures 
where featurecode = 'defaultSort'
and featurevalue like '%1436%'

select top 1 * from merchantprods where merchant_id = 1097



