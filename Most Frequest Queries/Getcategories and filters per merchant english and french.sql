select  categoryEn.category as categoryEn , specEn.spec as specEn, categoryfr.category as categoryFr ,specFr.spec as specFr
    from merchantcats mc WITH(NOLOCK)
    inner join Categories categoryEn WITH(NOLOCK) on  categoryEn.Id_category = mc.catID  and categoryEn.id_langue = 1
    join specs specEn WITH(NOLOCK) on specEn.catid  = mc.catid  and specEn.Id_langue = 1
    inner join categories categoryFr  WITH(NOLOCK)on categoryFr.Id_category = mc.catID and categoryFr.id_langue = 2
    join specs specFr WITH(NOLOCK) on specFr.CatId = mc.catID and specFr.Id_langue = 2
    where mc.merchant_id = 1449 
    and specEn.Id_spec = specFr.Id_spec
    order by mc.catID



    select  categoryEn.category as categoryEn , specEn.spec as specEn, categoryfr.category as categoryFr ,specFr.spec as specFr
    from merchantcats mc WITH(NOLOCK)
    inner join Categories categoryEn WITH(NOLOCK) on  categoryEn.Id_category = mc.catID  and categoryEn.id_langue = 1
    join specs specEn WITH(NOLOCK) on specEn.catid  = mc.catid  and specEn.Id_langue = 1
    inner join categories categoryFr  WITH(NOLOCK)on categoryFr.Id_category = mc.catID and categoryFr.id_langue = 2
    join specs specFr WITH(NOLOCK) on specFr.CatId = mc.catID and specFr.Id_langue = 2
    where mc.merchant_id = 1175 
    and specEn.Id_spec = specFr.Id_spec
    order by mc.catID
    
    
    