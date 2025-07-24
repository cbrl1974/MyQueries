
DECLARE @json nvarchar(max);
SELECT @json = FeedOptionsJson
FROM feeds.merchantfeeds
WHERE merchantId = 2087;

-- Replace manually (you can use JSON_QUERY for correct array embedding)
SET @json = JSON_MODIFY(@json, '$.ManufacturerIds', JSON_QUERY('[3181,3182,3184,4226,4227,7587]'));

UPDATE feeds.merchantfeeds
SET FeedOptionsJson = @json
WHERE merchantId = 2087;