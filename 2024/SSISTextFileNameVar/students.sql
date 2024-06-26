USE [poc]
GO
/****** Object:  Table [dbo].[students]    Script Date: 4/8/2024 11:32:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[students](
	[student_id] [int] NOT NULL,
	[student_name] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[students] ([student_id], [student_name]) VALUES (1, N'Chan')
INSERT [dbo].[students] ([student_id], [student_name]) VALUES (2, N'Ming')
GO
