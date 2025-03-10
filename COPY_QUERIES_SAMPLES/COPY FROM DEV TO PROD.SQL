insert into  [DB.PROD].datatail20130410.dbo.MerchantDiscountProducts
    (Merchant_ID, Code_disc,ProductId)
select Merchant_ID, Code_disc, ProductId
from MerchantDiscountProducts
where merchant_id = 3507 and Code_disc = 'SansTaxes'
