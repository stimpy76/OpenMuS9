USE [MuOnline]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
CREATE  procedure [dbo].[ArcaBattleMemberSelect]  
 @CharName varchar(10)  
as         
BEGIN      
    
 DECLARE @return int    
 SET @return = 0      
         
 Set  nocount on    
      
IF NOT EXISTS ( SELECT CharName FROM ARCA_BATTLE_MEMBER_JOIN_INFO WITH ( READUNCOMMITTED )           
    WHERE CharName =  @CharName )      
  BEGIN 
 SET  @return = 11    
   END    
    
 SET XACT_ABORT OFF    
 Set nocount off    
     
 SELECT @return    
END





GO

