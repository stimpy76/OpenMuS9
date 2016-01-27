USE [MuOnline]
GO

/****** Object:  StoredProcedure [dbo].[PartyMatching_GetList]    Script Date: 08/11/2014 00:31:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PartyMatching_GetList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PartyMatching_GetList]
GO

USE [MuOnline]
GO

/****** Object:  StoredProcedure [dbo].[PartyMatching_GetList]    Script Date: 08/11/2014 00:31:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[PartyMatching_GetList]
	@PageCount int output,
	@RequestPage int,
	@RequestType int,
	@RequestString varchar(10),
	@Level int,
	@Class int,
	@Gens int
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON

	DECLARE @RowCount INT = 0
	DECLARE @PageSize INT = 6
	DECLARE @SearchClass INT = 0

	IF @RequestType = 0
		SELECT @RowCount=COUNT(*) FROM PartyMatching_InfoData WHERE Status = 1
	ELSE IF @RequestType = 1
		SELECT @RowCount=COUNT(*) FROM PartyMatching_InfoData WHERE Description LIKE '%'+@RequestString+'%' AND Status = 1
	ELSE IF @RequestType = 2
	BEGIN
		IF @Class = 0
			SET @SearchClass=4
		ELSE IF @Class = 1
			SET @SearchClass=1
		ELSE IF @Class = 2
			SET @SearchClass=2
		ELSE IF @Class = 3
			SET @SearchClass=8
		ELSE IF @Class = 4
			SET @SearchClass=16
		ELSE IF @Class = 5
			SET @SearchClass=32
		ELSE IF @Class = 6
			SET @SearchClass=64

		SELECT @RowCount=COUNT(*) FROM PartyMatching_InfoData WHERE @Level >= MinLevel AND @Level <= MaxLevel AND (Class&@SearchClass)=@SearchClass AND Gens=@Gens AND Status = 1
	END

	IF (@RowCount%@PageSize) = 0
		SET @PageCount = @RowCount/@PageSize
	ELSE
		SET @PageCount = @RowCount/@PageSize + 1

	IF @RequestType = 0
	BEGIN
		WITH PartyList AS
		(
			SELECT ROW_NUMBER() OVER (ORDER BY RDate DESC) AS Row, party.* FROM PartyMatching_InfoData AS party
		)
		SELECT 
			(SELECT count(*) FROM PartyMatching_List WHERE PartyLeader = PartyList.PartyLeader AND Status = 2) as PartyCount,
			PartyList.ServerCode as LeaderChannel,
			(SELECT cLevel FROM Character WHERE Name = PartyList.PartyLeader) as LeaderLevel,
			(SELECT Class FROM Character WHERE Name = PartyList.PartyLeader) as LeaderClass,
				PartyList.* FROM PartyList WHERE Row BETWEEN (@RequestPage - 1) * @PageSize + 1 AND @RequestPage*@PageSize AND Status = 1
	END
	ELSE IF @RequestType = 1
	BEGIN
		WITH PartyList AS
		(
			SELECT ROW_NUMBER() OVER (ORDER BY RDate DESC) AS Row, party.* FROM PartyMatching_InfoData AS party WHERE Description LIKE '%'+@RequestString+'%'
		)
		SELECT 
			(SELECT count(*) FROM PartyMatching_List WHERE PartyLeader = PartyList.PartyLeader AND Status = 2) as PartyCount,
			PartyList.ServerCode as LeaderChannel,
			(SELECT cLevel FROM Character WHERE Name = PartyList.PartyLeader) as LeaderLevel,
			(SELECT Class FROM Character WHERE Name = PartyList.PartyLeader) as LeaderClass,
				PartyList.* FROM PartyList WHERE Row BETWEEN (@RequestPage - 1) * @PageSize + 1 AND @RequestPage*@PageSize AND Status = 1
	END
	ELSE IF @RequestType = 2
	BEGIN
		WITH PartyList AS
		(
			SELECT ROW_NUMBER() OVER (ORDER BY RDate DESC) AS Row, party.* FROM PartyMatching_InfoData AS party WHERE @Level >= MinLevel AND @Level <= MaxLevel AND (Class&@SearchClass)=@SearchClass AND Gens=@Gens
		)
		SELECT 
			(SELECT count(*) FROM PartyMatching_List WHERE PartyLeader = PartyList.PartyLeader AND Status = 2) as PartyCount,
			PartyList.ServerCode as LeaderChannel,
			(SELECT cLevel FROM Character WHERE Name = PartyList.PartyLeader) as LeaderLevel,
			(SELECT Class FROM Character WHERE Name = PartyList.PartyLeader) as LeaderClass,
				PartyList.* FROM PartyList WHERE Row BETWEEN (@RequestPage - 1) * @PageSize + 1 AND @RequestPage*@PageSize AND Status = 1
	END

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
END



GO

