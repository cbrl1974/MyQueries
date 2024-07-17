
select * from datatail20130410.dbo.SystemStates where [key] = 'ImageImportState';


update top (1) SystemStates
set state = '{"Busy":false,"Error":false,"TotalBatches":3,"Batches":3}'
 where [key] = 'ImageImportState';
 