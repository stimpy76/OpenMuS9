USE [MuOnline]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  procedure [dbo].[ArcaBattleMinGuildSelect]
 @G_Name varchar(8),
 @nMinGuildMemCnt int
as     
BEGIN

 DECLARE @return int
 DECLARE @GuildNum int
 DECLARE @GuildMemCnt int
 SET @return = -1       

 Set  nocount on

 SELECT @GuildNum = Number FROM ARCA_BATTLE_MEMBER_JOIN_INFO WHERE G_Name = @G_Name
 SET @GuildMemCnt = @@ROWCOUNT
 IF( @GuildMemCnt < @nMinGuildMemCnt )
 BEGIN
   SELECT @return
 END
ELSE
 BEGIN
   SELECT @GuildNum
 END
END





GO

