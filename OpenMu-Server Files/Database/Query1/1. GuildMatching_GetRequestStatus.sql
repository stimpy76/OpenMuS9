USE [MuOnline]
GO

/****** Object:  StoredProcedure [dbo].[GuildMatching_GetRequestStatus]    Script Date: 08/11/2014 00:31:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GuildMatching_GetRequestStatus]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GuildMatching_GetRequestStatus]
GO

USE [MuOnline]
GO

/****** Object:  StoredProcedure [dbo].[GuildMatching_GetRequestStatus]    Script Date: 08/11/2014 00:31:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[GuildMatching_GetRequestStatus]
	@Sender varchar(10)
AS
BEGIN
	BEGIN TRANSACTION
	SET NOCOUNT ON
	
	DECLARE @RowCount int
	DECLARE @MASTER varchar(10)
	SET @RowCount = 0
	
	SELECT @RowCount = COUNT(*) FROM GuildMatching_RequestList WHERE Sender = @Sender
	SELECT @MASTER = G_Master FROM Guild WHERE G_Master = (SELECT Recipient FROM GuildMatching_RequestList WHERE Sender = @Sender)
	
	IF @RowCount > 1
		BEGIN
			SELECT 0 AS Result
			DELETE FROM GuildMatching_RequestList WHERE Sender = @Sender
		END
	ELSE IF @RowCount = 1
		BEGIN
			SELECT 
			(SELECT Recipient FROM GuildMatching_RequestList WHERE Sender = @Sender) as Recipient,
			(SELECT G_Name FROM Guild WHERE G_Master = @MASTER) as Guild,
			(SELECT Status FROM GuildMatching_RequestList WHERE Sender = @Sender) as Status,
			1 as Result
		END

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
END





GO

