USE [MuOnline]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[ArcaBattleMarkRankSelect]
	@G_Number		INT
AS
    SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @return int
	DECLARE @GuildRegRank int

	SET @return = 0  
	SET @GuildRegRank = 0
	 
	IF NOT EXISTS ( SELECT G_Number FROM dbo.ARCA_BATTLE_GUILDMARK_REG WHERE G_Number =  @G_Number)  
	BEGIN
		SELECT @return, @GuildRegRank
		RETURN
	END

	DECLARE @Tbl_Rank TABLE 
	(
		mRank		INT IDENTITY(1,1) primary key,
		G_Number	INT,
		mMarkCnt	BIGINT
	)
	
	INSERT INTO @Tbl_Rank (G_Number, mMarkCnt) 
	SELECT G_Number, MarkCnt FROM dbo.ARCA_BATTLE_GUILDMARK_REG ORDER BY MarkCnt DESC, GuildRegRank ASC
	
	SELECT mRank, mMarkCnt  FROM @Tbl_Rank WHERE G_Number = @G_Number
	
	
	RETURN





GO

