USE [MuOnline]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[ArcaBattleTopRankSelect]
AS
	SELECT top 6 G_Name, MarkCnt FROM dbo.ARCA_BATTLE_GUILDMARK_REG ORDER BY MarkCnt DESC, GuildRegRank ASC





GO

