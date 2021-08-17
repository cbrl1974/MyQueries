DECLARE @TargetId AS INT = 1572

-- ALL SHOP BY ROOM
--select T.* 
--from MerchantWebsiteTexts T
--join merchants M on M.id = T.merchant_id
--where M.id = @TargetId
--and T.textcode like 'shopByRoomAd%'

-- DELETE ALL SHOP BY ROOM
DELETE T 
from MerchantWebsiteTexts T
join merchants M on M.id = T.merchant_id
where M.id = @TargetId
and T.textcode like 'shopByRoomAd%'

