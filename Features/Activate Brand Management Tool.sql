DECLARE @merchantID AS INT = 3559;
DECLARE @havefeatures as int = 
	( 
        SELECT count(featureCode) FROM merchantwebsitefeatures 
        WHERE merchant_id = @merchantID 
        AND featurecode IN ('canClearPricesByBrand','canDisplayFeaturedBrands','canHideEntireBrands','canRenameBrands','canStartingAtEntireBrands','hasHideBrands')
	);

select  @havefeatures

IF @havefeatures = 0
BEGIN
    INSERT INTO merchantwebsitefeatures VALUES
    (@merchantID, 'canClearPricesByBrand', null),
    (@merchantID, 'canDisplayFeaturedBrands', null),
    (@merchantID, 'canHideEntireBrands', null),
    (@merchantID, 'canRenameBrands', null),
    (@merchantID, 'canStartingAtEntireBrands', null),
    (@merchantID, 'hasHideBrands', null)
END

SELECT * FROM merchantwebsitefeatures 
WHERE merchant_id = @merchantID 
AND featurecode IN ('canClearPricesByBrand','canDisplayFeaturedBrands','canHideEntireBrands','canRenameBrands','canStartingAtEntireBrands','hasHideBrands')
select  @havefeatures