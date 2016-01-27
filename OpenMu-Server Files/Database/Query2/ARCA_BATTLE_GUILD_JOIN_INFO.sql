USE [MuOnline]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ARCA_BATTLE_GUILD_JOIN_INFO](
	[G_Name] [varchar](8) NOT NULL,
	[G_Master] [varchar](10) NOT NULL,
	[Number] [int] NOT NULL,
	[JoinDate] [smalldatetime] NULL,
	[GroupNum] [tinyint] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

