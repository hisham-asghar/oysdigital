USE [master]
GO
/****** Object:  Database [oysdigital]    Script Date: 6/29/2020 5:38:03 PM ******/
CREATE DATABASE [oysdigital]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'oysdigital', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\oysdigital.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'oysdigital_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\oysdigital_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [oysdigital] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [oysdigital].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [oysdigital] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [oysdigital] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [oysdigital] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [oysdigital] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [oysdigital] SET ARITHABORT OFF 
GO
ALTER DATABASE [oysdigital] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [oysdigital] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [oysdigital] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [oysdigital] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [oysdigital] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [oysdigital] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [oysdigital] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [oysdigital] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [oysdigital] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [oysdigital] SET  DISABLE_BROKER 
GO
ALTER DATABASE [oysdigital] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [oysdigital] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [oysdigital] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [oysdigital] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [oysdigital] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [oysdigital] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [oysdigital] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [oysdigital] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [oysdigital] SET  MULTI_USER 
GO
ALTER DATABASE [oysdigital] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [oysdigital] SET DB_CHAINING OFF 
GO
ALTER DATABASE [oysdigital] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [oysdigital] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [oysdigital] SET DELAYED_DURABILITY = DISABLED 
GO
USE [oysdigital]
GO
/****** Object:  UserDefinedFunction [dbo].[SplitString]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[SplitString] ( @stringToSplit VARCHAR(MAX) )
RETURNS
 @returnList TABLE ([Name] [nvarchar] (500))
AS
BEGIN

 DECLARE @name NVARCHAR(255)
 DECLARE @pos INT

 WHILE CHARINDEX(',', @stringToSplit) > 0
 BEGIN
  SELECT @pos  = CHARINDEX(',', @stringToSplit)  
  SELECT @name = SUBSTRING(@stringToSplit, 1, @pos-1)

  INSERT INTO @returnList 
  SELECT @name

  SELECT @stringToSplit = SUBSTRING(@stringToSplit, @pos+1, LEN(@stringToSplit)-@pos)
 END

 INSERT INTO @returnList
 SELECT @stringToSplit

 RETURN
END

GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[Name] [nvarchar](256) NULL,
	[ProfilePic] [nvarchar](256) NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customer]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Guid] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[Address] [nvarchar](max) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NOT NULL,
	[OnModified] [datetime2](7) NOT NULL,
	[Name] [nvarchar](max) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LabelType]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LabelType](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NOT NULL,
	[OnModified] [datetime2](7) NOT NULL,
	[ColorCode] [nvarchar](max) NULL,
 CONSTRAINT [PK_LabelType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Mobile]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mobile](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NOT NULL,
	[OnModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Mobile] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MobileSpaces]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MobileSpaces](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[MobileId] [bigint] NOT NULL,
	[Name] [nvarchar](max) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NOT NULL,
	[OnModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_MobileSpaces] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Platform]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Platform](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[IconClass] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[IsActive] [bit] NOT NULL DEFAULT ((0)),
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NOT NULL DEFAULT ('0001-01-01T00:00:00.0000000'),
	[OnModified] [datetime2](7) NOT NULL DEFAULT ('0001-01-01T00:00:00.0000000'),
 CONSTRAINT [PK_Platforms] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Project]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Project](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Guid] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NULL,
	[CustomerId] [bigint] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NOT NULL,
	[OnModified] [datetime2](7) NOT NULL,
	[MobileSpaceId] [bigint] NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectAlertMessage]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectAlertMessage](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Message] [nvarchar](max) NULL,
	[LabelTypeId] [int] NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NOT NULL,
	[OnModified] [datetime2](7) NOT NULL,
	[IsActive] [bit] NULL,
	[ProjectId] [bigint] NULL,
	[AlertTypeId] [int] NULL,
 CONSTRAINT [PK_projectAlertMessages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectMembers]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectMembers](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ProjectMemberTypeId] [bigint] NOT NULL,
	[ProjectId] [bigint] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NOT NULL,
	[OnModified] [datetime2](7) NOT NULL,
	[AspNetUserId] [nvarchar](max) NULL,
 CONSTRAINT [PK_projectMembers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectMemberTypes]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectMemberTypes](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NOT NULL,
	[OnModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_projectMemberTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectNotes]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectNotes](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Message] [nvarchar](max) NULL,
	[LabelTypeId] [int] NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NOT NULL,
	[OnModified] [datetime2](7) NOT NULL,
	[IsActive] [bit] NULL,
	[AccessLevelTypeId] [int] NULL,
	[ProjectId] [bigint] NULL,
 CONSTRAINT [PK_projectNotes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectPlatforms]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectPlatforms](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Link] [nvarchar](max) NULL,
	[ProjectId] [bigint] NOT NULL,
	[PlatformId] [bigint] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NOT NULL,
	[OnModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_projectPlatforms] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectTask]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectTask](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ProjectId] [bigint] NOT NULL,
	[TaskTypeId] [int] NULL,
	[Frequency] [int] NULL,
	[FrequencyTypeId] [int] NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NOT NULL,
	[OnModified] [datetime2](7) NOT NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_ProjectTask] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectTaskScheduling]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectTaskScheduling](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ProjectTaskId] [bigint] NULL,
	[Time] [datetime2](7) NULL,
 CONSTRAINT [PK_ProjectTaskScheduling] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WorkTask]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkTask](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ProjectId] [bigint] NOT NULL,
	[ProjectSchedulingTime] [datetime2](7) NULL,
	[IsCompleted] [bit] NULL,
	[IsDesigned] [bit] NULL,
	[IsScheduled] [bit] NULL,
	[OnReported] [datetime2](7) NULL,
	[IsReported] [bit] NULL,
	[ReportedBy] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NULL CONSTRAINT [DF_WorkTask_OnCreated]  DEFAULT ('0001-01-01T00:00:00.0000000'),
	[OnModified] [datetime2](7) NULL CONSTRAINT [DF_WorkTask_OnModified]  DEFAULT ('0001-01-01T00:00:00.0000000'),
 CONSTRAINT [PK_WorkTask] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WorkTaskMembers]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkTaskMembers](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[AspNetUserId] [nvarchar](max) NOT NULL,
	[MemberTypeId] [bigint] NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NOT NULL,
	[OnModified] [datetime2](7) NOT NULL,
	[WorkTaskId] [bigint] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WorkTaskPlatforms]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkTaskPlatforms](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[PlatformId] [bigint] NULL,
	[WorkTaskId] [bigint] NULL,
	[IsCompleted] [bit] NULL,
	[IsDesigned] [bit] NULL,
	[IsScheduled] [bit] NULL,
	[Status] [bit] NULL,
	[Link] [nvarchar](max) NULL,
 CONSTRAINT [PK_WorkTaskPlatforms] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  View [dbo].[WorkTaskMembersView]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[WorkTaskMembersView] AS 
SELECT [dbo].[WorkTaskMembers].WorkTaskId
      ,dbo.ProjectMemberTypes.Id MemberTypeId
      ,dbo.ProjectMemberTypes.Name MemberType,
	  [dbo].[WorkTaskMembers].AspNetUserId UserId
  FROM [dbo].[WorkTaskMembers] INNER JOIN dbo.ProjectMemberTypes ON dbo.WorkTaskMembers.MemberTypeId = dbo.ProjectMemberTypes.Id
UNION ALL
SELECT dbo.WorkTask.Id WorkTaskId,Member.Id MemberTypeId,Member.Name MemberType,AdminUser.AspNetUserId 
FROM dbo.WorkTask CROSS JOIN
	(SELECT Id,Name FROM dbo.ProjectMemberTypes WHERE Name like 'Manager') Member 
	CROSS JOIN
	(SELECT distinct UserId AspNetUserId 
	FROM dbo.AspNetUserRoles 
	WHERE RoleId IN (SELECT Id FROM dbo.AspNetRoles WHERE NormalizedName IN ('ADMIN','HR'))) AdminUser



GO
/****** Object:  View [dbo].[UserTaskView]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[UserTaskView] AS
SELECT *--COUNT(*) OverallTask, SUM(CASE WHEN(MemberType = 'Designer') THEN CAST(IsDesigned AS INT) ELSE CASE WHEN(MemberType = 'Scheduler') THEN CAST(IsScheduled AS INT) ELSE 0 END END)
FROM 
(SELECT dbo.WorkTask.IsCompleted,
        dbo.WorkTask.IsDesigned,
        dbo.WorkTask.IsReported,
        dbo.WorkTask.IsScheduled,
        dbo.WorkTask.ProjectId,
        dbo.WorkTask.ProjectSchedulingTime,
        WorkTaskId,
        MemberType,
        AspNetUserId,
        ProjectMemberTypeId
 FROM dbo.WorkTask
          INNER JOIN (
		  SELECT dbo.WorkTaskMembersView.WorkTaskId,
       dbo.ProjectMemberTypes.Name,
       ProjectMemberTypes.Id   as ProjectMemberTypeId,
       ProjectMemberTypes.Name as MemberType,
       dbo.WorkTaskMembersView.UserId AspNetUserId
FROM dbo.WorkTaskMembersView
         INNER JOIN dbo.ProjectMemberTypes
                    ON dbo.ProjectMemberTypes.Id = dbo.WorkTaskMembersView.MemberTypeId
 ) WorkTaskMembers
                     ON dbo.WorkTask.Id = WorkTaskMembers.WorkTaskId
)
 Statistic

GO
/****** Object:  View [dbo].[WorkTaskView]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[WorkTaskView] AS





SELECT dbo.WorkTask.*,dbo.Project.Name AS ProjectName, WTMV_Designer.Name DesignerName, WTMV_Scheduler.Name SchedulerName
FROM dbo.WorkTask INNER JOIN dbo.Project ON Project.Id = WorkTask.ProjectId
LEFT OUTER JOIN (SELECT * FROM dbo.WorkTaskMembersView INNER JOIN dbo.AspNetUsers ON dbo.WorkTaskMembersView.UserId = dbo.AspNetUsers.Id) WTMV_Designer
	ON dbo.WorkTask.Id = WTMV_Designer.WorkTaskId AND WTMV_Designer.MemberType like 'Designer'
LEFT OUTER JOIN (SELECT * FROM dbo.WorkTaskMembersView INNER JOIN dbo.AspNetUsers ON dbo.WorkTaskMembersView.UserId = dbo.AspNetUsers.Id) WTMV_Scheduler
	ON dbo.WorkTask.Id = WTMV_Scheduler.WorkTaskId AND WTMV_Scheduler.MemberType like 'Scheduler'

GO
/****** Object:  View [dbo].[UserRoleView]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[UserRoleView] AS
SELECT	dbo.AspNetUsers.Id,
		dbo.AspNetUsers.Name,
		dbo.AspNetUsers.UserName,
		dbo.AspNetUsers.NormalizedUserName,
		dbo.AspNetUsers.Email,
		dbo.AspNetUsers.NormalizedEmail,
		UserRole.RoleId,
		UserRole.RoleName,
		UserRole.NormalizedRoleName
FROM dbo.AspNetUsers LEFT OUTER JOIN (
	SELECT 
		dbo.AspNetUserRoles.UserId,
		dbo.AspNetRoles.Id AS RoleId,
		dbo.AspNetRoles.Name AS RoleName,
		dbo.AspNetRoles.NormalizedName AS NormalizedRoleName
		FROM dbo.AspNetUserRoles
	INNER JOIN dbo.AspNetRoles ON dbo.AspNetRoles.Id = dbo.AspNetUserRoles.RoleId) UserRole
	ON UserRole.UserId = dbo.AspNetUsers.Id

GO
/****** Object:  View [dbo].[WorkTaskPlatformsView]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[WorkTaskPlatformsView] AS
SELECT WorkTaskPlatforms.*, [Platform].Name AS PlatformName, dbo.[Platform].IconClass AS PlatformIcon 
FROM dbo.WorkTaskPlatforms INNER JOIN dbo.[Platform] 
		ON dbo.[Platform].Id = dbo.WorkTaskPlatforms.PlatformId


GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AspNetRoleClaims_RoleId]    Script Date: 6/29/2020 5:38:03 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetRoleClaims_RoleId] ON [dbo].[AspNetRoleClaims]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [RoleNameIndex]    Script Date: 6/29/2020 5:38:03 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AspNetUserClaims_UserId]    Script Date: 6/29/2020 5:38:03 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserClaims_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AspNetUserLogins_UserId]    Script Date: 6/29/2020 5:38:03 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserLogins_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AspNetUserRoles_RoleId]    Script Date: 6/29/2020 5:38:03 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserRoles_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [EmailIndex]    Script Date: 6/29/2020 5:38:03 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 6/29/2020 5:38:03 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_MobileSpaces_MobileId]    Script Date: 6/29/2020 5:38:03 PM ******/
CREATE NONCLUSTERED INDEX [IX_MobileSpaces_MobileId] ON [dbo].[MobileSpaces]
(
	[MobileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Project_CustomerId]    Script Date: 6/29/2020 5:38:03 PM ******/
CREATE NONCLUSTERED INDEX [IX_Project_CustomerId] ON [dbo].[Project]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_projectMembers_ProjectId]    Script Date: 6/29/2020 5:38:03 PM ******/
CREATE NONCLUSTERED INDEX [IX_projectMembers_ProjectId] ON [dbo].[ProjectMembers]
(
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_projectMembers_ProjectMemberTypesId]    Script Date: 6/29/2020 5:38:03 PM ******/
CREATE NONCLUSTERED INDEX [IX_projectMembers_ProjectMemberTypesId] ON [dbo].[ProjectMembers]
(
	[ProjectMemberTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_projectPlatforms_PlatformId]    Script Date: 6/29/2020 5:38:03 PM ******/
CREATE NONCLUSTERED INDEX [IX_projectPlatforms_PlatformId] ON [dbo].[ProjectPlatforms]
(
	[PlatformId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_projectPlatforms_ProjectId]    Script Date: 6/29/2020 5:38:03 PM ******/
CREATE NONCLUSTERED INDEX [IX_projectPlatforms_ProjectId] ON [dbo].[ProjectPlatforms]
(
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[MobileSpaces]  WITH CHECK ADD  CONSTRAINT [FK_MobileSpaces_Mobile_MobileId] FOREIGN KEY([MobileId])
REFERENCES [dbo].[Mobile] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MobileSpaces] CHECK CONSTRAINT [FK_MobileSpaces_Mobile_MobileId]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_Project_Customer_CustomerId]
GO
ALTER TABLE [dbo].[ProjectMembers]  WITH CHECK ADD  CONSTRAINT [FK_projectMembers_Project_ProjectId] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProjectMembers] CHECK CONSTRAINT [FK_projectMembers_Project_ProjectId]
GO
ALTER TABLE [dbo].[ProjectMembers]  WITH CHECK ADD  CONSTRAINT [FK_projectMembers_projectMemberTypes_ProjectMemberTypesId] FOREIGN KEY([ProjectMemberTypeId])
REFERENCES [dbo].[ProjectMemberTypes] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProjectMembers] CHECK CONSTRAINT [FK_projectMembers_projectMemberTypes_ProjectMemberTypesId]
GO
ALTER TABLE [dbo].[ProjectPlatforms]  WITH CHECK ADD  CONSTRAINT [FK_projectPlatforms_Platforms_PlatformId] FOREIGN KEY([PlatformId])
REFERENCES [dbo].[Platform] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProjectPlatforms] CHECK CONSTRAINT [FK_projectPlatforms_Platforms_PlatformId]
GO
ALTER TABLE [dbo].[ProjectPlatforms]  WITH CHECK ADD  CONSTRAINT [FK_projectPlatforms_Project_ProjectId] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProjectPlatforms] CHECK CONSTRAINT [FK_projectPlatforms_Project_ProjectId]
GO
ALTER TABLE [dbo].[ProjectTask]  WITH CHECK ADD  CONSTRAINT [FK_ProjectTask_ProjectTask] FOREIGN KEY([Id])
REFERENCES [dbo].[ProjectTask] ([Id])
GO
ALTER TABLE [dbo].[ProjectTask] CHECK CONSTRAINT [FK_ProjectTask_ProjectTask]
GO
/****** Object:  StoredProcedure [dbo].[GetGenerateableTaskMembers]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Hisham Asghar
-- Create date: 06-05-2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetGenerateableTaskMembers] 
	-- Add the parameters for the stored procedure here
	@date NVARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	
SELECT UnCreatedTaskMembers.*
	FROM (SELECT distinct WorkTasks.Id WorkTaskId,dbo.ProjectMembers.ProjectId,dbo.ProjectMembers.ProjectMemberTypeId MemberTypeId,
	dbo.ProjectMembers.AspNetUserId FROM 
	dbo.ProjectMembers INNER JOIN (SELECT Id,ProjectId FROM dbo.WorkTask
	WHERE CONVERT(VARCHAR(10),ProjectSchedulingTime, 110) = @date) WorkTasks
	 ON dbo.ProjectMembers.ProjectId = WorkTasks.ProjectId) UnCreatedTaskMembers
	 LEFT OUTER JOIN dbo.WorkTaskMembers 
		ON UnCreatedTaskMembers.WorkTaskId = dbo.WorkTaskMembers.WorkTaskId
		AND UnCreatedTaskMembers.MemberTypeId = dbo.WorkTaskMembers.MemberTypeId
		WHERE dbo.WorkTaskMembers.Id IS NULL


END

GO
/****** Object:  StoredProcedure [dbo].[GetGenerateableTaskPlatforms]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Hisham Asghar
-- Create date: 06-05-2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetGenerateableTaskPlatforms] 
	-- Add the parameters for the stored procedure here
	@date NVARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT UnCreatedTaskPlatforms.*
FROM (
SELECT dbo.ProjectPlatforms.PlatformId,dbo.ProjectPlatforms.Link,WorkTasks.WorkTaskId FROM 
dbo.ProjectPlatforms INNER JOIN (SELECT Id WorkTaskId,ProjectId FROM dbo.WorkTask
WHERE CONVERT(VARCHAR(10),ProjectSchedulingTime, 110) = @date) WorkTasks
 ON dbo.ProjectPlatforms.ProjectId = WorkTasks.ProjectId) UnCreatedTaskPlatforms
 LEFT OUTER JOIN dbo.WorkTaskPlatforms 
	ON UnCreatedTaskPlatforms.WorkTaskId = dbo.WorkTaskPlatforms.WorkTaskId
	AND UnCreatedTaskPlatforms.PlatformId = dbo.WorkTaskPlatforms.PlatformId

	WHERE dbo.WorkTaskPlatforms.Id IS NULL

END

GO
/****** Object:  StoredProcedure [dbo].[GetGenerateableTasks]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Hisham Asghar
-- Create date: 06-01-2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetGenerateableTasks] 
	-- Add the parameters for the stored procedure here
	@date NVARCHAR(MAX),
	@userId NVARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT TaskView.ProjectId,[Time] ProjectSchedulingTime
FROM (SELECT [dbo].ProjectTaskScheduling.Id, ProjectId,CAST(@date + ' ' + CONVERT(VARCHAR(10), [Time], 108) AS datetime) Time
FROM [dbo].ProjectTaskScheduling 
	INNER JOIN dbo.ProjectTask ON dbo.ProjectTaskScheduling.ProjectTaskId = dbo.ProjectTask.Id) TaskView
LEFT OUTER JOIN (
	(SELECT ProjectId,ProjectSchedulingTime  FROM dbo.WorkTask
	WHERE CONVERT(VARCHAR(10),ProjectSchedulingTime, 110) = @date)) WorkTasks
	ON TaskView.ProjectId = WorkTasks.ProjectId AND 
	CONVERT(VARCHAR(10), TaskView.[Time], 108) =  CONVERT(VARCHAR(10), WorkTasks.ProjectSchedulingTime, 108) AND 
	CONVERT(VARCHAR(10), TaskView.[Time], 110) =  CONVERT(VARCHAR(10), WorkTasks.ProjectSchedulingTime, 110)
	WHERE WorkTasks.ProjectId IS NULL AND (TaskView.ProjectId IN (
SELECT ProjectId FROM dbo.ProjectMembers
WHERE AspNetUserId = @userId) OR @userId IN (SELECT [Id] FROM [dbo].[UserRoleView] WHERE [NormalizedRoleName] IN ('ADMIN','HR')))
END

GO
/****** Object:  StoredProcedure [dbo].[GetGenerateableTasksCount]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Hisham Asghar
-- Create date: 06-01-2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetGenerateableTasksCount] 
	-- Add the parameters for the stored procedure here
	@dates NVARCHAR(MAX),
	@userId NVARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT Dates.CurrentDate as [Date],
(SELECT Count(*)
FROM (SELECT [dbo].ProjectTaskScheduling.Id, ProjectId,CAST(Dates.CurrentDate + ' ' + CONVERT(VARCHAR(10), [Time], 108) AS datetime) Time
FROM [dbo].ProjectTaskScheduling 
	INNER JOIN dbo.ProjectTask ON dbo.ProjectTaskScheduling.ProjectTaskId = dbo.ProjectTask.Id) TaskView
LEFT OUTER JOIN (
	(SELECT ProjectId,ProjectSchedulingTime  FROM dbo.WorkTask
	WHERE CONVERT(VARCHAR(10),ProjectSchedulingTime, 110) = Dates.CurrentDate)) WorkTasks
	ON TaskView.ProjectId = WorkTasks.ProjectId AND 
	CONVERT(VARCHAR(10), TaskView.[Time], 108) =  CONVERT(VARCHAR(10), WorkTasks.ProjectSchedulingTime, 108) AND 
	CONVERT(VARCHAR(10), TaskView.[Time], 110) =  CONVERT(VARCHAR(10), WorkTasks.ProjectSchedulingTime, 110)
	WHERE WorkTasks.ProjectId IS NULL AND (TaskView.ProjectId IN (
SELECT ProjectId FROM dbo.ProjectMembers
WHERE AspNetUserId = @userId) OR @userId IN (SELECT [Id] FROM [dbo].[UserRoleView] WHERE [NormalizedRoleName] IN ('ADMIN','HR')))) TaskCount
FROM (SELECT Name as CurrentDate FROM dbo.SplitString(@dates)) Dates

END

GO
/****** Object:  StoredProcedure [dbo].[MarkDesignDone]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Hisham Asghar
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[MarkDesignDone] 
	-- Add the parameters for the stored procedure here
	@projectId int = 0, 
	@userId nvarchar(MAX) = NULL, 
	@date nvarchar(MAX) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE dbo.WorkTask
	SET IsDesigned = 1
	WHERE dbo.WorkTask.Id IN (SELECT Id
	FROM dbo.WorkTask 
	WHERE ProjectId = @projectId AND 
	Id IN (SELECT WorkTaskId FROM dbo.WorkTaskMembersView WHERE UserId = @userId)
	AND CONVERT(VARCHAR(10),ProjectSchedulingTime, 110) = @date)

	UPDATE dbo.WorkTaskPlatforms
	SET IsDesigned = 1
	WHERE dbo.WorkTaskPlatforms.WorkTaskId IN (SELECT Id
	FROM dbo.WorkTask 
	WHERE ProjectId = @projectId AND 
	Id IN (SELECT WorkTaskId FROM dbo.WorkTaskMembersView WHERE UserId = @userId)
	AND CONVERT(VARCHAR(10),ProjectSchedulingTime, 110) = @date)

	EXEC [dbo].[UpdateTaskStatuses]
END

GO
/****** Object:  StoredProcedure [dbo].[MarkScheduleDone]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Hisham Asghar
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[MarkScheduleDone] 
	-- Add the parameters for the stored procedure here
	@projectId int = 0, 
	@userId nvarchar(MAX) = NULL, 
	@date nvarchar(MAX) = NULL,
	@ids NVARCHAR(MAX) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE dbo.WorkTaskPlatforms
	SET IsScheduled = 1
	WHERE dbo.WorkTaskPlatforms.Id IN (SELECT dbo.WorkTaskPlatforms.Id FROM dbo.WorkTaskPlatforms 
	INNER JOIN (
	SELECT dbo.WorkTaskMembers.* FROM dbo.ProjectMemberTypes INNER JOIN dbo.WorkTaskMembers ON dbo.ProjectMemberTypes.Id = dbo.WorkTaskMembers.MemberTypeId AND dbo.WorkTaskMembers.AspNetUserId = @userId AND dbo.ProjectMemberTypes.Name like 'Scheduler'
	) WorkTaskMembers ON dbo.WorkTaskPlatforms.WorkTaskId = WorkTaskMembers.WorkTaskId
	INNER JOIN dbo.WorkTask ON dbo.WorkTask.Id = dbo.WorkTaskPlatforms.WorkTaskId AND dbo.WorkTask.ProjectId = @projectId
WHERE dbo.WorkTaskPlatforms.Id IN (SELECT * FROM [dbo].[SplitString](@ids)) 
AND CONVERT(VARCHAR(10),dbo.WorkTask.ProjectSchedulingTime, 110) = @date)

	EXEC [dbo].[UpdateTaskStatuses]

END

GO
/****** Object:  StoredProcedure [dbo].[UpdateTaskStatuses]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Hisham Asghar
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[UpdateTaskStatuses]
AS
BEGIN
	
	UPDATE dbo.WorkTaskPlatforms 
	SET IsCompleted = CASE WHEN IsDesigned = 1 AND IsScheduled = 1 THEN 1 ELSE 0 END

	UPDATE dbo.WorkTask
	SET IsDesigned = (SELECT TOP 1 CASE WHEN Info.PlatformCount = Info.PlatformDoneCount THEN 1 ELSE 0 END
	FROM (SELECT WorkTaskId,IsDesigned, COUNT(IsDesigned) PlatformCount,SUM(CASE WHEN IsDesigned = 1 THEN 1 ELSE 0 END) PlatformDoneCount FROM dbo.WorkTaskPlatforms
	GROUP BY WorkTaskId,IsDesigned) Info WHERE Info.WorkTaskId = dbo.WorkTask.Id),

	IsScheduled = (SELECT TOP 1 CASE WHEN Info.PlatformCount = Info.PlatformDoneCount THEN 1 ELSE 0 END
	FROM (SELECT WorkTaskId,IsScheduled, COUNT(IsScheduled) PlatformCount,SUM(CASE WHEN IsScheduled = 1 THEN 1 ELSE 0 END) PlatformDoneCount FROM dbo.WorkTaskPlatforms
	GROUP BY WorkTaskId,IsScheduled) Info WHERE Info.WorkTaskId = dbo.WorkTask.Id),

	IsCompleted = (SELECT TOP 1 CASE WHEN Info.PlatformCount = Info.PlatformDoneCount THEN 1 ELSE 0 END
	FROM (SELECT WorkTaskId,IsCompleted, COUNT(IsCompleted) PlatformCount,SUM(CASE WHEN IsCompleted = 1 THEN 1 ELSE 0 END) PlatformDoneCount FROM dbo.WorkTaskPlatforms
	GROUP BY WorkTaskId,IsCompleted) Info WHERE Info.WorkTaskId = dbo.WorkTask.Id)


END

GO
/****** Object:  StoredProcedure [dbo].[UserTask]    Script Date: 6/29/2020 5:38:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UserTask] AS
SELECT dbo.WorkTask.IsCompleted,
       dbo.WorkTask.IsDesigned,
	   dbo.WorkTask.IsReported,
	   dbo.WorkTask.IsScheduled,
	   dbo.WorkTask.IsCompleted,
	   dbo.WorkTask.ProjectId,
	   WorkTaskId,Name
FROM dbo.WorkTask 
	INNER JOIN (SELECT WorkTaskId,dbo.ProjectMemberTypes.Name
	FROM dbo.WorkTaskMembers 
		INNER JOIN dbo.ProjectMemberTypes ON dbo.ProjectMemberTypes.Id = dbo.WorkTaskMembers.MemberTypeId 
	WHERE AspNetUserId='eb8cdcc8-5137-4397-bf1f-2d6be802c120') WorkTaskMembers
		ON dbo.WorkTask.Id = WorkTaskMembers.WorkTaskId
;

GO
USE [master]
GO
ALTER DATABASE [oysdigital] SET  READ_WRITE 
GO
