USE [MuOnline]
GO

/****** Object:  Table [dbo].[PartyMatching_List]    Script Date: 08/11/2014 00:30:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PartyMatching_List]') AND type in (N'U'))
DROP TABLE [dbo].[PartyMatching_List]
GO

USE [MuOnline]
GO

/****** Object:  Table [dbo].[PartyMatching_List]    Script Date: 08/11/2014 00:30:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[PartyMatching_List](
	[PartyLeader] [varchar](10) NOT NULL,
	[Name] [varchar](10) NOT NULL,
	[Status] [tinyint] NOT NULL,
	[ServerCode] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
 CONSTRAINT [PK_PartyMatching_LIST] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

