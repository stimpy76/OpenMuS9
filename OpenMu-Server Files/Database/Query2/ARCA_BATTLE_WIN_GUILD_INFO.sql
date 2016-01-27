USE [MuOnline]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ARCA_BATTLE_WIN_GUILD_INFO](
	[G_Name] [varchar](8) NOT NULL,
	[G_Number] [int] NOT NULL,
	[WinDate] [smalldatetime] NOT NULL,
	[OuccupyObelisk] [tinyint] NOT NULL,
	[ObeliskGroup] [tinyint] NOT NULL,
	[LeftTime] [bigint] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

