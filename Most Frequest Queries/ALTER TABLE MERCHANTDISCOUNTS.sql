use datatail20130410

-- QUERY 1 ************* DeliveryOnly*****************


select DeliveryOnly from merchantdiscounts  where DeliveryOnly is null
update  merchantdiscounts set DeliveryOnly = 0 where DeliveryOnly is null

ALTER TABLE merchantdiscounts ALTER COLUMN DeliveryOnly bit  NOT NULL;

ALTER TABLE merchantdiscounts
ADD CONSTRAINT DeliveryOnly
DEFAULT 0 FOR DeliveryOnly;


--QUERY 2 ************* StorePickupOnly*****************
select StorePickupOnly from merchantdiscounts  where StorePickupOnly is null

update  merchantdiscounts set StorePickupOnly = 0 where StorePickupOnly is null

ALTER TABLE merchantdiscounts ALTER COLUMN StorePickupOnly bit  NOT NULL;

ALTER TABLE merchantdiscounts
ADD CONSTRAINT StorePickupOnly
DEFAULT 0 FOR StorePickupOnly;





