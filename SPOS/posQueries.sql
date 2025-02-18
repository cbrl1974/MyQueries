--When onboarding you need to add the new merchant here 

select * from datatail20130410.dbo.MerchantPosConfigs

--CheckLogs
select top 250 * from datatail20130410.dbo.MerchantPosLogs 
order by time desc