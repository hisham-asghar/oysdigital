USE [master]
GO
/****** Object:  Database [oysdigital]    Script Date: 4/24/2020 5:31:15 PM ******/
CREATE DATABASE [oysdigital]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'oysdigital', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\oysdigital.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'oysdigital_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\oysdigital_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
ALTER DATABASE [oysdigital] SET AUTO_CLOSE ON 
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
ALTER DATABASE [oysdigital] SET  ENABLE_BROKER 
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
ALTER DATABASE [oysdigital] SET READ_COMMITTED_SNAPSHOT ON 
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
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 4/24/2020 5:31:15 PM ******/
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
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 4/24/2020 5:31:15 PM ******/
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
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 4/24/2020 5:31:15 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 4/24/2020 5:31:15 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 4/24/2020 5:31:15 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 4/24/2020 5:31:15 PM ******/
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
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 4/24/2020 5:31:15 PM ******/
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
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 4/24/2020 5:31:15 PM ******/
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
/****** Object:  Table [dbo].[Customer]    Script Date: 4/24/2020 5:31:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerId] [bigint] IDENTITY(1,1) NOT NULL,
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
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Mobile]    Script Date: 4/24/2020 5:31:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mobile](
	[MobileId] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NOT NULL,
	[OnModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Mobile] PRIMARY KEY CLUSTERED 
(
	[MobileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MobileSpaces]    Script Date: 4/24/2020 5:31:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MobileSpaces](
	[MobileSpacesId] [bigint] IDENTITY(1,1) NOT NULL,
	[MobileId] [bigint] NOT NULL,
	[SpaceName] [nvarchar](max) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NOT NULL,
	[OnModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_MobileSpaces] PRIMARY KEY CLUSTERED 
(
	[MobileSpacesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Platforms]    Script Date: 4/24/2020 5:31:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Platforms](
	[PlatformId] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[IconUrl] [nvarchar](max) NULL,
 CONSTRAINT [PK_Platforms] PRIMARY KEY CLUSTERED 
(
	[PlatformId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Project]    Script Date: 4/24/2020 5:31:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Project](
	[ProjectId] [bigint] IDENTITY(1,1) NOT NULL,
	[Guid] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NULL,
	[ProjectStatusId] [int] NOT NULL,
	[CustomerId] [bigint] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NOT NULL,
	[OnModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectAlertMessages]    Script Date: 4/24/2020 5:31:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectAlertMessages](
	[ProjectAlertMessageId] [bigint] IDENTITY(1,1) NOT NULL,
	[Message] [nvarchar](max) NULL,
	[ProjectMessageTypeId] [int] NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NOT NULL,
	[OnModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_projectAlertMessages] PRIMARY KEY CLUSTERED 
(
	[ProjectAlertMessageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectMembers]    Script Date: 4/24/2020 5:31:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectMembers](
	[ProjectMembersId] [bigint] IDENTITY(1,1) NOT NULL,
	[ProjectMemberTypesId] [bigint] NOT NULL,
	[ProjectId] [bigint] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NOT NULL,
	[OnModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_projectMembers] PRIMARY KEY CLUSTERED 
(
	[ProjectMembersId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectMemberTypes]    Script Date: 4/24/2020 5:31:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectMemberTypes](
	[ProjectMemberTypesId] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NOT NULL,
	[OnModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_projectMemberTypes] PRIMARY KEY CLUSTERED 
(
	[ProjectMemberTypesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectNotes]    Script Date: 4/24/2020 5:31:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectNotes](
	[ProjectNotesId] [bigint] IDENTITY(1,1) NOT NULL,
	[Message] [nvarchar](max) NULL,
	[NoteTypeId] [int] NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NOT NULL,
	[OnModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_projectNotes] PRIMARY KEY CLUSTERED 
(
	[ProjectNotesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectPlatforms]    Script Date: 4/24/2020 5:31:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectPlatforms](
	[ProjectPlatformsId] [bigint] IDENTITY(1,1) NOT NULL,
	[PlatformLink] [nvarchar](max) NULL,
	[ProjectId] [bigint] NOT NULL,
	[PlatformId] [bigint] NOT NULL,
	[PostPerDay] [int] NOT NULL,
	[PostPerWeek] [int] NOT NULL,
	[PostPerMonth] [int] NOT NULL,
	[PostSchedulingTime] [datetime2](7) NOT NULL,
	[StoriesPerDay] [int] NOT NULL,
	[StoriesPerWeek] [int] NOT NULL,
	[StoriesMonth] [int] NOT NULL,
	[StoriesSchedulingTime] [datetime2](7) NOT NULL,
	[MobileSpacesId] [bigint] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](max) NULL,
	[OnCreated] [datetime2](7) NOT NULL,
	[OnModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_projectPlatforms] PRIMARY KEY CLUSTERED 
(
	[ProjectPlatformsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AspNetRoleClaims_RoleId]    Script Date: 4/24/2020 5:31:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetRoleClaims_RoleId] ON [dbo].[AspNetRoleClaims]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [RoleNameIndex]    Script Date: 4/24/2020 5:31:15 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AspNetUserClaims_UserId]    Script Date: 4/24/2020 5:31:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserClaims_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AspNetUserLogins_UserId]    Script Date: 4/24/2020 5:31:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserLogins_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AspNetUserRoles_RoleId]    Script Date: 4/24/2020 5:31:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserRoles_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [EmailIndex]    Script Date: 4/24/2020 5:31:15 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 4/24/2020 5:31:15 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_MobileSpaces_MobileId]    Script Date: 4/24/2020 5:31:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_MobileSpaces_MobileId] ON [dbo].[MobileSpaces]
(
	[MobileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Project_CustomerId]    Script Date: 4/24/2020 5:31:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Project_CustomerId] ON [dbo].[Project]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_projectMembers_ProjectId]    Script Date: 4/24/2020 5:31:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_projectMembers_ProjectId] ON [dbo].[ProjectMembers]
(
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_projectMembers_ProjectMemberTypesId]    Script Date: 4/24/2020 5:31:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_projectMembers_ProjectMemberTypesId] ON [dbo].[ProjectMembers]
(
	[ProjectMemberTypesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_projectPlatforms_MobileSpacesId]    Script Date: 4/24/2020 5:31:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_projectPlatforms_MobileSpacesId] ON [dbo].[ProjectPlatforms]
(
	[MobileSpacesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_projectPlatforms_PlatformId]    Script Date: 4/24/2020 5:31:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_projectPlatforms_PlatformId] ON [dbo].[ProjectPlatforms]
(
	[PlatformId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_projectPlatforms_ProjectId]    Script Date: 4/24/2020 5:31:15 PM ******/
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
REFERENCES [dbo].[Mobile] ([MobileId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MobileSpaces] CHECK CONSTRAINT [FK_MobileSpaces_Mobile_MobileId]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_Project_Customer_CustomerId]
GO
ALTER TABLE [dbo].[ProjectMembers]  WITH CHECK ADD  CONSTRAINT [FK_projectMembers_Project_ProjectId] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([ProjectId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProjectMembers] CHECK CONSTRAINT [FK_projectMembers_Project_ProjectId]
GO
ALTER TABLE [dbo].[ProjectMembers]  WITH CHECK ADD  CONSTRAINT [FK_projectMembers_projectMemberTypes_ProjectMemberTypesId] FOREIGN KEY([ProjectMemberTypesId])
REFERENCES [dbo].[ProjectMemberTypes] ([ProjectMemberTypesId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProjectMembers] CHECK CONSTRAINT [FK_projectMembers_projectMemberTypes_ProjectMemberTypesId]
GO
ALTER TABLE [dbo].[ProjectPlatforms]  WITH CHECK ADD  CONSTRAINT [FK_projectPlatforms_MobileSpaces_MobileSpacesId] FOREIGN KEY([MobileSpacesId])
REFERENCES [dbo].[MobileSpaces] ([MobileSpacesId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProjectPlatforms] CHECK CONSTRAINT [FK_projectPlatforms_MobileSpaces_MobileSpacesId]
GO
ALTER TABLE [dbo].[ProjectPlatforms]  WITH CHECK ADD  CONSTRAINT [FK_projectPlatforms_Platforms_PlatformId] FOREIGN KEY([PlatformId])
REFERENCES [dbo].[Platforms] ([PlatformId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProjectPlatforms] CHECK CONSTRAINT [FK_projectPlatforms_Platforms_PlatformId]
GO
ALTER TABLE [dbo].[ProjectPlatforms]  WITH CHECK ADD  CONSTRAINT [FK_projectPlatforms_Project_ProjectId] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([ProjectId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProjectPlatforms] CHECK CONSTRAINT [FK_projectPlatforms_Project_ProjectId]
GO
USE [master]
GO
ALTER DATABASE [oysdigital] SET  READ_WRITE 
GO
