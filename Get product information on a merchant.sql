select p.model, co.cie, c.category, sc.subcategory, sc.Id_subCategory, mp.price, mp.reducedPriceEndDate, mp.realprice from products p 
join merchantProds mp on mp.productid = p.id_product 
join companies co on co. id_cie = p.manufid 
join categories c on c.id_langue = 1 and c.Id_category = p.catid 
join SubCategories sc on sc.id_langue = 1 and sc.catID = p.catid
where merchant_id = 938
and p.catid = 41
and sc.Id_subCategory =527


