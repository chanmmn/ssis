USE [BankDb]
GO

/****** Object:  Table [dbo].[Account]    Script Date: 3/9/2024 8:38:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Account](
	[InternalRecordID] [int] NOT NULL,
	[PositionDate] [date] NOT NULL,
	[Status] [varchar](1) NULL,
	[InputDateTime] [datetime] NULL,
	[PositionID] [varchar](6) NULL,
	[GLCode] [varchar](3) NULL
) ON [PRIMARY]
GO


