USE [MuOnline]
GO

/****** Object:  StoredProcedure [dbo].[PartyMatching_Waiting]    Script Date: 08/11/2014 00:32:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PartyMatching_Waiting]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PartyMatching_Waiting]
GO

USE [MuOnline]
GO

/****** Object:  StoredProcedure [dbo].[PartyMatching_Waiting]    Script Date: 08/11/2014 00:32:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[PartyMatching_Waiting]
	@Name varchar(10)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @PartyLeader varchar(10) = 'NOT'
	DECLARE @PartyChannel int = 0

	SELECT @PartyLeader=plist.PartyLeader,@PartyChannel=(SELECT ServerCode FROM PartyMatching_InfoData WHERE Name=plist.PartyLeader) FROM PartyMatching_List AS plist WHERE Name=@Name AND Status = 1

	IF @PartyLeader = 'NOT'
		SELECT -1 AS WaitResult, -1 as PartyLeader, -1 as PartyChannel
	ELSE
		SELECT 0 AS WaitResult, @PartyLeader as PartyLeader, @PartyChannel as PartyChannel

	SET NOCOUNT OFF	
END



GO

