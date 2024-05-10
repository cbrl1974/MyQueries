USE [datatail20130410]
GO

/****** Object:  StoredProcedure [dbo].[ScraperDataReport]    Script Date: 5/10/2024 9:45:42 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[ScraperDataReport]
	@DaysLookup int=30
as 
begin
declare @Columns nvarchar(max)=
(select '['+dbo.group_concat_d(distinct r.retailer,'],[')+']' from [TailbaseServices].[dbo].[WebTrackingProducts] wp
  inner join datatail20130410.dbo.Retailers r on wp.RetailerID=r.Id_retailer
where date>getdate()-@DaysLookup);

declare @DynamicPivot nvarchar(max)=N'
select * from (
SELECT  CONVERT(date,[date]) ''ScrapeDate'',r.retailer,count(*) ''scrapedCount''
  FROM [TailbaseServices].[dbo].[WebTrackingProducts] wp
  inner join datatail20130410.dbo.Retailers r on wp.RetailerID=r.Id_retailer
  where wp.[date]>getdate()-@DaysLookup
  group by r.retailer,wp.[date]) x
  pivot (max(scrapedCount) for retailer in ('+@columns+')) piv1
  order by ScrapeDate desc'
-- execute the dynamic SQL
EXECUTE sp_executesql @DynamicPivot,N'@DaysLookup int',@DaysLookup;
end
GO


select 