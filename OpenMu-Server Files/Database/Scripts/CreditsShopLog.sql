USE [MuOnline]
GO

/****** Object:  Table [dbo].[CreditsShopLog]    Script Date: 05/16/2015 07:46:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CreditsShopLog]') AND type in (N'U'))
DROP TABLE [dbo].[CreditsShopLog]
GO

USE [MuOnline]
GO

/****** Object:  Table [dbo].[CreditsShopLog]    Script Date: 05/16/2015 07:46:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[CreditsShopLog](
	[AccountName] [varchar](10) NOT NULL,
	[Price] [int] NOT NULL,
	[Date] [datetime] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

