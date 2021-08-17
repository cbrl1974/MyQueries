DECLARE @BrandsList AS TABLE (
	Sort INT IDENTITY(1,1),
	Cie VARCHAR(100)
)

INSERT INTO @BrandsList(Cie) VALUES
('Whirlpool'),
('KitchenAid'),
('Maytag'),
('Amana'),
('Speed Queen'),
('Danby'),
('Broan'),
('Nutone'),
('Cyclone'),
('Sakura USA Co.')

SELECT COALESCE(C.Id_Cie,C2.Id_Cie), L.Cie, COALESCE(C.Cie,C2.Cie)
FROM @BrandsList L
LEFT JOIN Temp_BSBrandNames N ON N.RawBrandName = L.Cie
LEFT JOIN Companies C ON C.Cie = N.TailbaseBrandName AND C.typeID = 1
LEFT JOIN Companies C2 ON C2.Cie = L.Cie AND C2.typeID = 1
--WHERE COALESCE(C.Id_Cie,C2.Id_Cie) IS NULL
ORDER BY L.Sort

 SELECT * FROM Companies WHERE Cie LIKE '%Sakura%%'

-- SELECT * FROM Temp_BSBrandNames WHERE RawBrandName LIKE '%ya%'



