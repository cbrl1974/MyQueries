--DECLARE @refno INT = 140945357;

--select * from SALES where refno = @refno

WITH
    Duplicates
    AS
    (
        SELECT MESSAGE_ID, -- Replace with your actual primary key column
            ROW_NUMBER() OVER (PARTITION BY REFNO ORDER BY SALEDATE) AS rn
        FROM salesInformation
        WHERE  SALEDATE <= '2022-01-01'
    )

SELECT *
FROM Duplicates
WHERE rn > 1;






WITH
    Duplicates
    AS
    (
        SELECT Id,
            ROW_NUMBER() OVER (PARTITION BY REFNO ORDER BY SALEDATE) AS rn
        FROM salesInformation
        WHERE   SALEDATE <= '2022-01-01'
    )

DELETE FROM salesInformation
WHERE Id IN (
    SELECT Id
FROM Duplicates
WHERE rn > 1
);


