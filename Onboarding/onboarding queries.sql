DECLARE @MerchantId AS INT = 3389;

select * from merchantWebsiteFeatures where merchant_id = @MerchantId and featurecode in ('usesPlatinumLayout', 'v3Layout', 'carouselAutoplaySpeed')

insert into merchantWebsiteFeatures
 values (@MerchantId, 'usesPlatinumLayout', null);

insert into merchantWebsiteFeatures
 values (@MerchantId, 'v3Layout', 'FLX'); --(remember use this according to the merchant template FLX - Platinum – Primary)

insert into merchantWebsiteFeatures
 values (@MerchantId, 'carouselAutoplaySpeed', 4000);

 --Content pages
 DECLARE @MerchantIdForCPPages AS INT = 3389;

    Select * from merchantwebsitepages where merchant_id =   @MerchantIdForCPPages

    update top (1) merchantwebsitepages
    set  name = 'Reviews',
    slug = 'reviews'
    where id = 19088

    select * from merchantwebsiteconfigs where merchantid = 3379
    