-- Get Competition from merchant
DECLARE @MerchantID as int = 675;
select competition from merchants where id = @MerchantID

select * from companies where id_cie in (19,156,25,155,27,28,994,21,225,160,31,47,307)
select id, merchant, competition from merchants where competition is not null and active = 1
 
-- update top (1) merchants
-- set competition = '19,156,27,21,225,160,31'
--  where id = 675

select * from retailers where webtracking = 1 and countryid = 36
select * from products where model like '%RF25HMIDBSR%'

SELECT TOP (100) [LogID]
      ,[Project]
      ,[Category]
      ,[Text]
      ,[Time]
      ,[Severity]
      ,[Module]
      ,[Location]
  FROM [EventReactor].[dbo].[Logs]
  where Category = 'scrapers'
  order by [Time] desc

  select distinct category  FROM [EventReactor].[dbo].[Logs]



select retailerid, sku, modelNo, RegularPrice, AdvertisedPrice, [date]
  from TailbaseServices.dbo.WebTrackingProducts
where retailerid = 26
and [date] between '2022-01-12' and '2022-01-17'
and modelNo like '%RF25HMIDBSR%'



--This checks if the total of products per merchant on a specific day. To check if the scrapper did ran

exec dbo.ScraperDataReport

--OR
select a.retailerid as RETAILER_ID, b.cie AS RETAILER_NAME, date , count(*) as PRODUCT_COUNT
from Tailbaseservices.dbo.WebTrackingProducts a
inner join [datatail20130410].dbo.companies b
on a.RetailerID = b.Id_cie
where cast(a.date as date)  = '2022-04-30'
group by a.retailerid, b.cie,date
order by b.cie

--Check the state of a scraper
select assemblyclass, [state], LastIntervalExecution, [Interval] from Tailbaseservices.dbo.AsyncTasks where AssemblyClass like '%scraper%'
 order by  [state] , LastIntervalExecution desc

--This checks  the state of a scraper
select * from Tailbaseservices.dbo.AsyncTasks where AssemblyClass like '%bestbuy%' and AssemblyMethodName = 'ScrapeProducts'

----- *****************This runs an indicidual scrapper********************

--BestBuyCanadaScraper
update top (1) Tailbaseservices.dbo.asynctasks
set State = 1
where id = '283d76b5-c42e-4b8d-a921-39dedc447c45'

--LeonsScraper
update top (1) Tailbaseservices.dbo.asynctasks
set state = 1
where id = '38C5029F-EFB6-4E8E-B25D-EBDAD106470E'


--HomeDepotCanadaScraper
update top (1) Tailbaseservices.dbo.asynctasks
set State = 1
where id = '7C2CB5E5-171A-4354-A1DE-F5E9E198B7B1'


--LowesCanadaScraper
update top (1) Tailbaseservices.dbo.asynctasks
set state = 1
where id = 'cfa1d4bb-9f88-4a93-a0ee-aa40a1e9b607'


--RonaScraper
update top (1) Tailbaseservices.dbo.asynctasks
set State = 1
where id = 'E95716A6-4C72-4FB7-AA3C-3E8D8B843936'

********************************HERE

--BraultetMartineauScraper
update top (1) Tailbaseservices.dbo.asynctasks
set state= 1
where id = 'EDF195ED-B671-4AF6-8048-824306FD1E08'


--Visions
update top (1) Tailbaseservices.dbo.asynctasks
set state = 1
where id = '18DE8062-ABCE-42AA-83A0-C03049382FCB'


--MesElectrosScraper
update top (1) Tailbaseservices.dbo.asynctasks
set state = 1
where id = '247349A6-1605-41E4-91D8-A58EE1A06C1F'


--CostcoCanadaScraper
update top (1) Tailbaseservices.dbo.asynctasks
set State = 1
where id = 'BBF0B852-5967-4278-B302-A9D3747F7C87'


--RenoDepotScraper
update top (1) Tailbaseservices.dbo.asynctasks
set state = 1
where id = '9CA939FF-B5E8-42CE-A9F0-AD04BEFDE670'



--TheBrickScraper
update top (1) Tailbaseservices.dbo.asynctasks
set State = 1
where id = 'F2227F48-7997-446C-BF34-9DBDB069D9CE'


--CAS Morning
update top (1) Tailbaseservices.dbo.asynctasks
set State = 1
where id = '90FB4928-525F-4CF5-9EA1-915CE2406478'


--Goemans
update top (1) Tailbaseservices.dbo.asynctasks
set state = 1
where id = 'B9D227DC-8FFE-48BB-A983-806C4EC1D30F'


--CorbeilElectroScraper
update top (1) Tailbaseservices.dbo.asynctasks
set state = 1
where id = 'b06311af-3c7e-406f-aeac-6037c8fea39a'



--Tanguay
update top (1) Tailbaseservices.dbo.asynctasks
set  state = 1
where id = '4D8C9AEE-E07F-4090-936C-0E49EF8B64EB'




--BestBuyUsScraper
update top (1) Tailbaseservices.dbo.asynctasks
set state= 1
where id = '556bccba-7c26-4732-9da0-82d9d80cc1c1'


--HomeDepotUsScraper
update top (1) Tailbaseservices.dbo.asynctasks
set State = 1
where id = 'a84c8fd6-b708-446b-ba86-95086e76fd0b'


--LowesUsScraper
update top (1) Tailbaseservices.dbo.asynctasks
set state = 1
where id = '3ff2b78b-5ce8-465f-942b-f62af9ab9a6d'






--States Defintiion
    1 = queue to the tasks list (will be executed shortly)
    3 = currently executing
    5 = finished executing
    6 = finished executing successfully




select top 10 * from Tailbaseservices.dbo.WebTrackingProducts order by date desc











select * from Tailbaseservices.dbo.ScrapersSettings
select  top 10 * from Tailbaseservices.dbo.HomeDepotCanadaBrandModels
select top 10 * from Tailbaseservices.dbo.DebugInfoScraper
select * from Tailbaseservices.dbo.WebTrackingCategories
select top 10 * from Tailbaseservices.dbo.WebTrackingProducts order by date desc
select * from Tailbaseservices.dbo.ApiClientConfigs



