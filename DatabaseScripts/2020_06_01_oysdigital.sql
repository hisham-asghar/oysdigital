USE [oysdigital]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[Customer]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[LabelType]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[Mobile]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[MobileSpaces]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[Platform]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[Project]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[ProjectAlertMessage]    Script Date: 6/1/2020 10:00:57 AM ******/
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
 CONSTRAINT [PK_projectAlertMessages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectMembers]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[ProjectMemberTypes]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[ProjectNotes]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[ProjectPlatforms]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[ProjectTask]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[ProjectTaskScheduling]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[WorkTask]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[WorkTaskMembers]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  Table [dbo].[WorkTaskPlatforms]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  View [dbo].[WorkTaskMembersView]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  View [dbo].[UserTaskView]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  View [dbo].[UserRoleView]    Script Date: 6/1/2020 10:00:57 AM ******/
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
/****** Object:  View [dbo].[WorkTaskPlatformsView]    Script Date: 6/1/2020 10:00:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[WorkTaskPlatformsView] AS
SELECT WorkTaskPlatforms.*, [Platform].Name AS PlatformName, dbo.[Platform].IconClass AS PlatformIcon 
FROM dbo.WorkTaskPlatforms INNER JOIN dbo.[Platform] 
		ON dbo.[Platform].Id = dbo.WorkTaskPlatforms.PlatformId

GO
/****** Object:  View [dbo].[WorkTaskView]    Script Date: 6/1/2020 10:00:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[WorkTaskView] AS
SELECT dbo.WorkTask.*,dbo.Project.Name AS ProjectName 
FROM dbo.WorkTask INNER JOIN dbo.Project ON Project.Id = WorkTask.ProjectId

GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'0dc7ceb7-7c17-488f-88df-34e8eb9fea4a', N'Designer', N'DESIGNER', N'28d32db1-fbc0-4e21-94d5-a8ac9bd60bb3')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'25bef407-a8f8-4d0d-8f4a-9cc6098a1a54', N'Scheduler', N'SCHEDULER', N'5ed580e0-0682-45b8-9acc-fc50ef8e68e5')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'2f6ddb9d-92f4-428f-ba99-4a84e145c864', N'Hr', N'HR', N'dffaec5e-1145-4509-b460-74f58546627d')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'd576e487-3322-4d62-8083-49467eb95f72', N'Admin', N'ADMIN', N'd99e5f32-69a7-4427-97ba-7690c332a9af')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'09ce0515-1885-4d4b-891d-c613d59fa7a7', N'0dc7ceb7-7c17-488f-88df-34e8eb9fea4a')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'0a38f7cb-d2bf-40f4-b8e1-1bfabd067ce0', N'25bef407-a8f8-4d0d-8f4a-9cc6098a1a54')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'0a8544c4-bdc9-46c3-96e4-3b1d2aca721a', N'2f6ddb9d-92f4-428f-ba99-4a84e145c864')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'2f6ddb9d-92f4-428f-ba99-4a84e145c864')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'd576e487-3322-4d62-8083-49467eb95f72')
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Name], [ProfilePic]) VALUES (N'09ce0515-1885-4d4b-891d-c613d59fa7a7', N'tayyab.tariq@octacer.com', N'TAYYAB.TARIQ@OCTACER.COM', N'tayyab.tariq@octacer.com', N'TAYYAB.TARIQ@OCTACER.COM', 0, N'AQAAAAEAACcQAAAAENPuKZavUO6fshMWKCAYsCAAsLuFIt11GvX1pTx00q5tqBFgoTaPihLwqau3QB1gaQ==', N'O5L5FBAS6EQHXFWXTKQABIZJM5LQE23P', N'b3f19aeb-8667-4b18-8eb1-e02bc128b374', N'', 0, 0, NULL, 1, 0, N'Tayyab', N'')
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Name], [ProfilePic]) VALUES (N'0a38f7cb-d2bf-40f4-b8e1-1bfabd067ce0', N'mehtab.aslam@octacer.com', N'MEHTAB.ASLAM@OCTACER.COM', N'mehtab.aslam@octacer.com', N'MEHTAB.ASLAM@OCTACER.COM', 0, N'AQAAAAEAACcQAAAAEG/qgRsmG5/Yg2S6QLAUwleU+NWUtQvHECZlq8C8+OvFqFz0SHE7UIOJY2KGMV+lKg==', N'YVYYURFWIQYU3J4KIBIM3H2JVBADPRYP', N'1cdf7661-c085-4de4-9ab3-dd166bfef555', N'', 0, 0, NULL, 1, 0, N'Mehtab Aslam', N'')
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Name], [ProfilePic]) VALUES (N'0a8544c4-bdc9-46c3-96e4-3b1d2aca721a', N'salman.ahmed@octacer.com', N'SALMAN.AHMED@OCTACER.COM', N'salman.ahmed@octacer.com', N'SALMAN.AHMED@OCTACER.COM', 0, N'AQAAAAEAACcQAAAAEDxTcFyT2GPVQqCJOIWDYinvHFqrm7Y4RR/9Op/eF7GBmUjFRmEiu0Ymp2PTLHXsEQ==', N'PI6QPYRYP7A4SGEX3OYNWY7YJX2UX3V7', N'736b70e6-4454-49b7-9815-27cfe6a3801e', N'', 0, 0, NULL, 1, 0, N'Salman Ahmed', N'')
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [Name], [ProfilePic]) VALUES (N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'hisham@octacer.com', N'HISHAM@OCTACER.COM', N'hisham@octacer.com', N'HISHAM@OCTACER.COM', 0, N'AQAAAAEAACcQAAAAEMFMewXOu6uWe5zXW0rd8DwYDUDHU4R9MALiiyQEXHLbvj8Cf4/2Zfqevp/yx8NPAg==', N'IDC65LFAVH4AZDFY2SE3HGWVFPUVGC6T', N'6c284219-1d4c-4286-a4c8-d798242848a5', N'', 0, 0, NULL, 1, 0, N'Hisham Asghar', N'')
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([Id], [Guid], [Email], [PhoneNumber], [Address], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [Name]) VALUES (1, N'0be6dbf0-a764-43df-952a-7f7180370621', N'Customer@gmail.com', N'92321444521892', N'.....', 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 15:07:38.0000000' AS DateTime2), CAST(N'2020-05-30 15:07:38.0000000' AS DateTime2), N'Customer One')
SET IDENTITY_INSERT [dbo].[Customer] OFF
SET IDENTITY_INSERT [dbo].[LabelType] ON 

INSERT [dbo].[LabelType] ([Id], [Name], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [ColorCode]) VALUES (1, N'General', N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 16:29:12.0000000' AS DateTime2), CAST(N'2020-05-30 16:29:12.0000000' AS DateTime2), N'#00AABB')
INSERT [dbo].[LabelType] ([Id], [Name], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [ColorCode]) VALUES (2, N'Executive', N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 16:30:14.0000000' AS DateTime2), CAST(N'2020-05-30 16:30:14.0000000' AS DateTime2), N'#141321')
SET IDENTITY_INSERT [dbo].[LabelType] OFF
SET IDENTITY_INSERT [dbo].[Mobile] ON 

INSERT [dbo].[Mobile] ([Id], [Name], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified]) VALUES (6, N'J7 ', 0, NULL, N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), CAST(N'2020-05-30 15:09:53.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Mobile] OFF
SET IDENTITY_INSERT [dbo].[MobileSpaces] ON 

INSERT [dbo].[MobileSpaces] ([Id], [MobileId], [Name], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified]) VALUES (1, 6, N'LT ', 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 15:10:07.0000000' AS DateTime2), CAST(N'2020-05-30 15:10:07.0000000' AS DateTime2))
INSERT [dbo].[MobileSpaces] ([Id], [MobileId], [Name], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified]) VALUES (2, 6, N'RT ', 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 15:10:11.0000000' AS DateTime2), CAST(N'2020-05-30 15:10:11.0000000' AS DateTime2))
INSERT [dbo].[MobileSpaces] ([Id], [MobileId], [Name], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified]) VALUES (3, 6, N'LM ', 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 15:10:18.0000000' AS DateTime2), CAST(N'2020-05-30 15:10:18.0000000' AS DateTime2))
INSERT [dbo].[MobileSpaces] ([Id], [MobileId], [Name], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified]) VALUES (4, 6, N'RM ', 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 15:12:40.0000000' AS DateTime2), CAST(N'2020-05-30 15:12:40.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[MobileSpaces] OFF
SET IDENTITY_INSERT [dbo].[Platform] ON 

INSERT [dbo].[Platform] ([Id], [Name], [IconClass], [CreatedBy], [IsActive], [ModifiedBy], [OnCreated], [OnModified]) VALUES (1, N'facebook', N'zmdi zmdi-facebook', N'414276f2-f967-4af5-9b32-d79e242ffcbd', 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 16:26:27.0000000' AS DateTime2), CAST(N'2020-05-30 16:26:27.0000000' AS DateTime2))
INSERT [dbo].[Platform] ([Id], [Name], [IconClass], [CreatedBy], [IsActive], [ModifiedBy], [OnCreated], [OnModified]) VALUES (2, N'Google Plus', N'zmdi zmdi-google-plus', N'414276f2-f967-4af5-9b32-d79e242ffcbd', 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 16:26:34.0000000' AS DateTime2), CAST(N'2020-05-30 16:26:34.0000000' AS DateTime2))
INSERT [dbo].[Platform] ([Id], [Name], [IconClass], [CreatedBy], [IsActive], [ModifiedBy], [OnCreated], [OnModified]) VALUES (3, N'youtube', N'zmdi zmdi-youtube', N'414276f2-f967-4af5-9b32-d79e242ffcbd', 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 16:26:44.0000000' AS DateTime2), CAST(N'2020-05-30 16:26:44.0000000' AS DateTime2))
INSERT [dbo].[Platform] ([Id], [Name], [IconClass], [CreatedBy], [IsActive], [ModifiedBy], [OnCreated], [OnModified]) VALUES (4, N'instagram', N'zmdi zmdi-instagram', N'414276f2-f967-4af5-9b32-d79e242ffcbd', 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 16:26:50.0000000' AS DateTime2), CAST(N'2020-05-30 16:26:50.0000000' AS DateTime2))
INSERT [dbo].[Platform] ([Id], [Name], [IconClass], [CreatedBy], [IsActive], [ModifiedBy], [OnCreated], [OnModified]) VALUES (5, N'twitter', N'zmdi zmdi-twitter', N'414276f2-f967-4af5-9b32-d79e242ffcbd', 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 16:26:57.0000000' AS DateTime2), CAST(N'2020-05-30 16:26:57.0000000' AS DateTime2))
INSERT [dbo].[Platform] ([Id], [Name], [IconClass], [CreatedBy], [IsActive], [ModifiedBy], [OnCreated], [OnModified]) VALUES (6, N'linked In', N'zmdi zmdi-linkedin', N'414276f2-f967-4af5-9b32-d79e242ffcbd', 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 16:27:07.0000000' AS DateTime2), CAST(N'2020-05-30 16:27:07.0000000' AS DateTime2))
INSERT [dbo].[Platform] ([Id], [Name], [IconClass], [CreatedBy], [IsActive], [ModifiedBy], [OnCreated], [OnModified]) VALUES (7, N'google', N'zmdi zmdi-google', N'414276f2-f967-4af5-9b32-d79e242ffcbd', 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 16:27:16.0000000' AS DateTime2), CAST(N'2020-05-30 16:27:16.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Platform] OFF
SET IDENTITY_INSERT [dbo].[Project] ON 

INSERT [dbo].[Project] ([Id], [Guid], [Name], [CustomerId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [MobileSpaceId]) VALUES (1, N'45094a50-7f9d-4c85-ba04-4a530e4fcc8e', N'Octacer', 1, 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 15:21:18.0000000' AS DateTime2), CAST(N'2020-05-30 15:21:18.0000000' AS DateTime2), 3)
INSERT [dbo].[Project] ([Id], [Guid], [Name], [CustomerId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [MobileSpaceId]) VALUES (2, N'eab8251b-e5c1-40b2-a2f1-a2077ab1e953', N'OYS', 1, 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-06-01 00:33:21.0000000' AS DateTime2), CAST(N'2020-06-01 00:33:21.0000000' AS DateTime2), 1)
SET IDENTITY_INSERT [dbo].[Project] OFF
SET IDENTITY_INSERT [dbo].[ProjectMembers] ON 

INSERT [dbo].[ProjectMembers] ([Id], [ProjectMemberTypeId], [ProjectId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [AspNetUserId]) VALUES (2, 2, 1, 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 16:23:13.0000000' AS DateTime2), CAST(N'2020-05-30 16:23:13.0000000' AS DateTime2), N'0a38f7cb-d2bf-40f4-b8e1-1bfabd067ce0')
INSERT [dbo].[ProjectMembers] ([Id], [ProjectMemberTypeId], [ProjectId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [AspNetUserId]) VALUES (3, 1, 1, 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-06-01 00:09:41.0000000' AS DateTime2), CAST(N'2020-06-01 00:09:41.0000000' AS DateTime2), N'09ce0515-1885-4d4b-891d-c613d59fa7a7')
SET IDENTITY_INSERT [dbo].[ProjectMembers] OFF
SET IDENTITY_INSERT [dbo].[ProjectMemberTypes] ON 

INSERT [dbo].[ProjectMemberTypes] ([Id], [Name], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified]) VALUES (1, N'Designer', 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 15:22:54.0000000' AS DateTime2), CAST(N'2020-05-30 15:22:54.0000000' AS DateTime2))
INSERT [dbo].[ProjectMemberTypes] ([Id], [Name], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified]) VALUES (2, N'Scheduler', 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 15:23:02.0000000' AS DateTime2), CAST(N'2020-05-30 15:23:02.0000000' AS DateTime2))
INSERT [dbo].[ProjectMemberTypes] ([Id], [Name], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified]) VALUES (3, N'Manager', 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-31 17:14:40.0000000' AS DateTime2), CAST(N'2020-05-31 17:14:40.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[ProjectMemberTypes] OFF
SET IDENTITY_INSERT [dbo].[ProjectNotes] ON 

INSERT [dbo].[ProjectNotes] ([Id], [Message], [LabelTypeId], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [IsActive], [AccessLevelTypeId], [ProjectId]) VALUES (1, N'Test Mesgga sadhbas asjd  asghd asdga dasjd ajhdsa hd ajhsa sajdsa dhas asjhas sah', 2, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 16:30:53.0000000' AS DateTime2), CAST(N'2020-05-30 16:30:53.0000000' AS DateTime2), 0, 2, 1)
INSERT [dbo].[ProjectNotes] ([Id], [Message], [LabelTypeId], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [IsActive], [AccessLevelTypeId], [ProjectId]) VALUES (2, N'Hello', 1, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 16:37:27.0000000' AS DateTime2), CAST(N'2020-05-30 16:37:27.0000000' AS DateTime2), 0, 1, 1)
SET IDENTITY_INSERT [dbo].[ProjectNotes] OFF
SET IDENTITY_INSERT [dbo].[ProjectPlatforms] ON 

INSERT [dbo].[ProjectPlatforms] ([Id], [Link], [ProjectId], [PlatformId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified]) VALUES (1, N'fb.com/octacer', 1, 1, 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 16:27:43.0000000' AS DateTime2), CAST(N'2020-05-30 16:27:43.0000000' AS DateTime2))
INSERT [dbo].[ProjectPlatforms] ([Id], [Link], [ProjectId], [PlatformId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified]) VALUES (2, N'twitter.com/octacer', 1, 5, 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-30 16:27:59.0000000' AS DateTime2), CAST(N'2020-05-30 16:27:59.0000000' AS DateTime2))
INSERT [dbo].[ProjectPlatforms] ([Id], [Link], [ProjectId], [PlatformId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified]) VALUES (3, N'a.a..a.', 2, 3, 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-06-01 00:33:33.0000000' AS DateTime2), CAST(N'2020-06-01 00:33:33.0000000' AS DateTime2))
INSERT [dbo].[ProjectPlatforms] ([Id], [Link], [ProjectId], [PlatformId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified]) VALUES (4, N'a.a.a.a', 2, 1, 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-06-01 00:33:37.0000000' AS DateTime2), CAST(N'2020-06-01 00:33:37.0000000' AS DateTime2))
INSERT [dbo].[ProjectPlatforms] ([Id], [Link], [ProjectId], [PlatformId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified]) VALUES (5, N'sssss', 2, 4, 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-06-01 00:33:46.0000000' AS DateTime2), CAST(N'2020-06-01 00:33:46.0000000' AS DateTime2))
INSERT [dbo].[ProjectPlatforms] ([Id], [Link], [ProjectId], [PlatformId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified]) VALUES (8, N'sssss', 1, 3, 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-06-01 00:33:46.0000000' AS DateTime2), CAST(N'2020-06-01 00:33:46.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[ProjectPlatforms] OFF
SET IDENTITY_INSERT [dbo].[ProjectTask] ON 

INSERT [dbo].[ProjectTask] ([Id], [ProjectId], [TaskTypeId], [Frequency], [FrequencyTypeId], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [IsActive]) VALUES (7, 1, 0, 1, 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-31 20:23:20.0000000' AS DateTime2), CAST(N'2020-05-31 20:23:20.0000000' AS DateTime2), NULL)
INSERT [dbo].[ProjectTask] ([Id], [ProjectId], [TaskTypeId], [Frequency], [FrequencyTypeId], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [IsActive]) VALUES (8, 1, 0, 2, 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-31 20:24:38.0000000' AS DateTime2), CAST(N'2020-05-31 20:24:38.0000000' AS DateTime2), NULL)
INSERT [dbo].[ProjectTask] ([Id], [ProjectId], [TaskTypeId], [Frequency], [FrequencyTypeId], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [IsActive]) VALUES (17, 1, 0, 3, 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-05-31 20:56:19.0000000' AS DateTime2), CAST(N'2020-05-31 20:56:19.0000000' AS DateTime2), NULL)
INSERT [dbo].[ProjectTask] ([Id], [ProjectId], [TaskTypeId], [Frequency], [FrequencyTypeId], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [IsActive]) VALUES (18, 2, 0, 3, 0, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-06-01 00:34:13.0000000' AS DateTime2), CAST(N'2020-06-01 00:34:13.0000000' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[ProjectTask] OFF
SET IDENTITY_INSERT [dbo].[ProjectTaskScheduling] ON 

INSERT [dbo].[ProjectTaskScheduling] ([Id], [ProjectTaskId], [Time]) VALUES (3, 7, CAST(N'2020-05-31 20:23:00.0000000' AS DateTime2))
INSERT [dbo].[ProjectTaskScheduling] ([Id], [ProjectTaskId], [Time]) VALUES (4, 8, CAST(N'2020-05-31 08:10:00.0000000' AS DateTime2))
INSERT [dbo].[ProjectTaskScheduling] ([Id], [ProjectTaskId], [Time]) VALUES (5, 8, CAST(N'2020-05-31 15:15:00.0000000' AS DateTime2))
INSERT [dbo].[ProjectTaskScheduling] ([Id], [ProjectTaskId], [Time]) VALUES (6, 9, CAST(N'2020-05-31 20:24:00.0000000' AS DateTime2))
INSERT [dbo].[ProjectTaskScheduling] ([Id], [ProjectTaskId], [Time]) VALUES (7, 9, CAST(N'2020-05-31 20:24:00.0000000' AS DateTime2))
INSERT [dbo].[ProjectTaskScheduling] ([Id], [ProjectTaskId], [Time]) VALUES (8, 9, CAST(N'2020-05-31 20:25:00.0000000' AS DateTime2))
INSERT [dbo].[ProjectTaskScheduling] ([Id], [ProjectTaskId], [Time]) VALUES (9, 9, CAST(N'2020-05-31 20:25:00.0000000' AS DateTime2))
INSERT [dbo].[ProjectTaskScheduling] ([Id], [ProjectTaskId], [Time]) VALUES (10, 9, CAST(N'2020-05-31 20:25:00.0000000' AS DateTime2))
INSERT [dbo].[ProjectTaskScheduling] ([Id], [ProjectTaskId], [Time]) VALUES (11, 17, CAST(N'2020-05-31 20:56:00.0000000' AS DateTime2))
INSERT [dbo].[ProjectTaskScheduling] ([Id], [ProjectTaskId], [Time]) VALUES (12, 17, CAST(N'2020-05-31 20:56:00.0000000' AS DateTime2))
INSERT [dbo].[ProjectTaskScheduling] ([Id], [ProjectTaskId], [Time]) VALUES (13, 17, CAST(N'2020-05-31 20:56:00.0000000' AS DateTime2))
INSERT [dbo].[ProjectTaskScheduling] ([Id], [ProjectTaskId], [Time]) VALUES (14, 18, CAST(N'2020-06-01 00:33:00.0000000' AS DateTime2))
INSERT [dbo].[ProjectTaskScheduling] ([Id], [ProjectTaskId], [Time]) VALUES (15, 18, CAST(N'2020-06-01 03:33:00.0000000' AS DateTime2))
INSERT [dbo].[ProjectTaskScheduling] ([Id], [ProjectTaskId], [Time]) VALUES (16, 18, CAST(N'2020-06-01 09:34:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[ProjectTaskScheduling] OFF
SET IDENTITY_INSERT [dbo].[WorkTask] ON 

INSERT [dbo].[WorkTask] ([Id], [ProjectId], [ProjectSchedulingTime], [IsCompleted], [IsDesigned], [IsScheduled], [OnReported], [IsReported], [ReportedBy], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified]) VALUES (1, 1, CAST(N'2020-05-30 03:30:00.0000000' AS DateTime2), 1, 1, 1, CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), 0, N'', N'09ce0515-1885-4d4b-891d-c613d59fa7a7', N'09ce0515-1885-4d4b-891d-c613d59fa7a7', CAST(N'2020-05-30 00:00:00.0000000' AS DateTime2), CAST(N'2020-05-30 00:00:00.0000000' AS DateTime2))
INSERT [dbo].[WorkTask] ([Id], [ProjectId], [ProjectSchedulingTime], [IsCompleted], [IsDesigned], [IsScheduled], [OnReported], [IsReported], [ReportedBy], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified]) VALUES (2, 1, CAST(N'2020-05-30 16:30:00.0000000' AS DateTime2), 0, 0, 0, CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), 0, NULL, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', N'09ce0515-1885-4d4b-891d-c613d59fa7a7', CAST(N'2020-05-30 00:00:00.0000000' AS DateTime2), CAST(N'2020-05-30 00:00:00.0000000' AS DateTime2))
INSERT [dbo].[WorkTask] ([Id], [ProjectId], [ProjectSchedulingTime], [IsCompleted], [IsDesigned], [IsScheduled], [OnReported], [IsReported], [ReportedBy], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified]) VALUES (3, 1, CAST(N'2020-05-30 03:30:00.0000000' AS DateTime2), 0, 0, 0, CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), 0, NULL, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', N'09ce0515-1885-4d4b-891d-c613d59fa7a7', CAST(N'2020-05-31 00:00:00.0000000' AS DateTime2), CAST(N'2020-05-31 00:00:00.0000000' AS DateTime2))
INSERT [dbo].[WorkTask] ([Id], [ProjectId], [ProjectSchedulingTime], [IsCompleted], [IsDesigned], [IsScheduled], [OnReported], [IsReported], [ReportedBy], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified]) VALUES (4, 1, CAST(N'2020-05-30 16:30:00.0000000' AS DateTime2), 0, 0, 0, CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), 0, NULL, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', N'09ce0515-1885-4d4b-891d-c613d59fa7a7', CAST(N'2020-05-31 00:00:00.0000000' AS DateTime2), CAST(N'2020-05-31 00:00:00.0000000' AS DateTime2))
INSERT [dbo].[WorkTask] ([Id], [ProjectId], [ProjectSchedulingTime], [IsCompleted], [IsDesigned], [IsScheduled], [OnReported], [IsReported], [ReportedBy], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified]) VALUES (5, 1, CAST(N'2020-05-30 03:30:00.0000000' AS DateTime2), 1, 1, 1, CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), 0, N'', N'09ce0515-1885-4d4b-891d-c613d59fa7a7', N'09ce0515-1885-4d4b-891d-c613d59fa7a7', CAST(N'2020-06-01 00:00:00.0000000' AS DateTime2), CAST(N'2020-06-01 00:00:00.0000000' AS DateTime2))
INSERT [dbo].[WorkTask] ([Id], [ProjectId], [ProjectSchedulingTime], [IsCompleted], [IsDesigned], [IsScheduled], [OnReported], [IsReported], [ReportedBy], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified]) VALUES (6, 1, CAST(N'2020-05-30 16:30:00.0000000' AS DateTime2), 0, 1, 0, CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), 0, N'', N'09ce0515-1885-4d4b-891d-c613d59fa7a7', N'09ce0515-1885-4d4b-891d-c613d59fa7a7', CAST(N'2020-06-01 00:00:00.0000000' AS DateTime2), CAST(N'2020-06-01 00:00:00.0000000' AS DateTime2))
INSERT [dbo].[WorkTask] ([Id], [ProjectId], [ProjectSchedulingTime], [IsCompleted], [IsDesigned], [IsScheduled], [OnReported], [IsReported], [ReportedBy], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified]) VALUES (7, 1, CAST(N'2020-05-31 20:23:00.0000000' AS DateTime2), 0, 0, 0, CAST(N'0001-01-01 00:00:00.0000000' AS DateTime2), 0, NULL, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-06-01 00:00:00.0000000' AS DateTime2), CAST(N'2020-06-01 00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[WorkTask] OFF
SET IDENTITY_INSERT [dbo].[WorkTaskMembers] ON 

INSERT [dbo].[WorkTaskMembers] ([Id], [AspNetUserId], [MemberTypeId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [WorkTaskId]) VALUES (1, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', 1, 1, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', N'09ce0515-1885-4d4b-891d-c613d59fa7a7', CAST(N'2020-05-30 16:45:39.0000000' AS DateTime2), CAST(N'2020-05-30 16:45:39.0000000' AS DateTime2), 1)
INSERT [dbo].[WorkTaskMembers] ([Id], [AspNetUserId], [MemberTypeId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [WorkTaskId]) VALUES (2, N'0a38f7cb-d2bf-40f4-b8e1-1bfabd067ce0', 2, 1, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', N'09ce0515-1885-4d4b-891d-c613d59fa7a7', CAST(N'2020-05-30 16:45:39.0000000' AS DateTime2), CAST(N'2020-05-30 16:45:39.0000000' AS DateTime2), 1)
INSERT [dbo].[WorkTaskMembers] ([Id], [AspNetUserId], [MemberTypeId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [WorkTaskId]) VALUES (3, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', 1, 1, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', N'09ce0515-1885-4d4b-891d-c613d59fa7a7', CAST(N'2020-05-30 16:45:39.0000000' AS DateTime2), CAST(N'2020-05-30 16:45:39.0000000' AS DateTime2), 2)
INSERT [dbo].[WorkTaskMembers] ([Id], [AspNetUserId], [MemberTypeId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [WorkTaskId]) VALUES (4, N'0a38f7cb-d2bf-40f4-b8e1-1bfabd067ce0', 2, 1, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', N'09ce0515-1885-4d4b-891d-c613d59fa7a7', CAST(N'2020-05-30 16:45:39.0000000' AS DateTime2), CAST(N'2020-05-30 16:45:39.0000000' AS DateTime2), 2)
INSERT [dbo].[WorkTaskMembers] ([Id], [AspNetUserId], [MemberTypeId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [WorkTaskId]) VALUES (5, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', 1, 1, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', N'09ce0515-1885-4d4b-891d-c613d59fa7a7', CAST(N'2020-05-31 14:11:12.0000000' AS DateTime2), CAST(N'2020-05-31 14:11:12.0000000' AS DateTime2), 3)
INSERT [dbo].[WorkTaskMembers] ([Id], [AspNetUserId], [MemberTypeId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [WorkTaskId]) VALUES (6, N'0a38f7cb-d2bf-40f4-b8e1-1bfabd067ce0', 2, 1, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', N'09ce0515-1885-4d4b-891d-c613d59fa7a7', CAST(N'2020-05-31 14:11:12.0000000' AS DateTime2), CAST(N'2020-05-31 14:11:12.0000000' AS DateTime2), 3)
INSERT [dbo].[WorkTaskMembers] ([Id], [AspNetUserId], [MemberTypeId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [WorkTaskId]) VALUES (7, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', 1, 1, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', N'09ce0515-1885-4d4b-891d-c613d59fa7a7', CAST(N'2020-05-31 14:11:12.0000000' AS DateTime2), CAST(N'2020-05-31 14:11:12.0000000' AS DateTime2), 4)
INSERT [dbo].[WorkTaskMembers] ([Id], [AspNetUserId], [MemberTypeId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [WorkTaskId]) VALUES (8, N'0a38f7cb-d2bf-40f4-b8e1-1bfabd067ce0', 2, 1, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', N'09ce0515-1885-4d4b-891d-c613d59fa7a7', CAST(N'2020-05-31 14:11:12.0000000' AS DateTime2), CAST(N'2020-05-31 14:11:12.0000000' AS DateTime2), 4)
INSERT [dbo].[WorkTaskMembers] ([Id], [AspNetUserId], [MemberTypeId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [WorkTaskId]) VALUES (9, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', 1, 1, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', N'09ce0515-1885-4d4b-891d-c613d59fa7a7', CAST(N'2020-05-31 15:29:04.0000000' AS DateTime2), CAST(N'2020-05-31 15:29:04.0000000' AS DateTime2), 5)
INSERT [dbo].[WorkTaskMembers] ([Id], [AspNetUserId], [MemberTypeId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [WorkTaskId]) VALUES (10, N'0a38f7cb-d2bf-40f4-b8e1-1bfabd067ce0', 2, 1, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', N'09ce0515-1885-4d4b-891d-c613d59fa7a7', CAST(N'2020-05-31 15:29:04.0000000' AS DateTime2), CAST(N'2020-05-31 15:29:04.0000000' AS DateTime2), 5)
INSERT [dbo].[WorkTaskMembers] ([Id], [AspNetUserId], [MemberTypeId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [WorkTaskId]) VALUES (11, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', 1, 1, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', N'09ce0515-1885-4d4b-891d-c613d59fa7a7', CAST(N'2020-05-31 15:29:04.0000000' AS DateTime2), CAST(N'2020-05-31 15:29:04.0000000' AS DateTime2), 6)
INSERT [dbo].[WorkTaskMembers] ([Id], [AspNetUserId], [MemberTypeId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [WorkTaskId]) VALUES (12, N'0a38f7cb-d2bf-40f4-b8e1-1bfabd067ce0', 2, 1, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', N'09ce0515-1885-4d4b-891d-c613d59fa7a7', CAST(N'2020-05-31 15:29:04.0000000' AS DateTime2), CAST(N'2020-05-31 15:29:04.0000000' AS DateTime2), 6)
INSERT [dbo].[WorkTaskMembers] ([Id], [AspNetUserId], [MemberTypeId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [WorkTaskId]) VALUES (13, N'0a38f7cb-d2bf-40f4-b8e1-1bfabd067ce0', 2, 1, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-06-01 00:38:54.0000000' AS DateTime2), CAST(N'2020-06-01 00:38:54.0000000' AS DateTime2), 7)
INSERT [dbo].[WorkTaskMembers] ([Id], [AspNetUserId], [MemberTypeId], [IsActive], [CreatedBy], [ModifiedBy], [OnCreated], [OnModified], [WorkTaskId]) VALUES (14, N'09ce0515-1885-4d4b-891d-c613d59fa7a7', 1, 1, N'414276f2-f967-4af5-9b32-d79e242ffcbd', N'414276f2-f967-4af5-9b32-d79e242ffcbd', CAST(N'2020-06-01 00:38:54.0000000' AS DateTime2), CAST(N'2020-06-01 00:38:54.0000000' AS DateTime2), 7)
SET IDENTITY_INSERT [dbo].[WorkTaskMembers] OFF
SET IDENTITY_INSERT [dbo].[WorkTaskPlatforms] ON 

INSERT [dbo].[WorkTaskPlatforms] ([Id], [PlatformId], [WorkTaskId], [IsCompleted], [IsDesigned], [IsScheduled], [Status], [Link]) VALUES (1, 1, 1, 0, 1, 1, 0, N'fb.com/octacer')
INSERT [dbo].[WorkTaskPlatforms] ([Id], [PlatformId], [WorkTaskId], [IsCompleted], [IsDesigned], [IsScheduled], [Status], [Link]) VALUES (2, 5, 1, 1, 1, 1, 0, N'twitter.com/octacer')
INSERT [dbo].[WorkTaskPlatforms] ([Id], [PlatformId], [WorkTaskId], [IsCompleted], [IsDesigned], [IsScheduled], [Status], [Link]) VALUES (3, 1, 2, 0, 0, 0, 0, N'fb.com/octacer')
INSERT [dbo].[WorkTaskPlatforms] ([Id], [PlatformId], [WorkTaskId], [IsCompleted], [IsDesigned], [IsScheduled], [Status], [Link]) VALUES (4, 5, 2, 0, 0, 0, 0, N'twitter.com/octacer')
INSERT [dbo].[WorkTaskPlatforms] ([Id], [PlatformId], [WorkTaskId], [IsCompleted], [IsDesigned], [IsScheduled], [Status], [Link]) VALUES (5, 1, 3, 0, 0, 0, 0, N'fb.com/octacer')
INSERT [dbo].[WorkTaskPlatforms] ([Id], [PlatformId], [WorkTaskId], [IsCompleted], [IsDesigned], [IsScheduled], [Status], [Link]) VALUES (6, 5, 3, 0, 0, 0, 0, N'twitter.com/octacer')
INSERT [dbo].[WorkTaskPlatforms] ([Id], [PlatformId], [WorkTaskId], [IsCompleted], [IsDesigned], [IsScheduled], [Status], [Link]) VALUES (7, 1, 4, 0, 0, 0, 0, N'fb.com/octacer')
INSERT [dbo].[WorkTaskPlatforms] ([Id], [PlatformId], [WorkTaskId], [IsCompleted], [IsDesigned], [IsScheduled], [Status], [Link]) VALUES (8, 5, 4, 0, 0, 0, 0, N'twitter.com/octacer')
INSERT [dbo].[WorkTaskPlatforms] ([Id], [PlatformId], [WorkTaskId], [IsCompleted], [IsDesigned], [IsScheduled], [Status], [Link]) VALUES (9, 1, 5, 0, 1, 1, 0, N'fb.com/octacer')
INSERT [dbo].[WorkTaskPlatforms] ([Id], [PlatformId], [WorkTaskId], [IsCompleted], [IsDesigned], [IsScheduled], [Status], [Link]) VALUES (10, 5, 5, 1, 1, 1, 0, N'twitter.com/octacer')
INSERT [dbo].[WorkTaskPlatforms] ([Id], [PlatformId], [WorkTaskId], [IsCompleted], [IsDesigned], [IsScheduled], [Status], [Link]) VALUES (11, 1, 6, 0, 1, 0, 0, N'fb.com/octacer')
INSERT [dbo].[WorkTaskPlatforms] ([Id], [PlatformId], [WorkTaskId], [IsCompleted], [IsDesigned], [IsScheduled], [Status], [Link]) VALUES (12, 5, 6, 0, 1, 0, 0, N'twitter.com/octacer')
INSERT [dbo].[WorkTaskPlatforms] ([Id], [PlatformId], [WorkTaskId], [IsCompleted], [IsDesigned], [IsScheduled], [Status], [Link]) VALUES (13, 1, 7, 0, 0, 0, 0, N'fb.com/octacer')
INSERT [dbo].[WorkTaskPlatforms] ([Id], [PlatformId], [WorkTaskId], [IsCompleted], [IsDesigned], [IsScheduled], [Status], [Link]) VALUES (14, 5, 7, 0, 0, 0, 0, N'twitter.com/octacer')
SET IDENTITY_INSERT [dbo].[WorkTaskPlatforms] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AspNetRoleClaims_RoleId]    Script Date: 6/1/2020 10:00:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetRoleClaims_RoleId] ON [dbo].[AspNetRoleClaims]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [RoleNameIndex]    Script Date: 6/1/2020 10:00:58 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AspNetUserClaims_UserId]    Script Date: 6/1/2020 10:00:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserClaims_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AspNetUserLogins_UserId]    Script Date: 6/1/2020 10:00:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserLogins_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AspNetUserRoles_RoleId]    Script Date: 6/1/2020 10:00:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserRoles_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [EmailIndex]    Script Date: 6/1/2020 10:00:58 AM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 6/1/2020 10:00:58 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_MobileSpaces_MobileId]    Script Date: 6/1/2020 10:00:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_MobileSpaces_MobileId] ON [dbo].[MobileSpaces]
(
	[MobileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Project_CustomerId]    Script Date: 6/1/2020 10:00:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_Project_CustomerId] ON [dbo].[Project]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_projectMembers_ProjectId]    Script Date: 6/1/2020 10:00:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_projectMembers_ProjectId] ON [dbo].[ProjectMembers]
(
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_projectMembers_ProjectMemberTypesId]    Script Date: 6/1/2020 10:00:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_projectMembers_ProjectMemberTypesId] ON [dbo].[ProjectMembers]
(
	[ProjectMemberTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_projectPlatforms_PlatformId]    Script Date: 6/1/2020 10:00:58 AM ******/
CREATE NONCLUSTERED INDEX [IX_projectPlatforms_PlatformId] ON [dbo].[ProjectPlatforms]
(
	[PlatformId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_projectPlatforms_ProjectId]    Script Date: 6/1/2020 10:00:58 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetGenerateableTasks]    Script Date: 6/1/2020 10:00:58 AM ******/
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
	@date NVARCHAR(MAX)
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
END

GO
/****** Object:  StoredProcedure [dbo].[UserTask]    Script Date: 6/1/2020 10:00:58 AM ******/
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
