SELECT      c.name  AS 'ColumnName'
            ,t.name AS 'TableName'
FROM        sys.columns c
JOIN        sys.tables  t   ON c.object_id = t.object_id
WHERE       c.name LIKE '%discount%'
ORDER BY    TableName
            ,ColumnName;


			select * from CustomerOrders where merchant_id = 2850
			select * from CustomerOrderItems where orderId in (select id from CustomerOrders where merchant_id = 2850)