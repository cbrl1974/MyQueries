DECLARE @RowsToProcess  int
DECLARE @CurrentRow     int
DECLARE @SelectCol1     int

DECLARE @table1 TABLE (RowID int not null primary key identity(1,1), col1 int )  
INSERT into @table1 (col1) SELECT col1 FROM table2
SET @RowsToProcess=@@ROWCOUNT

SET @CurrentRow=0
WHILE @CurrentRow<@RowsToProcess
BEGIN
    SET @CurrentRow=@CurrentRow+1
    SELECT 
        @SelectCol1=col1
        FROM @table1
        WHERE RowID=@CurrentRow

    --do your thing here--

END