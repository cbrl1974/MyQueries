select  distinct ipaddress, url_string, [status] from firewall.dbo.historical
where url_string like '%haneysappliances.ca%'
and status  = 'grey'
and timestamp > '2024-11-17'

-- Delete ip addresses on teh geey list
delete from firewall.dbo.grey where ipaddress in (select  distinct ipaddress from firewall.dbo.historical
where url_string like '%haneysappliances.ca%'
and status  = 'grey'
and timestamp > '2024-11-17')


-- Delete ip addresses on teh geey list
delete from firewall.dbo.grey where ipaddress in (select  distinct ipaddress from firewall.dbo.historical
where url_string like '%haneysappliances.ca%'
and status  = 'black'
and timestamp > '2024-11-17')