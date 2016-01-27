USE [MuOnline]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE  procedure [dbo].[ArcaBattleGuildInsert]
 @GuildName varchar(8),      
 @CharName varchar(10),      
 @Number int
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
    WHERE Number =  @Number )  
  BEGIN 
   begin transaction      
  INSERT INTO ARCA_BATTLE_GUILD_JOIN_INFO (G_Name, G_Master, Number, JoinDate, GroupNum) VALUES      
   (  @GuildName, @CharName, @Number, GetDate(), @GuildGroupNum+1 )

  INSERT INTO ARCA_BATTLE_MEMBER_JOIN_INFO (G_Name, Number, CharName, JoinDate) VALUES      
   (  @GuildName, @Number, @CharName, GetDate() )
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
		rollback transaction
		SET @return = -1
		SELECT @return
	END 
	ELSE
	BEGIN
		commit transaction
		SELECT @return
	END

EndProc:

	SET	XACT_ABORT OFF
	Set	nocount off
	
	SELECT @return
END





GO

