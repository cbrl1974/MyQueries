
Declare @merchantID INT = 589;

DECLARE @BlogToolActivated as int =  (select hasBlog from merchantcms where merchant_id = @merchantID);

if @BlogToolActivated = 0 
    update top (1) merchantcms set hasBlog = 1 where merchant_id = @merchantID
ELSE
    select @BlogToolActivated;
 

select * from merchantblogs where merchantid = @merchantID

insert into merchantblogs (name,urlkey,merchantid) values
('Default','',@merchantID)


Declare @merchantIDForUsers INT = 2443;
--Check the users for the blogTools session
 SELECT merchants.ID, merchant, retailerID ,merchantusers.ID AS opruserid, merchants.merchant_url, seoTools, blogTools,email_user, f_name, l_name
FROM        merchants
INNER JOIN  merchantusers on merchants.ID = merchantusers.merchant_ID
where merchants.id = @merchantIDForUsers


Declare @userId INT = (SELECT top (1) merchantusers.id
FROM        merchants merchants
INNER JOIN  merchantusers merchantusers on merchants.ID = merchantusers.merchant_ID
where merchants.id = @merchantIDForUsers);

select @userId

update top (1) merchantusers
set blogtools = 1
where id =  @userId

