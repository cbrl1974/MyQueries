SELECT merchant 
FROM ( 
    SELECT CompId FROM (
    VALUES 
        (2753),
        (2806),
        (23),
        (700),
        (2896),
        (2897),
        (2898),
        (2899),
        (2755),
        (1100),
        (2921),
        (2922),
        (2923),
        (2924),
        (2756),
        (28),
        (2926),
        (21),
        (805),
        (397),
        (225),
        (31)
    ) CI(CompId) 
) V
OUTER APPLY (
    SELECT * 
    FROM Merchants 
    WHERE ',' + Competition + ',' LIKE '%,' + CAST(V.CompId AS VARCHAR(20)) +',%'
        AND Active = 1
) OAv