
DECLARE @ShoppingCartPriceIncludesFees as varchar(200) = 'shoppingCartPriceIncludesFees';
DECLARE @HideFeeAmount as varchar(200) = 'hideFeeAmount';
DECLARE @MerchantID as int = 3102;

--Check if they exist
select *
from merchantwebsitefeatures
where featureCode in (@ShoppingCartPriceIncludesFees, @HideFeeAmount) and merchant_id = @MerchantID

--Activate feature for ecofees in Quebec
insert into merchantwebsitefeatures
    (merchant_id, featureCode)
values
    (@MerchantID, @ShoppingCartPriceIncludesFees),
    (@MerchantID, @HideFeeAmount)

--Check if they are in
select *
from merchantwebsitefeatures
where featureCode in (@ShoppingCartPriceIncludesFees, @HideFeeAmount) and merchant_id = @MerchantID


--Check some pricing on websites with fee

Select productid, price, reducedPrice, fee from merchantProds where merchant_id  = 3102 and fee is not null
