
			SELECT DISTINCT p.manufid as brandid,co.cie as brand, m.id,m.merchant, 
			max(pp.startdate) as startdate,  map.enabled, m.countryCode
			FROM ProductsPrices pp
			INNER JOIN		Products p ON p.Id_product = pp.ProductID AND pp.Type not in ( 'PROMO', 'hpromo') -- or in
			INNER JOIN 		Companies co ON co.id_cie = p.manufid
			INNER JOIN		merchants m ON m.countryCode = pp.Country
			INNER JOIN 		MerchantCats mc ON mc.merchant_id = m.id AND mc.catid = p.catid 
			INNER JOIN		MerchantBrands b ON b.merchant_id = m.id AND b.cieid = p.manufid
			INNER JOIN		MerchantProdAutoPush map on map.merchantID = m.id and map.brandID = b.cieid  and map.pushType = 'normal' --'promo'
			--WHERE m.id = 3442
			where m.active = 1 
			and m.countryCode = 'US'
			and  m.merchant not like '%demo%'
			and  m.merchant not like '%dynamic%'
			and  m.merchant not like '%old%'
			and  m.merchant not like '%staging%'
			AND p.active = 1
			AND p.specs = '1'
			AND	p.model NOT LIKE '% bdl%'
			AND	p.model NOT LIKE '%refurbished%'
			AND pp.StartDate < GETDATE()			
			group by m.id,m.merchant, p.manufid ,co.cie,  map.enabled, m.countryCode
			ORDER BY m.merchant


			
