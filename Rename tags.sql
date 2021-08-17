
use datatail20130410
DECLARE @MerchantId AS INT = 1532
DECLARE @tagName AS VARCHAR(50) = 'TagLabelWebOnly'
select top (5) * from merchantWebsitetexts where  textcode like @tagName
select * from merchantWebsitetexts where merchant_id = @MerchantId and textcode like @tagName


DECLARE @IDSample AS INT = (select top (1) id from merchantWebsitetexts where textcode like @tagName);
DECLARE @textCodeSample AS VARCHAR(50) = (select top (1) textcode from merchantWebsitetexts where textcode like @tagName);
DECLARE @NewNameValue AS VARCHAR(50) = 'In Stock'

--RENAME FLAG
insert into merchantWebsitetexts (merchant_id,textcode,content_1) 
select  @MerchantId,@textCodeSample, @NewNameValue 
from merchantWebsitetexts where  id =   @IDSample

--UPDATE MERCHANTPRODS TO TEST

DECLARE @tagNameCode AS VARCHAR(50) = 'WebOnly'
DECLARE @active AS VARCHAR(50) = 0
DECLARE @MerchantId2 AS INT = 1532

select top (1) productid from merchantprods where merchant_id = @MerchantId2
DECLARE @firstProductWithLabel AS INT = (select top (1) productid from merchantprods where merchant_id = @MerchantId2);

update top (1) merchantprods set WebOnly = @active where productid = @firstProductWithLabel and merchant_id = @MerchantId2





