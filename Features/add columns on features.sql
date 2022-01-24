ALTER TABLE features  ADD creator varchar(50)
ALTER TABLE features  ADD creationdate DATETIME NULL 
ALTER TABLE features  ADD modifier varchar(50)
ALTER TABLE features  ADD modifierDate DATETIME NULL 
ALTER TABLE features  ADD  validated BIT DEFAULT 0

