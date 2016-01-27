USE [MuOnline]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ARCA_BATTLE_GUILDMARK_REG](
	[Index] [int] IDENTITY(1,1) NOT NULL,
	[G_Number] [int] NOT NULL,
	[G_Name] [varchar](8) NOT NULL,
	[G_Master] [varchar](10) NOT NULL,
	[RegDate] [smalldatetime] NULL,
	[GuildRegRank] [int] NULL,
	[MarkCnt] [bigint] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

