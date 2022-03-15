  Declare @IPToDelete as varchar(50) = '100.35.75.170';
  
  select * from firewall.dbo.black where ipaddress = @IPToDelete
  select * from  firewall.dbo.white where ipaddress = @IPToDelete

  delete top (1) from firewall.dbo.black where ipaddress = @IPToDelete