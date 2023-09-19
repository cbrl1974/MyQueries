-- Declare a table variable to store the results
DECLARE @ExtractedResults TABLE (
    ID INT,
    Name NVARCHAR(255),
    Result INT
);

DECLARE @Id INT;
DECLARE @Name NVARCHAR(255);
DECLARE @Options NVARCHAR(MAX);

DECLARE DataCursor CURSOR FOR
SELECT id, name, [options]
FROM feeds.Feeds;

OPEN DataCursor;

FETCH NEXT FROM DataCursor INTO @Id, @Name, @Options;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO @ExtractedResults (ID, Name, Result)
    SELECT
        @Id AS 'ID',
        @Name AS 'Name',
        CAST(JSON_VALUE(bc.value, '$.brandId') AS INT) AS 'Result'
    FROM OPENJSON(@Options, '$.brandCategories') AS bc;

    FETCH NEXT FROM DataCursor INTO @Id, @Name, @Options;
END;

CLOSE DataCursor;
DEALLOCATE DataCursor;

-- Select the results from the table variable
SELECT DISTINCT * FROM @ExtractedResults;
