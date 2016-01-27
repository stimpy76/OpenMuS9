USE [MuOnline]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

    
CREATE  procedure [dbo].[ArcaBattleWinGuildInsert]    
 @GuildName varchar(8),        
 @Number int,    
 @nOuccupyObelisk tinyint,    
 @nObeliskGroup tinyint,    
 @nLeftTime bigint    
    
as         
BEGIN      
         
 Set  nocount on    
    
 INSERT INTO ARCA_BATTLE_WIN_GUILD_INFO (G_Name, G_Number, WinDate, OuccupyObelisk, ObeliskGroup, LeftTime) VALUES         
   (@GuildName, @Number, GetDate(), @nOuccupyObelisk,@nObeliskGroup,  @nLeftTime)    
      
 Set nocount off      
    
END





GO

