USE [MuOnline]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PartyMatching_InfoData_ServerCode]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PartyMatching_InfoData] DROP CONSTRAINT [DF_PartyMatching_InfoData_ServerCode]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PartyMatching_InfoData_Status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PartyMatching_InfoData] DROP CONSTRAINT [DF_PartyMatching_InfoData_Status]
END

GO

USE [MuOnline]
GO

/****** Object:  Table [dbo].[PartyMatching_InfoData]    Script Date: 08/11/2014 00:29:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PartyMatching_InfoData]') AND type in (N'U'))
DROP TABLE [dbo].[PartyMatching_InfoData]
GO

USE [MuOnline]
GO

/****** Object:  Table [dbo].[PartyMatching_InfoData]    Script Date: 08/11/2014 00:29:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[PartyMatching_InfoData](
	[PartyLeader] [varchar](10) NOT NULL,
	[Description] [varchar](40) NOT NULL,
	[Password] [varchar](4) NOT NULL,
	[Class] [int] NOT NULL,
	[MinLevel] [int] NOT NULL,
	[MaxLevel] [int] NOT NULL,
	[MoveReqId] [int] NOT NULL,
	[AutoAccept] [tinyint] NOT NULL,
	[Gens] [tinyint] NOT NULL,
	[ServerCode] [int] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[RDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PartyMatching_DATA] PRIMARY KEY CLUSTERED 
(
	[PartyLeader] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[PartyMatching_InfoData] ADD  CONSTRAINT [DF_PartyMatching_InfoData_ServerCode]  DEFAULT ((0)) FOR [ServerCode]
GO

ALTER TABLE [dbo].[PartyMatching_InfoData] ADD  CONSTRAINT [DF_PartyMatching_InfoData_Status]  DEFAULT ((0)) FOR [Status]
GO

