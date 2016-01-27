USE [MuOnline]
GO

/****** Object:  StoredProcedure [dbo].[PartyMatching_JoinRequest]    Script Date: 08/11/2014 00:31:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PartyMatching_JoinRequest]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PartyMatching_JoinRequest]
GO

USE [MuOnline]
GO

/****** Object:  StoredProcedure [dbo].[PartyMatching_JoinRequest]    Script Date: 08/11/2014 00:31:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[PartyMatching_JoinRequest]
	@RequestType int,
	@ServerCode int,
	@PartyLeader varchar(10),
	@Password varchar(4),
	@Name varchar(10),
	@Level int,
	@Class int,
	@Gens int
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @PartyPassword varchar(4) = 'NOT'
	DECLARE @RequestCount INT = 0
	DECLARE @ValidCount INT = 0

	IF @RequestType=2
		SELECT TOP 1 @PartyPassword=Password FROM PartyMatching_InfoData WHERE @Level >= MinLevel AND @Level <= MaxLevel AND Gens=@Gens
	ELSE
		SELECT @PartyPassword=Password FROM PartyMatching_InfoData WHERE PartyLeader=@PartyLeader AND @Level >= MinLevel AND @Level <= MaxLevel AND Gens=@Gens
	
	IF @PartyPassword='NOT'
	BEGIN
		IF @RequestType=2
			SELECT -3 AS RequestResult
		ELSE
			SELECT -2 AS RequestResult

		RETURN
	END
	
	IF @PartyPassword <> @Password
	BEGIN
		SELECT -1 AS RequestResult
		RETURN
	END

	IF EXISTS( SELECT * FROM PartyMatching_List WHERE Name = @Name )
	BEGIN
		SELECT -4 AS RequestResult
		RETURN
	END
	
	SELECT @RequestCount=count(*) FROM PartyMatching_List WHERE PartyLeader=@PartyLeader AND Status=1
	SELECT @ValidCount=count(*) FROM PartyMatching_List WHERE PartyLeader=@PartyLeader AND Status=2

	IF @RequestCount >= 5 OR @ValidCount >= 5
	BEGIN
		SELECT -7 AS RequestResult
		RETURN
	END

	IF @RequestType = 2
		INSERT INTO PartyMatching_List (PartyLeader,Name,Status,ServerCode, Date) 
			VALUES (@PartyLeader,@Name,@RequestType,@ServerCode, GETDATE())
	ELSE
		INSERT INTO PartyMatching_List (PartyLeader,Name,Status,ServerCode, Date) 
			VALUES (@PartyLeader,@Name,1,@ServerCode, GETDATE())

	SELECT 0 as RequestResult

	SET NOCOUNT OFF	
END



GO

