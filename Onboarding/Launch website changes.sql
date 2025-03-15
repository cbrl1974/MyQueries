DECLARE @Oldmerchant as int = 848;
DECLARE @Newmerchant as int = 3570;

-- ====================== Old merchant update ======================

--add '- old' to the old merchant name
--deactivate the old merchant
select id, merchant, merchant_url from merchants where id = @Oldmerchant

update top (1) merchants
set merchant = 'True Style Furniture Plus - old',
active = 0
from merchants where id = @Oldmerchant

select id, merchant, merchant_url from merchants where id = @Oldmerchant


-- ====================== New merchant update ======================

--remove 'Up' from the new merchant name

select id, merchant, merchant_url from merchants where id = @Newmerchant

update top (1) merchants
set merchant = 'True Style Furniture Plus'
from merchants where id = @Newmerchant

select id, merchant, merchant_url from merchants where id = @Newmerchant


-- ====================== DB Changes merchantUsers ======================

select * from merchantUsers where merchant_id = @Oldmerchant

select * from merchantUsers where merchant_id = @Newmerchant