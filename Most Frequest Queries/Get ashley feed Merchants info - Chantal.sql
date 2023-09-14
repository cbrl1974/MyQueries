select m.id, m.merchant, SUBSTRING(mf.remoteFTPUser, 4, 6) as AccountNumber, m.merchant_url,
    (
    CASE WHEN mwf.featurecode = 'shoppingCartType' THEN 'yes' else 'no' end
) as EcommerceSite,
    (
    CASE WHEN ms.dropShippingProgramID = 1 THEN 'yes' else 'no' end
) as DirectExress,
    (
    CASE WHEN count(p.manufid) = 5 THEN 'Ashley Only' else 'Multi MFG' end
) as isAshley,
(
    CASE WHEN mc.RTOConsole = 1 THEN 'yes' else 'no' end
) as isRTO,
    md.city,
    md.statecode,
    md.CountryName,
    replace(REPLACE(mf.lastModified,'{ts ''', ''), '''}','') as lastmodified,
    count(distinct mp.productid)
from merchantfeeds mf
    inner join merchants m on m.id = mf.merchant_id and mf.brand = 'Ashley'
    inner join merchantProds mp on mp.Merchant_ID = m.id
    inner join products p on p.Id_product = mp.ProductID
    left join MerchantDistributorWarehouseLocations md on md.merchantid = mf.merchant_id 
    left join merchantwebsitefeatures mwf on mwf.merchant_id = mf.merchant_id
    and mwf.featurecode = 'shoppingCartType'
    inner join merchantCms mc on mc.Merchant_id = m.id
    left join merchantshipping ms on ms.dropShippingProgramID = md.DistributorID 
	and ms.dropShippingProgramID = 1 and ms.merchant_id = md.MerchantID  ---added direct express
where mf.brand = 'Ashley'
    and m.active = 1
    and mf.active = 1
    and p.manufID in (1436,3181,3182,3184,4227)
group by m.id, m.merchant,mf.remoteFTPUser,m.merchant_url,mwf.featurecode,ms.dropShippingProgramID,md.city, md.statecode, md.CountryName,mc.RTOConsole, lastmodified
order by m.id

select * from merchantfeeds where merchant_id = 3074