SELECT CONVERT(CHAR(7), ordertimestamp, 120) as Year_Month,
       SUM(total) as totalMonth
    FROM customerorders
	where merchant_id = 1097
and ordertimeStamp between '2017-01-01' and '2017-02-01'
and status  != 'cancelled'
    GROUP BY CONVERT(CHAR(7), ordertimestamp, 120) 
    ORDER BY Year_Month
