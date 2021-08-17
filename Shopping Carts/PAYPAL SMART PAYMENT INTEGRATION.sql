select * from merchantwebsitetexts where merchant_id = 2524 and textcode like '%payment%'
select * from merchantwebsitefeatures where merchant_id = 2524 and featurecode = 'shoppingCartType'
insert into merchantwebsitetexts (merchant_id,textcode,content_1) values
(2524,'paymentPPCDetail','PayPalCheckout|AUTH_URL~https://api.paypal.com/v1/oauth2/token|CLIENT_ID~AR8AIizZG3uwIF97tZrUss-lVwy1QCz1ZLJxiCxpVfwTO4H8QqrecnjKf3h6Gd9t3nAdu-2PNXLFuOMH|CLIENT_SECRET~EHWG_Y6kcHYh49BmlmSpFce0jS3jH5Bd-OwriCOyxIoNdlLbz2r3awBME_dTW5oGyRnpUP2OCxS4OBPl|ORDERS_URL~https://api.paypal.com/v2/checkout/orders'),
(2524,'paymentPPCDetailTest','testConnection|PayPalCheckout|AUTH_URL~https://api.sandbox.paypal.com/v1/oauth2/token|CLIENT_ID~AcJHYACvv2p9Y9XQyTnP_svdZ0JbyLqSViLfTEZztIp10ZFXGdrYSUu_GyWyWBJhhBXItn75hiI027OE|CLIENT_SECRET~EE9roW-Y-DJ6wBaIjKGF1EBxwnNTubWmS7nxQdhrHAfNLdKSAFLcTjNkZFG2bbaAoyKMkOOwSc4DoF_i|ORDERS_URL~https://api.sandbox.paypal.com/v2/checkout/orders')



update top (1) merchantwebsitefeatures set featureValue = 'PaypalSmartPayment'
where merchant_id = 2524 and featurecode = 'shoppingCartType'



