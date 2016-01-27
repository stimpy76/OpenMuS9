USE [MuOnline]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ArcaBattleGuildMarkInfoAllDel]

AS BEGIN
	DECLARE @ErrorCode int

	SET @ErrorCode = 0

	SET nocount on

	DELETE dbo.ARCA_BATTLE_GUILDMARK_REG

	IF ( @@Error <> 0 ) BEGIN
		SET @ErrorCode = -1
	END

	SELECT @ErrorCode

	SET nocount off
END





GO

