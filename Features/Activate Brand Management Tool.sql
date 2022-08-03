DECLARE @merchantID AS INT = 3124;

SELECT * FROM merchantwebsitefeatures 
WHERE merchant_id = @merchantID 
AND featurecode IN ('canClearPricesByBrand','canDisplayFeaturedBrands','canHideEntireBrands','canRenameBrands','canStartingAtEntireBrands','hasHideBrands')

INSERT INTO merchantwebsitefeatures VALUES
(3124, 'canClearPricesByBrand', null),
(3124, 'canDisplayFeaturedBrands', null),
(3124, 'canHideEntireBrands', null),
(3124, 'canRenameBrands', null),
(3124, 'canStartingAtEntireBrands', null),
(3124, 'hasHideBrands', null)