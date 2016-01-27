USE [MuOnline]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  procedure [dbo].[ArcaBattleMarkInsert]
 @G_Name varchar(8),      
 @G_Number int,
 @G_Master varchar(10),      
 @MarkCnt bigint
as     
BEGIN  

 DECLARE @return int
 DECLARE @GuildRegRank int
 DECLARE @CurrMarkCnt int

 SET @return = 0  
     
 Set  nocount on


IF NOT EXISTS ( SELECT G_Number FROM ARCA_BATTLE_GUILDMARK_REG WITH ( READUNCOMMITTED )       
    WHERE G_Number =  @G_Number )  
  BEGIN

	SET @GuildRegRank = (SELECT count (*) FROM ARCA_BATTLE_GUILDMARK_REG)
	IF( @GuildRegRank >= 250 )
	BEGIN
	   SET  @return = 3
	   GOTO EndProc
	END

   begin transaction      
  INSERT INTO ARCA_BATTLE_GUILDMARK_REG (G_Name, G_Number, G_Master, RegDate, GuildRegRank, MarkCnt ) VALUES      
   (  @G_Name, @G_Number, @G_Master, GetDate(), (@GuildRegRank+1), @MarkCnt )
   goto EndProcTran

   END
ELSE
 BEGIN
	SET @CurrMarkCnt  = (SELECT MarkCnt from ARCA_BATTLE_GUILDMARK_REG WHERE G_Number = @G_Number AND G_Name = @G_Name)
	 begin transaction
	 UPDATE ARCA_BATTLE_GUILDMARK_REG SET MarkCnt = (@MarkCnt + @CurrMarkCnt)  WHERE G_Number = @G_Number AND G_Name = @G_Name
	 SET @return = 1
	goto EndProcTran
 END

EndProcTran:
	IF ( @@Error  <> 0 )
	BEGIN	
		rollback transaction
		SET @return = -1
		select @return
	END 
	ELSE
	BEGIN
		commit transaction
		select @return
	END
	RETURN

EndProc:
	SET	XACT_ABORT OFF
	Set	nocount off	
	select @return
	RETURN
END





GO

