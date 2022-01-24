use datatail20130410

 insert into merchantWebsiteFeatures(merchant_id, featureCode, featureValue)
 values(847, 'featureConfigs', '{    "features": {        "heyday": true    }}')

 delete top (1) from  merchantWebsiteFeatures where merchant_id = 847 and featurecode = 'featureConfigs'

			

