
Declare @merchantID INT = 2852;
select hasBlog from merchantcms where merchant_id = @merchantID

update top (1) merchantcms set hasBlog = 1 where merchant_id = @merchantID

select * from merchantblogs where merchantid = @merchantID

insert into merchantblogs (name,urlkey,merchantid) values
('Default','',@merchantID)

