USE [MuOnline]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  procedure [dbo].[ArcaBattleMarkCntSelect]
 @G_Number int
as     
BEGIN  

 DECLARE @return int
 DECLARE @GuildRegRank bigint

 SET @return = 0  
     
 Set  nocount on

IF NOT EXISTS ( SELECT G_Number FROM ARCA_BATTLE_GUILDMARK_REG WITH ( READUNCOMMITTED )       
    WHERE G_Number =  @G_Number)  
  BEGIN

	SET @GuildRegRank = (SELECT count (*) FROM ARCA_BATTLE_GUILDMARK_REG)
	IF( @GuildRegRank >= 250 )
	 BEGIN
	   SET  @return = -1
	   GOTO EndProc
	 END	  
   END
ELSE
  BEGIN
	set @return = (SELECT MarkCnt FROM ARCA_BATTLE_GUILDMARK_REG WHERE G_Number =  @G_Number)
  END

EndProc:
	SET	XACT_ABORT OFF
	Set	nocount off	
	select @return
	RETURN
END





GO

