
select distinct featureCode from merchantwebsitefeatures where featureCode like 'use%discounts%'

insert into merchantwebsitefeatures (merchant_id,featureCode,featureValue) values
(996,'useGlobalDiscounts',null)

select  * from merchantwebsitefeatures where merchant_id = 163

select discountsTool from merchantcms where merchant_id = 996

update merchantcms set discountsTool = 1
where merchant_id = 1097

--Advanced

insert into merchantWebsiteFeatures (merchant_id,featureCode,featureValue) values
(1097,'globalDiscountBeforeTaxes',null),
(1097,'useTaxesDiscounts',null),
(1097,'useGlobalDiscounts',null),
(1097,'useGroupDiscounts',null),
(1097,'useItemsDiscounts',null)
