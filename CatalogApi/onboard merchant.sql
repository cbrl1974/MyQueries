DECLARE @MERCHANTID  as int = 3462;

SELECT * FROM CatalogApiConfigs

insert into CatalogApiConfigs  (merchantID, ApiKey, Config) values
(@MERCHANTID, NEWID(),'{"features":true,"documents":true,"specs":true,"associatedProducts":true,"variants":true,"videos":true,"images":true}')


SELECT * FROM CatalogApiConfigs