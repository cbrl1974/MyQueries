use datatail20130410


declare @MerchantId int=1210;
declare @Columns nvarchar(max)=
(select '['+dbo.group_concat_d(distinct msi.infolabel,'],[')+']'  from merchantstores ms
inner join MerchantStoreInfos msi on msi.MerchantStoreId = ms.id
where ms.merchantid = @MerchantId);
declare @DynamicPivot nvarchar(max)=N'
select * from (
select ms.*, msi.InfoLabel,msi.InfoValue from merchantstores ms
inner join MerchantStoreInfos msi on msi.MerchantStoreId = ms.id
where ms.merchantid = @MerchantId
) x pivot (max(InfoValue) for InfoLabel in ('+@columns+')) piv1';
-- execute the dynamic SQL
EXECUTE sp_executesql @DynamicPivot,N'@MerchantId int',@MerchantId;

select top 10 * from customerOrders

select m.id,m.merchant_code,m.merchant, o.*, c.first_Name, c.last_name,c.email,c.telephone, ca.address1, ca.address2,ca.city, ca.provincecode, ca.postalcode, ca.countrycode,ca.address2
from customerOrders o
JOIN  merchants m on m.id = o.merchant_id
join customers c on c.id = o.customerId and c.merchant_id = o.merchant_id
join CustomerAddresses ca on ca.customerId = c.id
JOIN MerchantWebsiteFeatures F ON F.Merchant_Id = M.ID AND F.FeatureCode = 'template'
WHERE F.FeatureValue IN ('tbmega1','tbmega2')


select top 10 * from  CustomerAddresses

