USE [master]
GO
/****** Object:  Database [ERPdb]    Script Date: 2014/11/8 22:30:18 ******/
CREATE DATABASE [ERPdb]
GO
ALTER DATABASE [ERPdb] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ERPdb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ERPdb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ERPdb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ERPdb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ERPdb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ERPdb] SET ARITHABORT OFF 
GO
ALTER DATABASE [ERPdb] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ERPdb] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ERPdb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ERPdb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ERPdb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ERPdb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ERPdb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ERPdb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ERPdb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ERPdb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ERPdb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ERPdb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ERPdb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ERPdb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ERPdb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ERPdb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ERPdb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ERPdb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ERPdb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ERPdb] SET  MULTI_USER 
GO
ALTER DATABASE [ERPdb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ERPdb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ERPdb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ERPdb] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [ERPdb]
GO
/****** Object:  Table [dbo].[branchTB]    Script Date: 2014/11/8 22:30:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[branchTB](
	[id] [int] IDENTITY(100,1) NOT NULL,
	[branchName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[departmentTB]    Script Date: 2014/11/8 22:30:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[departmentTB](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[branchid] [int] NOT NULL,
	[departmentName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[employeeTB]    Script Date: 2014/11/8 22:30:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[employeeTB](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[employeeName] [varchar](50) NOT NULL,
	[phoneNumber] [varchar](20) NOT NULL,
	[dateOfEntry] [date] NOT NULL,
	[userid] [int] NULL,
	[positionid] [int] NULL,
	[departmentid] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[jurisdictionTB]    Script Date: 2014/11/8 22:30:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[jurisdictionTB](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userid] [varchar](20) NULL,
	[limitsName] [varchar](50) NOT NULL,
	[moduleid] [int] NOT NULL,
	[isposition] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_jurisdictionTB] UNIQUE NONCLUSTERED 
(
	[userid] ASC,
	[moduleid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[moduleTB]    Script Date: 2014/11/8 22:30:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[moduleTB](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[moduleName] [varchar](100) NULL,
	[descb] [varchar](500) NOT NULL,
	[moduleid] [int] NOT NULL,
	[moduleGoup] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[moduleid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[positionTB]    Script Date: 2014/11/8 22:30:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[positionTB](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[positionName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[positionName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[usersTB]    Script Date: 2014/11/8 22:30:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[usersTB](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userid] [varchar](20) NOT NULL,
	[userpassword] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[userid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[jurisdictionTB] ADD  DEFAULT ('false') FOR [isposition]
GO
ALTER TABLE [dbo].[departmentTB]  WITH CHECK ADD FOREIGN KEY([branchid])
REFERENCES [dbo].[branchTB] ([id])
GO
ALTER TABLE [dbo].[employeeTB]  WITH CHECK ADD FOREIGN KEY([departmentid])
REFERENCES [dbo].[departmentTB] ([id])
GO
ALTER TABLE [dbo].[employeeTB]  WITH CHECK ADD FOREIGN KEY([positionid])
REFERENCES [dbo].[positionTB] ([id])
GO
ALTER TABLE [dbo].[employeeTB]  WITH CHECK ADD FOREIGN KEY([userid])
REFERENCES [dbo].[usersTB] ([id])
GO
ALTER TABLE [dbo].[jurisdictionTB]  WITH CHECK ADD FOREIGN KEY([moduleid])
REFERENCES [dbo].[moduleTB] ([moduleid])
GO
ALTER TABLE [dbo].[jurisdictionTB]  WITH CHECK ADD FOREIGN KEY([userid])
REFERENCES [dbo].[usersTB] ([userid])
GO
ALTER TABLE [dbo].[employeeTB]  WITH CHECK ADD CHECK  (([phoneNumber] like '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' OR NOT [phoneNumber] like '%[^0-9]%' AND len([phoneNumber])=(13)))
GO
USE [ERPdb]

insert into usersTB values('1','3d4f2bf07dc1be38b20cd6e46949a1071f9d0e3d')
insert into moduleTB values('添加员工','添加员工模块',1002,'100')
insert into jurisdictionTB values('1','超级管理','1002','false')