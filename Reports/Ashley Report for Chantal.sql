select m.id, m.merchant, SUBSTRING(mf.remoteFTPUser, 4, 6) as AccountNumber,
    m.merchant_url,
    (
    CASE WHEN mwf.featurecode = 'shoppingCartType' THEN 'yes' else 'no' end
) as EcommerceSite,
    (
    CASE WHEN ms.dropShippingProgramID = 1 THEN 'yes' else 'no' end
) as DirectExress,
    (
    CASE 
    WHEN COUNT(CASE WHEN mb.cieId IN (1436, 4227, 3184, 3182, 4226, 3181) THEN 1 ELSE NULL END) = 6 
    THEN 'Ashley Only' 
    ELSE 'Multi MFG' 
    end
) as isAshley,
    (
    CASE WHEN mc.RTOConsole = 1 THEN 'yes' else 'no' end
) as isRTO,
    md.city,
    md.statecode,
    md.CountryName,
    replace(REPLACE(mf.lastModified,'{ts ''', ''), '''}','') as lastmodified,
    count(distinct mp.productid) as AshleyProdsOnWebsite,
     (
        CASE WHEN mf.active = 1 THEN 'yes' else 'no' end
    ) as IsAshleyFeedActiveInTheConsole
from merchantfeeds mf
    inner join merchants m on m.id = mf.merchant_id and mf.brand = 'Ashley'
    inner join merchantProds mp on mp.Merchant_ID = m.id
    inner join products p on p.Id_product = mp.ProductID
    left join merchantBrands mb on mb.merchant_id = m.id and mb.cieId = p.manufID
    left join MerchantDistributorWarehouseLocations md on md.merchantid = m.id
    left join merchantwebsitefeatures mwf on mwf.merchant_id = m.id and mwf.featurecode = 'shoppingCartType'
    inner join merchantCms mc on mc.Merchant_id = m.id
    left join merchantshipping ms on ms.merchant_id = md.MerchantID and ms.dropShippingProgramID = 1
where mf.brand = 'Ashley'
    and m.active = 1
    --and mf.active = 1
    and p.manufID in (1486,6183, 3181, 3182, 3184, 4226, 4227)
group by m.id, m.merchant,mf.remoteFTPUser,m.merchant_url,mwf.featurecode,ms.dropShippingProgramID,md.city, md.statecode, md.CountryName,mc.RTOConsole, lastmodified, mf.active
order by m.id

