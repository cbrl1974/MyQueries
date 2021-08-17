DECLARE @TargetId AS INT = 1680

DELETE C
FROM   MerchantWebsitePages P
JOIN   MerchantWebsitePageContent C On C.MerchantWebsitePageId = P.Id
WHERE  P.Merchant_Id = @TargetId AND P.Slug IN ('about-us','our-services')

DELETE P
FROM   MerchantWebsitePages P
WHERE  P.Merchant_Id = @TargetId AND P.Slug IN ('about-us','our-services')


INSERT INTO MerchantWebsitePages(merchant_id, name, slug, WebsitePageDesignId, active)
SELECT  @TargetId, name, slug, WebsitePageDesignId, active
FROM    MerchantWebsitePages
WHERE   Merchant_Id = 1210 AND Slug IN ('about-us')

INSERT INTO MerchantWebsitePageContent(MerchantWebsitePageId, ContentCode, Content, Id_langue)
SELECT  P.Id, REPLACE(D.ContentCode, '_', '1'), '', 1
FROM    WebsitePageDesignContent D
JOIN    MerchantWebsitePages P ON P.merchant_id = @TargetId AND P.slug = 'about-us'
WHERE   D.WebsitePageDesignId = 40

INSERT INTO MerchantWebsitePageContent(MerchantWebsitePageId, ContentCode, Content, Id_langue)
SELECT  P.Id, REPLACE(D.ContentCode, '_', '1'), '', 2
FROM    WebsitePageDesignContent D
JOIN    MerchantWebsitePages P ON P.merchant_id = @TargetId AND P.slug = 'about-us'
WHERE   D.WebsitePageDesignId = 40

INSERT INTO MerchantWebsitePages(merchant_id, name, slug, WebsitePageDesignId, active)
SELECT  @TargetId, 'Our Services', 'our-services', WebsitePageDesignId, active
FROM    MerchantWebsitePages
WHERE   Merchant_Id = 1210 AND Slug IN ('about-us')

INSERT INTO MerchantWebsitePageContent(MerchantWebsitePageId, ContentCode, Content, Id_langue)
SELECT  P.Id, REPLACE(D.ContentCode, '_', '1'), '', 1
FROM    WebsitePageDesignContent D
JOIN    MerchantWebsitePages P ON P.merchant_id = @TargetId AND P.slug = 'our-services'
WHERE   D.WebsitePageDesignId = 40

INSERT INTO MerchantWebsitePageContent(MerchantWebsitePageId, ContentCode, Content, Id_langue)
SELECT  P.Id, REPLACE(D.ContentCode, '_', '1'), '', 2
FROM    WebsitePageDesignContent D
JOIN    MerchantWebsitePages P ON P.merchant_id = @TargetId AND P.slug = 'our-services'
WHERE   D.WebsitePageDesignId = 40