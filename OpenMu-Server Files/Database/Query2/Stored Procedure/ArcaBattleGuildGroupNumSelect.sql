USE [MuOnline]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  procedure [dbo].[ArcaBattleGuildGroupNumSelect]  
 @CharName varchar(10)
as         
BEGIN      
    
 DECLARE @GuildName varchar(8)
 DECLARE @return int    
 SET @return = 0      
         
 Set  nocount on    

set @GuildName = (SELECT G_Name FROM ARCA_BATTLE_MEMBER_JOIN_INFO where CharName = @CharName)

 SELECT GroupNum FROM ARCA_BATTLE_GUILD_JOIN_INFO
  WHERE G_Name =  @GuildName

 SET XACT_ABORT OFF    
 Set nocount off    
      
END





GO

