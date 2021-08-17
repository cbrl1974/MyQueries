use datatail20130410

select m.id, m.merchant, m.merchant_code, m.filepath from merchants m
inner join merchantwebsitefeatures mwf on mwf.merchant_id = m.id
inner join merchantwebsitetexts mwt on mwt.merchant_id = m.id
where mwf.featurevalue = 'TBVision'
and mwt.textcode = 'paymentPPEDetail'
