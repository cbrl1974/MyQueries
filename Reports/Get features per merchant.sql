-- Get merchants and features
   select 
    distinct m.id as 'Merchant ID', 
    m.merchant as 'Merchant',
    m.AccountingID as 'TB Number', 
    mi.infoValue as Solution,
    case when mcs.hasBlog = 1  then 'Yes' else 'No' end as 'Has Blog',
    case when mcs.discountsTool = 1 then 'Yes' else 'No' end as 'Has Discounts Tool',
    case when mcs.RTOConsole = 1 then 'Yes' else 'No' end as 'Is RTO',
    case when mcs.hasURLMapping = 1 then 'Yes' else 'No' end as 'Has Url Mapping Tool',    
    MAX(case when mw.id IS NOT NULL then 'Yes' else 'No' end) as 'Has Warranties',
    MAX(case when mis.id IS NOT NULL then 'Yes' else 'No' end) as 'Has Installations',
    MAX(case when mf.featurecode = 'installationsSettings' then 'Yes' else 'No' end) as 'installations Settings tool',
    MAX(case when mf.featurecode = 'ShoppingCartType' then 'Yes' else 'No' end) as 'Has ShoppingCart',    
    MAX(case when mf.featurecode = 'useDropShipping' then 'Yes' else 'No' end) as 'Ashley Express',
    MAX(case when mf.featurecode = 'persistsActiveCart' then 'Yes' else 'No' end) as 'Abandoned Carts',
    MAX(case when mf.featurecode = 'hasInlineAdsOnProductListPage' then 'Yes' else 'No' end) as 'has InlineAds'    ,
    MAX(case when mf.featurecode = 'useWishList' or mf.featurecode = 'hasWishList' then 'Yes' else 'No' end) as 'has Wishlist',
    MAX(case when mf.featurecode = 'shoppingCartPriceIncludesFees' then 'Yes' else 'No' end) as 'has Ecofees',
    MAX(case when mf.featurecode = 'canRenameBrands' then 'Yes' else 'No' end) as 'has Brand Tool Management'  
from merchants m
    INNER join MerchantWebsiteInformation mi on mi.merchant_id = m.id and mi.infoCode = 'template' 
    inner join merchantwebsitefeatures mf on mf.merchant_id = m.ID
    INNER JOIN merchantCMS mcs on mcs.Merchant_id = m.id
    left join merchantwarranties mw on mw.merchantID = m.id
    left join merchantInstallations mis on mis.merchantID = m.id
where m.active = 1
    and m.merchant not like '% old%'
group by m.id, m.merchant, m.AccountingID, mi.infoValue, mcs.hasBlog, mcs.discountsTool, mcs.RTOConsole, mcs.hasURLMapping, mw.id,mis.id


select top 1 * from merchantcms
select distinct featurecode from merchantwebsitefeatures where featurecode like '%pers%'