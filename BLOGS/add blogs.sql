DECLARE @merchantID INT = 3423;

DECLARE @BlogToolActivated INT = (
    SELECT hasBlog
    FROM merchantcms
    WHERE merchant_id = @merchantID
);

IF ISNULL(@BlogToolActivated, 0) = 0
BEGIN
    UPDATE TOP (1) merchantcms
    SET hasBlog = 1
    WHERE merchant_id = @merchantID;
END
ELSE
BEGIN
    SELECT @BlogToolActivated AS BlogToolActivated;
END;


SELECT *
FROM merchantblogs
WHERE merchantid = @merchantID;


IF NOT EXISTS (
    SELECT 1
    FROM merchantblogs
    WHERE merchantid = @merchantID
      AND name = 'Default'
)
BEGIN
    INSERT INTO merchantblogs (name, urlkey, merchantid)
    VALUES ('Default', '', @merchantID);
END;


SELECT *
FROM merchantblogs
WHERE merchantid = @merchantID;


-- Check the users for the blogTools session
SELECT 
    merchants.ID,
    merchant,
    retailerID,
    merchantusers.ID AS opruserid,
    merchants.merchant_url,
    seoTools,
    blogTools,
    email_user,
    f_name,
    l_name
FROM merchants
INNER JOIN merchantusers 
    ON merchants.ID = merchantusers.merchant_ID
WHERE merchants.ID = @merchantID;


-- Update the 3 users for this merchant
;WITH UsersToUpdate AS (
    SELECT TOP (3) merchantusers.ID
    FROM merchantusers
    WHERE merchant_ID = @merchantID
    ORDER BY ID
)
UPDATE merchantusers
SET blogTools = 1
WHERE ID IN (
    SELECT ID
    FROM UsersToUpdate
);


SELECT 
    ID,
    merchant_ID,
    blogTools,
    email_user,
    f_name,
    l_name
FROM merchantusers
WHERE merchant_ID = @merchantID;