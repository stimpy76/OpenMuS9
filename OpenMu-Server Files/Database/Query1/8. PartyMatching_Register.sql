USE [MuOnline]
GO

/****** Object:  StoredProcedure [dbo].[PartyMatching_Register]    Script Date: 08/11/2014 00:31:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PartyMatching_Register]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PartyMatching_Register]
GO

USE [MuOnline]
GO

/****** Object:  StoredProcedure [dbo].[PartyMatching_Register]    Script Date: 08/11/2014 00:31:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[PartyMatching_Register]
	@ServerCode int,
	@LeaderName	varchar(10),
	@Description varchar(40),
	@Password varchar(4),
	@MinLevel int,
	@MaxLevel int,
	@MoveReqId int,
	@Class int,
	@AutoAccept tinyint,
	@Gens tinyint
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON

	DECLARE @Status tinyint
	SET @Status = 0

	SELECT @Status = Status FROM PartyMatching_List WHERE Name = @LeaderName

	IF @Status = 1
	BEGIN 
		SELECT -2 as RegResult
	END
	ELSE
	BEGIN
	IF EXISTS( SELECT * FROM PartyMatching_InfoData WHERE PartyLeader = @LeaderName )
		UPDATE PartyMatching_InfoData SET 
			Description = @Description,
			Password = @Password,
			MinLevel = @MinLevel,
			MaxLevel = @MaxLevel,
			MoveReqId = @MoveReqId,
			Class = @Class,
			AutoAccept = @AutoAccept,
			Gens = @Gens,
			ServerCode = @ServerCode,
			Status = 1,
			RDate = GETDATE()
				WHERE PartyLeader = @LeaderName
	ELSE
		INSERT INTO PartyMatching_InfoData (PartyLeader,Description,Password,Class,MinLevel,MaxLevel,MoveReqId,AutoAccept,Gens, ServerCode, Status, RDate) 
			VALUES
				(@LeaderName,@Description,@Password,@Class,@MinLevel,@MaxLevel,@MoveReqId,@AutoAccept,@Gens, @ServerCode, 1, GETDATE())

	SELECT 0 AS RegResult
	END

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
END



GO

