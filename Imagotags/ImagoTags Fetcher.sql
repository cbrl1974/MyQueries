DECLARE @RC int
DECLARE @MerchantId int  =  1725;
DECLARE @LanguageId int = 1;

-- TODO: Set parameter values here.

EXECUTE @RC = [dbo].[Imagotags_DataFetcher] 
   @MerchantId
  ,@LanguageId
GO


