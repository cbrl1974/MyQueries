DECLARE @merchantID  as int  = 2704;
DECLARE @hasSeoManagement as int = 
	( 
		select seoManagement from merchantcms where merchant_id = @merchantID 
	);

DECLARE @hasSeoFeature as varchar(10) = 
	( 
		select featurecode from merchantwebsitefeatures where merchant_id = @merchantID and featurecode = 'hasSEO'
	);

-- Update seoManagement if it's not already 1
IF @hasSeoManagement <> 1
BEGIN
    UPDATE merchantcms 
    SET seoManagement = 1 
    WHERE merchant_id = @merchantID;
    PRINT 'seoManagement set to 1';
END
ELSE
BEGIN
    PRINT 'seoManagement already set to 1';
END

-- Insert hasSEO feature if it's not already present
IF @hasSeoFeature IS NULL
BEGIN
    INSERT INTO merchantwebsitefeatures (merchant_id, featurecode, featureValue) 
    VALUES (@merchantID, 'hasSEO', '');
    PRINT 'hasSEO feature added';
END
ELSE
BEGIN
    PRINT 'hasSEO feature already added';
END

-- Check results
SELECT seoManagement 
FROM merchantcms 
WHERE merchant_id = @merchantID;

SELECT * 
FROM merchantwebsitefeatures 
WHERE merchant_id = @merchantID 
AND featurecode = 'hasSEO';


--Reset merchant url
http://merchantcode.web1.tailbase.com/?reset=me2
http://merchantcode.web2.tailbase.com/?reset=me2