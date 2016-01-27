USE [MuOnline]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure  [dbo].[ArcaBattleMarkRegDel]
 @G_Number int
as       
BEGIN  
 DECLARE @return int
 SET @return = 0  
 Set  nocount on

 begin transaction  

 delete dbo.ARCA_BATTLE_GUILDMARK_REG WHERE G_Number =  @G_Number

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
END





GO

