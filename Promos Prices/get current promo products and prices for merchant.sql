

select  pp.* from productsprices pp
inner join merchantProds p on p.ProductID = pp.ProductID
where p.Merchant_ID = 3487
and pp.[Type] = 'Promo'
and pp.StartDate > CONVERT(DATE,GETDATE()-1) 
order by pp.StartDate desc

