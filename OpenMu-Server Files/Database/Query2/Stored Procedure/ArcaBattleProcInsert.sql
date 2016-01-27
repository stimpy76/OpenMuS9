USE [MuOnline]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  procedure [dbo].[ArcaBattleProcInsert]
 @nProcState tinyint
as     
BEGIN  

 DECLARE @return int
 SET @return = 0  
 Set  nocount on

IF NOT EXISTS ( SELECT Proc_State FROM ARCA_BATTLE_PROC_STATE WITH ( READUNCOMMITTED ) )  
  BEGIN
   begin transaction      
  INSERT INTO ARCA_BATTLE_PROC_STATE (Proc_State) VALUES  ( @nProcState )
   END
ELSE
 begin transaction      
  UPDATE ARCA_BATTLE_PROC_STATE SET  Proc_State = @nProcState

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

