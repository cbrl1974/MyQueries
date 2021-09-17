select distinct specEn.spec as Spec_Name_EN, specFr.spec as Spec_Name_FR, specsProdEn.SpecValue_1 as Spec_Value_EN, specsProdFr.SpecValue_2 as Spec_Value_FR
from specs specEn WITH(NOLOCK)
join specs specFr WITH(NOLOCK) on specFr.id_spec = specEn.id_spec and specFr.CatId = specEn.CatId and specFr.Id_langue = 2 and specEn.id_langue = 1
inner join SpecsProd specsProdEn WITH(NOLOCK) on specsProdEn.specsID_1 = specEn.ID
inner join SpecsProd specsProdFr WITH(NOLOCK) on specsProdFr.specsID_2 = specFr.ID and specsProdFr.productID = specsProdEn.productID
where specEn.isfilter = 1
and specFr.isfilter = 1
