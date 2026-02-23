DECLARE @merchantId INT = 1719;

DECLARE @textcodeProd NVARCHAR(255) = 'paymentPPCDetail';
DECLARE @ClientIDProd NVARCHAR(MAX) = 'AX310agAgtVKlYKampTZArrMLwlvaPdcQ0zmBRveoEqhgDLuujv2zV6Ddoe6nn7NSnsyYEB_hqQQjduU';
DECLARE @ClientSecretProd NVARCHAR(MAX) = 'EH5D0z_lKzavuFconCS_LOU1oAX7zoe9_7oEUNEdqGf9RhcSigEurY3IWNFR1oKASE_YOnA118BekLaa';

DECLARE @textcodeDev NVARCHAR(255) = 'paymentPPCDetailTest';
DECLARE @ClientIDDev NVARCHAR(MAX) = 'AX310agAgtVKlYKampTZArrMLwlvaPdcQ0zmBRveoEqhgDLuujv2zV6Ddoe6nn7NSnsyYEB_hqQQjduU';
DECLARE @ClientSecretDev NVARCHAR(MAX) = 'EKR-OmaERYBcTx8Q_AmoL0MT06oJCj8wkMlg5ssmGSQjQVfKfZs-4a0-PP3pk6cSdrz3XNaeAzY8RtRy';


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