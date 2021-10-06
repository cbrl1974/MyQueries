DECLARE @MerchantIdforProdsWithPrices AS INT = 3272;

DECLARE @PRODUCTID AS INT = (select top 1 productid from merchantprods where merchant_id = @MerchantIdforProdsWithPrices
and price is not null and  price != 0.00)
DECLARE @POSTALCODE AS VARCHAR(5) = (select top (1) RTRIM(LTRIM(postalcode)) from merchantstores where merchantid = @MerchantIdforProdsWithPrices )
DECLARE @WARRANTY AS INT =  (select COUNT(ID) from merchantwarranties where merchantid = @MerchantIdforProdsWithPrices)
DECLARE @CARTOPTION AS INT = (select COUNT(ID) from merchantCartOptions where merchantid = @MerchantIdforProdsWithPrices)
DECLARE @INSTALLATION AS INT = (select COUNT(ID) from Merchantinstallations where merchantid = @MerchantIdforProdsWithPrices)
DECLARE @DISCOUNTS AS INT = (select COUNT(Code_disc) from merchantDiscounts where merchant_id = @MerchantIdforProdsWithPrices)

DECLARE @SHIPPINGINFOS TABLE
(MERCHANTID INT NOT NULL,
 PRODUCTID INT NULL, 
 POSTALCODE VARCHAR(50), 
 WARRANTY INT NULL,
 CARTOPTION INT NULL,
 INSTALLATION INT NULL,
 DISCOUNTS INT NULL
)

INSERT INTO @SHIPPINGINFOS (MERCHANTID,PRODUCTID,POSTALCODE,WARRANTY,CARTOPTION,INSTALLATION,DISCOUNTS) 
VALUES(@MerchantIdforProdsWithPrices,@PRODUCTID,@POSTALCODE,@WARRANTY,@CARTOPTION,@INSTALLATION,@DISCOUNTS)

SELECT * FROM @SHIPPINGINFOS


-- update top (1) merchantprods
-- set price = NULL
-- where merchant_id = @MerchantIdforProdsWithPrices
-- and productid  = 129672





