USE [MuOnline]
GO

/****** Object:  StoredProcedure [dbo].[PartyMatching_GetRequestList]    Script Date: 08/11/2014 00:31:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PartyMatching_GetRequestList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PartyMatching_GetRequestList]
GO

USE [MuOnline]
GO

/****** Object:  StoredProcedure [dbo].[PartyMatching_GetRequestList]    Script Date: 08/11/2014 00:31:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[PartyMatching_GetRequestList]
	@PartyLeader varchar(10)
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON

	DECLARE @RowCount int = 0
	DECLARE @MaxRequestDays int = 14
	
	SELECT @RowCount = COUNT(*) FROM PartyMatching_List WHERE PartyLeader = @PartyLeader	
	DELETE FROM PartyMatching_List WHERE DATEDIFF(day, Date, GETDATE()) > @MaxRequestDays
	
	BEGIN
		WITH RequestList AS
		(
			SELECT ROW_NUMBER() OVER (ORDER BY Date DESC) AS Row, Request.* FROM PartyMatching_List AS Request
		)		
		SELECT 			
			(SELECT Class FROM Character WHERE Name = RequestList.Name) as SenderClass,
			(SELECT cLevel FROM Character WHERE Name = RequestList.Name) as SenderLevel,
			RequestList.* FROM RequestList 
			WHERE PartyLeader = @PartyLeader AND Status = 1
			AND (SELECT cLevel FROM Character WHERE Name = RequestList.Name) IS NOT NULL
	END

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
END


GO

