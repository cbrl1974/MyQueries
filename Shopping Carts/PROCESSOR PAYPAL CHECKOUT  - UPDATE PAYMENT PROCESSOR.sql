DECLARE @merchantId INT = 1941;

DECLARE @textcodeProd NVARCHAR(255) = 'paymentPPCDetail';
DECLARE @ClientIDProd NVARCHAR(MAX) = 'AY3tJKh2uG87YQMp8AVqO17_ecH3tXTqD6NZtKTgS13qcbelTS98yCbufXzgXEoMnHIBySuUH0LaZY2U';
DECLARE @ClientSecretProd NVARCHAR(MAX) = 'EF94w9nrKqFQ3yB2V-U4spdly7id85HIYjahWU8ik5Gnn6gYYR3gppO6KF92gYmvvmtBghrYKBdl3_Pl';

DECLARE @textcodeDev NVARCHAR(255) = 'paymentPPCDetailTest';
DECLARE @ClientIDDev NVARCHAR(MAX) = 'Adbf1a1nQZyTAnw355137krkxVp2HZol-pxIm2ecwq9yWxee0lXMknwljp6ZnaNjdRVTuiC9bBn2mMYF';
DECLARE @ClientSecretDev NVARCHAR(MAX) = 'EMSshb0F6cnUR0OXm5gRnns3g43RHZwBHwH8heFxUIZe7-chDzL7P6_HAmO8wVY_QQzgfGkVwDJNMSXD';


DECLARE @Id_langue INT = 1;
DECLARE @PaymentProcessor NVARCHAR(255) = 'onlyppc';

DECLARE @contentProd NVARCHAR(MAX) =
    N'PayPalCheckout|AUTH_URL~https://api.paypal.com/v1/oauth2/token|CLIENT_ID~' + @ClientIDProd +
    N'|CLIENT_SECRET~' + @ClientSecretProd +
    N'|ORDERS_URL~https://api.paypal.com/v2/checkout/orders';

DECLARE @contentDev NVARCHAR(MAX) =
    N'PayPalCheckout|AUTH_URL~https://api.sandbox.paypal.com/v1/oauth2/token|CLIENT_ID~' + @ClientIDDev +
    N'|CLIENT_SECRET~' + @ClientSecretDev +
    N'|ORDERS_URL~https://api.sandbox.paypal.com/v2/checkout/orders';

-- Upsert PROD text
IF EXISTS (
    SELECT 1
FROM MerchantWebsiteTexts
WHERE merchant_id = @merchantId
    AND textcode = @textcodeProd
    AND Id_langue = @Id_langue
)
BEGIN
    UPDATE MerchantWebsiteTexts
    SET content_1 = @contentProd
    WHERE merchant_id = @merchantId
        AND textcode = @textcodeProd
        AND Id_langue = @Id_langue;
END
ELSE
BEGIN
    INSERT INTO MerchantWebsiteTexts
        (merchant_id, textcode, content_1, Id_langue)
    VALUES
        (@merchantId, @textcodeProd, @contentProd, @Id_langue);
END

-- Upsert DEV text
IF EXISTS (
    SELECT 1
FROM MerchantWebsiteTexts
WHERE merchant_id = @merchantId
    AND textcode = @textcodeDev
    AND Id_langue = @Id_langue
)
BEGIN
    UPDATE MerchantWebsiteTexts
    SET content_1 = @contentDev
    WHERE merchant_id = @merchantId
        AND textcode = @textcodeDev
        AND Id_langue = @Id_langue;
END
ELSE
BEGIN
    INSERT INTO MerchantWebsiteTexts
        (merchant_id, textcode, content_1, Id_langue)
    VALUES
        (@merchantId, @textcodeDev, @contentDev, @Id_langue);
END

-- Upsert feature
IF EXISTS (
    SELECT 1
FROM merchantWebsiteFeatures
WHERE merchant_id = @merchantId
    AND featureCode = 'shoppingCartType'
)
BEGIN
    UPDATE merchantWebsiteFeatures
    SET featureValue = @PaymentProcessor
    WHERE merchant_id = @merchantId
        AND featureCode = 'shoppingCartType';
END
ELSE
BEGIN
    INSERT INTO merchantWebsiteFeatures
        (merchant_id, featureCode, featureValue)
    VALUES
        (@merchantId, 'shoppingCartType', @PaymentProcessor);
END

GO

select *
from MerchantWebsiteTexts
where merchant_id = 1941
    and textcode like '%payment%'

select *
from MerchantWebsitefeatures
where merchant_id = 1941
    and featurecode like '%shoppingCartType%'

PayPalCheckout|AUTH_URL~
https:
//api.paypal.com/v1/oauth2/token|CLIENT_ID~AY3tJKh2uG87YQMp8AVqO17_ecH3tXTqD6NZtKTgS13qcbelTS98yCbufXzgXEoMnHIBySuUH0LaZY2U|CLIENT_SECRET~EF94w9nrKqFQ3yB2V-U4spdly7id85HIYjahWU8ik5Gnn6gYYR3gppO6KF92gYmvvmtBghrYKBdl3_Pl|ORDERS_URL~
https:
//api.paypal.com/v2/checkout/orders