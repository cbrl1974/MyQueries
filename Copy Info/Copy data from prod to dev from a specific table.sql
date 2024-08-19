SET IDENTITY_INSERT DevTailbaseCore.dbo.SpecTranslationDictionary ON

insert into
    DevTailbaseCore.dbo.SpecTranslationDictionary
	(id, CategoryId, SpecEng, TranslationFr, CreationDate, ModificationDate, Validated)
select
	id, CategoryId, SpecEng, TranslationFr, CreationDate, ModificationDate, Validated
from
	[DB.PROD].datatail20130410.dbo.SpecTranslationDictionary


SET IDENTITY_INSERT DevTailbaseCore.dbo.SpecTranslationDictionary OFF


  