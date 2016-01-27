USE [MuOnline]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  procedure [dbo].[ArcaBattleMemberUnderSelect]
 @GuildName varchar(8)
as         
BEGIN      
 
 Set  nocount on    

 SELECT count (*) FROM ARCA_BATTLE_MEMBER_JOIN_INFO WHERE G_Name = @GuildName

 SET XACT_ABORT OFF    
 Set nocount off    
      
END





GO

