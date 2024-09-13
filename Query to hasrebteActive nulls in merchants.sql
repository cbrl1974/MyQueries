DECLARE @RC int
DECLARE @MerchantId nvarchar(1000) = 3343
DECLARE @MixedList nvarchar(max)
DECLARE @Language int  = 1
DECLARE @TrackChanges bit
DECLARE @MaxTrackID bigint
DECLARE @OptionRecompile bit

-- TODO: Set parameter values here.

EXECUTE @RC = [dbo].[ElasticSearch_Update_Procedure] 
   @MerchantId
  ,@MixedList
  ,@Language
  ,@TrackChanges
  ,@MaxTrackID
  ,@OptionRecompile
GO



--Check if there any hasActiveRebate null
select m.id,  m.merchant, mp.productid, mp.hasactiverebate from merchantProds mp
inner join merchants m on m.id = mp.Merchant_ID
where mp.hasactiverebate is null


-- ****FIX by executing the storedProcedure

EXEC [dbo].[Maintain_HasActiveRebate_Bit] 
GO

--if doesn't work update manually
update top (142) merchantProds
set HasActiveRebate = 0
where merchant_id = 3343 
and productid in (815722,815968,816111,816134,816137,816138,816174,816184,816587,816593,818921,818922,818923,818924,818925,818926)


