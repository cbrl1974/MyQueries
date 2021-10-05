DECLARE @MerchantID as int = 3259;

select  * from MerchantWebsiteTexts where merchant_id = @MerchantID and textcode in ('googleanalyticscode', 'googleanalyticscodeHead')

update top (2) MerchantWebsiteTexts
set availableinmerchantbean = 1
where id in (
    select id from MerchantWebsiteTexts where merchant_id = @MerchantID and textcode in ('googleanalyticscode', 'googleanalyticscodeHead')
)
and merchant_id = @MerchantID