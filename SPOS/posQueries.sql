--When onboarding you need to add the new merchant here 
select * from datatail20130410.dbo.merchants where id = 3054
select * from datatail20130410.dbo.MerchantPosConfigs

--CheckLogs
select  * from datatail20130410.dbo.MerchantPosLogs 
where time > convert(date,getdate()-1)
order by time desc

