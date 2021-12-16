-- Get Competition from merchant
DECLARE @MerchantID as int = 1900;
select competition from merchants where id = @MerchantID


select * from retailers where webtracking = 1 and countryid = 36


DECLARE @ProductID as int = 558502;
DECLARE @MerchantID as int = 1900;
select price, reducedPrice from merchantprods where merchant_id = @MerchantID and productid = @ProductID
select top 100 * from webtracking 
where retailerID in (2753,2755,2756)
and productid =  @ProductID
and TrackingDate between '2021-12-15' and '2021-12-16'



select a.retailerid as RETAILER_ID, b.cie AS RETAILER_NAME, date , count(*) as PRODUCT_COUNT
from Tailbaseservices.dbo.WebTrackingProducts a
inner join [datatail20130410].dbo.companies b
on a.RetailerID = b.Id_cie
where cast(a.date as date)  >= '2021-12-16'
group by a.retailerid, b.cie,date
order by b.cie


select * from companies where Id_cie = 3132

select top 10 * from Tailbaseservices.dbo.WebTrackingProducts order by date desc



select * from Tailbaseservices.dbo.AsyncTasks where AssemblyClass like '%scraper%' order by LastIntervalExecution desc
select * from Tailbaseservices.dbo.ScrapersSettings
select  top 10 * from Tailbaseservices.dbo.HomeDepotCanadaBrandModels
select top 10 * from Tailbaseservices.dbo.DebugInfoScraper
select * from Tailbaseservices.dbo.WebTrackingCategories
select top 10 * from Tailbaseservices.dbo.WebTrackingProducts order by date desc
select * from Tailbaseservices.dbo.ApiClientConfigs



