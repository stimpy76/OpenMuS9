USE [MuOnline]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[ArcaBattleWinGuildSelect]    
as         
BEGIN      
      
 SELECT G_Name, OuccupyObelisk, ObeliskGroup FROM ARCA_BATTLE_WIN_GUILD_INFO
    
END





GO

