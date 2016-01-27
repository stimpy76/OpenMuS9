USE [MuOnline]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  procedure [dbo].[ArcaBattleGuildNamesSelect]
as         
BEGIN      
           
 Set  nocount on    

 SELECT G_Name FROM ARCA_BATTLE_GUILD_JOIN_INFO

 SET XACT_ABORT OFF    
 Set nocount off    
      
END





GO

