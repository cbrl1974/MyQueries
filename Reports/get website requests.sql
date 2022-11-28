	SELECT			wr.ID as ID,  wr.first_name as fname, wr.last_name as lname, wr.province as zipcode
				  , wr.phone as phone, wr.email as email, wr.comments as comments, wr.submitdate as sdate, mu.f_name as salesrep1, mu.l_name as salesrep2
				  , wrf.status as status,  wrf.emailreminderdate as reminder, wrf.note as note, wrf.salseamount as salesamount, ms.store as store
				  , dep.dept as depart, ca.category as cat, p.model as model, c.collection_1 as collection
		FROM		websiteRequests wr
		LEFT JOIN	WebsiteRequestFollowups wrf on wr.ID = wrf.websiterequestID
		LEFT JOIN 	MerchantUsers mu on wrf.merchantuserID = mu.ID
		LEFT JOIN	MerchantStores ms on wr.storeID = ms.ID
		LEFT JOIN	WebsiteRequestProducts wrp on wr.ID = wrp.websiterequestID
		LEFT JOIN	Departments dep on wrp.deptID = dep.ID_dept and dep.id_langue = 1
		LEFT JOIN	Categories ca on wrp.catID = ca.id_category and ca.id_langue = 1
		LEFT JOIN	Products p on wrp.productID = p.id_product
		LEFT JOIN	Collections c on wrp.collectionID = c.id
		WHERE		wr.Merchant_ID = 1727
		--AND 		wr.submitdate > '#yesterday#'
		Order by sdate desc