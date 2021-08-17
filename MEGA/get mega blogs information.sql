select m.id, m.merchant from merchants m
inner join merchantwebsitefeatures mwf on mwf.merchant_id = m.id
where mwf.featurecode = 'template'
and mwf.featurevalue in  ('tbmega1','tbmega2')

select m.merchant,mb.MerchantID,m.merchant_code,mb.id as blogid,mba.title,mba.id as articeid,
case when mba.id_langue = 1 
then 'En' 
else 'Fr' end AS language,CONCAT('/blog/',mba.id,'-',mba.title) as url,
mba.CategoriesForSearch,
mba.creationDate
from merchantblogs mb			
inner join merchants m on m.id = mb.MerchantID
inner join MerchantBlogArticles mba on mba.merchantblogid = mb.id
where mb.merchantid in
 (1210,1267,1268,1274,1275,1276,1277,1278,1279,1280,1281,1282,1283,1284,1285,1286,1287,1288,1289,1290,1291,1292,1293,1294,1301,1302,1303,1304,1305,1306,1307,1308,1309,1310,1311,1312,1329,1330,1331,1332,1333,1338,1339,1340,1341,1342,1343,1344,1345,1346,1347,1351,1352,1357,1358,1359,1360,1362,1364,1366,1434,1465,1466,1467,1468,1491,1504,1670,1678,1679,1680,1687,1694,1706,1718,1720,1723,1726,1741,1742,1743,1887,1889,2112,2131,2254,2298,2302,1368,1374,1378,1379,1381,1383,1384,1385,1387,1389,1391,1479,1488,1490,1572,1684,1781,1801,1820,1821,1830,1831,1885,2252,2304,2306,2308,2310)