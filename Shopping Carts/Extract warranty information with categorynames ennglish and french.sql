select categoryName_en.category, categoryName_fr.category, mw.description_1, mw.description_2, mwp.code, mwp.lowPrice, mwp.highPrice, mwp.cost 
from merchantwarranties mw 
inner join MerchantWarrantyPrices mwp on mwp.MerchantWarrantyID = mw.id
inner join merchantwarrantyfilters mwf on mwf.MerchantWarrantyID = mw.id
inner join categories as categoryName_en on categoryName_en.id_category = mwf.catID and categoryName_en.Id_langue = 1
inner join categories as categoryName_fr on categoryName_fr.id_category = mwf.catID and categoryName_fr.Id_langue = 2
where mw.merchantid = 1175
group by categoryName_en.category, categoryName_fr.category, mw.description_1, mw.description_2, mwp.code, mwp.lowPrice, mwp.highPrice, mwp.cost 
order by categoryName_en.category, categoryName_fr.category, mw.description_1, mw.description_2, mwp.code, mwp.lowPrice, mwp.highPrice, mwp.cost 
