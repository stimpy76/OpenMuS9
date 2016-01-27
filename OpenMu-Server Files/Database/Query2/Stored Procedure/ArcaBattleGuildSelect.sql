USE [MuOnline]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  procedure [dbo].[ArcaBattleGuildSelect]
 @CharName varchar(10)

as     
BEGIN  

 DECLARE @return int
 DECLARE @GuildNum int
 DECLARE @GuildGroupNum tinyint
 SET @return = 0  
     
 Set  nocount on

SELECT @GuildNum = Number FROM ARCA_BATTLE_GUILD_JOIN_INFO
set @GuildGroupNum = @@ROWCOUNT
IF( @GuildGroupNum >= 6 )
BEGIN
   SET  @return = 3
   GOTO EndProc
END

IF NOT EXISTS ( SELECT Number FROM ARCA_BATTLE_GUILD_JOIN_INFO WITH ( READUNCOMMITTED )       
    WHERE G_Master = @CharName )  
  BEGIN    
   
   goto EndProcTran
   END
ELSE
 BEGIN
   SET  @return = 4
   GOTO EndProc
 END

EndProcTran:
	IF ( @@Error  <> 0 )
	BEGIN	
		SET @return = -1
		SELECT @return
	END 
	ELSE
	BEGIN
		SELECT @return
	END

EndProc:

	SET	XACT_ABORT OFF
	Set	nocount off
	
	SELECT @return
END





GO

