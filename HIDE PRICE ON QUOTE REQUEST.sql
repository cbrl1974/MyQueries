SELECT * FROM MERCHANTWEBSITETEXTS WHERE MERCHANT_ID = 1761


SELECT MERCHANT_ID, TEXTCODE,content_1 FROM MERCHANTWEBSITETEXTS WHERE TEXTCODE = 'requestHiddenPrice' and merchant_id in  (685,589,1193)

INSERT INTO MERCHANTWEBSITETEXTS (MERCHANT_ID,TEXTCODE,content_1) VALUES
(589,'requestHiddenPrice','1'),
(685,'requestHiddenPrice','1'),
(1193,'requestHiddenPrice','1')



SELECT MERCHANT_ID, TEXTCODE,content_1,content_2 FROM MERCHANTWEBSITETEXTS WHERE  merchant_id = 1193 and textcode = 'quoterequestemail'

update top (1) MERCHANTWEBSITETEXTS set content_1 = 'Mpersechino@tailbase.com,efranco@tailbase.com'
--, content_2 = 'efranco@tailbase.com,lcabral@tailbase.com'
WHERE  merchant_id = 1193 and textcode = 'quoterequestemail'


