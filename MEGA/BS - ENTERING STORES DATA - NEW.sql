DECLARE @TargetId AS INT = 1210
DECLARE @Store       AS VARCHAR(100) = 'Airdrie Appliance and Furniture'
DECLARE @Address     AS VARCHAR(100) = '302-505 Main Street SW'
DECLARE @City        AS VARCHAR(100) = 'Airdrie'
DECLARE @Province    AS VARCHAR(100) = 'AB'
DECLARE @PostalCode  AS VARCHAR(100) = 'T4B 3K3'
DECLARE @Country     AS VARCHAR(100) = 'Canada'
DECLARE @Phone       AS VARCHAR(100) = '(403) 948-9345'
DECLARE @Email       AS VARCHAR(100) = 'info@airdrieappliance.ca'
DECLARE @Latitude    AS VARCHAR(100) = '51.288636'
DECLARE @Longitude   AS VARCHAR(100) = '-114.01453'

DECLARE @MonOpen  AS VARCHAR(20) = '9:30'
DECLARE @MonClose AS VARCHAR(20) = '7:00'
DECLARE @TueOpen  AS VARCHAR(20) = '9:30'
DECLARE @TueClose AS VARCHAR(20) = '7:00'
DECLARE @WedOpen  AS VARCHAR(20) = '9:30'
DECLARE @WedClose AS VARCHAR(20) = '7:00'
DECLARE @ThuOpen  AS VARCHAR(20) = '9:30'
DECLARE @ThuClose AS VARCHAR(20) = '7:00'
DECLARE @FriOpen  AS VARCHAR(20) = '9:30'
DECLARE @FriClose AS VARCHAR(20) = '7:00'
DECLARE @SatOpen  AS VARCHAR(20) = '9:30'
DECLARE @SatClose AS VARCHAR(20) = '5:00'
DECLARE @SunOpen  AS VARCHAR(20) = '11:30'
DECLARE @SunClose AS VARCHAR(20) = '5:00'

INSERT INTO MerchantStores(MerchantID,store,address,city,province,postalCode,country,phone,email,GeoPosition,detailsinternal)
SELECT @TargetId, @Store, @Address, @City, @Province, @PostalCode, @Country, @Phone, @Email, @Latitude + ',' + @Longitude  
-- mo_1:00,AM-1:00,PM;tu_1:00,AM-1:00,PM;we_1:00,AM-1:00,PM;th_1:00,AM-1:00,PM;fr_1:00,AM-1:00,PM;sa_1:00,AM-1:00,PM;su_Closed
, CASE WHEN @MonOpen = '0:00' AND @MonClose = '0:00' AND @TueOpen = '0:00' AND @TueClose = '0:00' 
	THEN
		'mo_1:00,AM-1:00,PM;tu_1:00,AM-1:00,PM;we_1:00,AM-1:00,PM;th_1:00,AM-1:00,PM;fr_1:00,AM-1:00,PM;sa_1:00,AM-1:00,PM;su_Closed'
	ELSE
		'mo_' + ( CASE WHEN @MonOpen = 'Closed' OR @MonClose = 'Closed' THEN 'Closed' ELSE (@MonOpen + ',' + 'AM' + '-' + @MonClose + ',' + 'PM') END ) + ';' 
		+ 'tu_' + ( CASE WHEN @TueOpen = 'Closed' OR @TueClose = 'Closed' THEN 'Closed' ELSE (@TueOpen + ',' + 'AM' + '-' + @TueClose + ',' + 'PM') END ) + ';' 
		+ 'we_' + ( CASE WHEN @WedOpen = 'Closed' OR @WedClose = 'Closed' THEN 'Closed' ELSE (@WedOpen + ',' + 'AM' + '-' + @WedClose + ',' + 'PM') END ) + ';' 
		+ 'th_' + ( CASE WHEN @ThuOpen = 'Closed' OR @ThuClose = 'Closed' THEN 'Closed' ELSE (@ThuOpen + ',' + 'AM' + '-' + @ThuClose + ',' + 'PM') END ) + ';' 
		+ 'fr_' + ( CASE WHEN @FriOpen = 'Closed' OR @FriClose = 'Closed' THEN 'Closed' ELSE (@FriOpen + ',' + 'AM' + '-' + @FriClose + ',' + 'PM') END ) + ';' 
		+ 'sa_' + ( CASE WHEN @SatOpen = 'Closed' OR @SatClose = 'Closed' THEN 'Closed' ELSE (@SatOpen + ',' + 'AM' + '-' + @SatClose + ',' + 'PM') END ) + ';' 
		+ 'su_' + ( CASE WHEN @SunOpen = 'Closed' OR @SunClose = 'Closed' THEN 'Closed' ELSE (@SunOpen + ',' + 'AM' + '-' + @SunClose + ',' + 'PM') END ) + '' 
END

select * from merchantstores where merchantid = 1210
