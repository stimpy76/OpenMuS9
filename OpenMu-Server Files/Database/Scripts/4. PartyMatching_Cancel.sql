USE [MuOnline]
GO

/****** Object:  StoredProcedure [dbo].[PartyMatching_Cancel]    Script Date: 08/11/2014 00:31:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PartyMatching_Cancel]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PartyMatching_Cancel]
GO

USE [MuOnline]
GO

/****** Object:  StoredProcedure [dbo].[PartyMatching_Cancel]    Script Date: 08/11/2014 00:31:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[PartyMatching_Cancel]
	@Name varchar(10),
	@Type int
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @PartyLeader varchar(10) = 'NOT'
	DECLARE @Result INT = 0

	IF @Type = 1
	BEGIN
		SELECT @PartyLeader=PartyLeader FROM PartyMatching_List WHERE Name=@Name AND Status = 1

		IF @PartyLeader='NOT'
		BEGIN
			SELECT -1 AS CancelResult
			RETURN
		END

		IF NOT EXISTS( SELECT * FROM PartyMatching_InfoData WHERE PartyLeader=@PartyLeader )
		BEGIN
			SET @Result = 1
		END

		DELETE FROM PartyMatching_List WHERE Name=@Name AND Status=1 
		SELECT @Result AS CancelResult
	END
	ELSE IF @Type = 0
	BEGIN
		IF NOT EXISTS( SELECT * FROM PartyMatching_InfoData WHERE PartyLeader=@Name )
		BEGIN
			SET @Result = 1
		END

		DELETE FROM PartyMatching_InfoData WHERE PartyLeader=@Name
		SELECT @Result AS CancelResult
	END

	SET NOCOUNT OFF	
END



GO

