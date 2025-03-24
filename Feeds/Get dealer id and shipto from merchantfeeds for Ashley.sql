
SELECT 
    m.id, 
    m.merchant, 
    mf.remoteftpuser,

    -- Extract Account ID (number between first and second underscore)
    CASE 
        WHEN mf.remoteftpuser IS NOT NULL 
             AND CHARINDEX('_', mf.remoteftpuser) > 0 
             AND CHARINDEX('_', mf.remoteftpuser, CHARINDEX('_', mf.remoteftpuser) + 1) > 0
        THEN 
            SUBSTRING(
                mf.remoteftpuser, 
                CHARINDEX('_', mf.remoteftpuser) + 1, 
                CHARINDEX('_', mf.remoteftpuser, CHARINDEX('_', mf.remoteftpuser) + 1) 
                - CHARINDEX('_', mf.remoteftpuser) - 1
            ) 
        ELSE NULL 
    END AS accountid,

    -- Extract Ship (number after the last underscore, removing '-')
    CASE 
        WHEN mf.remoteftpuser IS NOT NULL 
             AND CHARINDEX('_', REVERSE(mf.remoteftpuser)) > 0
        THEN 
            REPLACE(
                RIGHT(mf.remoteftpuser, CHARINDEX('_', REVERSE(mf.remoteftpuser)) - 1), 
                '-', ''
            ) 
        ELSE NULL 
    END AS ship

FROM merchantfeeds mf
JOIN merchants m ON m.id = mf.merchant_id
WHERE merchant_id IN (1140, 3319, 3515, 3538, 3445, 3227, 3496, 1546, 2923, 3558);