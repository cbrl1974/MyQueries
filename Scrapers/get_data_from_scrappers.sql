-- Get Competition from merchant
DECLARE @MerchantID as int = 1900;
select competition from merchants where id = @MerchantID


select * from retailers where webtracking = 1 and countryid = 36
select * from products where model like '%RF25HMIDBSR%'


select retailerid, sku, modelNo, RegularPrice, AdvertisedPrice, [date]
  from TailbaseServices.dbo.WebTrackingProducts
where retailerid = 26
and [date] between '2022-01-12' and '2022-01-13'
and modelNo like '%RF25HMIDBSR%'



--This checks if the total of products per merchant on a specific day. To check if the scrapper did ran
select a.retailerid as RETAILER_ID, b.cie AS RETAILER_NAME, date , count(*) as PRODUCT_COUNT
from Tailbaseservices.dbo.WebTrackingProducts a
inner join [datatail20130410].dbo.companies b
on a.RetailerID = b.Id_cie
where cast(a.date as date)  = '2022-01-12'
group by a.retailerid, b.cie,date
order by b.cie

--This checks  the state of a scraper
select * from Tailbaseservices.dbo.AsyncTasks where AssemblyClass like '%Leon%' and AssemblyMethodName = 'ScrapeProducts'

--This runs an indicidual scrapper

--BestBuyCanadaScraper
update asynctasks
set State = 1
where id = '283D76B5-C42E-4B8D-A921-39DEDC447C45'


--RonaScraper
update asynctasks
set State = 1
where id = 'E95716A6-4C72-4FB7-AA3C-3E8D8B843936'


--BraultetMartineauScraper
update asynctasks
set state= 1
where id = 'EDF195ED-B671-4AF6-8048-824306FD1E08'

--BestBuyUsScraper
update asynctasks
set state= 1
where id = '556BCCBA-7C26-4732-9DA0-82D9D80CC1C1'


--HomeDepotUsScraper
update asynctasks
set State = 1
where id = 'A84C8FD6-B708-446B-BA86-95086E76FD0B'


--MesElectrosScraper
update asynctasks
set state = 1
where id = '247349A6-1605-41E4-91D8-A58EE1A06C1F'


--CostcoCanadaScraper
update asynctasks
set State = 1
where id = 'BBF0B852-5967-4278-B302-A9D3747F7C87'


--LowesCanadaScraper
update asynctasks
set state = 1
where id = 'CFA1D4BB-9F88-4A93-A0EE-AA40A1E9B607'


--RenoDepotScraper
update asynctasks
set state = 1
where id = '9CA939FF-B5E8-42CE-A9F0-AD04BEFDE670'


--LeonsScraper
update asynctasks
set state = 1
where id = '38C5029F-EFB6-4E8E-B25D-EBDAD106470E'


--HomeDepotCanadaScraper
update asynctasks
set State = 1
where id = '7C2CB5E5-171A-4354-A1DE-F5E9E198B7B1'


--LowesUsScraper
update asynctasks
set state = 1
where id = '3FF2B78B-5CE8-465F-942B-F62AF9AB9A6D'


--TheBrickScraper
update asynctasks
set State = 1
where id = 'F2227F48-7997-446C-BF34-9DBDB069D9CE'


--CAS Morning
update asynctasks
set State = 1
where id = '90FB4928-525F-4CF5-9EA1-915CE2406478'


--Goemans
update asynctasks
set state = 1
where id = 'B9D227DC-8FFE-48BB-A983-806C4EC1D30F'


--Staples
update asynctasks
set state = 1
where id = 'F98DE0B9-7AFA-4FDC-AF18-1A00D794BD0B'


--TheBay
update asynctasks
set state = 1
where id = '6291fd82-5229-459b-bc78-f8dd9d7ebe8e'


--Visions
update asynctasks
set state = 1
where id = '18DE8062-ABCE-42AA-83A0-C03049382FCB'


--CorbeilElectroScraper
update asynctasks
set state = 1
where id = 'b06311af-3c7e-406f-aeac-6037c8fea39a'


--Tanguay
update asynctasks
set lset state = 1
where id = '4D8C9AEE-E07F-4090-936C-0E49EF8B64EB'


--The Source
update asynctasks
set lastintervalexecution = set state = 1
where id = '425D9ECB-3D1C-47DE-9B07-20C105908682'


--Amazon
update asynctasks
set lastintervalexecution = set state = 1
where id = 'E67BEB31-D352-4981-B164-C3A501748555'


--States Defintiion
    1 = queue to the tasks list (will be executed shortly)
    3 = currently executing
    5 = finished executing
    6 = finished executing successfully


select * from companies where Id_cie = 3132

select top 10 * from Tailbaseservices.dbo.WebTrackingProducts order by date desc



select * from Tailbaseservices.dbo.AsyncTasks where AssemblyClass like '%scraper%' order by LastIntervalExecution desc
select * from Tailbaseservices.dbo.ScrapersSettings
select  top 10 * from Tailbaseservices.dbo.HomeDepotCanadaBrandModels
select top 10 * from Tailbaseservices.dbo.DebugInfoScraper
select * from Tailbaseservices.dbo.WebTrackingCategories
select top 10 * from Tailbaseservices.dbo.WebTrackingProducts order by date desc
select * from Tailbaseservices.dbo.ApiClientConfigs



