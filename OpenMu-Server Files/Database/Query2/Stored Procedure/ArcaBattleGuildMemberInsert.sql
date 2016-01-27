USE [MuOnline]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  procedure [dbo].[ArcaBattleGuildMemberInsert]
 @GuildName varchar(8),      
 @CharName varchar(10),      
 @Number int
as     
BEGIN  

 DECLARE @return int
 DECLARE @GuildNum int
 SET @return = 0  
     
 Set  nocount on

SELECT @GuildNum = Number FROM ARCA_BATTLE_GUILD_JOIN_INFO WHERE Number =  @Number
IF( @@ROWCOUNT  < 1 )
BEGIN
   SET  @return = 7
   GOTO EndProc
END

SELECT @GuildNum = Number FROM ARCA_BATTLE_MEMBER_JOIN_INFO WHERE Number =  @Number
IF( @@ROWCOUNT  >= 30 )
BEGIN
   SET  @return = 9
   GOTO EndProc
END

IF NOT EXISTS ( SELECT CharName FROM ARCA_BATTLE_MEMBER_JOIN_INFO WITH ( READUNCOMMITTED )       
    WHERE CharName =  @CharName )  
  BEGIN
   begin transaction 
  INSERT INTO ARCA_BATTLE_MEMBER_JOIN_INFO (G_Name, Number, CharName, JoinDate) VALUES      
   (  @GuildName, @Number, @CharName, GetDate() )
   goto EndProcTran
   END
ELSE
 BEGIN
   SET  @return = 8
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

