USE [MuOnline]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ArcaBattleGuildMemberSelect]
	@G_Number int
AS BEGIN
	DECLARE @ErrorCode int

	SET @ErrorCode = 0

	SET nocount on

	SET @ErrorCode = (select count (Number)  from ARCA_BATTLE_MEMBER_JOIN_INFO where Number = @G_Number)

	IF ( @@Error <> 0 ) BEGIN
		SET @ErrorCode = -1
	END

	SELECT @ErrorCode

	SET nocount off
END





GO

