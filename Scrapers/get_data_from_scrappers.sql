-- Get Competition from merchant
DECLARE @MerchantID as int = 1900;
select competition from merchants where id = @MerchantID


select * from retailers where webtracking = 1 and countryid = 36
select * from products where model like '%RF25HMIDBSR%'


select retailerid, sku, modelNo, RegularPrice, AdvertisedPrice
  from TailbaseServices.dbo.WebTrackingProducts
where retailerid = 26
and [date] between '2022-01-12' and '2022-01-13'
and modelNo like '%RF28T5A01SR%'



--This checks if the total of products per merchant on a specific day. To check if the scrapper did ran
select a.retailerid as RETAILER_ID, b.cie AS RETAILER_NAME, date , count(*) as PRODUCT_COUNT
from Tailbaseservices.dbo.WebTrackingProducts a
inner join [datatail20130410].dbo.companies b
on a.RetailerID = b.Id_cie
where cast(a.date as date)  = '2022-01-12'
group by a.retailerid, b.cie,date
order by b.cie

--This checks  the state of a scraper
select * from Tailbaseservices.dbo.AsyncTasks where AssemblyClass like '%Visions%' and AssemblyMethodName = 'ScrapeProducts'

--This runs an indicidual scrapper
update top (1) Tailbaseservices.dbo.AsyncTasks 
set State = 1
where id = '18DE8062-ABCE-42AA-83A0-C03049382FCB'


--the brick
--home depot canada
--leon
--Best Buy CA
--Canadian Appliance Source (Run any of them)
--Les Spécialistes de l'électroménager (MesElectrosScraper)
--Reno Depot
--Rona
--Visions
--Best Buy USA


select * from companies where Id_cie = 3132

select top 10 * from Tailbaseservices.dbo.WebTrackingProducts order by date desc



select * from Tailbaseservices.dbo.AsyncTasks where AssemblyClass like '%scraper%' order by LastIntervalExecution desc
select * from Tailbaseservices.dbo.ScrapersSettings
select  top 10 * from Tailbaseservices.dbo.HomeDepotCanadaBrandModels
select top 10 * from Tailbaseservices.dbo.DebugInfoScraper
select * from Tailbaseservices.dbo.WebTrackingCategories
select top 10 * from Tailbaseservices.dbo.WebTrackingProducts order by date desc
select * from Tailbaseservices.dbo.ApiClientConfigs



