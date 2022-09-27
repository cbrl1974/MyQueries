
Declare @merchantID INT = 2852;

select hasBlog from merchantcms where merchant_id = @merchantID

update top (1) merchantcms set hasBlog = 1 where merchant_id = @merchantID

select * from merchantblogs where merchantid = @merchantID

insert into merchantblogs (name,urlkey,merchantid) values
('Default','',@merchantID)

--Check the users for the blogTools session
 SELECT merchants.ID, merchant, retailerID ,merchantusers.ID AS opruserid, merchants.merchant_url, seoTools, blogTools,email_user, f_name, l_name
FROM        merchants
INNER JOIN  merchantusers on merchants.ID = merchantusers.merchant_ID
where merchants.id = @merchantID


Declare @userId INT = (SELECT top (1) opruserid
FROM        merchants
INNER JOIN  merchantusers on merchants.ID = merchantusers.merchant_ID
where merchants.id = @merchantID);

update top (1) merchantusers
set blogtools = 1
where id =  @userId

