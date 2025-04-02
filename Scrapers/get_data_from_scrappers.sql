use datatail20130410

-- ***********This checks if the total of products per merchant on a specific day. To check if the scrapper did ran*************
exec datatail20130410.dbo.ScraperDataReport

--Check the state of a scraper
select assemblyclass, [state], LastIntervalExecution, [Interval], AssemblyMethodName from Tailbaseservices.dbo.AsyncTasks WITH (NOLOCK)  
where AssemblyMethodName like 'Scrape%'
and AssemblyMethodName = 'ScrapeProducts'
 order by  [state] ,LastIntervalExecution desc 



-- Get Competition from merchant
DECLARE @MerchantID as int = 675;
select competition from datatail20130410.dbo.merchants where id = @MerchantID

select * from datatail20130410.dbo.companies where id_cie in (19,21,23,156,25,155,27,28,994,21,225,160,31,47,307,1100,2756)
select id, merchant, competition from datatail20130410.dbo.merchants where competition is not null and active = 1
select * from datatail20130410.dbo.companies where cie like '%lowe%'
 
-- update top (1) merchants
-- set competition = '19,156,27,21,225,160,31'
--  where id = 675

select * from datatail20130410.dbo.retailers where webtracking = 1 and countryid = 36
select * from datatail20130410.dbo.products where model like '%RF25HMIDBSR%'

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
 --and module = 'TheBrickScraper'
  order by [Time] desc


select  *  from TailbaseServices.dbo.WebTrackingCategories WITH (NOLOCK)         
where RetailerID = 21
--and Department = ''
--and url like '%furniture%'
-- and not  url like '%gaming%'
and parse =1
--and url like '%appliances%'
order by DateModified, Parse desc



select top 150  * from TailbaseServices.dbo.WebTrackingProducts  WITH (NOLOCK)         
where RetailerID = 21
--and TailbaseId = 756879
and date > convert(date,getdate()-1)
 order by date desc 




--This checks  the state of a scraper
select * from Tailbaseservices.dbo.AsyncTasks where AssemblyClass like '%homedepot%' and AssemblyMethodName like 'Scrape%'


----- *****************This runs an individual scrapper********************

--********TheBrickScraper
--Products
update top (1) Tailbaseservices.dbo.asynctasks
set State = 1
where id = 'F2227F48-7997-446C-BF34-9DBDB069D9CE'

--Categories
update top (1) Tailbaseservices.dbo.asynctasks
set State = 1
where id = 'F2227F48-7997-446C-BF34-9DBDB069D9CE'



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






select * from Tailbaseservices.dbo.ScrapersSettings where retailerid = 21
select  top 10 * from Tailbaseservices.dbo.HomeDepotCanadaBrandModels
select  top 500 * from Tailbaseservices.dbo.ScrapersModelsMappings where retailerid = 21 order by CreatedOn desc
select top 100 * from Tailbaseservices.dbo.DebugInfoScraper
select top 100 * from Tailbaseservices.dbo.ScrapersSkuInfos
select * from Tailbaseservices.dbo.WebTrackingCategories where retailerid = 1100
select top 10 * from Tailbaseservices.dbo.WebTrackingProducts where retailerid = 1100  order by date desc
select * from Tailbaseservices.dbo.ApiClientConfigs



