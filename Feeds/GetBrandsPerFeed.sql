-- Declare a table variable to store the combined results
DECLARE @CombinedResults TABLE (
    ID INT,
    Name NVARCHAR(255),
    Result INT
);

-- Query 1
DECLARE @Id1 INT;
DECLARE @Name1 NVARCHAR(255);
DECLARE @Options1 NVARCHAR(MAX);

DECLARE DataCursor1 CURSOR FOR
SELECT id, name, [options]
FROM feeds.Feeds
WHERE id NOT IN (3, 2, 17, 13, 14);

OPEN DataCursor1;

FETCH NEXT FROM DataCursor1 INTO @Id1, @Name1, @Options1;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO @CombinedResults (ID, Name, Result)
    SELECT
        @Id1 AS 'ID',
        @Name1 AS 'Name',
        CAST(JSON_VALUE(bc.value, '$.brandId') AS INT) AS 'Result'
    FROM OPENJSON(@Options1, '$.brandCategories') AS bc
    WHERE JSON_VALUE(bc.value, '$.brandId') IS NOT NULL;

    FETCH NEXT FROM DataCursor1 INTO @Id1, @Name1, @Options1;
END;

CLOSE DataCursor1;
DEALLOCATE DataCursor1;

-- Query 2
DECLARE @Id2 INT;
DECLARE @Name2 NVARCHAR(255);
DECLARE @Options2 NVARCHAR(MAX);

DECLARE DataCursor2 CURSOR FOR
SELECT id, name, [options]
FROM feeds.Feeds
WHERE id NOT IN (3, 2, 17, 13, 14);

OPEN DataCursor2;

FETCH NEXT FROM DataCursor2 INTO @Id2, @Name2, @Options2;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO @CombinedResults (ID, Name, Result)
    SELECT
        @Id2 AS 'ID',
        @Name2 AS 'Name',
        CAST(value AS INT) AS 'Result'
    FROM OPENJSON(@Options2, '$.statusProcessorSettings.manufIds')
    WHERE value IS NOT NULL;

    FETCH NEXT FROM DataCursor2 INTO @Id2, @Name2, @Options2;
END;

CLOSE DataCursor2;
DEALLOCATE DataCursor2;

-- Select the combined results without NULL values
SELECT DISTINCT * FROM @CombinedResults WHERE Result IS NOT NULL;
