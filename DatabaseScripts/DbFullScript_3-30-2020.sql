USE [master]
GO
/****** Object:  Database [myventures_bluebell]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE DATABASE [myventures_bluebell]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'bluebell', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\bluebell.mdf' , SIZE = 9216KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'bluebell_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\bluebell_log.ldf' , SIZE = 2304KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [myventures_bluebell] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [myventures_bluebell].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [myventures_bluebell] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [myventures_bluebell] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [myventures_bluebell] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [myventures_bluebell] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [myventures_bluebell] SET ARITHABORT OFF 
GO
ALTER DATABASE [myventures_bluebell] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [myventures_bluebell] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [myventures_bluebell] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [myventures_bluebell] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [myventures_bluebell] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [myventures_bluebell] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [myventures_bluebell] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [myventures_bluebell] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [myventures_bluebell] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [myventures_bluebell] SET  ENABLE_BROKER 
GO
ALTER DATABASE [myventures_bluebell] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [myventures_bluebell] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [myventures_bluebell] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [myventures_bluebell] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [myventures_bluebell] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [myventures_bluebell] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [myventures_bluebell] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [myventures_bluebell] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [myventures_bluebell] SET  MULTI_USER 
GO
ALTER DATABASE [myventures_bluebell] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [myventures_bluebell] SET DB_CHAINING OFF 
GO
ALTER DATABASE [myventures_bluebell] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [myventures_bluebell] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [myventures_bluebell] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'myventures_bluebell', N'ON'
GO
USE [myventures_bluebell]
GO
/****** Object:  Schema [myven_hisham]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE SCHEMA [myven_hisham]
GO
/****** Object:  Schema [myven_ventures]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE SCHEMA [myven_ventures]
GO
/****** Object:  Schema [myventures_bluebell]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE SCHEMA [myventures_bluebell]
GO
/****** Object:  UserDefinedFunction [dbo].[nop_splitstring_to_table]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[nop_splitstring_to_table]
(
    @string NVARCHAR(MAX),
    @delimiter CHAR(1)
)
RETURNS @output TABLE(
    data NVARCHAR(MAX)
)
BEGIN
    DECLARE @start INT, @end INT
    SELECT @start = 1, @end = CHARINDEX(@delimiter, @string)

    WHILE @start < LEN(@string) + 1 BEGIN
        IF @end = 0 
            SET @end = LEN(@string) + 1

        INSERT INTO @output (data) 
        VALUES(SUBSTRING(@string, @start, @end - @start))
        SET @start = @end + 1
        SET @end = CHARINDEX(@delimiter, @string, @start)
    END
    RETURN
END


GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 3/30/2020 12:49:38 PM ******/
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
/****** Object:  Table [dbo].[AclRecord]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AclRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerRoleId] [int] NOT NULL,
	[EntityName] [nvarchar](400) NOT NULL,
	[EntityId] [int] NOT NULL,
 CONSTRAINT [PK_AclRecord] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ActivityLog]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IpAddress] [nvarchar](200) NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[Comment] [nvarchar](max) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[EntityName] [nvarchar](400) NULL,
	[EntityId] [int] NULL,
	[ActivityLogTypeId] [int] NOT NULL,
 CONSTRAINT [PK_ActivityLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ActivityLogType]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityLogType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Enabled] [bit] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[SystemKeyword] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_ActivityLogType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Address]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[CustomAttributes] [nvarchar](max) NULL,
	[FaxNumber] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[ZipPostalCode] [nvarchar](max) NULL,
	[Address2] [nvarchar](max) NULL,
	[Address1] [nvarchar](max) NULL,
	[City] [nvarchar](max) NULL,
	[County] [nvarchar](max) NULL,
	[StateProvinceId] [int] NULL,
	[CountryId] [int] NULL,
	[Company] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[LastName] [nvarchar](max) NULL,
	[FirstName] [nvarchar](max) NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AddressAttribute]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AddressAttribute](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[AttributeControlTypeId] [int] NOT NULL,
	[IsRequired] [bit] NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_AddressAttribute] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AddressAttributeValue]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AddressAttributeValue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[IsPreSelected] [bit] NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
	[AddressAttributeId] [int] NOT NULL,
 CONSTRAINT [PK_AddressAttributeValue] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Affiliate]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Affiliate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[FriendlyUrlName] [nvarchar](max) NULL,
	[AdminComment] [nvarchar](max) NULL,
	[AddressId] [int] NOT NULL,
 CONSTRAINT [PK_Affiliate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ApiClaims]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApiClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ApiResourceId] [int] NOT NULL,
	[Type] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_ApiClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ApiProperties]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApiProperties](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](250) NOT NULL,
	[Value] [nvarchar](2000) NOT NULL,
	[ApiResourceId] [int] NOT NULL,
 CONSTRAINT [PK_ApiProperties] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ApiResources]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApiResources](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[DisplayName] [nvarchar](200) NULL,
	[Enabled] [bit] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Created] [datetime2](7) NOT NULL DEFAULT ('0001-01-01T00:00:00.0000000'),
	[LastAccessed] [datetime2](7) NULL,
	[NonEditable] [bit] NOT NULL DEFAULT ((0)),
	[Updated] [datetime2](7) NULL,
 CONSTRAINT [PK_ApiResources] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ApiScopeClaims]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApiScopeClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ApiScopeId] [int] NOT NULL,
	[Type] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_ApiScopeClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ApiScopes]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApiScopes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ApiResourceId] [int] NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[DisplayName] [nvarchar](200) NULL,
	[Emphasize] [bit] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Required] [bit] NOT NULL,
	[ShowInDiscoveryDocument] [bit] NOT NULL,
 CONSTRAINT [PK_ApiScopes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ApiSecrets]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApiSecrets](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ApiResourceId] [int] NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[Expiration] [datetime2](7) NULL,
	[Type] [nvarchar](250) NOT NULL,
	[Value] [nvarchar](4000) NOT NULL,
	[Created] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ApiSecrets] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 3/30/2020 12:49:38 PM ******/
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
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 3/30/2020 12:49:38 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 3/30/2020 12:49:38 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 3/30/2020 12:49:38 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 3/30/2020 12:49:38 PM ******/
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
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 3/30/2020 12:49:38 PM ******/
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
	[Name] [nvarchar](max) NULL,
	[ProfilePic] [nvarchar](max) NULL,
	[CustomerId] [int] NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 3/30/2020 12:49:38 PM ******/
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
/****** Object:  Table [dbo].[BackInStockSubscription]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BackInStockSubscription](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[StoreId] [int] NOT NULL,
 CONSTRAINT [PK_BackInStockSubscription] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BlogComment]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogComment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[BlogPostId] [int] NOT NULL,
	[StoreId] [int] NOT NULL,
	[IsApproved] [bit] NOT NULL,
	[CommentText] [nvarchar](max) NULL,
	[CustomerId] [int] NOT NULL,
 CONSTRAINT [PK_BlogComment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BlogPost]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogPost](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[LimitedToStores] [bit] NOT NULL,
	[MetaTitle] [nvarchar](400) NULL,
	[MetaDescription] [nvarchar](max) NULL,
	[MetaKeywords] [nvarchar](400) NULL,
	[EndDateUtc] [datetime2](7) NULL,
	[StartDateUtc] [datetime2](7) NULL,
	[Tags] [nvarchar](max) NULL,
	[AllowComments] [bit] NOT NULL,
	[BodyOverview] [nvarchar](max) NULL,
	[Body] [nvarchar](max) NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[IncludeInSitemap] [bit] NOT NULL,
	[LanguageId] [int] NOT NULL,
 CONSTRAINT [PK_BlogPost] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Campaign]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Campaign](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DontSendBeforeDateUtc] [datetime2](7) NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[CustomerRoleId] [int] NOT NULL,
	[StoreId] [int] NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[Subject] [nvarchar](max) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Campaign] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UpdatedOnUtc] [datetime2](7) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[Published] [bit] NOT NULL,
	[LimitedToStores] [bit] NOT NULL,
	[SubjectToAcl] [bit] NOT NULL,
	[IncludeInTopMenu] [bit] NOT NULL,
	[ShowOnHomepage] [bit] NOT NULL,
	[PriceRanges] [nvarchar](400) NULL,
	[PageSizeOptions] [nvarchar](200) NULL,
	[AllowCustomersToSelectPageSize] [bit] NOT NULL,
	[PageSize] [int] NOT NULL,
	[PictureId] [int] NOT NULL,
	[ParentCategoryId] [int] NOT NULL,
	[MetaTitle] [nvarchar](400) NULL,
	[MetaDescription] [nvarchar](max) NULL,
	[MetaKeywords] [nvarchar](400) NULL,
	[CategoryTemplateId] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CategoryTemplate]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryTemplate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[ViewPath] [nvarchar](400) NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_CategoryTemplate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CheckoutAttribute]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CheckoutAttribute](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ConditionAttributeXml] [nvarchar](max) NULL,
	[DefaultValue] [nvarchar](max) NULL,
	[ValidationFileMaximumSize] [int] NULL,
	[ValidationFileAllowedExtensions] [nvarchar](max) NULL,
	[ValidationMaxLength] [int] NULL,
	[ValidationMinLength] [int] NULL,
	[LimitedToStores] [bit] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[AttributeControlTypeId] [int] NOT NULL,
	[TaxCategoryId] [int] NOT NULL,
	[IsTaxExempt] [bit] NOT NULL,
	[ShippableProductRequired] [bit] NOT NULL,
	[IsRequired] [bit] NOT NULL,
	[TextPrompt] [nvarchar](max) NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_CheckoutAttribute] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CheckoutAttributeValue]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CheckoutAttributeValue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[IsPreSelected] [bit] NOT NULL,
	[WeightAdjustment] [decimal](18, 4) NOT NULL,
	[PriceAdjustment] [decimal](18, 4) NOT NULL,
	[ColorSquaresRgb] [nvarchar](100) NULL,
	[Name] [nvarchar](400) NOT NULL,
	[CheckoutAttributeId] [int] NOT NULL,
 CONSTRAINT [PK_CheckoutAttributeValue] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ClientClaims]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[Type] [nvarchar](250) NOT NULL,
	[Value] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_ClientClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ClientCorsOrigins]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientCorsOrigins](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[Origin] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_ClientCorsOrigins] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ClientGrantTypes]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientGrantTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[GrantType] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_ClientGrantTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ClientIdPRestrictions]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientIdPRestrictions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[Provider] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_ClientIdPRestrictions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ClientPostLogoutRedirectUris]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientPostLogoutRedirectUris](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[PostLogoutRedirectUri] [nvarchar](2000) NOT NULL,
 CONSTRAINT [PK_ClientPostLogoutRedirectUris] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ClientProperties]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientProperties](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[Key] [nvarchar](250) NOT NULL,
	[Value] [nvarchar](2000) NOT NULL,
 CONSTRAINT [PK_ClientProperties] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ClientRedirectUris]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientRedirectUris](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[RedirectUri] [nvarchar](2000) NOT NULL,
 CONSTRAINT [PK_ClientRedirectUris] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Clients]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clients](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AbsoluteRefreshTokenLifetime] [int] NOT NULL,
	[AccessTokenLifetime] [int] NOT NULL,
	[AccessTokenType] [int] NOT NULL,
	[AllowAccessTokensViaBrowser] [bit] NOT NULL,
	[AllowOfflineAccess] [bit] NOT NULL,
	[AllowPlainTextPkce] [bit] NOT NULL,
	[AllowRememberConsent] [bit] NOT NULL,
	[AlwaysIncludeUserClaimsInIdToken] [bit] NOT NULL,
	[AlwaysSendClientClaims] [bit] NOT NULL,
	[AuthorizationCodeLifetime] [int] NOT NULL,
	[ClientId] [nvarchar](200) NOT NULL,
	[ClientName] [nvarchar](200) NULL,
	[ClientUri] [nvarchar](2000) NULL,
	[EnableLocalLogin] [bit] NOT NULL,
	[Enabled] [bit] NOT NULL,
	[IdentityTokenLifetime] [int] NOT NULL,
	[IncludeJwtId] [bit] NOT NULL,
	[LogoUri] [nvarchar](2000) NULL,
	[ProtocolType] [nvarchar](200) NOT NULL,
	[RefreshTokenExpiration] [int] NOT NULL,
	[RefreshTokenUsage] [int] NOT NULL,
	[RequireClientSecret] [bit] NOT NULL,
	[RequireConsent] [bit] NOT NULL,
	[RequirePkce] [bit] NOT NULL,
	[SlidingRefreshTokenLifetime] [int] NOT NULL,
	[UpdateAccessTokenClaimsOnRefresh] [bit] NOT NULL,
	[BackChannelLogoutSessionRequired] [bit] NOT NULL,
	[BackChannelLogoutUri] [nvarchar](2000) NULL,
	[ClientClaimsPrefix] [nvarchar](200) NULL,
	[ConsentLifetime] [int] NULL,
	[Description] [nvarchar](1000) NULL,
	[FrontChannelLogoutSessionRequired] [bit] NOT NULL,
	[FrontChannelLogoutUri] [nvarchar](2000) NULL,
	[PairWiseSubjectSalt] [nvarchar](200) NULL,
	[Created] [datetime2](7) NOT NULL,
	[DeviceCodeLifetime] [int] NOT NULL,
	[LastAccessed] [datetime2](7) NULL,
	[NonEditable] [bit] NOT NULL,
	[Updated] [datetime2](7) NULL,
	[UserCodeType] [nvarchar](100) NULL,
	[UserSsoLifetime] [int] NULL,
 CONSTRAINT [PK_Clients] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ClientScopes]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientScopes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[Scope] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_ClientScopes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ClientSecrets]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientSecrets](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[Description] [nvarchar](2000) NULL,
	[Expiration] [datetime2](7) NULL,
	[Type] [nvarchar](250) NOT NULL,
	[Value] [nvarchar](4000) NOT NULL,
	[Created] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ClientSecrets] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Country]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LimitedToStores] [bit] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Published] [bit] NOT NULL,
	[SubjectToVat] [bit] NOT NULL,
	[NumericIsoCode] [int] NOT NULL,
	[ThreeLetterIsoCode] [nvarchar](3) NULL,
	[TwoLetterIsoCode] [nvarchar](2) NULL,
	[AllowsShipping] [bit] NOT NULL,
	[AllowsBilling] [bit] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CrossSellProduct]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CrossSellProduct](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId2] [int] NOT NULL,
	[ProductId1] [int] NOT NULL,
 CONSTRAINT [PK_CrossSellProduct] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Currency]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Currency](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoundingTypeId] [int] NOT NULL,
	[UpdatedOnUtc] [datetime2](7) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Published] [bit] NOT NULL,
	[LimitedToStores] [bit] NOT NULL,
	[CustomFormatting] [nvarchar](50) NULL,
	[DisplayLocale] [nvarchar](50) NULL,
	[Rate] [decimal](18, 4) NOT NULL,
	[CurrencyCode] [nvarchar](5) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Currency] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customer]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ShippingAddress_Id] [int] NULL,
	[BillingAddress_Id] [int] NULL,
	[RegisteredInStoreId] [int] NOT NULL,
	[LastActivityDateUtc] [datetime2](7) NOT NULL,
	[LastLoginDateUtc] [datetime2](7) NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[LastIpAddress] [nvarchar](max) NULL,
	[SystemName] [nvarchar](400) NULL,
	[IsSystemAccount] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
	[CannotLoginUntilDateUtc] [datetime2](7) NULL,
	[FailedLoginAttempts] [int] NOT NULL,
	[RequireReLogin] [bit] NOT NULL,
	[HasShoppingCartItems] [bit] NOT NULL,
	[VendorId] [int] NOT NULL,
	[AffiliateId] [int] NOT NULL,
	[IsTaxExempt] [bit] NOT NULL,
	[AdminComment] [nvarchar](max) NULL,
	[EmailToRevalidate] [nvarchar](1000) NULL,
	[Email] [nvarchar](1000) NULL,
	[Username] [nvarchar](1000) NULL,
	[CustomerGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customer_CustomerRole_Mapping]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer_CustomerRole_Mapping](
	[CustomerRole_Id] [int] NOT NULL,
	[Customer_Id] [int] NOT NULL,
 CONSTRAINT [PK_Customer_CustomerRole_Mapping] PRIMARY KEY CLUSTERED 
(
	[Customer_Id] ASC,
	[CustomerRole_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerAddresses]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerAddresses](
	[Address_Id] [int] NOT NULL,
	[Customer_Id] [int] NOT NULL,
 CONSTRAINT [PK_CustomerAddresses] PRIMARY KEY CLUSTERED 
(
	[Customer_Id] ASC,
	[Address_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerAttribute]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerAttribute](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[AttributeControlTypeId] [int] NOT NULL,
	[IsRequired] [bit] NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_CustomerAttribute] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerAttributeValue]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerAttributeValue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[IsPreSelected] [bit] NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
	[CustomerAttributeId] [int] NOT NULL,
 CONSTRAINT [PK_CustomerAttributeValue] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerPassword]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerPassword](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[PasswordSalt] [nvarchar](max) NULL,
	[PasswordFormatId] [int] NOT NULL,
	[Password] [nvarchar](max) NULL,
	[CustomerId] [int] NOT NULL,
 CONSTRAINT [PK_CustomerPassword] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerRole]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerRole](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PurchasedWithProductId] [int] NOT NULL,
	[DefaultTaxDisplayTypeId] [int] NOT NULL,
	[OverrideTaxDisplayType] [bit] NOT NULL,
	[EnablePasswordLifetime] [bit] NOT NULL,
	[SystemName] [nvarchar](255) NULL,
	[IsSystemRole] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
	[TaxExempt] [bit] NOT NULL,
	[FreeShipping] [bit] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_CustomerRole] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DeliveryDate]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeliveryDate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_DeliveryDate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DeviceCodes]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceCodes](
	[DeviceCode] [nvarchar](200) NOT NULL,
	[UserCode] [nvarchar](200) NOT NULL,
	[SubjectId] [nvarchar](200) NULL,
	[ClientId] [nvarchar](200) NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[Expiration] [datetime2](7) NOT NULL,
	[Data] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_DeviceCodes] PRIMARY KEY CLUSTERED 
(
	[UserCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Discount]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discount](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AppliedToSubCategories] [bit] NOT NULL,
	[MaximumDiscountedQuantity] [int] NULL,
	[LimitationTimes] [int] NOT NULL,
	[DiscountLimitationId] [int] NOT NULL,
	[IsCumulative] [bit] NOT NULL,
	[CouponCode] [nvarchar](100) NULL,
	[RequiresCouponCode] [bit] NOT NULL,
	[EndDateUtc] [datetime2](7) NULL,
	[StartDateUtc] [datetime2](7) NULL,
	[MaximumDiscountAmount] [decimal](18, 4) NULL,
	[DiscountAmount] [decimal](18, 4) NOT NULL,
	[DiscountPercentage] [decimal](18, 4) NOT NULL,
	[UsePercentage] [bit] NOT NULL,
	[DiscountTypeId] [int] NOT NULL,
	[AdminComment] [nvarchar](max) NULL,
	[Name] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Discount] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Discount_AppliedToCategories]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discount_AppliedToCategories](
	[Discount_Id] [int] NOT NULL,
	[Category_Id] [int] NOT NULL,
 CONSTRAINT [PK_Discount_AppliedToCategories] PRIMARY KEY CLUSTERED 
(
	[Discount_Id] ASC,
	[Category_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Discount_AppliedToManufacturers]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discount_AppliedToManufacturers](
	[Discount_Id] [int] NOT NULL,
	[Manufacturer_Id] [int] NOT NULL,
 CONSTRAINT [PK_Discount_AppliedToManufacturers] PRIMARY KEY CLUSTERED 
(
	[Discount_Id] ASC,
	[Manufacturer_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Discount_AppliedToProducts]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discount_AppliedToProducts](
	[Discount_Id] [int] NOT NULL,
	[Product_Id] [int] NOT NULL,
 CONSTRAINT [PK_Discount_AppliedToProducts] PRIMARY KEY CLUSTERED 
(
	[Discount_Id] ASC,
	[Product_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DiscountRequirement]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiscountRequirement](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[InteractionTypeId] [int] NULL,
	[ParentId] [int] NULL,
	[DiscountRequirementRuleSystemName] [nvarchar](max) NULL,
	[DiscountId] [int] NOT NULL,
 CONSTRAINT [PK_DiscountRequirement] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DiscountUsageHistory]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiscountUsageHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[OrderId] [int] NOT NULL,
	[DiscountId] [int] NOT NULL,
 CONSTRAINT [PK_DiscountUsageHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Download]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Download](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsNew] [bit] NOT NULL,
	[Extension] [nvarchar](max) NULL,
	[Filename] [nvarchar](max) NULL,
	[ContentType] [nvarchar](max) NULL,
	[DownloadBinary] [varbinary](max) NULL,
	[DownloadUrl] [nvarchar](max) NULL,
	[UseDownloadUrl] [bit] NOT NULL,
	[DownloadGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Download] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmailAccount]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailAccount](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UseDefaultCredentials] [bit] NOT NULL,
	[EnableSsl] [bit] NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[Username] [nvarchar](255) NOT NULL,
	[Port] [int] NOT NULL,
	[Host] [nvarchar](255) NOT NULL,
	[DisplayName] [nvarchar](255) NULL,
	[Email] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_EmailAccount] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExternalAuthenticationRecord]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExternalAuthenticationRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProviderSystemName] [nvarchar](max) NULL,
	[OAuthAccessToken] [nvarchar](max) NULL,
	[OAuthToken] [nvarchar](max) NULL,
	[ExternalDisplayIdentifier] [nvarchar](max) NULL,
	[ExternalIdentifier] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[CustomerId] [int] NOT NULL,
 CONSTRAINT [PK_ExternalAuthenticationRecord] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Forums_Forum]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forums_Forum](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UpdatedOnUtc] [datetime2](7) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[LastPostTime] [datetime2](7) NULL,
	[LastPostCustomerId] [int] NOT NULL,
	[LastPostId] [int] NOT NULL,
	[LastTopicId] [int] NOT NULL,
	[NumPosts] [int] NOT NULL,
	[NumTopics] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Name] [nvarchar](200) NOT NULL,
	[ForumGroupId] [int] NOT NULL,
 CONSTRAINT [PK_Forums_Forum] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Forums_Group]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forums_Group](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UpdatedOnUtc] [datetime2](7) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Forums_Group] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Forums_Post]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forums_Post](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VoteCount] [int] NOT NULL,
	[UpdatedOnUtc] [datetime2](7) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[IPAddress] [nvarchar](100) NULL,
	[Text] [nvarchar](max) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[TopicId] [int] NOT NULL,
 CONSTRAINT [PK_Forums_Post] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Forums_PostVote]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forums_PostVote](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[IsUp] [bit] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[ForumPostId] [int] NOT NULL,
 CONSTRAINT [PK_Forums_PostVote] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Forums_PrivateMessage]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forums_PrivateMessage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[IsDeletedByRecipient] [bit] NOT NULL,
	[IsDeletedByAuthor] [bit] NOT NULL,
	[IsRead] [bit] NOT NULL,
	[Text] [nvarchar](max) NOT NULL,
	[Subject] [nvarchar](450) NOT NULL,
	[ToCustomerId] [int] NOT NULL,
	[FromCustomerId] [int] NOT NULL,
	[StoreId] [int] NOT NULL,
 CONSTRAINT [PK_Forums_PrivateMessage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Forums_Subscription]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forums_Subscription](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[TopicId] [int] NOT NULL,
	[ForumId] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[SubscriptionGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Forums_Subscription] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Forums_Topic]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forums_Topic](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UpdatedOnUtc] [datetime2](7) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[LastPostTime] [datetime2](7) NULL,
	[LastPostCustomerId] [int] NOT NULL,
	[LastPostId] [int] NOT NULL,
	[Views] [int] NOT NULL,
	[NumPosts] [int] NOT NULL,
	[Subject] [nvarchar](450) NOT NULL,
	[TopicTypeId] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[ForumId] [int] NOT NULL,
 CONSTRAINT [PK_Forums_Topic] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GdprConsent]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GdprConsent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[DisplayOnCustomerInfoPage] [bit] NOT NULL,
	[DisplayDuringRegistration] [bit] NOT NULL,
	[RequiredMessage] [nvarchar](max) NULL,
	[IsRequired] [bit] NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_GdprConsent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GdprLog]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GdprLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[RequestDetails] [nvarchar](max) NULL,
	[RequestTypeId] [int] NOT NULL,
	[CustomerInfo] [nvarchar](max) NULL,
	[ConsentId] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
 CONSTRAINT [PK_GdprLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GenericAttribute]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GenericAttribute](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOrUpdatedDateUTC] [datetime2](7) NULL,
	[StoreId] [int] NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[Key] [nvarchar](400) NOT NULL,
	[KeyGroup] [nvarchar](400) NOT NULL,
	[EntityId] [int] NOT NULL,
 CONSTRAINT [PK_GenericAttribute] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GiftCard]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiftCard](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[IsRecipientNotified] [bit] NOT NULL,
	[Message] [nvarchar](max) NULL,
	[SenderEmail] [nvarchar](max) NULL,
	[SenderName] [nvarchar](max) NULL,
	[RecipientEmail] [nvarchar](max) NULL,
	[RecipientName] [nvarchar](max) NULL,
	[GiftCardCouponCode] [nvarchar](max) NULL,
	[IsGiftCardActivated] [bit] NOT NULL,
	[Amount] [decimal](18, 4) NOT NULL,
	[GiftCardTypeId] [int] NOT NULL,
	[PurchasedWithOrderItemId] [int] NULL,
 CONSTRAINT [PK_GiftCard] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GiftCardUsageHistory]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiftCardUsageHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[UsedValue] [decimal](18, 4) NOT NULL,
	[UsedWithOrderId] [int] NOT NULL,
	[GiftCardId] [int] NOT NULL,
 CONSTRAINT [PK_GiftCardUsageHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IdentityClaims]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IdentityClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdentityResourceId] [int] NOT NULL,
	[Type] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_IdentityClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IdentityProperties]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IdentityProperties](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](250) NOT NULL,
	[Value] [nvarchar](2000) NOT NULL,
	[IdentityResourceId] [int] NOT NULL,
 CONSTRAINT [PK_IdentityProperties] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IdentityResources]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IdentityResources](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[DisplayName] [nvarchar](200) NULL,
	[Emphasize] [bit] NOT NULL,
	[Enabled] [bit] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Required] [bit] NOT NULL,
	[ShowInDiscoveryDocument] [bit] NOT NULL,
	[Created] [datetime2](7) NOT NULL,
	[NonEditable] [bit] NOT NULL,
	[Updated] [datetime2](7) NULL,
 CONSTRAINT [PK_IdentityResources] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Language]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Language](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Published] [bit] NOT NULL,
	[DefaultCurrencyId] [int] NOT NULL,
	[LimitedToStores] [bit] NOT NULL,
	[Rtl] [bit] NOT NULL,
	[FlagImageFileName] [nvarchar](50) NULL,
	[UniqueSeoCode] [nvarchar](2) NULL,
	[LanguageCulture] [nvarchar](20) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LocaleStringResource]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocaleStringResource](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ResourceValue] [nvarchar](max) NOT NULL,
	[ResourceName] [nvarchar](200) NOT NULL,
	[LanguageId] [int] NOT NULL,
 CONSTRAINT [PK_LocaleStringResource] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LocalizedProperty]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocalizedProperty](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LocaleValue] [nvarchar](max) NOT NULL,
	[LocaleKey] [nvarchar](400) NOT NULL,
	[LocaleKeyGroup] [nvarchar](400) NOT NULL,
	[LanguageId] [int] NOT NULL,
	[EntityId] [int] NOT NULL,
 CONSTRAINT [PK_LocalizedProperty] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Log]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[ReferrerUrl] [nvarchar](max) NULL,
	[PageUrl] [nvarchar](max) NULL,
	[CustomerId] [int] NULL,
	[IpAddress] [nvarchar](200) NULL,
	[FullMessage] [nvarchar](max) NULL,
	[ShortMessage] [nvarchar](max) NOT NULL,
	[LogLevelId] [int] NOT NULL,
 CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Manufacturer]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manufacturer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UpdatedOnUtc] [datetime2](7) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[Published] [bit] NOT NULL,
	[LimitedToStores] [bit] NOT NULL,
	[SubjectToAcl] [bit] NOT NULL,
	[PriceRanges] [nvarchar](400) NULL,
	[PageSizeOptions] [nvarchar](200) NULL,
	[AllowCustomersToSelectPageSize] [bit] NOT NULL,
	[PageSize] [int] NOT NULL,
	[PictureId] [int] NOT NULL,
	[MetaTitle] [nvarchar](400) NULL,
	[MetaDescription] [nvarchar](max) NULL,
	[MetaKeywords] [nvarchar](400) NULL,
	[ManufacturerTemplateId] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_Manufacturer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ManufacturerTemplate]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManufacturerTemplate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[ViewPath] [nvarchar](400) NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_ManufacturerTemplate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MeasureDimension]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MeasureDimension](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Ratio] [decimal](18, 8) NOT NULL,
	[SystemKeyword] [nvarchar](100) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_MeasureDimension] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MeasureWeight]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MeasureWeight](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Ratio] [decimal](18, 8) NOT NULL,
	[SystemKeyword] [nvarchar](100) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_MeasureWeight] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MessageTemplate]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MessageTemplate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LimitedToStores] [bit] NOT NULL,
	[EmailAccountId] [int] NOT NULL,
	[AttachedDownloadId] [int] NOT NULL,
	[DelayPeriodId] [int] NOT NULL,
	[DelayBeforeSend] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[Body] [nvarchar](max) NULL,
	[Subject] [nvarchar](1000) NULL,
	[BccEmailAddresses] [nvarchar](200) NULL,
	[Name] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_MessageTemplate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MigrationVersionInfo]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MigrationVersionInfo](
	[AppliedOn] [datetime2](7) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Version] [bigint] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[News]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[News](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[MetaTitle] [nvarchar](400) NULL,
	[MetaDescription] [nvarchar](max) NULL,
	[MetaKeywords] [nvarchar](400) NULL,
	[LimitedToStores] [bit] NOT NULL,
	[AllowComments] [bit] NOT NULL,
	[EndDateUtc] [datetime2](7) NULL,
	[StartDateUtc] [datetime2](7) NULL,
	[Published] [bit] NOT NULL,
	[Full] [nvarchar](max) NOT NULL,
	[Short] [nvarchar](max) NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[LanguageId] [int] NOT NULL,
 CONSTRAINT [PK_News] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NewsComment]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewsComment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[StoreId] [int] NOT NULL,
	[IsApproved] [bit] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[NewsItemId] [int] NOT NULL,
	[CommentText] [nvarchar](max) NULL,
	[CommentTitle] [nvarchar](max) NULL,
 CONSTRAINT [PK_NewsComment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NewsLetterSubscription]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewsLetterSubscription](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[StoreId] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[NewsLetterSubscriptionGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_NewsLetterSubscription] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Order]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RedeemedRewardPointsEntryId] [int] NULL,
	[CustomOrderNumber] [nvarchar](max) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CustomValuesXml] [nvarchar](max) NULL,
	[ShippingRateComputationMethodSystemName] [nvarchar](max) NULL,
	[ShippingMethod] [nvarchar](max) NULL,
	[PaidDateUtc] [datetime2](7) NULL,
	[SubscriptionTransactionId] [nvarchar](max) NULL,
	[CaptureTransactionResult] [nvarchar](max) NULL,
	[CaptureTransactionId] [nvarchar](max) NULL,
	[AuthorizationTransactionResult] [nvarchar](max) NULL,
	[AuthorizationTransactionCode] [nvarchar](max) NULL,
	[AuthorizationTransactionId] [nvarchar](max) NULL,
	[CardExpirationYear] [nvarchar](max) NULL,
	[CardExpirationMonth] [nvarchar](max) NULL,
	[CardCvv2] [nvarchar](max) NULL,
	[MaskedCreditCardNumber] [nvarchar](max) NULL,
	[CardNumber] [nvarchar](max) NULL,
	[CardName] [nvarchar](max) NULL,
	[CardType] [nvarchar](max) NULL,
	[AllowStoringCreditCardNumber] [bit] NOT NULL,
	[CustomerIp] [nvarchar](max) NULL,
	[AffiliateId] [int] NOT NULL,
	[CustomerLanguageId] [int] NOT NULL,
	[CheckoutAttributesXml] [nvarchar](max) NULL,
	[CheckoutAttributeDescription] [nvarchar](max) NULL,
	[RewardPointsHistoryEntryId] [int] NULL,
	[RefundedAmount] [decimal](18, 4) NOT NULL,
	[OrderTotal] [decimal](18, 4) NOT NULL,
	[OrderDiscount] [decimal](18, 4) NOT NULL,
	[OrderTax] [decimal](18, 4) NOT NULL,
	[TaxRates] [nvarchar](max) NULL,
	[PaymentMethodAdditionalFeeExclTax] [decimal](18, 4) NOT NULL,
	[PaymentMethodAdditionalFeeInclTax] [decimal](18, 4) NOT NULL,
	[OrderShippingExclTax] [decimal](18, 4) NOT NULL,
	[OrderShippingInclTax] [decimal](18, 4) NOT NULL,
	[OrderSubTotalDiscountExclTax] [decimal](18, 4) NOT NULL,
	[OrderSubTotalDiscountInclTax] [decimal](18, 4) NOT NULL,
	[OrderSubtotalExclTax] [decimal](18, 4) NOT NULL,
	[OrderSubtotalInclTax] [decimal](18, 4) NOT NULL,
	[VatNumber] [nvarchar](max) NULL,
	[CustomerTaxDisplayTypeId] [int] NOT NULL,
	[CurrencyRate] [decimal](18, 4) NOT NULL,
	[CustomerCurrencyCode] [nvarchar](max) NULL,
	[PaymentMethodSystemName] [nvarchar](max) NULL,
	[PaymentStatusId] [int] NOT NULL,
	[ShippingStatusId] [int] NOT NULL,
	[OrderStatusId] [int] NOT NULL,
	[PickupInStore] [bit] NOT NULL,
	[PickupAddressId] [int] NULL,
	[ShippingAddressId] [int] NULL,
	[BillingAddressId] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[StoreId] [int] NOT NULL,
	[OrderGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderItem]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RentalEndDateUtc] [datetime2](7) NULL,
	[RentalStartDateUtc] [datetime2](7) NULL,
	[ItemWeight] [decimal](18, 4) NULL,
	[LicenseDownloadId] [int] NULL,
	[IsDownloadActivated] [bit] NOT NULL,
	[DownloadCount] [int] NOT NULL,
	[AttributesXml] [nvarchar](max) NULL,
	[AttributeDescription] [nvarchar](max) NULL,
	[OriginalProductCost] [decimal](18, 4) NOT NULL,
	[DiscountAmountExclTax] [decimal](18, 4) NOT NULL,
	[DiscountAmountInclTax] [decimal](18, 4) NOT NULL,
	[PriceExclTax] [decimal](18, 4) NOT NULL,
	[PriceInclTax] [decimal](18, 4) NOT NULL,
	[UnitPriceExclTax] [decimal](18, 4) NOT NULL,
	[UnitPriceInclTax] [decimal](18, 4) NOT NULL,
	[Quantity] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[OrderId] [int] NOT NULL,
	[OrderItemGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_OrderItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderNote]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderNote](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[DisplayToCustomer] [bit] NOT NULL,
	[DownloadId] [int] NOT NULL,
	[Note] [nvarchar](max) NOT NULL,
	[OrderId] [int] NOT NULL,
 CONSTRAINT [PK_OrderNote] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PermissionRecord]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PermissionRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Category] [nvarchar](255) NOT NULL,
	[SystemName] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_PermissionRecord] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PermissionRecord_Role_Mapping]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PermissionRecord_Role_Mapping](
	[CustomerRole_Id] [int] NOT NULL,
	[PermissionRecord_Id] [int] NOT NULL,
 CONSTRAINT [PK_PermissionRecord_Role_Mapping] PRIMARY KEY CLUSTERED 
(
	[PermissionRecord_Id] ASC,
	[CustomerRole_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PersistedGrants]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersistedGrants](
	[Key] [nvarchar](200) NOT NULL,
	[ClientId] [nvarchar](200) NOT NULL,
	[CreationTime] [datetime2](7) NOT NULL,
	[Data] [nvarchar](max) NOT NULL,
	[Expiration] [datetime2](7) NULL,
	[SubjectId] [nvarchar](200) NULL,
	[Type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PersistedGrants] PRIMARY KEY CLUSTERED 
(
	[Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Picture]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Picture](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VirtualPath] [nvarchar](max) NULL,
	[IsNew] [bit] NOT NULL,
	[TitleAttribute] [nvarchar](max) NULL,
	[AltAttribute] [nvarchar](max) NULL,
	[SeoFilename] [nvarchar](300) NULL,
	[MimeType] [nvarchar](40) NOT NULL,
 CONSTRAINT [PK_Picture] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PictureBinary]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PictureBinary](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PictureId] [int] NOT NULL,
	[BinaryData] [varbinary](max) NULL,
 CONSTRAINT [PK_PictureBinary] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Poll]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Poll](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EndDateUtc] [datetime2](7) NULL,
	[StartDateUtc] [datetime2](7) NULL,
	[LimitedToStores] [bit] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[AllowGuestsToVote] [bit] NOT NULL,
	[ShowOnHomepage] [bit] NOT NULL,
	[Published] [bit] NOT NULL,
	[SystemKeyword] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NOT NULL,
	[LanguageId] [int] NOT NULL,
 CONSTRAINT [PK_Poll] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PollAnswer]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PollAnswer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[NumberOfVotes] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[PollId] [int] NOT NULL,
 CONSTRAINT [PK_PollAnswer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PollVotingRecord]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PollVotingRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[PollAnswerId] [int] NOT NULL,
 CONSTRAINT [PK_PollVotingRecord] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PredefinedProductAttributeValue]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PredefinedProductAttributeValue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[IsPreSelected] [bit] NOT NULL,
	[Cost] [decimal](18, 4) NOT NULL,
	[WeightAdjustment] [decimal](18, 4) NOT NULL,
	[PriceAdjustmentUsePercentage] [bit] NOT NULL,
	[PriceAdjustment] [decimal](18, 4) NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
	[ProductAttributeId] [int] NOT NULL,
 CONSTRAINT [PK_PredefinedProductAttributeValue] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UpdatedOnUtc] [datetime2](7) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[Published] [bit] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[AvailableEndDateTimeUtc] [datetime2](7) NULL,
	[AvailableStartDateTimeUtc] [datetime2](7) NULL,
	[Height] [decimal](18, 4) NOT NULL,
	[Width] [decimal](18, 4) NOT NULL,
	[Length] [decimal](18, 4) NOT NULL,
	[Weight] [decimal](18, 4) NOT NULL,
	[HasDiscountsApplied] [bit] NOT NULL,
	[HasTierPrices] [bit] NOT NULL,
	[MarkAsNewEndDateTimeUtc] [datetime2](7) NULL,
	[MarkAsNewStartDateTimeUtc] [datetime2](7) NULL,
	[MarkAsNew] [bit] NOT NULL,
	[BasepriceBaseUnitId] [int] NOT NULL,
	[BasepriceBaseAmount] [decimal](18, 4) NOT NULL,
	[BasepriceUnitId] [int] NOT NULL,
	[BasepriceAmount] [decimal](18, 4) NOT NULL,
	[BasepriceEnabled] [bit] NOT NULL,
	[MaximumCustomerEnteredPrice] [decimal](18, 4) NOT NULL,
	[MinimumCustomerEnteredPrice] [decimal](18, 4) NOT NULL,
	[CustomerEntersPrice] [bit] NOT NULL,
	[ProductCost] [decimal](18, 4) NOT NULL,
	[OldPrice] [decimal](18, 4) NOT NULL,
	[Price] [decimal](18, 4) NOT NULL,
	[CallForPrice] [bit] NOT NULL,
	[PreOrderAvailabilityStartDateTimeUtc] [datetime2](7) NULL,
	[AvailableForPreOrder] [bit] NOT NULL,
	[DisableWishlistButton] [bit] NOT NULL,
	[DisableBuyButton] [bit] NOT NULL,
	[NotReturnable] [bit] NOT NULL,
	[AllowAddingOnlyExistingAttributeCombinations] [bit] NOT NULL,
	[AllowedQuantities] [nvarchar](1000) NULL,
	[OrderMaximumQuantity] [int] NOT NULL,
	[OrderMinimumQuantity] [int] NOT NULL,
	[AllowBackInStockSubscriptions] [bit] NOT NULL,
	[BackorderModeId] [int] NOT NULL,
	[NotifyAdminForQuantityBelow] [int] NOT NULL,
	[LowStockActivityId] [int] NOT NULL,
	[MinStockQuantity] [int] NOT NULL,
	[DisplayStockQuantity] [bit] NOT NULL,
	[DisplayStockAvailability] [bit] NOT NULL,
	[StockQuantity] [int] NOT NULL,
	[WarehouseId] [int] NOT NULL,
	[UseMultipleWarehouses] [bit] NOT NULL,
	[ProductAvailabilityRangeId] [int] NOT NULL,
	[ManageInventoryMethodId] [int] NOT NULL,
	[IsTelecommunicationsOrBroadcastingOrElectronicServices] [bit] NOT NULL,
	[TaxCategoryId] [int] NOT NULL,
	[IsTaxExempt] [bit] NOT NULL,
	[DeliveryDateId] [int] NOT NULL,
	[AdditionalShippingCharge] [decimal](18, 4) NOT NULL,
	[ShipSeparately] [bit] NOT NULL,
	[IsFreeShipping] [bit] NOT NULL,
	[IsShipEnabled] [bit] NOT NULL,
	[RentalPricePeriodId] [int] NOT NULL,
	[RentalPriceLength] [int] NOT NULL,
	[IsRental] [bit] NOT NULL,
	[RecurringTotalCycles] [int] NOT NULL,
	[RecurringCyclePeriodId] [int] NOT NULL,
	[RecurringCycleLength] [int] NOT NULL,
	[IsRecurring] [bit] NOT NULL,
	[UserAgreementText] [nvarchar](max) NULL,
	[HasUserAgreement] [bit] NOT NULL,
	[SampleDownloadId] [int] NOT NULL,
	[HasSampleDownload] [bit] NOT NULL,
	[DownloadActivationTypeId] [int] NOT NULL,
	[DownloadExpirationDays] [int] NULL,
	[MaxNumberOfDownloads] [int] NOT NULL,
	[UnlimitedDownloads] [bit] NOT NULL,
	[DownloadId] [int] NOT NULL,
	[IsDownload] [bit] NOT NULL,
	[AutomaticallyAddRequiredProducts] [bit] NOT NULL,
	[RequiredProductIds] [nvarchar](1000) NULL,
	[RequireOtherProducts] [bit] NOT NULL,
	[OverriddenGiftCardAmount] [decimal](18, 4) NULL,
	[GiftCardTypeId] [int] NOT NULL,
	[IsGiftCard] [bit] NOT NULL,
	[Gtin] [nvarchar](400) NULL,
	[ManufacturerPartNumber] [nvarchar](400) NULL,
	[Sku] [nvarchar](400) NULL,
	[LimitedToStores] [bit] NOT NULL,
	[SubjectToAcl] [bit] NOT NULL,
	[NotApprovedTotalReviews] [int] NOT NULL,
	[ApprovedTotalReviews] [int] NOT NULL,
	[NotApprovedRatingSum] [int] NOT NULL,
	[ApprovedRatingSum] [int] NOT NULL,
	[AllowCustomerReviews] [bit] NOT NULL,
	[MetaTitle] [nvarchar](400) NULL,
	[MetaDescription] [nvarchar](max) NULL,
	[MetaKeywords] [nvarchar](400) NULL,
	[ShowOnHomepage] [bit] NOT NULL,
	[VendorId] [int] NOT NULL,
	[ProductTemplateId] [int] NOT NULL,
	[AdminComment] [nvarchar](max) NULL,
	[FullDescription] [nvarchar](max) NULL,
	[ShortDescription] [nvarchar](max) NULL,
	[Name] [nvarchar](400) NOT NULL,
	[VisibleIndividually] [bit] NOT NULL,
	[ParentGroupedProductId] [int] NOT NULL,
	[ProductTypeId] [int] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product_Category_Mapping]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Category_Mapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[IsFeaturedProduct] [bit] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
 CONSTRAINT [PK_Product_Category_Mapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product_Manufacturer_Mapping]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Manufacturer_Mapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[IsFeaturedProduct] [bit] NOT NULL,
	[ManufacturerId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
 CONSTRAINT [PK_Product_Manufacturer_Mapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product_Picture_Mapping]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Picture_Mapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[PictureId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
 CONSTRAINT [PK_Product_Picture_Mapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product_ProductAttribute_Mapping]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_ProductAttribute_Mapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ConditionAttributeXml] [nvarchar](max) NULL,
	[DefaultValue] [nvarchar](max) NULL,
	[ValidationFileMaximumSize] [int] NULL,
	[ValidationFileAllowedExtensions] [nvarchar](max) NULL,
	[ValidationMaxLength] [int] NULL,
	[ValidationMinLength] [int] NULL,
	[DisplayOrder] [int] NOT NULL,
	[AttributeControlTypeId] [int] NOT NULL,
	[IsRequired] [bit] NOT NULL,
	[TextPrompt] [nvarchar](max) NULL,
	[ProductAttributeId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
 CONSTRAINT [PK_Product_ProductAttribute_Mapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product_ProductTag_Mapping]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_ProductTag_Mapping](
	[ProductTag_Id] [int] NOT NULL,
	[Product_Id] [int] NOT NULL,
 CONSTRAINT [PK_Product_ProductTag_Mapping] PRIMARY KEY CLUSTERED 
(
	[Product_Id] ASC,
	[ProductTag_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product_SpecificationAttribute_Mapping]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_SpecificationAttribute_Mapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[ShowOnProductPage] [bit] NOT NULL,
	[AllowFiltering] [bit] NOT NULL,
	[CustomValue] [nvarchar](4000) NULL,
	[SpecificationAttributeOptionId] [int] NOT NULL,
	[AttributeTypeId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
 CONSTRAINT [PK_Product_SpecificationAttribute_Mapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductAttribute]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductAttribute](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ProductAttribute] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductAttributeCombination]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductAttributeCombination](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PictureId] [int] NOT NULL,
	[NotifyAdminForQuantityBelow] [int] NOT NULL,
	[OverriddenPrice] [decimal](18, 4) NULL,
	[Gtin] [nvarchar](400) NULL,
	[ManufacturerPartNumber] [nvarchar](400) NULL,
	[Sku] [nvarchar](400) NULL,
	[AllowOutOfStockOrders] [bit] NOT NULL,
	[StockQuantity] [int] NOT NULL,
	[AttributesXml] [nvarchar](max) NULL,
	[ProductId] [int] NOT NULL,
 CONSTRAINT [PK_ProductAttributeCombination] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductAttributeValue]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductAttributeValue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PictureId] [int] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[IsPreSelected] [bit] NOT NULL,
	[Quantity] [int] NOT NULL,
	[CustomerEntersQty] [bit] NOT NULL,
	[Cost] [decimal](18, 4) NOT NULL,
	[WeightAdjustment] [decimal](18, 4) NOT NULL,
	[PriceAdjustmentUsePercentage] [bit] NOT NULL,
	[PriceAdjustment] [decimal](18, 4) NOT NULL,
	[ImageSquaresPictureId] [int] NOT NULL,
	[ColorSquaresRgb] [nvarchar](100) NULL,
	[Name] [nvarchar](400) NOT NULL,
	[AssociatedProductId] [int] NOT NULL,
	[AttributeValueTypeId] [int] NOT NULL,
	[ProductAttributeMappingId] [int] NOT NULL,
 CONSTRAINT [PK_ProductAttributeValue] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductAvailabilityRange]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductAvailabilityRange](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_ProductAvailabilityRange] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductReview]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductReview](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[HelpfulNoTotal] [int] NOT NULL,
	[HelpfulYesTotal] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[CustomerNotifiedOfReply] [bit] NOT NULL,
	[ReplyText] [nvarchar](max) NULL,
	[ReviewText] [nvarchar](max) NULL,
	[Title] [nvarchar](max) NULL,
	[IsApproved] [bit] NOT NULL,
	[StoreId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
 CONSTRAINT [PK_ProductReview] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductReview_ReviewType_Mapping]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductReview_ReviewType_Mapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Rating] [int] NOT NULL,
	[ReviewTypeId] [int] NOT NULL,
	[ProductReviewId] [int] NOT NULL,
 CONSTRAINT [PK_ProductReview_ReviewType_Mapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductReviewHelpfulness]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductReviewHelpfulness](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[WasHelpful] [bit] NOT NULL,
	[ProductReviewId] [int] NOT NULL,
 CONSTRAINT [PK_ProductReviewHelpfulness] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductTag]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductTag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_ProductTag] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductTemplate]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductTemplate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IgnoredProductTypes] [nvarchar](max) NULL,
	[DisplayOrder] [int] NOT NULL,
	[ViewPath] [nvarchar](400) NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_ProductTemplate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductWarehouseInventory]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductWarehouseInventory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReservedQuantity] [int] NOT NULL,
	[StockQuantity] [int] NOT NULL,
	[WarehouseId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
 CONSTRAINT [PK_ProductWarehouseInventory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[QueuedEmail]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QueuedEmail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmailAccountId] [int] NOT NULL,
	[SentOnUtc] [datetime2](7) NULL,
	[SentTries] [int] NOT NULL,
	[DontSendBeforeDateUtc] [datetime2](7) NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[AttachedDownloadId] [int] NOT NULL,
	[AttachmentFileName] [nvarchar](max) NULL,
	[AttachmentFilePath] [nvarchar](max) NULL,
	[Body] [nvarchar](max) NULL,
	[Subject] [nvarchar](1000) NULL,
	[Bcc] [nvarchar](500) NULL,
	[CC] [nvarchar](500) NULL,
	[ReplyToName] [nvarchar](500) NULL,
	[ReplyTo] [nvarchar](500) NULL,
	[ToName] [nvarchar](500) NULL,
	[To] [nvarchar](500) NOT NULL,
	[FromName] [nvarchar](500) NULL,
	[From] [nvarchar](500) NOT NULL,
	[PriorityId] [int] NOT NULL,
 CONSTRAINT [PK_QueuedEmail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RecurringPayment]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecurringPayment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[InitialOrderId] [int] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[LastPaymentFailed] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[StartDateUtc] [datetime2](7) NOT NULL,
	[TotalCycles] [int] NOT NULL,
	[CyclePeriodId] [int] NOT NULL,
	[CycleLength] [int] NOT NULL,
 CONSTRAINT [PK_RecurringPayment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RecurringPaymentHistory]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecurringPaymentHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[OrderId] [int] NOT NULL,
	[RecurringPaymentId] [int] NOT NULL,
 CONSTRAINT [PK_RecurringPaymentHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RefreshTokens]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RefreshTokens](
	[Token] [nvarchar](max) NULL,
	[JwtId] [nvarchar](max) NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[ExpiryDate] [datetime2](7) NOT NULL,
	[Used] [bit] NOT NULL,
	[Invalidated] [bit] NOT NULL,
	[UserId] [nvarchar](450) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RelatedProduct]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelatedProduct](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[ProductId2] [int] NOT NULL,
	[ProductId1] [int] NOT NULL,
 CONSTRAINT [PK_RelatedProduct] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReturnRequest]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnRequest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UpdatedOnUtc] [datetime2](7) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[ReturnRequestStatusId] [int] NOT NULL,
	[StaffNotes] [nvarchar](max) NULL,
	[UploadedFileId] [int] NOT NULL,
	[CustomerComments] [nvarchar](max) NULL,
	[RequestedAction] [nvarchar](max) NOT NULL,
	[ReasonForReturn] [nvarchar](max) NOT NULL,
	[Quantity] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[OrderItemId] [int] NOT NULL,
	[StoreId] [int] NOT NULL,
	[CustomNumber] [nvarchar](max) NULL,
 CONSTRAINT [PK_ReturnRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReturnRequestAction]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnRequestAction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_ReturnRequestAction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReturnRequestReason]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnRequestReason](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_ReturnRequestReason] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReviewType]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReviewType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsRequired] [bit] NOT NULL,
	[VisibleToAllCustomers] [bit] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Description] [nvarchar](400) NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_ReviewType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RewardPointsHistory]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RewardPointsHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[ValidPoints] [int] NULL,
	[EndDateUtc] [datetime2](7) NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[Message] [nvarchar](max) NULL,
	[UsedAmount] [decimal](18, 4) NOT NULL,
	[PointsBalance] [int] NULL,
	[Points] [int] NOT NULL,
	[StoreId] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
 CONSTRAINT [PK_RewardPointsHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ScheduleTask]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScheduleTask](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LastSuccessUtc] [datetime2](7) NULL,
	[LastEndUtc] [datetime2](7) NULL,
	[LastStartUtc] [datetime2](7) NULL,
	[StopOnError] [bit] NOT NULL,
	[Enabled] [bit] NOT NULL,
	[Type] [nvarchar](max) NOT NULL,
	[Seconds] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ScheduleTask] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SearchTerm]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchTerm](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Count] [int] NOT NULL,
	[StoreId] [int] NOT NULL,
	[Keyword] [nvarchar](max) NULL,
 CONSTRAINT [PK_SearchTerm] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Setting]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Setting](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StoreId] [int] NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Setting] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Shipment]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shipment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[AdminComment] [nvarchar](max) NULL,
	[DeliveryDateUtc] [datetime2](7) NULL,
	[ShippedDateUtc] [datetime2](7) NULL,
	[TotalWeight] [decimal](18, 4) NULL,
	[TrackingNumber] [nvarchar](max) NULL,
	[OrderId] [int] NOT NULL,
 CONSTRAINT [PK_Shipment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShipmentItem]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShipmentItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WarehouseId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[OrderItemId] [int] NOT NULL,
	[ShipmentId] [int] NOT NULL,
 CONSTRAINT [PK_ShipmentItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShippingMethod]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShippingMethod](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_ShippingMethod] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShippingMethodRestrictions]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShippingMethodRestrictions](
	[Country_Id] [int] NOT NULL,
	[ShippingMethod_Id] [int] NOT NULL,
 CONSTRAINT [PK_ShippingMethodRestrictions] PRIMARY KEY CLUSTERED 
(
	[ShippingMethod_Id] ASC,
	[Country_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShoppingCartItem]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoppingCartItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UpdatedOnUtc] [datetime2](7) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[RentalEndDateUtc] [datetime2](7) NULL,
	[RentalStartDateUtc] [datetime2](7) NULL,
	[Quantity] [int] NOT NULL,
	[CustomerEnteredPrice] [decimal](18, 4) NOT NULL,
	[AttributesXml] [nvarchar](max) NULL,
	[ProductId] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[ShoppingCartTypeId] [int] NOT NULL,
	[StoreId] [int] NOT NULL,
 CONSTRAINT [PK_ShoppingCartItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SpecificationAttribute]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpecificationAttribute](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_SpecificationAttribute] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SpecificationAttributeOption]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpecificationAttributeOption](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[ColorSquaresRgb] [nvarchar](100) NULL,
	[Name] [nvarchar](max) NOT NULL,
	[SpecificationAttributeId] [int] NOT NULL,
 CONSTRAINT [PK_SpecificationAttributeOption] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StateProvince]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StateProvince](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Published] [bit] NOT NULL,
	[Abbreviation] [nvarchar](100) NULL,
	[Name] [nvarchar](100) NOT NULL,
	[CountryId] [int] NOT NULL,
 CONSTRAINT [PK_StateProvince] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StockQuantityHistory]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockQuantityHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WarehouseId] [int] NULL,
	[CombinationId] [int] NULL,
	[ProductId] [int] NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[Message] [nvarchar](max) NULL,
	[StockQuantity] [int] NOT NULL,
	[QuantityAdjustment] [int] NOT NULL,
 CONSTRAINT [PK_StockQuantityHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Store]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CompanyVat] [nvarchar](1000) NULL,
	[CompanyPhoneNumber] [nvarchar](1000) NULL,
	[CompanyAddress] [nvarchar](1000) NULL,
	[CompanyName] [nvarchar](1000) NULL,
	[DisplayOrder] [int] NOT NULL,
	[DefaultLanguageId] [int] NOT NULL,
	[Hosts] [nvarchar](1000) NULL,
	[SslEnabled] [bit] NOT NULL,
	[Url] [nvarchar](400) NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_Store] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StoreMapping]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StoreMapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StoreId] [int] NOT NULL,
	[EntityName] [nvarchar](400) NOT NULL,
	[EntityId] [int] NOT NULL,
 CONSTRAINT [PK_StoreMapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaxCategory]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaxCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_TaxCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TierPrice]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TierPrice](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EndDateTimeUtc] [datetime2](7) NULL,
	[StartDateTimeUtc] [datetime2](7) NULL,
	[Price] [decimal](18, 4) NOT NULL,
	[Quantity] [int] NOT NULL,
	[CustomerRoleId] [int] NULL,
	[StoreId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
 CONSTRAINT [PK_TierPrice] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Topic]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Topic](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LimitedToStores] [bit] NOT NULL,
	[SubjectToAcl] [bit] NOT NULL,
	[MetaTitle] [nvarchar](max) NULL,
	[MetaDescription] [nvarchar](max) NULL,
	[MetaKeywords] [nvarchar](max) NULL,
	[TopicTemplateId] [int] NOT NULL,
	[Published] [bit] NOT NULL,
	[Body] [nvarchar](max) NULL,
	[Title] [nvarchar](max) NULL,
	[Password] [nvarchar](max) NULL,
	[IsPasswordProtected] [bit] NOT NULL,
	[AccessibleWhenStoreClosed] [bit] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[IncludeInFooterColumn3] [bit] NOT NULL,
	[IncludeInFooterColumn2] [bit] NOT NULL,
	[IncludeInFooterColumn1] [bit] NOT NULL,
	[IncludeInTopMenu] [bit] NOT NULL,
	[IncludeInSitemap] [bit] NOT NULL,
	[SystemName] [nvarchar](max) NULL,
 CONSTRAINT [PK_Topic] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TopicTemplate]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TopicTemplate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[ViewPath] [nvarchar](400) NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_TopicTemplate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UrlRecord]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UrlRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LanguageId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Slug] [nvarchar](400) NOT NULL,
	[EntityName] [nvarchar](400) NOT NULL,
	[EntityId] [int] NOT NULL,
 CONSTRAINT [PK_UrlRecord] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Vendor]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vendor](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PageSizeOptions] [nvarchar](200) NULL,
	[AllowCustomersToSelectPageSize] [bit] NOT NULL,
	[PageSize] [int] NOT NULL,
	[MetaTitle] [nvarchar](400) NULL,
	[MetaDescription] [nvarchar](max) NULL,
	[MetaKeywords] [nvarchar](400) NULL,
	[DisplayOrder] [int] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
	[AdminComment] [nvarchar](max) NULL,
	[AddressId] [int] NOT NULL,
	[PictureId] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Email] [nvarchar](400) NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_Vendor] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VendorAttribute]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendorAttribute](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AttributeControlTypeId] [int] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[IsRequired] [bit] NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_VendorAttribute] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VendorAttributeValue]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendorAttributeValue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VendorAttributeId] [int] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[IsPreSelected] [bit] NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_VendorAttributeValue] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VendorNote]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendorNote](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOnUtc] [datetime2](7) NOT NULL,
	[Note] [nvarchar](max) NOT NULL,
	[VendorId] [int] NOT NULL,
 CONSTRAINT [PK_VendorNote] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Warehouse]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehouse](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AddressId] [int] NOT NULL,
	[AdminComment] [nvarchar](max) NULL,
	[Name] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_Warehouse] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  View [dbo].[FooterColumn1]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[FooterColumn1] AS
SELECT FooterTopics.*,Slug SeName FROM 
(SELECT Id,Title FROM dbo.Topic
WHERE IncludeInFooterColumn1 = 1) FooterTopics
	INNER JOIN dbo.UrlRecord
		ON dbo.UrlRecord.EntityId = FooterTopics.Id AND dbo.UrlRecord.EntityName = 'Topic'




GO
/****** Object:  View [dbo].[FooterColumn2]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[FooterColumn2] AS
SELECT FooterTopics.*,Slug SeName FROM 
(SELECT Id,Title FROM dbo.Topic
WHERE IncludeInFooterColumn2 = 1) FooterTopics
	INNER JOIN dbo.UrlRecord
		ON dbo.UrlRecord.EntityId = FooterTopics.Id AND dbo.UrlRecord.EntityName = 'Topic'




GO
/****** Object:  View [dbo].[FooterColumn3]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[FooterColumn3] AS
SELECT FooterTopics.*,Slug SeName FROM 
(SELECT Id,Title FROM dbo.Topic
WHERE IncludeInFooterColumn3 = 1) FooterTopics
	INNER JOIN dbo.UrlRecord
		ON dbo.UrlRecord.EntityId = FooterTopics.Id AND dbo.UrlRecord.EntityName = 'Topic'




GO
/****** Object:  View [dbo].[FooterColumns]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[FooterColumns] AS
SELECT 

ISNULL('['+STUFF
	(( SELECT ',' + '{ "Id": ' + CAST(Col1.Id AS nvarchar(10)) + ', "Title":"' + ISNULL(Col1.Title,'') + '", "SeName":"' + ISNULL(Col1.SeName,'')  + '" }' 
	FROM dbo.FooterColumn1 Col1  FOR XML PATH('') ), 1, 1, '') 
	+']','[]') FooterColumn1,
ISNULL('['+STUFF
	(( SELECT ',' + '{ "Id": ' + CAST(Col2.Id AS nvarchar(10)) + ', "Title":"' + ISNULL(Col2.Title,'') + '", "SeName":"' + ISNULL(Col2.SeName,'')  + '" }' 
	FROM dbo.FooterColumn2 Col2  FOR XML PATH('') ), 1, 1, '') 
	+']','[]') FooterColumn2,
ISNULL('['+STUFF
	(( SELECT ',' + '{ "Id": ' + CAST(Col3.Id AS nvarchar(10)) + ', "Title":"' + ISNULL(Col3.Title,'') + '", "SeName":"' + ISNULL(Col3.SeName,'')  + '" }' 
	FROM dbo.FooterColumn3 Col3  FOR XML PATH('') ), 1, 1, '') 
	+']','[]') FooterColumn3



GO
/****** Object:  View [dbo].[PictureJsonView]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PictureJsonView] AS
SELECT Id,
'{ "Id": ' + CAST(P.Id AS nvarchar(10)) + ', "MimeType":"' + ISNULL(P.MimeType,'') + '", "SeoFilename":"' + ISNULL(P.SeoFilename,'')  + '" }' Json
	
FROM dbo.Picture P



GO
/****** Object:  View [dbo].[ProductsView]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ProductsView] AS
SELECT P.[Id]
      ,P.[Name]
      ,[ShowOnHomepage]
      ,[Price]
      ,P.[DisplayOrder]
      ,[Published]
	  ,PC.CategoryId
      ,[Deleted]
      ,PT.ViewPath TemplateName
	  ,UR.Slug SeName
	  ,P.FullDescription
	  
,ISNULL('['+STUFF
	(( SELECT ',' + Prod.Json
FROM dbo.Product_Picture_Mapping PP INNER JOIN
dbo.PictureJsonView Prod ON PP.PictureId = Prod.Id
WHERE ProductId = P.Id ORDER BY PP.DisplayOrder FOR XML PATH('') ), 1, 1, '') 
	+']','[]') PicturesJson

  FROM [dbo].[Product] P INNER JOIN
	dbo.Product_Category_Mapping PC
	ON PC.ProductId = P.Id
	INNER JOIN dbo.ProductTemplate PT
	ON P.ProductTemplateId = PT.Id
	INNER JOIN dbo.UrlRecord UR
	ON P.Id = UR.EntityId AND UR.IsActive = 1 AND UR.EntityName = 'Product'




GO
/****** Object:  View [dbo].[TopMenuCategories]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[TopMenuCategories] AS
SELECT TopMenuCategories.*,Slug SeName FROM 
(SELECT Id,Name,ParentCategoryId FROM dbo.Category
WHERE IncludeInTopMenu = 1) TopMenuCategories
	INNER JOIN dbo.UrlRecord
		ON dbo.UrlRecord.EntityId = TopMenuCategories.Id AND dbo.UrlRecord.IsActive = 1 AND dbo.UrlRecord.EntityName = 'Category'




GO
/****** Object:  View [dbo].[TopMenuTopics]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TopMenuTopics] AS
SELECT TopMenuTopics.*,Slug SeName FROM 
(SELECT Id,Title FROM dbo.Topic
WHERE IncludeInTopMenu = 1) TopMenuTopics
	INNER JOIN dbo.UrlRecord
		ON dbo.UrlRecord.EntityId = TopMenuTopics.Id AND dbo.UrlRecord.EntityName = 'Topic'



GO
/****** Object:  View [dbo].[TopMenu]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TopMenu] AS
SELECT 

ISNULL('['+STUFF
	(( SELECT ',' + '{ "Id": ' + CAST(Topic.Id AS nvarchar(10)) + ', "Title":"' + ISNULL(Topic.Title,'') + '", "SeName":"' + ISNULL(Topic.SeName,'')  + '" }' 
	FROM dbo.TopMenuTopics Topic  FOR XML PATH('') ), 1, 1, '') 
	+']','[]') Topics,
ISNULL('['+STUFF
	(( SELECT ',' + '{ "Id": ' + CAST(Category.Id AS nvarchar(10)) + ', "ParentId": ' + CAST(Category.ParentCategoryId AS nvarchar(10)) + ', "Name":"' + ISNULL(Category.Name,'') + '", "SeName":"' + ISNULL(Category.SeName,'')  + '" }' 
	FROM dbo.TopMenuCategories Category FOR XML PATH('') ), 1, 1, '') 
	+']','[]') Categories



GO
/****** Object:  View [dbo].[AddressDetailView]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE view [dbo].[AddressDetailView]
as
select ad.*,ct.Name as CountryName,ct.ThreeLetterIsoCode as CountryCode,st.Name as StateProvinceName  from dbo.[Address] ad  LEFT JOIN   dbo.[StateProvince] st ON ad.StateProvinceId = st.Id  LEFT JOIN  dbo.[Country]ct
ON ad.CountryId = ct.Id












GO
/****** Object:  View [dbo].[ProductAttributeView]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE View  [dbo].[ProductAttributeView] as
select Product.Id,Product.Name,(
		SELECT ProductAttributeMapping.*,ProductAttribute.Name ProductAttributeName,
		(
			SELECT *
			FROM dbo.ProductAttributeValue ProductAttributeValue
			WHERE ProductAttributeValue.ProductAttributeMappingId = ProductAttributeMapping.Id
			FOR XML PATH('AttributeValue'), ROOT('AttributeValues'), TYPE
		) 
		FROM dbo.Product_ProductAttribute_Mapping ProductAttributeMapping
			INNER JOIN dbo.ProductAttribute ProductAttribute
			ON ProductAttribute.Id = ProductAttributeMapping.ProductAttributeId
		WHERE Product.Id = ProductAttributeMapping.ProductId 
		FOR XML PATH('ProductAttribute'), ROOT('ProductAttributes'), TYPE) as ProductAttributeXml from dbo.Product

GO
/****** Object:  View [dbo].[OrderDetailView]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE View  [dbo].[OrderDetailView]
as
select ord.*,
(select * from dbo.[AddressDetailView] WHERE dbo.[AddressDetailView].Id = ord.BillingAddressId  FOR XML PATH('Address'),Type ) as BillingAddressXml,
(select * from dbo.[AddressDetailView] WHERE dbo.[AddressDetailView].Id = ord.ShippingAddressId  FOR XML PATH('Address'),Type ) as ShippingAddressXml,

            (SELECT o.*,p.Name as ProductName,p.ProductAttributeXml
            FROM OrderItem o,ProductAttributeView p
			where o.OrderId = ord.Id
			and o.ProductId = p.Id
            FOR XML PATH('OrderItem'),Root ('OrderItems'),Type ) as OrderItemsXml
			
            

from dbo.[Order] ord, dbo.Customer cust 
where 
cust.Id = ord.CustomerId









GO
/****** Object:  View [dbo].[CustomerView]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE view [dbo].[CustomerView]
as
select cust.* ,
            (SELECT *
            FROM GenericAttribute g
			where g.EntityId = cust.Id
            For XML PATH('GenericAttribute'),Root('GenericAttributes'),Type  ) as GenericAttributesXml,
            (SELECT a.* 
			FROM AddressDetailView a,CustomerAddresses ca
			where  a.Id = ca.Address_Id and 
			ca.Customer_Id = cust.Id
            FOR XML PATH('Address'), ROOT('Addresses'), TYPE ) as AddressesXml,
			(SELECT * FROM dbo.OrderDetailView od WHERE od.CustomerId = cust.Id
			FOR XML PATH('Order'),Root('Orders'),Type) as OrdersXml
			
			
			          	  		
from  dbo.Customer cust














GO
/****** Object:  View [dbo].[LayoutItems]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[LayoutItems] AS
SELECT *
FROM
dbo.TopMenu,dbo.FooterColumns




GO
/****** Object:  View [dbo].[CustomerDetailView]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE view [dbo].[CustomerDetailView]
as
select cust.* ,
            (SELECT *
            FROM GenericAttribute g
where g.EntityId = cust.Id
            For XML PATH('GenericAttribute'),Root('GenericAttributes'),Type  ) as GenericAttributesXml,
            (SELECT a.*
FROM AddressDetailView a,CustomerAddresses ca
where  a.Id = ca.Address_Id and
ca.Customer_Id = cust.Id
            FOR XML PATH('Address'), ROOT('Addresses'), TYPE ) as AddressesXml,
(SELECT * FROM dbo.OrderDetailView od WHERE od.CustomerId = cust.Id
FOR XML PATH('Order'),Root('Orders'),Type) as OrdersXml


           
from  dbo.Customer cust














GO
/****** Object:  View [dbo].[ShoppingCartView]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[ShoppingCartView] AS
SELECT pa.ProductAttributeXml, CartItem.*,Prices.Price PricePerUnit, Prices.Price * CartItem.Quantity TotalPrice FROM dbo.ShoppingCartItem CartItem
CROSS APPLY (SELECT XMLData = CAST(CartItem.AttributesXml AS XML)) XmlInfo
CROSS APPLY (

SELECT SUM(Price) Price FROM (SELECT dbo.ProductAttributeValue.PriceAdjustment Price
FROM ((SELECT 
	C.value('../../@ID','int') AS ProductAttributeId,
	ISNULL(TRY_CONVERT(INT,C.value('./self::node()','NVARCHAR(MAX)')), 0) AS ProductAttributeValueId
FROM XmlInfo.XMLData.nodes('/Attributes/ProductAttribute/ProductAttributeValue/Value') AS T(C)) Attribute
	INNER JOIN dbo.ProductAttributeValue ON Attribute.ProductAttributeValueId = dbo.ProductAttributeValue.Id 
	)
UNION ALL
SELECT dbo.Product.Price FROM dbo.Product WHERE Id = CartItem.ProductId) CartItemPrices
) Prices,

dbo.ProductAttributeView pa
Where pa.Id = CartItem.ProductId

GO
/****** Object:  View [dbo].[CategoryView]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[CategoryView] AS
SELECT Cat.*,UR.Slug SeName, P.MimeType PictureMimeType, P.SeoFilename PictureSeoFilename 
,
ISNULL('['+STUFF
	(( SELECT ',' + CAST(CP.ProductId AS nvarchar(10)) 
	FROM dbo.Product_Category_Mapping CP
	WHERE CP.CategoryId = Cat.Id
	FOR XML PATH('') ), 1, 1, '') 
	+']','[]') ProductIds

FROM
(SELECT C.Id,C.Name,Ct.ViewPath TemplateName,ShowOnHomepage,C.DisplayOrder,Published,ParentCategoryId as ParentId,PictureId 
FROM dbo.Category C INNER JOIN dbo.CategoryTemplate CT
	ON C.CategoryTemplateId = CT.Id ) Cat
	INNER JOIN dbo.UrlRecord UR
	ON UR.IsActive = 1 AND UR.EntityName = 'Category' AND UR.EntityId = Cat.Id
	LEFT OUTER JOIN dbo.Picture P
	ON Cat.PictureId = P.Id









GO
/****** Object:  Index [IX_AclRecord_CustomerRoleId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_AclRecord_CustomerRoleId] ON [dbo].[AclRecord]
(
	[CustomerRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AclRecord_EntityId_EntityName]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_AclRecord_EntityId_EntityName] ON [dbo].[AclRecord]
(
	[EntityId] ASC,
	[EntityName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ActivityLog_ActivityLogTypeId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ActivityLog_ActivityLogTypeId] ON [dbo].[ActivityLog]
(
	[ActivityLogTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ActivityLog_CreatedOnUtc]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ActivityLog_CreatedOnUtc] ON [dbo].[ActivityLog]
(
	[CreatedOnUtc] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ActivityLog_CustomerId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ActivityLog_CustomerId] ON [dbo].[ActivityLog]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Address_CountryId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Address_CountryId] ON [dbo].[Address]
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Address_StateProvinceId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Address_StateProvinceId] ON [dbo].[Address]
(
	[StateProvinceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_AddressAttributeValue_AddressAttributeId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_AddressAttributeValue_AddressAttributeId] ON [dbo].[AddressAttributeValue]
(
	[AddressAttributeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Affiliate_AddressId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Affiliate_AddressId] ON [dbo].[Affiliate]
(
	[AddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ApiClaims_ApiResourceId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ApiClaims_ApiResourceId] ON [dbo].[ApiClaims]
(
	[ApiResourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ApiProperties_ApiResourceId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ApiProperties_ApiResourceId] ON [dbo].[ApiProperties]
(
	[ApiResourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ApiResources_Name]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ApiResources_Name] ON [dbo].[ApiResources]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ApiScopeClaims_ApiScopeId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ApiScopeClaims_ApiScopeId] ON [dbo].[ApiScopeClaims]
(
	[ApiScopeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ApiScopes_ApiResourceId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ApiScopes_ApiResourceId] ON [dbo].[ApiScopes]
(
	[ApiResourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ApiScopes_Name]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ApiScopes_Name] ON [dbo].[ApiScopes]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ApiSecrets_ApiResourceId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ApiSecrets_ApiResourceId] ON [dbo].[ApiSecrets]
(
	[ApiResourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_BackInStockSubscription_CustomerId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_BackInStockSubscription_CustomerId] ON [dbo].[BackInStockSubscription]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_BackInStockSubscription_ProductId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_BackInStockSubscription_ProductId] ON [dbo].[BackInStockSubscription]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_BlogComment_BlogPostId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_BlogComment_BlogPostId] ON [dbo].[BlogComment]
(
	[BlogPostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_BlogComment_CustomerId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_BlogComment_CustomerId] ON [dbo].[BlogComment]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_BlogComment_StoreId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_BlogComment_StoreId] ON [dbo].[BlogComment]
(
	[StoreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_BlogPost_LanguageId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_BlogPost_LanguageId] ON [dbo].[BlogPost]
(
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Category_Deleted_Extended]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Category_Deleted_Extended] ON [dbo].[Category]
(
	[Deleted] ASC
)
INCLUDE ( 	[Id],
	[Name],
	[SubjectToAcl],
	[LimitedToStores],
	[Published]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Category_DisplayOrder]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Category_DisplayOrder] ON [dbo].[Category]
(
	[DisplayOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Category_LimitedToStores]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Category_LimitedToStores] ON [dbo].[Category]
(
	[LimitedToStores] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Category_ParentCategoryId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Category_ParentCategoryId] ON [dbo].[Category]
(
	[ParentCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Category_SubjectToAcl]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Category_SubjectToAcl] ON [dbo].[Category]
(
	[SubjectToAcl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CheckoutAttributeValue_CheckoutAttributeId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_CheckoutAttributeValue_CheckoutAttributeId] ON [dbo].[CheckoutAttributeValue]
(
	[CheckoutAttributeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClientClaims_ClientId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ClientClaims_ClientId] ON [dbo].[ClientClaims]
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClientCorsOrigins_ClientId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ClientCorsOrigins_ClientId] ON [dbo].[ClientCorsOrigins]
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClientGrantTypes_ClientId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ClientGrantTypes_ClientId] ON [dbo].[ClientGrantTypes]
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClientIdPRestrictions_ClientId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ClientIdPRestrictions_ClientId] ON [dbo].[ClientIdPRestrictions]
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClientPostLogoutRedirectUris_ClientId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ClientPostLogoutRedirectUris_ClientId] ON [dbo].[ClientPostLogoutRedirectUris]
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClientProperties_ClientId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ClientProperties_ClientId] ON [dbo].[ClientProperties]
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClientRedirectUris_ClientId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ClientRedirectUris_ClientId] ON [dbo].[ClientRedirectUris]
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Clients_ClientId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Clients_ClientId] ON [dbo].[Clients]
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClientScopes_ClientId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ClientScopes_ClientId] ON [dbo].[ClientScopes]
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClientSecrets_ClientId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ClientSecrets_ClientId] ON [dbo].[ClientSecrets]
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Country_DisplayOrder]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Country_DisplayOrder] ON [dbo].[Country]
(
	[DisplayOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Currency_DisplayOrder]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Currency_DisplayOrder] ON [dbo].[Currency]
(
	[DisplayOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Customer_BillingAddress_Id]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Customer_BillingAddress_Id] ON [dbo].[Customer]
(
	[BillingAddress_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Customer_CreatedOnUtc]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Customer_CreatedOnUtc] ON [dbo].[Customer]
(
	[CreatedOnUtc] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Customer_CustomerGuid]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Customer_CustomerGuid] ON [dbo].[Customer]
(
	[CustomerGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Customer_Email]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Customer_Email] ON [dbo].[Customer]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Customer_ShippingAddress_Id]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Customer_ShippingAddress_Id] ON [dbo].[Customer]
(
	[ShippingAddress_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Customer_SystemName]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Customer_SystemName] ON [dbo].[Customer]
(
	[SystemName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Customer_Username]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Customer_Username] ON [dbo].[Customer]
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Customer_CustomerRole_Mapping_Customer_Id]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Customer_CustomerRole_Mapping_Customer_Id] ON [dbo].[Customer_CustomerRole_Mapping]
(
	[Customer_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Customer_CustomerRole_Mapping_CustomerRole_Id]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Customer_CustomerRole_Mapping_CustomerRole_Id] ON [dbo].[Customer_CustomerRole_Mapping]
(
	[CustomerRole_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomerAddresses_Address_Id]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_CustomerAddresses_Address_Id] ON [dbo].[CustomerAddresses]
(
	[Address_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomerAddresses_Customer_Id]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_CustomerAddresses_Customer_Id] ON [dbo].[CustomerAddresses]
(
	[Customer_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomerAttributeValue_CustomerAttributeId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_CustomerAttributeValue_CustomerAttributeId] ON [dbo].[CustomerAttributeValue]
(
	[CustomerAttributeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomerPassword_CustomerId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_CustomerPassword_CustomerId] ON [dbo].[CustomerPassword]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DeviceCodes_DeviceCode]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_DeviceCodes_DeviceCode] ON [dbo].[DeviceCodes]
(
	[DeviceCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DeviceCodes_Expiration]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_DeviceCodes_Expiration] ON [dbo].[DeviceCodes]
(
	[Expiration] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Discount_AppliedToCategories_Category_Id]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Discount_AppliedToCategories_Category_Id] ON [dbo].[Discount_AppliedToCategories]
(
	[Category_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Discount_AppliedToCategories_Discount_Id]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Discount_AppliedToCategories_Discount_Id] ON [dbo].[Discount_AppliedToCategories]
(
	[Discount_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Discount_AppliedToManufacturers_Discount_Id]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Discount_AppliedToManufacturers_Discount_Id] ON [dbo].[Discount_AppliedToManufacturers]
(
	[Discount_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Discount_AppliedToManufacturers_Manufacturer_Id]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Discount_AppliedToManufacturers_Manufacturer_Id] ON [dbo].[Discount_AppliedToManufacturers]
(
	[Manufacturer_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Discount_AppliedToProducts_Discount_Id]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Discount_AppliedToProducts_Discount_Id] ON [dbo].[Discount_AppliedToProducts]
(
	[Discount_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Discount_AppliedToProducts_Product_Id]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Discount_AppliedToProducts_Product_Id] ON [dbo].[Discount_AppliedToProducts]
(
	[Product_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DiscountRequirement_DiscountId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_DiscountRequirement_DiscountId] ON [dbo].[DiscountRequirement]
(
	[DiscountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DiscountUsageHistory_DiscountId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_DiscountUsageHistory_DiscountId] ON [dbo].[DiscountUsageHistory]
(
	[DiscountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DiscountUsageHistory_OrderId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_DiscountUsageHistory_OrderId] ON [dbo].[DiscountUsageHistory]
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ExternalAuthenticationRecord_CustomerId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ExternalAuthenticationRecord_CustomerId] ON [dbo].[ExternalAuthenticationRecord]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Forums_Forum_DisplayOrder]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Forums_Forum_DisplayOrder] ON [dbo].[Forums_Forum]
(
	[DisplayOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Forums_Forum_ForumGroupId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Forums_Forum_ForumGroupId] ON [dbo].[Forums_Forum]
(
	[ForumGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Forums_Group_DisplayOrder]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Forums_Group_DisplayOrder] ON [dbo].[Forums_Group]
(
	[DisplayOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Forums_Post_CustomerId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Forums_Post_CustomerId] ON [dbo].[Forums_Post]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Forums_Post_TopicId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Forums_Post_TopicId] ON [dbo].[Forums_Post]
(
	[TopicId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Forums_PostVote_ForumPostId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Forums_PostVote_ForumPostId] ON [dbo].[Forums_PostVote]
(
	[ForumPostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Forums_PrivateMessage_FromCustomerId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Forums_PrivateMessage_FromCustomerId] ON [dbo].[Forums_PrivateMessage]
(
	[FromCustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Forums_PrivateMessage_ToCustomerId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Forums_PrivateMessage_ToCustomerId] ON [dbo].[Forums_PrivateMessage]
(
	[ToCustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Forums_Subscription_CustomerId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Forums_Subscription_CustomerId] ON [dbo].[Forums_Subscription]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Forums_Subscription_ForumId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Forums_Subscription_ForumId] ON [dbo].[Forums_Subscription]
(
	[ForumId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Forums_Subscription_TopicId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Forums_Subscription_TopicId] ON [dbo].[Forums_Subscription]
(
	[TopicId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Forums_Topic_CustomerId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Forums_Topic_CustomerId] ON [dbo].[Forums_Topic]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Forums_Topic_ForumId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Forums_Topic_ForumId] ON [dbo].[Forums_Topic]
(
	[ForumId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_GenericAttribute_EntityId_and_KeyGroup]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_GenericAttribute_EntityId_and_KeyGroup] ON [dbo].[GenericAttribute]
(
	[EntityId] ASC,
	[KeyGroup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_GiftCard_PurchasedWithOrderItemId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_GiftCard_PurchasedWithOrderItemId] ON [dbo].[GiftCard]
(
	[PurchasedWithOrderItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_GiftCardUsageHistory_GiftCardId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_GiftCardUsageHistory_GiftCardId] ON [dbo].[GiftCardUsageHistory]
(
	[GiftCardId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_GiftCardUsageHistory_UsedWithOrderId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_GiftCardUsageHistory_UsedWithOrderId] ON [dbo].[GiftCardUsageHistory]
(
	[UsedWithOrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_IdentityClaims_IdentityResourceId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_IdentityClaims_IdentityResourceId] ON [dbo].[IdentityClaims]
(
	[IdentityResourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_IdentityProperties_IdentityResourceId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_IdentityProperties_IdentityResourceId] ON [dbo].[IdentityProperties]
(
	[IdentityResourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_IdentityResources_Name]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_IdentityResources_Name] ON [dbo].[IdentityResources]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Language_DisplayOrder]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Language_DisplayOrder] ON [dbo].[Language]
(
	[DisplayOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_LocaleStringResource]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_LocaleStringResource] ON [dbo].[LocaleStringResource]
(
	[ResourceName] ASC,
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LocaleStringResource_LanguageId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_LocaleStringResource_LanguageId] ON [dbo].[LocaleStringResource]
(
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_LocalizedProperty_LanguageId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_LocalizedProperty_LanguageId] ON [dbo].[LocalizedProperty]
(
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Log_CreatedOnUtc]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Log_CreatedOnUtc] ON [dbo].[Log]
(
	[CreatedOnUtc] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Log_CustomerId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Log_CustomerId] ON [dbo].[Log]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Manufacturer_DisplayOrder]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Manufacturer_DisplayOrder] ON [dbo].[Manufacturer]
(
	[DisplayOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Manufacturer_LimitedToStores]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Manufacturer_LimitedToStores] ON [dbo].[Manufacturer]
(
	[LimitedToStores] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Manufacturer_SubjectToAcl]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Manufacturer_SubjectToAcl] ON [dbo].[Manufacturer]
(
	[SubjectToAcl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_News_LanguageId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_News_LanguageId] ON [dbo].[News]
(
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_NewsComment_CustomerId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_NewsComment_CustomerId] ON [dbo].[NewsComment]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_NewsComment_NewsItemId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_NewsComment_NewsItemId] ON [dbo].[NewsComment]
(
	[NewsItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_NewsComment_StoreId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_NewsComment_StoreId] ON [dbo].[NewsComment]
(
	[StoreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_NewsletterSubscription_Email_StoreId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_NewsletterSubscription_Email_StoreId] ON [dbo].[NewsLetterSubscription]
(
	[Email] ASC,
	[StoreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Order_BillingAddressId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Order_BillingAddressId] ON [dbo].[Order]
(
	[BillingAddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Order_CreatedOnUtc]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Order_CreatedOnUtc] ON [dbo].[Order]
(
	[CreatedOnUtc] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Order_CustomerId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Order_CustomerId] ON [dbo].[Order]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Order_PickupAddressId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Order_PickupAddressId] ON [dbo].[Order]
(
	[PickupAddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Order_RewardPointsHistoryEntryId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Order_RewardPointsHistoryEntryId] ON [dbo].[Order]
(
	[RewardPointsHistoryEntryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Order_ShippingAddressId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Order_ShippingAddressId] ON [dbo].[Order]
(
	[ShippingAddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderItem_OrderId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderItem_OrderId] ON [dbo].[OrderItem]
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderItem_ProductId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderItem_ProductId] ON [dbo].[OrderItem]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderNote_OrderId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderNote_OrderId] ON [dbo].[OrderNote]
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PermissionRecord_Role_Mapping_CustomerRole_Id]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_PermissionRecord_Role_Mapping_CustomerRole_Id] ON [dbo].[PermissionRecord_Role_Mapping]
(
	[CustomerRole_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PermissionRecord_Role_Mapping_PermissionRecord_Id]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_PermissionRecord_Role_Mapping_PermissionRecord_Id] ON [dbo].[PermissionRecord_Role_Mapping]
(
	[PermissionRecord_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_PersistedGrants_SubjectId_ClientId_Type_Expiration]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_PersistedGrants_SubjectId_ClientId_Type_Expiration] ON [dbo].[PersistedGrants]
(
	[SubjectId] ASC,
	[ClientId] ASC,
	[Type] ASC,
	[Expiration] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PictureBinary_PictureId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_PictureBinary_PictureId] ON [dbo].[PictureBinary]
(
	[PictureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Poll_LanguageId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Poll_LanguageId] ON [dbo].[Poll]
(
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PollAnswer_PollId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_PollAnswer_PollId] ON [dbo].[PollAnswer]
(
	[PollId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PollVotingRecord_CustomerId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_PollVotingRecord_CustomerId] ON [dbo].[PollVotingRecord]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PollVotingRecord_PollAnswerId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_PollVotingRecord_PollAnswerId] ON [dbo].[PollVotingRecord]
(
	[PollAnswerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PredefinedProductAttributeValue_ProductAttributeId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_PredefinedProductAttributeValue_ProductAttributeId] ON [dbo].[PredefinedProductAttributeValue]
(
	[ProductAttributeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_GetLowStockProducts]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_GetLowStockProducts] ON [dbo].[Product]
(
	[Deleted] ASC,
	[VendorId] ASC,
	[ProductTypeId] ASC,
	[ManageInventoryMethodId] ASC,
	[MinStockQuantity] ASC,
	[UseMultipleWarehouses] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_Delete_Id]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_Delete_Id] ON [dbo].[Product]
(
	[Deleted] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_Deleted_and_Published]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_Deleted_and_Published] ON [dbo].[Product]
(
	[Published] ASC,
	[Deleted] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_LimitedToStores]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_LimitedToStores] ON [dbo].[Product]
(
	[LimitedToStores] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_ParentGroupedProductId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_ParentGroupedProductId] ON [dbo].[Product]
(
	[ParentGroupedProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_PriceDatesEtc]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_PriceDatesEtc] ON [dbo].[Product]
(
	[Price] ASC,
	[AvailableStartDateTimeUtc] ASC,
	[AvailableEndDateTimeUtc] ASC,
	[Published] ASC,
	[Deleted] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_Published]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_Published] ON [dbo].[Product]
(
	[Published] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_ShowOnHomepage]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_ShowOnHomepage] ON [dbo].[Product]
(
	[ShowOnHomepage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_SubjectToAcl]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_SubjectToAcl] ON [dbo].[Product]
(
	[SubjectToAcl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_VisibleIndividually]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_VisibleIndividually] ON [dbo].[Product]
(
	[VisibleIndividually] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_VisibleIndividually_Published_Deleted_Extended]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_VisibleIndividually_Published_Deleted_Extended] ON [dbo].[Product]
(
	[VisibleIndividually] ASC,
	[Published] ASC,
	[Deleted] ASC
)
INCLUDE ( 	[Id],
	[AvailableStartDateTimeUtc],
	[AvailableEndDateTimeUtc]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PCM_Product_and_Category]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_PCM_Product_and_Category] ON [dbo].[Product_Category_Mapping]
(
	[CategoryId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PCM_ProductId_Extended]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_PCM_ProductId_Extended] ON [dbo].[Product_Category_Mapping]
(
	[ProductId] ASC,
	[IsFeaturedProduct] ASC
)
INCLUDE ( 	[CategoryId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_Category_Mapping_CategoryId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_Category_Mapping_CategoryId] ON [dbo].[Product_Category_Mapping]
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_Category_Mapping_IsFeaturedProduct]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_Category_Mapping_IsFeaturedProduct] ON [dbo].[Product_Category_Mapping]
(
	[IsFeaturedProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_Category_Mapping_ProductId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_Category_Mapping_ProductId] ON [dbo].[Product_Category_Mapping]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PMM_Product_and_Manufacturer]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_PMM_Product_and_Manufacturer] ON [dbo].[Product_Manufacturer_Mapping]
(
	[ManufacturerId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PMM_ProductId_Extended]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_PMM_ProductId_Extended] ON [dbo].[Product_Manufacturer_Mapping]
(
	[ProductId] ASC,
	[IsFeaturedProduct] ASC
)
INCLUDE ( 	[ManufacturerId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_Manufacturer_Mapping_IsFeaturedProduct]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_Manufacturer_Mapping_IsFeaturedProduct] ON [dbo].[Product_Manufacturer_Mapping]
(
	[IsFeaturedProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_Manufacturer_Mapping_ManufacturerId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_Manufacturer_Mapping_ManufacturerId] ON [dbo].[Product_Manufacturer_Mapping]
(
	[ManufacturerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_Manufacturer_Mapping_ProductId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_Manufacturer_Mapping_ProductId] ON [dbo].[Product_Manufacturer_Mapping]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_Picture_Mapping_PictureId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_Picture_Mapping_PictureId] ON [dbo].[Product_Picture_Mapping]
(
	[PictureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_Picture_Mapping_ProductId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_Picture_Mapping_ProductId] ON [dbo].[Product_Picture_Mapping]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_ProductAttribute_Mapping_ProductAttributeId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_ProductAttribute_Mapping_ProductAttributeId] ON [dbo].[Product_ProductAttribute_Mapping]
(
	[ProductAttributeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_ProductAttribute_Mapping_ProductId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_ProductAttribute_Mapping_ProductId] ON [dbo].[Product_ProductAttribute_Mapping]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_ProductAttribute_Mapping_ProductId_DisplayOrder]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_ProductAttribute_Mapping_ProductId_DisplayOrder] ON [dbo].[Product_ProductAttribute_Mapping]
(
	[ProductId] ASC,
	[DisplayOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_ProductTag_Mapping_Product_Id]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_ProductTag_Mapping_Product_Id] ON [dbo].[Product_ProductTag_Mapping]
(
	[Product_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_ProductTag_Mapping_ProductTag_Id]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_ProductTag_Mapping_ProductTag_Id] ON [dbo].[Product_ProductTag_Mapping]
(
	[ProductTag_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_SpecificationAttribute_Mapping_ProductId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_SpecificationAttribute_Mapping_ProductId] ON [dbo].[Product_SpecificationAttribute_Mapping]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_SpecificationAttribute_Mapping_SpecificationAttributeOptionId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Product_SpecificationAttribute_Mapping_SpecificationAttributeOptionId] ON [dbo].[Product_SpecificationAttribute_Mapping]
(
	[SpecificationAttributeOptionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PSAM_AllowFiltering]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_PSAM_AllowFiltering] ON [dbo].[Product_SpecificationAttribute_Mapping]
(
	[AllowFiltering] ASC
)
INCLUDE ( 	[ProductId],
	[SpecificationAttributeOptionId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PSAM_SpecificationAttributeOptionId_AllowFiltering]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_PSAM_SpecificationAttributeOptionId_AllowFiltering] ON [dbo].[Product_SpecificationAttribute_Mapping]
(
	[SpecificationAttributeOptionId] ASC,
	[AllowFiltering] ASC
)
INCLUDE ( 	[ProductId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProductAttributeCombination_ProductId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductAttributeCombination_ProductId] ON [dbo].[ProductAttributeCombination]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProductAttributeValue_ProductAttributeMappingId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductAttributeValue_ProductAttributeMappingId] ON [dbo].[ProductAttributeValue]
(
	[ProductAttributeMappingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProductAttributeValue_ProductAttributeMappingId_DisplayOrder]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductAttributeValue_ProductAttributeMappingId_DisplayOrder] ON [dbo].[ProductAttributeValue]
(
	[ProductAttributeMappingId] ASC,
	[DisplayOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProductReview_CustomerId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductReview_CustomerId] ON [dbo].[ProductReview]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProductReview_ProductId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductReview_ProductId] ON [dbo].[ProductReview]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProductReview_StoreId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductReview_StoreId] ON [dbo].[ProductReview]
(
	[StoreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProductReview_ReviewType_Mapping_ProductReviewId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductReview_ReviewType_Mapping_ProductReviewId] ON [dbo].[ProductReview_ReviewType_Mapping]
(
	[ProductReviewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProductReview_ReviewType_Mapping_ReviewTypeId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductReview_ReviewType_Mapping_ReviewTypeId] ON [dbo].[ProductReview_ReviewType_Mapping]
(
	[ReviewTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProductReviewHelpfulness_ProductReviewId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductReviewHelpfulness_ProductReviewId] ON [dbo].[ProductReviewHelpfulness]
(
	[ProductReviewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ProductTag_Name]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductTag_Name] ON [dbo].[ProductTag]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProductWarehouseInventory_ProductId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductWarehouseInventory_ProductId] ON [dbo].[ProductWarehouseInventory]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProductWarehouseInventory_WarehouseId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductWarehouseInventory_WarehouseId] ON [dbo].[ProductWarehouseInventory]
(
	[WarehouseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_QueuedEmail_CreatedOnUtc]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_QueuedEmail_CreatedOnUtc] ON [dbo].[QueuedEmail]
(
	[CreatedOnUtc] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_QueuedEmail_EmailAccountId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_QueuedEmail_EmailAccountId] ON [dbo].[QueuedEmail]
(
	[EmailAccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_QueuedEmail_SentOnUtc_DontSendBeforeDateUtc_Extended]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_QueuedEmail_SentOnUtc_DontSendBeforeDateUtc_Extended] ON [dbo].[QueuedEmail]
(
	[SentOnUtc] ASC,
	[DontSendBeforeDateUtc] ASC
)
INCLUDE ( 	[SentTries]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RecurringPayment_InitialOrderId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_RecurringPayment_InitialOrderId] ON [dbo].[RecurringPayment]
(
	[InitialOrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RecurringPaymentHistory_RecurringPaymentId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_RecurringPaymentHistory_RecurringPaymentId] ON [dbo].[RecurringPaymentHistory]
(
	[RecurringPaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RelatedProduct_ProductId1]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_RelatedProduct_ProductId1] ON [dbo].[RelatedProduct]
(
	[ProductId1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ReturnRequest_CustomerId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ReturnRequest_CustomerId] ON [dbo].[ReturnRequest]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RewardPointsHistory_CustomerId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_RewardPointsHistory_CustomerId] ON [dbo].[RewardPointsHistory]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RewardPointsHistory_OrderId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_RewardPointsHistory_OrderId] ON [dbo].[RewardPointsHistory]
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Shipment_OrderId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Shipment_OrderId] ON [dbo].[Shipment]
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShipmentItem_ShipmentId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ShipmentItem_ShipmentId] ON [dbo].[ShipmentItem]
(
	[ShipmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShippingMethodRestrictions_Country_Id]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ShippingMethodRestrictions_Country_Id] ON [dbo].[ShippingMethodRestrictions]
(
	[Country_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShippingMethodRestrictions_ShippingMethod_Id]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ShippingMethodRestrictions_ShippingMethod_Id] ON [dbo].[ShippingMethodRestrictions]
(
	[ShippingMethod_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShoppingCartItem_CustomerId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ShoppingCartItem_CustomerId] ON [dbo].[ShoppingCartItem]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShoppingCartItem_ProductId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ShoppingCartItem_ProductId] ON [dbo].[ShoppingCartItem]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShoppingCartItem_ShoppingCartTypeId_CustomerId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_ShoppingCartItem_ShoppingCartTypeId_CustomerId] ON [dbo].[ShoppingCartItem]
(
	[ShoppingCartTypeId] ASC,
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SpecificationAttributeOption_SpecificationAttributeId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_SpecificationAttributeOption_SpecificationAttributeId] ON [dbo].[SpecificationAttributeOption]
(
	[SpecificationAttributeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_StateProvince_CountryId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_StateProvince_CountryId] ON [dbo].[StateProvince]
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_StockQuantityHistory_ProductId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_StockQuantityHistory_ProductId] ON [dbo].[StockQuantityHistory]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_StockQuantityHistory_WarehouseId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_StockQuantityHistory_WarehouseId] ON [dbo].[StockQuantityHistory]
(
	[WarehouseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_StoreMapping_EntityId_EntityName]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_StoreMapping_EntityId_EntityName] ON [dbo].[StoreMapping]
(
	[EntityId] ASC,
	[EntityName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_StoreMapping_StoreId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_StoreMapping_StoreId] ON [dbo].[StoreMapping]
(
	[StoreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_TierPrice_CustomerRoleId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_TierPrice_CustomerRoleId] ON [dbo].[TierPrice]
(
	[CustomerRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_TierPrice_ProductId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_TierPrice_ProductId] ON [dbo].[TierPrice]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UrlRecord_Custom_1]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_UrlRecord_Custom_1] ON [dbo].[UrlRecord]
(
	[EntityId] ASC,
	[EntityName] ASC,
	[LanguageId] ASC,
	[IsActive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UrlRecord_Slug]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_UrlRecord_Slug] ON [dbo].[UrlRecord]
(
	[Slug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_VendorAttributeValue_VendorAttributeId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_VendorAttributeValue_VendorAttributeId] ON [dbo].[VendorAttributeValue]
(
	[VendorAttributeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_VendorNote_VendorId]    Script Date: 3/30/2020 12:49:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_VendorNote_VendorId] ON [dbo].[VendorNote]
(
	[VendorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ApiSecrets] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [Created]
GO
ALTER TABLE [dbo].[Clients] ADD  DEFAULT ((0)) FOR [BackChannelLogoutSessionRequired]
GO
ALTER TABLE [dbo].[Clients] ADD  DEFAULT ((0)) FOR [FrontChannelLogoutSessionRequired]
GO
ALTER TABLE [dbo].[Clients] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [Created]
GO
ALTER TABLE [dbo].[Clients] ADD  DEFAULT ((0)) FOR [DeviceCodeLifetime]
GO
ALTER TABLE [dbo].[Clients] ADD  DEFAULT ((0)) FOR [NonEditable]
GO
ALTER TABLE [dbo].[ClientSecrets] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [Created]
GO
ALTER TABLE [dbo].[IdentityResources] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [Created]
GO
ALTER TABLE [dbo].[IdentityResources] ADD  DEFAULT ((0)) FOR [NonEditable]
GO
ALTER TABLE [dbo].[AclRecord]  WITH CHECK ADD  CONSTRAINT [FK_AclRecord_CustomerRole_CustomerRoleId] FOREIGN KEY([CustomerRoleId])
REFERENCES [dbo].[CustomerRole] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AclRecord] CHECK CONSTRAINT [FK_AclRecord_CustomerRole_CustomerRoleId]
GO
ALTER TABLE [dbo].[ActivityLog]  WITH CHECK ADD  CONSTRAINT [FK_ActivityLog_ActivityLogType_ActivityLogTypeId] FOREIGN KEY([ActivityLogTypeId])
REFERENCES [dbo].[ActivityLogType] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ActivityLog] CHECK CONSTRAINT [FK_ActivityLog_ActivityLogType_ActivityLogTypeId]
GO
ALTER TABLE [dbo].[ActivityLog]  WITH CHECK ADD  CONSTRAINT [FK_ActivityLog_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ActivityLog] CHECK CONSTRAINT [FK_ActivityLog_Customer_CustomerId]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_Country_CountryId] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_Country_CountryId]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_StateProvince_StateProvinceId] FOREIGN KEY([StateProvinceId])
REFERENCES [dbo].[StateProvince] ([Id])
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_StateProvince_StateProvinceId]
GO
ALTER TABLE [dbo].[AddressAttributeValue]  WITH CHECK ADD  CONSTRAINT [FK_AddressAttributeValue_AddressAttribute_AddressAttributeId] FOREIGN KEY([AddressAttributeId])
REFERENCES [dbo].[AddressAttribute] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AddressAttributeValue] CHECK CONSTRAINT [FK_AddressAttributeValue_AddressAttribute_AddressAttributeId]
GO
ALTER TABLE [dbo].[Affiliate]  WITH CHECK ADD  CONSTRAINT [FK_Affiliate_Address_AddressId] FOREIGN KEY([AddressId])
REFERENCES [dbo].[Address] ([Id])
GO
ALTER TABLE [dbo].[Affiliate] CHECK CONSTRAINT [FK_Affiliate_Address_AddressId]
GO
ALTER TABLE [dbo].[ApiClaims]  WITH CHECK ADD  CONSTRAINT [FK_ApiClaims_ApiResources_ApiResourceId] FOREIGN KEY([ApiResourceId])
REFERENCES [dbo].[ApiResources] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ApiClaims] CHECK CONSTRAINT [FK_ApiClaims_ApiResources_ApiResourceId]
GO
ALTER TABLE [dbo].[ApiProperties]  WITH CHECK ADD  CONSTRAINT [FK_ApiProperties_ApiResources_ApiResourceId] FOREIGN KEY([ApiResourceId])
REFERENCES [dbo].[ApiResources] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ApiProperties] CHECK CONSTRAINT [FK_ApiProperties_ApiResources_ApiResourceId]
GO
ALTER TABLE [dbo].[ApiScopeClaims]  WITH CHECK ADD  CONSTRAINT [FK_ApiScopeClaims_ApiScopes_ApiScopeId] FOREIGN KEY([ApiScopeId])
REFERENCES [dbo].[ApiScopes] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ApiScopeClaims] CHECK CONSTRAINT [FK_ApiScopeClaims_ApiScopes_ApiScopeId]
GO
ALTER TABLE [dbo].[ApiScopes]  WITH CHECK ADD  CONSTRAINT [FK_ApiScopes_ApiResources_ApiResourceId] FOREIGN KEY([ApiResourceId])
REFERENCES [dbo].[ApiResources] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ApiScopes] CHECK CONSTRAINT [FK_ApiScopes_ApiResources_ApiResourceId]
GO
ALTER TABLE [dbo].[ApiSecrets]  WITH CHECK ADD  CONSTRAINT [FK_ApiSecrets_ApiResources_ApiResourceId] FOREIGN KEY([ApiResourceId])
REFERENCES [dbo].[ApiResources] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ApiSecrets] CHECK CONSTRAINT [FK_ApiSecrets_ApiResources_ApiResourceId]
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
ALTER TABLE [dbo].[BackInStockSubscription]  WITH CHECK ADD  CONSTRAINT [FK_BackInStockSubscription_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BackInStockSubscription] CHECK CONSTRAINT [FK_BackInStockSubscription_Customer_CustomerId]
GO
ALTER TABLE [dbo].[BackInStockSubscription]  WITH CHECK ADD  CONSTRAINT [FK_BackInStockSubscription_Product_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BackInStockSubscription] CHECK CONSTRAINT [FK_BackInStockSubscription_Product_ProductId]
GO
ALTER TABLE [dbo].[BlogComment]  WITH CHECK ADD  CONSTRAINT [FK_BlogComment_BlogPost_BlogPostId] FOREIGN KEY([BlogPostId])
REFERENCES [dbo].[BlogPost] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BlogComment] CHECK CONSTRAINT [FK_BlogComment_BlogPost_BlogPostId]
GO
ALTER TABLE [dbo].[BlogComment]  WITH CHECK ADD  CONSTRAINT [FK_BlogComment_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BlogComment] CHECK CONSTRAINT [FK_BlogComment_Customer_CustomerId]
GO
ALTER TABLE [dbo].[BlogComment]  WITH CHECK ADD  CONSTRAINT [FK_BlogComment_Store_StoreId] FOREIGN KEY([StoreId])
REFERENCES [dbo].[Store] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BlogComment] CHECK CONSTRAINT [FK_BlogComment_Store_StoreId]
GO
ALTER TABLE [dbo].[BlogPost]  WITH CHECK ADD  CONSTRAINT [FK_BlogPost_Language_LanguageId] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Language] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BlogPost] CHECK CONSTRAINT [FK_BlogPost_Language_LanguageId]
GO
ALTER TABLE [dbo].[CheckoutAttributeValue]  WITH CHECK ADD  CONSTRAINT [FK_CheckoutAttributeValue_CheckoutAttribute_CheckoutAttributeId] FOREIGN KEY([CheckoutAttributeId])
REFERENCES [dbo].[CheckoutAttribute] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CheckoutAttributeValue] CHECK CONSTRAINT [FK_CheckoutAttributeValue_CheckoutAttribute_CheckoutAttributeId]
GO
ALTER TABLE [dbo].[ClientClaims]  WITH CHECK ADD  CONSTRAINT [FK_ClientClaims_Clients_ClientId] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Clients] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ClientClaims] CHECK CONSTRAINT [FK_ClientClaims_Clients_ClientId]
GO
ALTER TABLE [dbo].[ClientCorsOrigins]  WITH CHECK ADD  CONSTRAINT [FK_ClientCorsOrigins_Clients_ClientId] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Clients] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ClientCorsOrigins] CHECK CONSTRAINT [FK_ClientCorsOrigins_Clients_ClientId]
GO
ALTER TABLE [dbo].[ClientGrantTypes]  WITH CHECK ADD  CONSTRAINT [FK_ClientGrantTypes_Clients_ClientId] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Clients] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ClientGrantTypes] CHECK CONSTRAINT [FK_ClientGrantTypes_Clients_ClientId]
GO
ALTER TABLE [dbo].[ClientIdPRestrictions]  WITH CHECK ADD  CONSTRAINT [FK_ClientIdPRestrictions_Clients_ClientId] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Clients] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ClientIdPRestrictions] CHECK CONSTRAINT [FK_ClientIdPRestrictions_Clients_ClientId]
GO
ALTER TABLE [dbo].[ClientPostLogoutRedirectUris]  WITH CHECK ADD  CONSTRAINT [FK_ClientPostLogoutRedirectUris_Clients_ClientId] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Clients] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ClientPostLogoutRedirectUris] CHECK CONSTRAINT [FK_ClientPostLogoutRedirectUris_Clients_ClientId]
GO
ALTER TABLE [dbo].[ClientProperties]  WITH CHECK ADD  CONSTRAINT [FK_ClientProperties_Clients_ClientId] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Clients] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ClientProperties] CHECK CONSTRAINT [FK_ClientProperties_Clients_ClientId]
GO
ALTER TABLE [dbo].[ClientRedirectUris]  WITH CHECK ADD  CONSTRAINT [FK_ClientRedirectUris_Clients_ClientId] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Clients] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ClientRedirectUris] CHECK CONSTRAINT [FK_ClientRedirectUris_Clients_ClientId]
GO
ALTER TABLE [dbo].[ClientScopes]  WITH CHECK ADD  CONSTRAINT [FK_ClientScopes_Clients_ClientId] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Clients] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ClientScopes] CHECK CONSTRAINT [FK_ClientScopes_Clients_ClientId]
GO
ALTER TABLE [dbo].[ClientSecrets]  WITH CHECK ADD  CONSTRAINT [FK_ClientSecrets_Clients_ClientId] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Clients] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ClientSecrets] CHECK CONSTRAINT [FK_ClientSecrets_Clients_ClientId]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Address_AddressId] FOREIGN KEY([BillingAddress_Id])
REFERENCES [dbo].[Address] ([Id])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Address_AddressId]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_ShippingAddress_Id_Address_Id] FOREIGN KEY([ShippingAddress_Id])
REFERENCES [dbo].[Address] ([Id])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_ShippingAddress_Id_Address_Id]
GO
ALTER TABLE [dbo].[Customer_CustomerRole_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Customer_CustomerRole_Mapping_Customer_CustomerId] FOREIGN KEY([Customer_Id])
REFERENCES [dbo].[Customer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Customer_CustomerRole_Mapping] CHECK CONSTRAINT [FK_Customer_CustomerRole_Mapping_Customer_CustomerId]
GO
ALTER TABLE [dbo].[Customer_CustomerRole_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Customer_CustomerRole_Mapping_CustomerRole_CustomerRoleId] FOREIGN KEY([CustomerRole_Id])
REFERENCES [dbo].[CustomerRole] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Customer_CustomerRole_Mapping] CHECK CONSTRAINT [FK_Customer_CustomerRole_Mapping_CustomerRole_CustomerRoleId]
GO
ALTER TABLE [dbo].[CustomerAddresses]  WITH CHECK ADD  CONSTRAINT [FK_CustomerAddresses_Address_AddressId] FOREIGN KEY([Address_Id])
REFERENCES [dbo].[Address] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerAddresses] CHECK CONSTRAINT [FK_CustomerAddresses_Address_AddressId]
GO
ALTER TABLE [dbo].[CustomerAddresses]  WITH CHECK ADD  CONSTRAINT [FK_CustomerAddresses_Customer_CustomerId] FOREIGN KEY([Customer_Id])
REFERENCES [dbo].[Customer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerAddresses] CHECK CONSTRAINT [FK_CustomerAddresses_Customer_CustomerId]
GO
ALTER TABLE [dbo].[CustomerAttributeValue]  WITH CHECK ADD  CONSTRAINT [FK_CustomerAttributeValue_CustomerAttribute_CustomerAttributeId] FOREIGN KEY([CustomerAttributeId])
REFERENCES [dbo].[CustomerAttribute] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerAttributeValue] CHECK CONSTRAINT [FK_CustomerAttributeValue_CustomerAttribute_CustomerAttributeId]
GO
ALTER TABLE [dbo].[CustomerPassword]  WITH CHECK ADD  CONSTRAINT [FK_CustomerPassword_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerPassword] CHECK CONSTRAINT [FK_CustomerPassword_Customer_CustomerId]
GO
ALTER TABLE [dbo].[Discount_AppliedToCategories]  WITH CHECK ADD  CONSTRAINT [FK_Discount_AppliedToCategories_Category_CategoryId] FOREIGN KEY([Category_Id])
REFERENCES [dbo].[Category] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Discount_AppliedToCategories] CHECK CONSTRAINT [FK_Discount_AppliedToCategories_Category_CategoryId]
GO
ALTER TABLE [dbo].[Discount_AppliedToCategories]  WITH CHECK ADD  CONSTRAINT [FK_Discount_AppliedToCategories_Discount_DiscountId] FOREIGN KEY([Discount_Id])
REFERENCES [dbo].[Discount] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Discount_AppliedToCategories] CHECK CONSTRAINT [FK_Discount_AppliedToCategories_Discount_DiscountId]
GO
ALTER TABLE [dbo].[Discount_AppliedToManufacturers]  WITH CHECK ADD  CONSTRAINT [FK_Discount_AppliedToManufacturers_Discount_DiscountId] FOREIGN KEY([Discount_Id])
REFERENCES [dbo].[Discount] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Discount_AppliedToManufacturers] CHECK CONSTRAINT [FK_Discount_AppliedToManufacturers_Discount_DiscountId]
GO
ALTER TABLE [dbo].[Discount_AppliedToManufacturers]  WITH CHECK ADD  CONSTRAINT [FK_Discount_AppliedToManufacturers_Manufacturer_ManufacturerId] FOREIGN KEY([Manufacturer_Id])
REFERENCES [dbo].[Manufacturer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Discount_AppliedToManufacturers] CHECK CONSTRAINT [FK_Discount_AppliedToManufacturers_Manufacturer_ManufacturerId]
GO
ALTER TABLE [dbo].[Discount_AppliedToProducts]  WITH CHECK ADD  CONSTRAINT [FK_Discount_AppliedToProducts_Discount_DiscountId] FOREIGN KEY([Discount_Id])
REFERENCES [dbo].[Discount] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Discount_AppliedToProducts] CHECK CONSTRAINT [FK_Discount_AppliedToProducts_Discount_DiscountId]
GO
ALTER TABLE [dbo].[Discount_AppliedToProducts]  WITH CHECK ADD  CONSTRAINT [FK_Discount_AppliedToProducts_Product_ProductId] FOREIGN KEY([Product_Id])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Discount_AppliedToProducts] CHECK CONSTRAINT [FK_Discount_AppliedToProducts_Product_ProductId]
GO
ALTER TABLE [dbo].[DiscountRequirement]  WITH CHECK ADD  CONSTRAINT [FK_DiscountRequirement_Discount_DiscountId] FOREIGN KEY([DiscountId])
REFERENCES [dbo].[Discount] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DiscountRequirement] CHECK CONSTRAINT [FK_DiscountRequirement_Discount_DiscountId]
GO
ALTER TABLE [dbo].[DiscountRequirement]  WITH CHECK ADD  CONSTRAINT [FK_DiscountRequirement_DiscountRequirement_DiscountRequirementId] FOREIGN KEY([DiscountId])
REFERENCES [dbo].[DiscountRequirement] ([Id])
GO
ALTER TABLE [dbo].[DiscountRequirement] CHECK CONSTRAINT [FK_DiscountRequirement_DiscountRequirement_DiscountRequirementId]
GO
ALTER TABLE [dbo].[DiscountUsageHistory]  WITH CHECK ADD  CONSTRAINT [FK_DiscountUsageHistory_Discount_DiscountId] FOREIGN KEY([DiscountId])
REFERENCES [dbo].[Discount] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DiscountUsageHistory] CHECK CONSTRAINT [FK_DiscountUsageHistory_Discount_DiscountId]
GO
ALTER TABLE [dbo].[DiscountUsageHistory]  WITH CHECK ADD  CONSTRAINT [FK_DiscountUsageHistory_Order_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DiscountUsageHistory] CHECK CONSTRAINT [FK_DiscountUsageHistory_Order_OrderId]
GO
ALTER TABLE [dbo].[ExternalAuthenticationRecord]  WITH CHECK ADD  CONSTRAINT [FK_ExternalAuthenticationRecord_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ExternalAuthenticationRecord] CHECK CONSTRAINT [FK_ExternalAuthenticationRecord_Customer_CustomerId]
GO
ALTER TABLE [dbo].[Forums_Forum]  WITH CHECK ADD  CONSTRAINT [FK_Forums_Forum_Forums_Group_Forums_GroupId] FOREIGN KEY([ForumGroupId])
REFERENCES [dbo].[Forums_Group] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Forums_Forum] CHECK CONSTRAINT [FK_Forums_Forum_Forums_Group_Forums_GroupId]
GO
ALTER TABLE [dbo].[Forums_Post]  WITH CHECK ADD  CONSTRAINT [FK_Forums_Post_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[Forums_Post] CHECK CONSTRAINT [FK_Forums_Post_Customer_CustomerId]
GO
ALTER TABLE [dbo].[Forums_Post]  WITH CHECK ADD  CONSTRAINT [FK_Forums_Post_Forums_Topic_Forums_TopicId] FOREIGN KEY([TopicId])
REFERENCES [dbo].[Forums_Topic] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Forums_Post] CHECK CONSTRAINT [FK_Forums_Post_Forums_Topic_Forums_TopicId]
GO
ALTER TABLE [dbo].[Forums_PostVote]  WITH CHECK ADD  CONSTRAINT [FK_Forums_PostVote_Forums_Post_Forums_PostId] FOREIGN KEY([ForumPostId])
REFERENCES [dbo].[Forums_Post] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Forums_PostVote] CHECK CONSTRAINT [FK_Forums_PostVote_Forums_Post_Forums_PostId]
GO
ALTER TABLE [dbo].[Forums_PrivateMessage]  WITH CHECK ADD  CONSTRAINT [FK_Forums_PrivateMessage_Customer_CustomerId] FOREIGN KEY([FromCustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[Forums_PrivateMessage] CHECK CONSTRAINT [FK_Forums_PrivateMessage_Customer_CustomerId]
GO
ALTER TABLE [dbo].[Forums_PrivateMessage]  WITH CHECK ADD  CONSTRAINT [FK_Forums_PrivateMessage_ToCustomerId_Customer_Id] FOREIGN KEY([ToCustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[Forums_PrivateMessage] CHECK CONSTRAINT [FK_Forums_PrivateMessage_ToCustomerId_Customer_Id]
GO
ALTER TABLE [dbo].[Forums_Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Forums_Subscription_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[Forums_Subscription] CHECK CONSTRAINT [FK_Forums_Subscription_Customer_CustomerId]
GO
ALTER TABLE [dbo].[Forums_Topic]  WITH CHECK ADD  CONSTRAINT [FK_Forums_Topic_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[Forums_Topic] CHECK CONSTRAINT [FK_Forums_Topic_Customer_CustomerId]
GO
ALTER TABLE [dbo].[Forums_Topic]  WITH CHECK ADD  CONSTRAINT [FK_Forums_Topic_Forums_Forum_Forums_ForumId] FOREIGN KEY([ForumId])
REFERENCES [dbo].[Forums_Forum] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Forums_Topic] CHECK CONSTRAINT [FK_Forums_Topic_Forums_Forum_Forums_ForumId]
GO
ALTER TABLE [dbo].[GiftCard]  WITH CHECK ADD  CONSTRAINT [FK_GiftCard_OrderItem_OrderItemId] FOREIGN KEY([PurchasedWithOrderItemId])
REFERENCES [dbo].[OrderItem] ([Id])
GO
ALTER TABLE [dbo].[GiftCard] CHECK CONSTRAINT [FK_GiftCard_OrderItem_OrderItemId]
GO
ALTER TABLE [dbo].[GiftCardUsageHistory]  WITH CHECK ADD  CONSTRAINT [FK_GiftCardUsageHistory_GiftCard_GiftCardId] FOREIGN KEY([GiftCardId])
REFERENCES [dbo].[GiftCard] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GiftCardUsageHistory] CHECK CONSTRAINT [FK_GiftCardUsageHistory_GiftCard_GiftCardId]
GO
ALTER TABLE [dbo].[GiftCardUsageHistory]  WITH CHECK ADD  CONSTRAINT [FK_GiftCardUsageHistory_Order_OrderId] FOREIGN KEY([UsedWithOrderId])
REFERENCES [dbo].[Order] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GiftCardUsageHistory] CHECK CONSTRAINT [FK_GiftCardUsageHistory_Order_OrderId]
GO
ALTER TABLE [dbo].[IdentityClaims]  WITH CHECK ADD  CONSTRAINT [FK_IdentityClaims_IdentityResources_IdentityResourceId] FOREIGN KEY([IdentityResourceId])
REFERENCES [dbo].[IdentityResources] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IdentityClaims] CHECK CONSTRAINT [FK_IdentityClaims_IdentityResources_IdentityResourceId]
GO
ALTER TABLE [dbo].[IdentityProperties]  WITH CHECK ADD  CONSTRAINT [FK_IdentityProperties_IdentityResources_IdentityResourceId] FOREIGN KEY([IdentityResourceId])
REFERENCES [dbo].[IdentityResources] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IdentityProperties] CHECK CONSTRAINT [FK_IdentityProperties_IdentityResources_IdentityResourceId]
GO
ALTER TABLE [dbo].[LocaleStringResource]  WITH CHECK ADD  CONSTRAINT [FK_LocaleStringResource_Language_LanguageId] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Language] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LocaleStringResource] CHECK CONSTRAINT [FK_LocaleStringResource_Language_LanguageId]
GO
ALTER TABLE [dbo].[LocalizedProperty]  WITH CHECK ADD  CONSTRAINT [FK_LocalizedProperty_Language_LanguageId] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Language] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LocalizedProperty] CHECK CONSTRAINT [FK_LocalizedProperty_Language_LanguageId]
GO
ALTER TABLE [dbo].[Log]  WITH CHECK ADD  CONSTRAINT [FK_Log_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Log] CHECK CONSTRAINT [FK_Log_Customer_CustomerId]
GO
ALTER TABLE [dbo].[News]  WITH CHECK ADD  CONSTRAINT [FK_News_Language_LanguageId] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Language] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[News] CHECK CONSTRAINT [FK_News_Language_LanguageId]
GO
ALTER TABLE [dbo].[NewsComment]  WITH CHECK ADD  CONSTRAINT [FK_NewsComment_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NewsComment] CHECK CONSTRAINT [FK_NewsComment_Customer_CustomerId]
GO
ALTER TABLE [dbo].[NewsComment]  WITH CHECK ADD  CONSTRAINT [FK_NewsComment_News_NewsId] FOREIGN KEY([NewsItemId])
REFERENCES [dbo].[News] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NewsComment] CHECK CONSTRAINT [FK_NewsComment_News_NewsId]
GO
ALTER TABLE [dbo].[NewsComment]  WITH CHECK ADD  CONSTRAINT [FK_NewsComment_Store_StoreId] FOREIGN KEY([StoreId])
REFERENCES [dbo].[Store] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NewsComment] CHECK CONSTRAINT [FK_NewsComment_Store_StoreId]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Address_AddressId] FOREIGN KEY([BillingAddressId])
REFERENCES [dbo].[Address] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Address_AddressId]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Customer_CustomerId]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_PickupAddressId_Address_Id] FOREIGN KEY([PickupAddressId])
REFERENCES [dbo].[Address] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_PickupAddressId_Address_Id]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_RewardPointsHistory_RewardPointsHistoryId] FOREIGN KEY([RewardPointsHistoryEntryId])
REFERENCES [dbo].[RewardPointsHistory] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_RewardPointsHistory_RewardPointsHistoryId]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_ShippingAddressId_Address_Id] FOREIGN KEY([ShippingAddressId])
REFERENCES [dbo].[Address] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_ShippingAddressId_Address_Id]
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_Order_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [FK_OrderItem_Order_OrderId]
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_Product_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [FK_OrderItem_Product_ProductId]
GO
ALTER TABLE [dbo].[OrderNote]  WITH CHECK ADD  CONSTRAINT [FK_OrderNote_Order_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderNote] CHECK CONSTRAINT [FK_OrderNote_Order_OrderId]
GO
ALTER TABLE [dbo].[PermissionRecord_Role_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_PermissionRecord_Role_Mapping_CustomerRole_CustomerRoleId] FOREIGN KEY([CustomerRole_Id])
REFERENCES [dbo].[CustomerRole] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PermissionRecord_Role_Mapping] CHECK CONSTRAINT [FK_PermissionRecord_Role_Mapping_CustomerRole_CustomerRoleId]
GO
ALTER TABLE [dbo].[PermissionRecord_Role_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_PermissionRecord_Role_Mapping_PermissionRecord_PermissionRecordId] FOREIGN KEY([PermissionRecord_Id])
REFERENCES [dbo].[PermissionRecord] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PermissionRecord_Role_Mapping] CHECK CONSTRAINT [FK_PermissionRecord_Role_Mapping_PermissionRecord_PermissionRecordId]
GO
ALTER TABLE [dbo].[PictureBinary]  WITH CHECK ADD  CONSTRAINT [FK_PictureBinary_Picture_PictureId] FOREIGN KEY([PictureId])
REFERENCES [dbo].[Picture] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PictureBinary] CHECK CONSTRAINT [FK_PictureBinary_Picture_PictureId]
GO
ALTER TABLE [dbo].[Poll]  WITH CHECK ADD  CONSTRAINT [FK_Poll_Language_LanguageId] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Language] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Poll] CHECK CONSTRAINT [FK_Poll_Language_LanguageId]
GO
ALTER TABLE [dbo].[PollAnswer]  WITH CHECK ADD  CONSTRAINT [FK_PollAnswer_Poll_PollId] FOREIGN KEY([PollId])
REFERENCES [dbo].[Poll] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PollAnswer] CHECK CONSTRAINT [FK_PollAnswer_Poll_PollId]
GO
ALTER TABLE [dbo].[PollVotingRecord]  WITH CHECK ADD  CONSTRAINT [FK_PollVotingRecord_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PollVotingRecord] CHECK CONSTRAINT [FK_PollVotingRecord_Customer_CustomerId]
GO
ALTER TABLE [dbo].[PollVotingRecord]  WITH CHECK ADD  CONSTRAINT [FK_PollVotingRecord_PollAnswer_PollAnswerId] FOREIGN KEY([PollAnswerId])
REFERENCES [dbo].[PollAnswer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PollVotingRecord] CHECK CONSTRAINT [FK_PollVotingRecord_PollAnswer_PollAnswerId]
GO
ALTER TABLE [dbo].[PredefinedProductAttributeValue]  WITH CHECK ADD  CONSTRAINT [FK_PredefinedProductAttributeValue_ProductAttribute_ProductAttributeId] FOREIGN KEY([ProductAttributeId])
REFERENCES [dbo].[ProductAttribute] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PredefinedProductAttributeValue] CHECK CONSTRAINT [FK_PredefinedProductAttributeValue_ProductAttribute_ProductAttributeId]
GO
ALTER TABLE [dbo].[Product_Category_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category_Mapping_Category_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product_Category_Mapping] CHECK CONSTRAINT [FK_Product_Category_Mapping_Category_CategoryId]
GO
ALTER TABLE [dbo].[Product_Category_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category_Mapping_Product_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product_Category_Mapping] CHECK CONSTRAINT [FK_Product_Category_Mapping_Product_ProductId]
GO
ALTER TABLE [dbo].[Product_Manufacturer_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Product_Manufacturer_Mapping_Manufacturer_ManufacturerId] FOREIGN KEY([ManufacturerId])
REFERENCES [dbo].[Manufacturer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product_Manufacturer_Mapping] CHECK CONSTRAINT [FK_Product_Manufacturer_Mapping_Manufacturer_ManufacturerId]
GO
ALTER TABLE [dbo].[Product_Manufacturer_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Product_Manufacturer_Mapping_Product_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product_Manufacturer_Mapping] CHECK CONSTRAINT [FK_Product_Manufacturer_Mapping_Product_ProductId]
GO
ALTER TABLE [dbo].[Product_Picture_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Product_Picture_Mapping_Picture_PictureId] FOREIGN KEY([PictureId])
REFERENCES [dbo].[Picture] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product_Picture_Mapping] CHECK CONSTRAINT [FK_Product_Picture_Mapping_Picture_PictureId]
GO
ALTER TABLE [dbo].[Product_Picture_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Product_Picture_Mapping_Product_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product_Picture_Mapping] CHECK CONSTRAINT [FK_Product_Picture_Mapping_Product_ProductId]
GO
ALTER TABLE [dbo].[Product_ProductAttribute_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductAttribute_Mapping_Product_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product_ProductAttribute_Mapping] CHECK CONSTRAINT [FK_Product_ProductAttribute_Mapping_Product_ProductId]
GO
ALTER TABLE [dbo].[Product_ProductAttribute_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductAttribute_Mapping_ProductAttribute_ProductAttributeId] FOREIGN KEY([ProductAttributeId])
REFERENCES [dbo].[ProductAttribute] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product_ProductAttribute_Mapping] CHECK CONSTRAINT [FK_Product_ProductAttribute_Mapping_ProductAttribute_ProductAttributeId]
GO
ALTER TABLE [dbo].[Product_ProductTag_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductTag_Mapping_Product_ProductId] FOREIGN KEY([Product_Id])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product_ProductTag_Mapping] CHECK CONSTRAINT [FK_Product_ProductTag_Mapping_Product_ProductId]
GO
ALTER TABLE [dbo].[Product_ProductTag_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductTag_Mapping_ProductTag_ProductTagId] FOREIGN KEY([ProductTag_Id])
REFERENCES [dbo].[ProductTag] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product_ProductTag_Mapping] CHECK CONSTRAINT [FK_Product_ProductTag_Mapping_ProductTag_ProductTagId]
GO
ALTER TABLE [dbo].[Product_SpecificationAttribute_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Product_SpecificationAttribute_Mapping_Product_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product_SpecificationAttribute_Mapping] CHECK CONSTRAINT [FK_Product_SpecificationAttribute_Mapping_Product_ProductId]
GO
ALTER TABLE [dbo].[Product_SpecificationAttribute_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Product_SpecificationAttribute_Mapping_SpecificationAttributeOption_SpecificationAttributeOptionId] FOREIGN KEY([SpecificationAttributeOptionId])
REFERENCES [dbo].[SpecificationAttributeOption] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product_SpecificationAttribute_Mapping] CHECK CONSTRAINT [FK_Product_SpecificationAttribute_Mapping_SpecificationAttributeOption_SpecificationAttributeOptionId]
GO
ALTER TABLE [dbo].[ProductAttributeCombination]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeCombination_Product_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductAttributeCombination] CHECK CONSTRAINT [FK_ProductAttributeCombination_Product_ProductId]
GO
ALTER TABLE [dbo].[ProductAttributeValue]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttributeValue_Product_ProductAttribute_Mapping_Product_ProductAttribute_MappingId] FOREIGN KEY([ProductAttributeMappingId])
REFERENCES [dbo].[Product_ProductAttribute_Mapping] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductAttributeValue] CHECK CONSTRAINT [FK_ProductAttributeValue_Product_ProductAttribute_Mapping_Product_ProductAttribute_MappingId]
GO
ALTER TABLE [dbo].[ProductReview]  WITH CHECK ADD  CONSTRAINT [FK_ProductReview_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductReview] CHECK CONSTRAINT [FK_ProductReview_Customer_CustomerId]
GO
ALTER TABLE [dbo].[ProductReview]  WITH CHECK ADD  CONSTRAINT [FK_ProductReview_Product_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductReview] CHECK CONSTRAINT [FK_ProductReview_Product_ProductId]
GO
ALTER TABLE [dbo].[ProductReview]  WITH CHECK ADD  CONSTRAINT [FK_ProductReview_Store_StoreId] FOREIGN KEY([StoreId])
REFERENCES [dbo].[Store] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductReview] CHECK CONSTRAINT [FK_ProductReview_Store_StoreId]
GO
ALTER TABLE [dbo].[ProductReview_ReviewType_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_ProductReview_ReviewType_Mapping_ProductReview_ProductReviewId] FOREIGN KEY([ProductReviewId])
REFERENCES [dbo].[ProductReview] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductReview_ReviewType_Mapping] CHECK CONSTRAINT [FK_ProductReview_ReviewType_Mapping_ProductReview_ProductReviewId]
GO
ALTER TABLE [dbo].[ProductReview_ReviewType_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_ProductReview_ReviewType_Mapping_ReviewType_ReviewTypeId] FOREIGN KEY([ReviewTypeId])
REFERENCES [dbo].[ReviewType] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductReview_ReviewType_Mapping] CHECK CONSTRAINT [FK_ProductReview_ReviewType_Mapping_ReviewType_ReviewTypeId]
GO
ALTER TABLE [dbo].[ProductReviewHelpfulness]  WITH CHECK ADD  CONSTRAINT [FK_ProductReviewHelpfulness_ProductReview_ProductReviewId] FOREIGN KEY([ProductReviewId])
REFERENCES [dbo].[ProductReview] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductReviewHelpfulness] CHECK CONSTRAINT [FK_ProductReviewHelpfulness_ProductReview_ProductReviewId]
GO
ALTER TABLE [dbo].[ProductWarehouseInventory]  WITH CHECK ADD  CONSTRAINT [FK_ProductWarehouseInventory_Product_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductWarehouseInventory] CHECK CONSTRAINT [FK_ProductWarehouseInventory_Product_ProductId]
GO
ALTER TABLE [dbo].[ProductWarehouseInventory]  WITH CHECK ADD  CONSTRAINT [FK_ProductWarehouseInventory_Warehouse_WarehouseId] FOREIGN KEY([WarehouseId])
REFERENCES [dbo].[Warehouse] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductWarehouseInventory] CHECK CONSTRAINT [FK_ProductWarehouseInventory_Warehouse_WarehouseId]
GO
ALTER TABLE [dbo].[QueuedEmail]  WITH CHECK ADD  CONSTRAINT [FK_QueuedEmail_EmailAccount_EmailAccountId] FOREIGN KEY([EmailAccountId])
REFERENCES [dbo].[EmailAccount] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[QueuedEmail] CHECK CONSTRAINT [FK_QueuedEmail_EmailAccount_EmailAccountId]
GO
ALTER TABLE [dbo].[RecurringPayment]  WITH CHECK ADD  CONSTRAINT [FK_RecurringPayment_Order_OrderId] FOREIGN KEY([InitialOrderId])
REFERENCES [dbo].[Order] ([Id])
GO
ALTER TABLE [dbo].[RecurringPayment] CHECK CONSTRAINT [FK_RecurringPayment_Order_OrderId]
GO
ALTER TABLE [dbo].[RecurringPaymentHistory]  WITH CHECK ADD  CONSTRAINT [FK_RecurringPaymentHistory_RecurringPayment_RecurringPaymentId] FOREIGN KEY([RecurringPaymentId])
REFERENCES [dbo].[RecurringPayment] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RecurringPaymentHistory] CHECK CONSTRAINT [FK_RecurringPaymentHistory_RecurringPayment_RecurringPaymentId]
GO
ALTER TABLE [dbo].[RefreshTokens]  WITH CHECK ADD  CONSTRAINT [FK_RefreshTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[RefreshTokens] CHECK CONSTRAINT [FK_RefreshTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[ReturnRequest]  WITH CHECK ADD  CONSTRAINT [FK_ReturnRequest_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ReturnRequest] CHECK CONSTRAINT [FK_ReturnRequest_Customer_CustomerId]
GO
ALTER TABLE [dbo].[RewardPointsHistory]  WITH CHECK ADD  CONSTRAINT [FK_RewardPointsHistory_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RewardPointsHistory] CHECK CONSTRAINT [FK_RewardPointsHistory_Customer_CustomerId]
GO
ALTER TABLE [dbo].[RewardPointsHistory]  WITH CHECK ADD  CONSTRAINT [FK_RewardPointsHistory_Order_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[RewardPointsHistory] CHECK CONSTRAINT [FK_RewardPointsHistory_Order_OrderId]
GO
ALTER TABLE [dbo].[Shipment]  WITH CHECK ADD  CONSTRAINT [FK_Shipment_Order_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Shipment] CHECK CONSTRAINT [FK_Shipment_Order_OrderId]
GO
ALTER TABLE [dbo].[ShipmentItem]  WITH CHECK ADD  CONSTRAINT [FK_ShipmentItem_Shipment_ShipmentId] FOREIGN KEY([ShipmentId])
REFERENCES [dbo].[Shipment] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShipmentItem] CHECK CONSTRAINT [FK_ShipmentItem_Shipment_ShipmentId]
GO
ALTER TABLE [dbo].[ShippingMethodRestrictions]  WITH CHECK ADD  CONSTRAINT [FK_ShippingMethodRestrictions_Country_CountryId] FOREIGN KEY([Country_Id])
REFERENCES [dbo].[Country] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShippingMethodRestrictions] CHECK CONSTRAINT [FK_ShippingMethodRestrictions_Country_CountryId]
GO
ALTER TABLE [dbo].[ShippingMethodRestrictions]  WITH CHECK ADD  CONSTRAINT [FK_ShippingMethodRestrictions_ShippingMethod_ShippingMethodId] FOREIGN KEY([ShippingMethod_Id])
REFERENCES [dbo].[ShippingMethod] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShippingMethodRestrictions] CHECK CONSTRAINT [FK_ShippingMethodRestrictions_ShippingMethod_ShippingMethodId]
GO
ALTER TABLE [dbo].[ShoppingCartItem]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCartItem_Customer_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShoppingCartItem] CHECK CONSTRAINT [FK_ShoppingCartItem_Customer_CustomerId]
GO
ALTER TABLE [dbo].[ShoppingCartItem]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCartItem_Product_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShoppingCartItem] CHECK CONSTRAINT [FK_ShoppingCartItem_Product_ProductId]
GO
ALTER TABLE [dbo].[SpecificationAttributeOption]  WITH CHECK ADD  CONSTRAINT [FK_SpecificationAttributeOption_SpecificationAttribute_SpecificationAttributeId] FOREIGN KEY([SpecificationAttributeId])
REFERENCES [dbo].[SpecificationAttribute] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SpecificationAttributeOption] CHECK CONSTRAINT [FK_SpecificationAttributeOption_SpecificationAttribute_SpecificationAttributeId]
GO
ALTER TABLE [dbo].[StateProvince]  WITH CHECK ADD  CONSTRAINT [FK_StateProvince_Country_CountryId] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[StateProvince] CHECK CONSTRAINT [FK_StateProvince_Country_CountryId]
GO
ALTER TABLE [dbo].[StockQuantityHistory]  WITH CHECK ADD  CONSTRAINT [FK_StockQuantityHistory_Product_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[StockQuantityHistory] CHECK CONSTRAINT [FK_StockQuantityHistory_Product_ProductId]
GO
ALTER TABLE [dbo].[StockQuantityHistory]  WITH CHECK ADD  CONSTRAINT [FK_StockQuantityHistory_Warehouse_WarehouseId] FOREIGN KEY([WarehouseId])
REFERENCES [dbo].[Warehouse] ([Id])
GO
ALTER TABLE [dbo].[StockQuantityHistory] CHECK CONSTRAINT [FK_StockQuantityHistory_Warehouse_WarehouseId]
GO
ALTER TABLE [dbo].[StoreMapping]  WITH CHECK ADD  CONSTRAINT [FK_StoreMapping_Store_StoreId] FOREIGN KEY([StoreId])
REFERENCES [dbo].[Store] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[StoreMapping] CHECK CONSTRAINT [FK_StoreMapping_Store_StoreId]
GO
ALTER TABLE [dbo].[TierPrice]  WITH CHECK ADD  CONSTRAINT [FK_TierPrice_CustomerRole_CustomerRoleId] FOREIGN KEY([CustomerRoleId])
REFERENCES [dbo].[CustomerRole] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TierPrice] CHECK CONSTRAINT [FK_TierPrice_CustomerRole_CustomerRoleId]
GO
ALTER TABLE [dbo].[TierPrice]  WITH CHECK ADD  CONSTRAINT [FK_TierPrice_Product_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TierPrice] CHECK CONSTRAINT [FK_TierPrice_Product_ProductId]
GO
ALTER TABLE [dbo].[VendorAttributeValue]  WITH CHECK ADD  CONSTRAINT [FK_VendorAttributeValue_VendorAttribute_VendorAttributeId] FOREIGN KEY([VendorAttributeId])
REFERENCES [dbo].[VendorAttribute] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[VendorAttributeValue] CHECK CONSTRAINT [FK_VendorAttributeValue_VendorAttribute_VendorAttributeId]
GO
ALTER TABLE [dbo].[VendorNote]  WITH CHECK ADD  CONSTRAINT [FK_VendorNote_Vendor_VendorId] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[VendorNote] CHECK CONSTRAINT [FK_VendorNote_Vendor_VendorId]
GO
/****** Object:  StoredProcedure [dbo].[CartValidator]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Hisham Asghar
-- Create date: 03/04/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[CartValidator]
	-- Add the parameters for the stored procedure here
	@storeId int = 0, 
	@customerId int = 0,
	@productId int = 0,
	@Quantity int = 0
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


DECLARE @warnning nvarchar(max);
DECLARE @IsDeleted bit = 0;
DECLARE @ProductTypeId int = 0;
DECLARE @OrderMinimumQuantity int = 0;
DECLARE @OrderMaximumQuantity int = 0;
DECLARE @Records int = 0;
if(@Quantity <= 0)
BEGIN
SELECT @warnning = @warnning+',Quantity Can not be zero or less then zero'
END
SELECT
@Records = COUNT(p.Id),
 @IsDeleted = p.Deleted, @ProductTypeId = p.ProductTypeId,@OrderMinimumQuantity = p.OrderMinimumQuantity,
 @OrderMaximumQuantity = p.OrderMaximumQuantity FROM dbo.Product p WHERE p.Id = @productId
 group by p.Deleted,p.ProductTypeId,p.OrderMinimumQuantity,p.OrderMaximumQuantity
 if(@Records > 0)
 BEGIN
  if(@IsDeleted = 1)
 BEGIN
   SELECT @warnning = @warnning+',Product Is Deleted' 
 END

 if(@ProductTypeId != 5)
 BEGIN
   SELECT @warnning = @warnning+',Only Simple Product Can be added'
 END


 if(@OrderMinimumQuantity > @Quantity)
 BEGIN
   SELECT @warnning = @warnning+',Product Quantity is less then Minimum Quantity' 
 END


 if(@OrderMaximumQuantity < @Quantity)
 BEGIN
   SELECT @warnning = @warnning+',Product Quantity is greater then Maximum Quantity' 
 END
 

 END
 ELSE
 SELECT @warnning = @warnning+',No Product Found' 



END



GO
/****** Object:  StoredProcedure [dbo].[CategoryLoadAllPaged]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CategoryLoadAllPaged]
(
    @ShowHidden         BIT = 0,
    @Name               NVARCHAR(MAX) = NULL,
    @StoreId            INT = 0,
    @CustomerRoleIds	NVARCHAR(MAX) = NULL,
    @PageIndex			INT = 0,
	@PageSize			INT = 2147483644,
    @TotalRecords		INT = NULL OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON

    --filter by customer role IDs (access control list)
	SET @CustomerRoleIds = ISNULL(@CustomerRoleIds, '')
	CREATE TABLE #FilteredCustomerRoleIds
	(
		CustomerRoleId INT NOT NULL
	)
	INSERT INTO #FilteredCustomerRoleIds (CustomerRoleId)
	SELECT CAST(data AS INT) FROM [nop_splitstring_to_table](@CustomerRoleIds, ',')
	DECLARE @FilteredCustomerRoleIdsCount INT = (SELECT COUNT(1) FROM #FilteredCustomerRoleIds)

    --ordered categories
    CREATE TABLE #OrderedCategoryIds
	(
		[Id] int IDENTITY (1, 1) NOT NULL,
		[CategoryId] int NOT NULL
	)
    
    --get max length of DisplayOrder and Id columns (used for padding Order column)
    DECLARE @lengthId INT = (SELECT LEN(MAX(Id)) FROM [Category])
    DECLARE @lengthOrder INT = (SELECT LEN(MAX(DisplayOrder)) FROM [Category])

    --get category tree
    ;WITH [CategoryTree]
    AS (SELECT [Category].[Id] AS [Id], 
		(select RIGHT(REPLICATE('0', @lengthOrder)+ RTRIM(CAST([Category].[DisplayOrder] AS NVARCHAR(MAX))), @lengthOrder)) + '-' + (select RIGHT(REPLICATE('0', @lengthId)+ RTRIM(CAST([Category].[Id] AS NVARCHAR(MAX))), @lengthId))  AS [Order]
        FROM [Category] WHERE [Category].[ParentCategoryId] = 0
        UNION ALL
        SELECT [Category].[Id] AS [Id], 
		[CategoryTree].[Order] + '|' + (select RIGHT(REPLICATE('0', @lengthOrder)+ RTRIM(CAST([Category].[DisplayOrder] AS NVARCHAR(MAX))), @lengthOrder)) + '-' + (select RIGHT(REPLICATE('0', @lengthId)+ RTRIM(CAST([Category].[Id] AS NVARCHAR(MAX))), @lengthId))  AS [Order]
        FROM [Category]
        INNER JOIN [CategoryTree] ON [CategoryTree].[Id] = [Category].[ParentCategoryId])
    INSERT INTO #OrderedCategoryIds ([CategoryId])
    SELECT [Category].[Id]
    FROM [CategoryTree]
    RIGHT JOIN [Category] ON [CategoryTree].[Id] = [Category].[Id]

    --filter results
    WHERE [Category].[Deleted] = 0
    AND (@ShowHidden = 1 OR [Category].[Published] = 1)
    AND (@Name IS NULL OR @Name = '' OR [Category].[Name] LIKE ('%' + @Name + '%'))
    AND (@ShowHidden = 1 OR @FilteredCustomerRoleIdsCount  = 0 OR [Category].[SubjectToAcl] = 0
        OR EXISTS (SELECT 1 FROM #FilteredCustomerRoleIds [roles] WHERE [roles].[CustomerRoleId] IN
            (SELECT [acl].[CustomerRoleId] FROM [AclRecord] acl WITH (NOLOCK) WHERE [acl].[EntityId] = [Category].[Id] AND [acl].[EntityName] = 'Category')
        )
    )
    AND (@StoreId = 0 OR [Category].[LimitedToStores] = 0
        OR EXISTS (SELECT 1 FROM [StoreMapping] sm WITH (NOLOCK)
			WHERE [sm].[EntityId] = [Category].[Id] AND [sm].[EntityName] = 'Category' AND [sm].[StoreId] = @StoreId
		)
    )
    ORDER BY ISNULL([CategoryTree].[Order], 1)

    --total records
    SET @TotalRecords = @@ROWCOUNT

    --paging
    SELECT [Category].* FROM #OrderedCategoryIds AS [Result] INNER JOIN [Category] ON [Result].[CategoryId] = [Category].[Id]
    WHERE ([Result].[Id] > @PageSize * @PageIndex AND [Result].[Id] <= @PageSize * (@PageIndex + 1))
    ORDER BY [Result].[Id]

    DROP TABLE #FilteredCustomerRoleIds
    DROP TABLE #OrderedCategoryIds
END


GO
/****** Object:  StoredProcedure [dbo].[CreateCustomerFromIdentityUser]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hisham Asghar
-- Create date: 03/04/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[CreateCustomerFromIdentityUser]
	-- Add the parameters for the stored procedure here
	@userId nvarchar(450), 
	@password nvarchar(max),
	@firstName nvarchar(450),
	@lastName nvarchar(450),
	@onCreated datetime2(7)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


DECLARE @userName nvarchar(256);
DECLARE @email nvarchar(256);
DECLARE @customerId int;

SELECT @userName = UserName, @email = Email FROM dbo.AspNetUsers WHERE Id = @userId

INSERT INTO [dbo].[Customer]

    ([RegisteredInStoreId],[LastActivityDateUtc],[CreatedOnUtc],[IsSystemAccount]
	,[Active],[Email],[Username],[CustomerGuid],Deleted,FailedLoginAttempts
	,RequireReLogin,HasShoppingCartItems,VendorId,AffiliateId,IsTaxExempt)
	OUTPUT INSERTED.Id 
     VALUES (1, @onCreated, @onCreated, 0, 1, @email, @userName, @userId, 0, 0, 0, 0, 0, 0, 0)


SELECT @customerId = Id FROM dbo.Customer WHERE CustomerGuid = @userId;
UPDATE dbo.AspNetUsers
 SET CustomerId = @customerId
  WHERE Id = @userId;

  

INSERT INTO dbo.Customer_CustomerRole_Mapping
	(Customer_Id,CustomerRole_Id)
	VALUES(@customerId,(SELECT Id FROM dbo.CustomerRole WHERE SystemName = 'Registered'))

INSERT INTO [dbo].[CustomerPassword]
           ([CreatedOnUtc],[PasswordFormatId],[Password],[CustomerId])
     VALUES
           (@onCreated,0,@password,@customerId)
		   
INSERT INTO [dbo].[CustomerPassword]
           ([CreatedOnUtc],[PasswordFormatId],[Password],[CustomerId])
     VALUES
           (@onCreated,0,@password,@customerId)

INSERT INTO [dbo].[GenericAttribute]
           ([CreatedOrUpdatedDateUTC]
           ,[StoreId]
           ,[Value]
           ,[Key]
           ,[KeyGroup]
           ,[EntityId])
     VALUES
           (@onCreated,0,@firstName,'FirstName','Customer',@customerId),
           (@onCreated,0,@lastName,'LastName','Customer',@customerId)



END


GO
/****** Object:  StoredProcedure [dbo].[CreateUpdateShoppingCart]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Hisham Asghar
-- Create date: 03/04/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[CreateUpdateShoppingCart]
	@StoreId int = 0, 
	@ShoppingCartTypeId int = 0,
	@ProductId int = 0,
	@CustomerId int = 0,
	@CurrentTime datetime = '',
	@AttributeXml nvarchar(MAX),
	@Quantity int = 0
AS
Declare @CurrentQuantity int = 0;
Declare @ShoppingCartItemId int = 0;
SELECT  @CurrentQuantity = dc.Quantity,@ShoppingCartItemId = dc.Id  FROM dbo.ShoppingCartView dc 
WHERE dc.ShoppingCartTypeId = @ShoppingCartTypeId
AND dc.ProductId = @ProductId
AND dc.StoreId = @StoreId
AND dc.AttributesXml = @AttributeXml
AND dc.CustomerId = @CustomerId

if(@CurrentQuantity > 0)

BEGIN
 UPDATE  dbo.ShoppingCartItem SET dbo.ShoppingCartItem.Quantity = @CurrentQuantity+@Quantity ,
 dbo.ShoppingCartItem.UpdatedOnUtc = @CurrentTime
 WHERE dbo.ShoppingCartItem.Id = @ShoppingCartItemId
END
ELSE

BEGIN

INSERT INTO dbo.ShoppingCartItem (StoreId,CustomerId,ShoppingCartTypeId,ProductId,AttributesXml,CustomerEnteredPrice,Quantity,CreatedOnUtc,UpdatedOnUtc)
VALUES(@StoreId,@CustomerId,@ShoppingCartTypeId,@ProductId,@AttributeXml,0,@Quantity,@CurrentTime,@CurrentTime)

END


 SELECT * FROM dbo.ShoppingCartView WHERE dbo.ShoppingCartView.CustomerId = @CustomerId


GO
/****** Object:  StoredProcedure [dbo].[DeleteAddress]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteAddress] 
@AddressId int = 0
AS
BEGIN
	DELETE FROM dbo.CustomerAddresses WHERE dbo.CustomerAddresses.Address_Id = @AddressId;

	Delete FROM dbo.[Address] WHERE dbo.[Address].Id = @AddressId;


END



GO
/****** Object:  StoredProcedure [dbo].[DeleteGuests]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteGuests]
(
	@OnlyWithoutShoppingCart bit = 1,
	@CreatedFromUtc datetime,
	@CreatedToUtc datetime,
	@TotalRecordsDeleted int = null OUTPUT
)
AS
BEGIN
	CREATE TABLE #tmp_guests (CustomerId int)
	CREATE TABLE #tmp_adresses (AddressId int)
		
	INSERT #tmp_guests (CustomerId)
	SELECT c.[Id] 
	FROM [Customer] c with (NOLOCK)
		LEFT JOIN [ShoppingCartItem] sci with (NOLOCK) ON sci.[CustomerId] = c.[Id]
		INNER JOIN (
			--guests only
			SELECT ccrm.[Customer_Id] 
			FROM [Customer_CustomerRole_Mapping] ccrm with (NOLOCK)
				INNER JOIN [CustomerRole] cr with (NOLOCK) ON cr.[Id] = ccrm.[CustomerRole_Id]
			WHERE cr.[SystemName] = N'Guests'
		) g ON g.[Customer_Id] = c.[Id]
		LEFT JOIN [Order] o with (NOLOCK) ON o.[CustomerId] = c.[Id]
		LEFT JOIN [BlogComment] bc with (NOLOCK) ON bc.[CustomerId] = c.[Id]
		LEFT JOIN [NewsComment] nc with (NOLOCK) ON nc.[CustomerId] = c.[Id]
		LEFT JOIN [ProductReview] pr with (NOLOCK) ON pr.[CustomerId] = c.[Id]
		LEFT JOIN [ProductReviewHelpfulness] prh with (NOLOCK) ON prh.[CustomerId] = c.[Id]
		LEFT JOIN [PollVotingRecord] pvr with (NOLOCK) ON pvr.[CustomerId] = c.[Id]
		LEFT JOIN [Forums_Topic] ft with (NOLOCK) ON ft.[CustomerId] = c.[Id]
		LEFT JOIN [Forums_Post] fp with (NOLOCK) ON fp.[CustomerId] = c.[Id]
	WHERE 1 = 1
		--no orders
		AND (o.Id is null)
		--no blog comments
		AND (bc.Id is null)
		--no news comments
		AND (nc.Id is null)
		--no product reviews
		AND (pr.Id is null)
		--no product reviews helpfulness
		AND (prh.Id is null)
		--no poll voting
		AND (pvr.Id is null)
		--no forum topics
		AND (ft.Id is null)
		--no forum topics
		AND (fp.Id is null)
		--no system accounts
		AND (c.IsSystemAccount = 0)
		--created from
		AND ((@CreatedFromUtc is null) OR (c.[CreatedOnUtc] > @CreatedFromUtc))
		--created to
		AND ((@CreatedToUtc is null) OR (c.[CreatedOnUtc] < @CreatedToUtc))
		--shopping cart items
		AND ((@OnlyWithoutShoppingCart = 0) OR (sci.Id is null))

	INSERT #tmp_adresses (AddressId)
	SELECT [Address_Id] FROM [CustomerAddresses] WHERE [Customer_Id] IN (SELECT [CustomerId] FROM #tmp_guests)

	--delete guests
	DELETE [Customer]
	WHERE [Id] IN (SELECT [CustomerId] FROM #tmp_guests)
	
	--delete attributes
	DELETE [GenericAttribute]
	WHERE ([EntityId] IN (SELECT [CustomerId] FROM #tmp_guests))
	AND
	([KeyGroup] = N'Customer')

	--delete addresses
	DELETE [Address]
	WHERE [Id] IN (SELECT [AddressId] FROM #tmp_adresses)
	
	--total records
	SELECT @TotalRecordsDeleted = COUNT(1) FROM #tmp_guests
	
	DROP TABLE #tmp_guests
	DROP TABLE #tmp_adresses
END


GO
/****** Object:  StoredProcedure [dbo].[DeleteOrder]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteOrder] 
@OrderId int = 0
AS
BEGIN
	DELETE FROM dbo.OrderItem WHERE dbo.OrderItem.OrderId = @OrderId;

	Delete FROM dbo.[Order] WHERE dbo.[Order].Id = @OrderId;


END


GO
/****** Object:  StoredProcedure [dbo].[FullText_Disable]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FullText_Disable]
AS
BEGIN
	EXEC('
	--drop indexes
	IF EXISTS (SELECT 1 FROM sys.fulltext_indexes WHERE object_id = object_id(''[Product]''))
		DROP FULLTEXT INDEX ON [Product]
	')

	EXEC('
	IF EXISTS (SELECT 1 FROM sys.fulltext_indexes WHERE object_id = object_id(''[LocalizedProperty]''))
		DROP FULLTEXT INDEX ON [LocalizedProperty]
	')

	EXEC('
	IF EXISTS (SELECT 1 FROM sys.fulltext_indexes WHERE object_id = object_id(''[ProductTag]''))
		DROP FULLTEXT INDEX ON [ProductTag]
	')

	--drop catalog
	EXEC('
	IF EXISTS (SELECT 1 FROM sys.fulltext_catalogs WHERE [name] = ''nopCommerceFullTextCatalog'')
		DROP FULLTEXT CATALOG [nopCommerceFullTextCatalog]
	')
END


GO
/****** Object:  StoredProcedure [dbo].[FullText_Enable]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FullText_Enable]
AS
BEGIN
	--create catalog
	EXEC('
	IF NOT EXISTS (SELECT 1 FROM sys.fulltext_catalogs WHERE [name] = ''nopCommerceFullTextCatalog'')
		CREATE FULLTEXT CATALOG [nopCommerceFullTextCatalog] AS DEFAULT')

	DECLARE @SQL nvarchar(500);
	DECLARE @index_name nvarchar(1000)
	DECLARE @ParmDefinition nvarchar(500);

	SELECT @SQL = N'SELECT @index_name_out = i.name FROM sys.tables AS tbl INNER JOIN sys.indexes AS i ON (i.index_id > 0 and i.is_hypothetical = 0) AND (i.object_id=tbl.object_id) WHERE (i.is_unique=1 and i.is_disabled=0) and (tbl.name=@table_name)'
	SELECT @ParmDefinition = N'@table_name varchar(100), @index_name_out nvarchar(1000) OUTPUT'

	EXEC sp_executesql @SQL, @ParmDefinition, @table_name = 'Product', @index_name_out=@index_name OUTPUT
	
	--create indexes
	DECLARE @create_index_text nvarchar(4000)
	SET @create_index_text = '
	IF NOT EXISTS (SELECT 1 FROM sys.fulltext_indexes WHERE object_id = object_id(''[Product]''))
		CREATE FULLTEXT INDEX ON [Product]([Name], [ShortDescription], [FullDescription])
		KEY INDEX [' + @index_name +  '] ON [nopCommerceFullTextCatalog] WITH CHANGE_TRACKING AUTO'
	EXEC(@create_index_text)

	EXEC sp_executesql @SQL, @ParmDefinition, @table_name = 'LocalizedProperty', @index_name_out=@index_name OUTPUT
	
	SET @create_index_text = '
	IF NOT EXISTS (SELECT 1 FROM sys.fulltext_indexes WHERE object_id = object_id(''[LocalizedProperty]''))
		CREATE FULLTEXT INDEX ON [LocalizedProperty]([LocaleValue])
		KEY INDEX [' + @index_name +  '] ON [nopCommerceFullTextCatalog] WITH CHANGE_TRACKING AUTO'
	EXEC(@create_index_text)

	EXEC sp_executesql @SQL, @ParmDefinition, @table_name = 'ProductTag', @index_name_out=@index_name OUTPUT

	SET @create_index_text = '
	IF NOT EXISTS (SELECT 1 FROM sys.fulltext_indexes WHERE object_id = object_id(''[ProductTag]''))
		CREATE FULLTEXT INDEX ON [ProductTag]([Name])
		KEY INDEX [' + @index_name +  '] ON [nopCommerceFullTextCatalog] WITH CHANGE_TRACKING AUTO'
	EXEC(@create_index_text)
END


GO
/****** Object:  StoredProcedure [dbo].[FullText_IsSupported]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FullText_IsSupported]
AS
BEGIN	
	EXEC('
	SELECT CASE SERVERPROPERTY(''IsFullTextInstalled'')
	WHEN 1 THEN 
		CASE DatabaseProperty (DB_NAME(DB_ID()), ''IsFulltextEnabled'')
		WHEN 1 THEN 1
		ELSE 0
		END
	ELSE 0
	END as Value')
END


GO
/****** Object:  StoredProcedure [dbo].[GetProductByIdOrGuid]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Hisham Asghar
-- Create date: 02/29/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetProductByIdOrGuid] 
	-- Add the parameters for the stored procedure here
	@id int = 0, 
	@guid nvarchar(MAX) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
	(SELECT *,
	(
		SELECT ProductAttributeMapping.*,ProductAttribute.Name ProductAttributeName,
		(
			SELECT *
			FROM dbo.ProductAttributeValue ProductAttributeValue
			WHERE ProductAttributeValue.ProductAttributeMappingId = ProductAttributeMapping.Id
			FOR XML PATH('AttributeValue'), ROOT('AttributeValues'), TYPE
		) 
		FROM dbo.Product_ProductAttribute_Mapping ProductAttributeMapping
			INNER JOIN dbo.ProductAttribute ProductAttribute
			ON ProductAttribute.Id = ProductAttributeMapping.ProductAttributeId
		WHERE Product.Id = ProductAttributeMapping.ProductId 
		FOR XML PATH('ProductAttribute'), ROOT('ProductAttributes'), TYPE)
  FROM 
  (
	SELECT dbo.Product.*,UrlRecord.Slug SeName,
	ISNULL('['+STUFF
	(( SELECT ',' + Prod.Json
FROM dbo.Product_Picture_Mapping PP INNER JOIN
dbo.PictureJsonView Prod ON PP.PictureId = Prod.Id
WHERE ProductId = dbo.Product.Id ORDER BY PP.DisplayOrder FOR XML PATH('') ), 1, 1, '') 
	+']','[]') PicturesJson,
	(SELECT TOP 1 ProductCategoryMapping.CategoryId FROM
		dbo.Product_Category_Mapping ProductCategoryMapping
		WHERE ProductCategoryMapping.ProductId = dbo.Product.Id
	) CategoryId
	FROM dbo.Product 
	INNER JOIN dbo.UrlRecord UrlRecord
	ON Product.Id = UrlRecord.EntityId AND UrlRecord.IsActive = 1 AND UrlRecord.EntityName = 'Product'

	)
   Product 
	

  WHERE Product.Id = @id OR (Product.SeName IS NOT NULL AND RTRIM(LTRIM(Product.SeName)) != '' AND Product.SeName = @guid)
  FOR XML AUTO) Result

END





GO
/****** Object:  StoredProcedure [dbo].[LanguagePackImport]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LanguagePackImport]
(
	@LanguageId int,
	@XmlPackage xml,
	@UpdateExistingResources bit
)
AS
BEGIN
	IF EXISTS(SELECT * FROM [Language] WHERE [Id] = @LanguageId)
	BEGIN
		CREATE TABLE #LocaleStringResourceTmp
			(
				[LanguageId] [int] NOT NULL,
				[ResourceName] [nvarchar](200) NOT NULL,
				[ResourceValue] [nvarchar](MAX) NOT NULL
			)

		INSERT INTO #LocaleStringResourceTmp (LanguageId, ResourceName, ResourceValue)
		SELECT	@LanguageId, nref.value('@Name', 'nvarchar(200)'), nref.value('Value[1]', 'nvarchar(MAX)')
		FROM	@XmlPackage.nodes('//Language/LocaleResource') AS R(nref)

		DECLARE @ResourceName nvarchar(200)
		DECLARE @ResourceValue nvarchar(MAX)
		DECLARE cur_localeresource CURSOR FOR
		SELECT LanguageId, ResourceName, ResourceValue
		FROM #LocaleStringResourceTmp
		OPEN cur_localeresource
		FETCH NEXT FROM cur_localeresource INTO @LanguageId, @ResourceName, @ResourceValue
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF (EXISTS (SELECT 1 FROM [LocaleStringResource] WHERE LanguageId=@LanguageId AND ResourceName=@ResourceName))
			BEGIN
				IF (@UpdateExistingResources = 1)
				BEGIN
					UPDATE [LocaleStringResource]
					SET [ResourceValue]=@ResourceValue
					WHERE LanguageId=@LanguageId AND ResourceName=@ResourceName
				END
			END
			ELSE 
			BEGIN
				INSERT INTO [LocaleStringResource]
				(
					[LanguageId],
					[ResourceName],
					[ResourceValue]
				)
				VALUES
				(
					@LanguageId,
					@ResourceName,
					@ResourceValue
				)
			END
			
			
			FETCH NEXT FROM cur_localeresource INTO @LanguageId, @ResourceName, @ResourceValue
			END
		CLOSE cur_localeresource
		DEALLOCATE cur_localeresource

		DROP TABLE #LocaleStringResourceTmp
	END
END


GO
/****** Object:  StoredProcedure [dbo].[ProductLoadAllPaged]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductLoadAllPaged]
(
	@CategoryIds		nvarchar(MAX) = null,	--a list of category IDs (comma-separated list). e.g. 1,2,3
	@ManufacturerId		int = 0,
	@StoreId			int = 0,
	@VendorId			int = 0,
	@WarehouseId		int = 0,
	@ProductTypeId		int = null, --product type identifier, null - load all products
	@VisibleIndividuallyOnly bit = 0, 	--0 - load all products , 1 - "visible indivially" only
	@MarkedAsNewOnly	bit = 0, 	--0 - load all products , 1 - "marked as new" only
	@ProductTagId		int = 0,
	@FeaturedProducts	bit = null,	--0 featured only , 1 not featured only, null - load all products
	@PriceMin			decimal(18, 4) = null,
	@PriceMax			decimal(18, 4) = null,
	@Keywords			nvarchar(4000) = null,
	@SearchDescriptions bit = 0, --a value indicating whether to search by a specified "keyword" in product descriptions
	@SearchManufacturerPartNumber bit = 0, -- a value indicating whether to search by a specified "keyword" in manufacturer part number
	@SearchSku			bit = 0, --a value indicating whether to search by a specified "keyword" in product SKU
	@SearchProductTags  bit = 0, --a value indicating whether to search by a specified "keyword" in product tags
	@UseFullTextSearch  bit = 0,
	@FullTextMode		int = 0, --0 - using CONTAINS with <prefix_term>, 5 - using CONTAINS and OR with <prefix_term>, 10 - using CONTAINS and AND with <prefix_term>
	@FilteredSpecs		nvarchar(MAX) = null,	--filter by specification attribute options (comma-separated list of IDs). e.g. 14,15,16
	@LanguageId			int = 0,
	@OrderBy			int = 0, --0 - position, 5 - Name: A to Z, 6 - Name: Z to A, 10 - Price: Low to High, 11 - Price: High to Low, 15 - creation date
	@AllowedCustomerRoleIds	nvarchar(MAX) = null,	--a list of customer role IDs (comma-separated list) for which a product should be shown (if a subject to ACL)
	@PageIndex			int = 0, 
	@PageSize			int = 2147483644,
	@ShowHidden			bit = 0,
	@OverridePublished	bit = null, --null - process "Published" property according to "showHidden" parameter, true - load only "Published" products, false - load only "Unpublished" products
	@LoadFilterableSpecificationAttributeOptionIds bit = 0, --a value indicating whether we should load the specification attribute option identifiers applied to loaded products (all pages)
	@FilterableSpecificationAttributeOptionIds nvarchar(MAX) = null OUTPUT, --the specification attribute option identifiers applied to loaded products (all pages). returned as a comma separated list of identifiers
	@TotalRecords		int = null OUTPUT
)
AS
BEGIN
	
	/* Products that filtered by keywords */
	CREATE TABLE #KeywordProducts
	(
		[ProductId] int NOT NULL
	)

	DECLARE
		@SearchKeywords bit,
		@OriginalKeywords nvarchar(4000),
		@sql nvarchar(max),
		@sql_orderby nvarchar(max)

	SET NOCOUNT ON
	
	--filter by keywords
	SET @Keywords = isnull(@Keywords, '')
	SET @Keywords = rtrim(ltrim(@Keywords))
	SET @OriginalKeywords = @Keywords
	IF ISNULL(@Keywords, '') != ''
	BEGIN
		SET @SearchKeywords = 1
		
		IF @UseFullTextSearch = 1
		BEGIN
			--remove wrong chars (' ")
			SET @Keywords = REPLACE(@Keywords, '''', '')
			SET @Keywords = REPLACE(@Keywords, '"', '')
			
			--full-text search
			IF @FullTextMode = 0 
			BEGIN
				--0 - using CONTAINS with <prefix_term>
				SET @Keywords = ' "' + @Keywords + '*" '
			END
			ELSE
			BEGIN
				--5 - using CONTAINS and OR with <prefix_term>
				--10 - using CONTAINS and AND with <prefix_term>

				--clean multiple spaces
				WHILE CHARINDEX('  ', @Keywords) > 0 
					SET @Keywords = REPLACE(@Keywords, '  ', ' ')

				DECLARE @concat_term nvarchar(100)				
				IF @FullTextMode = 5 --5 - using CONTAINS and OR with <prefix_term>
				BEGIN
					SET @concat_term = 'OR'
				END 
				IF @FullTextMode = 10 --10 - using CONTAINS and AND with <prefix_term>
				BEGIN
					SET @concat_term = 'AND'
				END

				--now let's build search string
				declare @fulltext_keywords nvarchar(4000)
				set @fulltext_keywords = N''
				declare @index int		
		
				set @index = CHARINDEX(' ', @Keywords, 0)

				-- if index = 0, then only one field was passed
				IF(@index = 0)
					set @fulltext_keywords = ' "' + @Keywords + '*" '
				ELSE
				BEGIN		
					DECLARE @first BIT
					SET  @first = 1			
					WHILE @index > 0
					BEGIN
						IF (@first = 0)
							SET @fulltext_keywords = @fulltext_keywords + ' ' + @concat_term + ' '
						ELSE
							SET @first = 0

						SET @fulltext_keywords = @fulltext_keywords + '"' + SUBSTRING(@Keywords, 1, @index - 1) + '*"'					
						SET @Keywords = SUBSTRING(@Keywords, @index + 1, LEN(@Keywords) - @index)						
						SET @index = CHARINDEX(' ', @Keywords, 0)
					end
					
					-- add the last field
					IF LEN(@fulltext_keywords) > 0
						SET @fulltext_keywords = @fulltext_keywords + ' ' + @concat_term + ' ' + '"' + SUBSTRING(@Keywords, 1, LEN(@Keywords)) + '*"'	
				END
				SET @Keywords = @fulltext_keywords
			END
		END
		ELSE
		BEGIN
			--usual search by PATINDEX
			SET @Keywords = '%' + @Keywords + '%'
		END
		--PRINT @Keywords

		--product name
		SET @sql = '
		INSERT INTO #KeywordProducts ([ProductId])
		SELECT p.Id
		FROM Product p with (NOLOCK)
		WHERE '
		IF @UseFullTextSearch = 1
			SET @sql = @sql + 'CONTAINS(p.[Name], @Keywords) '
		ELSE
			SET @sql = @sql + 'PATINDEX(@Keywords, p.[Name]) > 0 '

		IF @SearchDescriptions = 1
		BEGIN
			--product short description
			IF @UseFullTextSearch = 1
			BEGIN
				SET @sql = @sql + 'OR CONTAINS(p.[ShortDescription], @Keywords) '
				SET @sql = @sql + 'OR CONTAINS(p.[FullDescription], @Keywords) '
			END
			ELSE
			BEGIN
				SET @sql = @sql + 'OR PATINDEX(@Keywords, p.[ShortDescription]) > 0 '
				SET @sql = @sql + 'OR PATINDEX(@Keywords, p.[FullDescription]) > 0 '
			END
		END

		--manufacturer part number (exact match)
		IF @SearchManufacturerPartNumber = 1
		BEGIN
			SET @sql = @sql + 'OR p.[ManufacturerPartNumber] = @OriginalKeywords '
		END

		--SKU (exact match)
		IF @SearchSku = 1
		BEGIN
			SET @sql = @sql + 'OR p.[Sku] = @OriginalKeywords '
		END

		--localized product name
		SET @sql = @sql + '
		UNION
		SELECT lp.EntityId
		FROM LocalizedProperty lp with (NOLOCK)
		WHERE
			lp.LocaleKeyGroup = N''Product''
			AND lp.LanguageId = ' + ISNULL(CAST(@LanguageId AS nvarchar(max)), '0') + '
			AND ( (lp.LocaleKey = N''Name'''
		IF @UseFullTextSearch = 1
			SET @sql = @sql + ' AND CONTAINS(lp.[LocaleValue], @Keywords) '
		ELSE
			SET @sql = @sql + ' AND PATINDEX(@Keywords, lp.[LocaleValue]) > 0) '

		IF @SearchDescriptions = 1
		BEGIN
			--localized product short description
			SET @sql = @sql + '
				OR (lp.LocaleKey = N''ShortDescription'''
			IF @UseFullTextSearch = 1
				SET @sql = @sql + ' AND CONTAINS(lp.[LocaleValue], @Keywords) '
			ELSE
				SET @sql = @sql + ' AND PATINDEX(@Keywords, lp.[LocaleValue]) > 0) '

			--localized product full description
			SET @sql = @sql + '
				OR (lp.LocaleKey = N''FullDescription'''
			IF @UseFullTextSearch = 1
				SET @sql = @sql + ' AND CONTAINS(lp.[LocaleValue], @Keywords) '
			ELSE
				SET @sql = @sql + ' AND PATINDEX(@Keywords, lp.[LocaleValue]) > 0) '
		END

		SET @sql = @sql + ' ) '

		IF @SearchProductTags = 1
		BEGIN
			--product tags (exact match)
			SET @sql = @sql + '
			UNION
			SELECT pptm.Product_Id
			FROM Product_ProductTag_Mapping pptm with(NOLOCK) INNER JOIN ProductTag pt with(NOLOCK) ON pt.Id = pptm.ProductTag_Id
			WHERE pt.[Name] = @OriginalKeywords '

			--localized product tags
			SET @sql = @sql + '
			UNION
			SELECT pptm.Product_Id
			FROM LocalizedProperty lp with (NOLOCK) INNER JOIN Product_ProductTag_Mapping pptm with(NOLOCK) ON lp.EntityId = pptm.ProductTag_Id
			WHERE
				lp.LocaleKeyGroup = N''ProductTag''
				AND lp.LanguageId = ' + ISNULL(CAST(@LanguageId AS nvarchar(max)), '0') + '
				AND lp.LocaleKey = N''Name''
				AND lp.[LocaleValue] = @OriginalKeywords '
		END

		--PRINT (@sql)
		EXEC sp_executesql @sql, N'@Keywords nvarchar(4000), @OriginalKeywords nvarchar(4000)', @Keywords, @OriginalKeywords

	END
	ELSE
	BEGIN
		SET @SearchKeywords = 0
	END

	--filter by category IDs
	SET @CategoryIds = isnull(@CategoryIds, '')	
	CREATE TABLE #FilteredCategoryIds
	(
		CategoryId int not null
	)
	INSERT INTO #FilteredCategoryIds (CategoryId)
	SELECT CAST(data as int) FROM [nop_splitstring_to_table](@CategoryIds, ',')	
	DECLARE @CategoryIdsCount int	
	SET @CategoryIdsCount = (SELECT COUNT(1) FROM #FilteredCategoryIds)

	--filter by customer role IDs (access control list)
	SET @AllowedCustomerRoleIds = isnull(@AllowedCustomerRoleIds, '')	
	CREATE TABLE #FilteredCustomerRoleIds
	(
		CustomerRoleId int not null
	)
	INSERT INTO #FilteredCustomerRoleIds (CustomerRoleId)
	SELECT CAST(data as int) FROM [nop_splitstring_to_table](@AllowedCustomerRoleIds, ',')
	DECLARE @FilteredCustomerRoleIdsCount int	
	SET @FilteredCustomerRoleIdsCount = (SELECT COUNT(1) FROM #FilteredCustomerRoleIds)
	
	--paging
	DECLARE @PageLowerBound int
	DECLARE @PageUpperBound int
	DECLARE @RowsToReturn int
	SET @RowsToReturn = @PageSize * (@PageIndex + 1)	
	SET @PageLowerBound = @PageSize * @PageIndex
	SET @PageUpperBound = @PageLowerBound + @PageSize + 1
	
	CREATE TABLE #DisplayOrderTmp 
	(
		[Id] int IDENTITY (1, 1) NOT NULL,
		[ProductId] int NOT NULL
	)

	SET @sql = '
	SELECT p.Id
	FROM
		Product p with (NOLOCK)'
	
	IF @CategoryIdsCount > 0
	BEGIN
		SET @sql = @sql + '
		INNER JOIN Product_Category_Mapping pcm with (NOLOCK)
			ON p.Id = pcm.ProductId'
	END
	
	IF @ManufacturerId > 0
	BEGIN
		SET @sql = @sql + '
		INNER JOIN Product_Manufacturer_Mapping pmm with (NOLOCK)
			ON p.Id = pmm.ProductId'
	END
	
	IF ISNULL(@ProductTagId, 0) != 0
	BEGIN
		SET @sql = @sql + '
		INNER JOIN Product_ProductTag_Mapping pptm with (NOLOCK)
			ON p.Id = pptm.Product_Id'
	END
	
	--searching by keywords
	IF @SearchKeywords = 1
	BEGIN
		SET @sql = @sql + '
		JOIN #KeywordProducts kp
			ON  p.Id = kp.ProductId'
	END
	
	SET @sql = @sql + '
	WHERE
		p.Deleted = 0'
	
	--filter by category
	IF @CategoryIdsCount > 0
	BEGIN
		SET @sql = @sql + '
		AND pcm.CategoryId IN ('
		
		SET @sql = @sql + + CAST(@CategoryIds AS nvarchar(max))

		SET @sql = @sql + ')'

		IF @FeaturedProducts IS NOT NULL
		BEGIN
			SET @sql = @sql + '
		AND pcm.IsFeaturedProduct = ' + CAST(@FeaturedProducts AS nvarchar(max))
		END
	END
	
	--filter by manufacturer
	IF @ManufacturerId > 0
	BEGIN
		SET @sql = @sql + '
		AND pmm.ManufacturerId = ' + CAST(@ManufacturerId AS nvarchar(max))
		
		IF @FeaturedProducts IS NOT NULL
		BEGIN
			SET @sql = @sql + '
		AND pmm.IsFeaturedProduct = ' + CAST(@FeaturedProducts AS nvarchar(max))
		END
	END
	
	--filter by vendor
	IF @VendorId > 0
	BEGIN
		SET @sql = @sql + '
		AND p.VendorId = ' + CAST(@VendorId AS nvarchar(max))
	END
	
	--filter by warehouse
	IF @WarehouseId > 0
	BEGIN
		--we should also ensure that 'ManageInventoryMethodId' is set to 'ManageStock' (1)
		--but we skip it in order to prevent hard-coded values (e.g. 1) and for better performance
		SET @sql = @sql + '
		AND  
			(
				(p.UseMultipleWarehouses = 0 AND
					p.WarehouseId = ' + CAST(@WarehouseId AS nvarchar(max)) + ')
				OR
				(p.UseMultipleWarehouses > 0 AND
					EXISTS (SELECT 1 FROM ProductWarehouseInventory [pwi]
					WHERE [pwi].WarehouseId = ' + CAST(@WarehouseId AS nvarchar(max)) + ' AND [pwi].ProductId = p.Id))
			)'
	END
	
	--filter by product type
	IF @ProductTypeId is not null
	BEGIN
		SET @sql = @sql + '
		AND p.ProductTypeId = ' + CAST(@ProductTypeId AS nvarchar(max))
	END
	
	--filter by "visible individually"
	IF @VisibleIndividuallyOnly = 1
	BEGIN
		SET @sql = @sql + '
		AND p.VisibleIndividually = 1'
	END
	
	--filter by "marked as new"
	IF @MarkedAsNewOnly = 1
	BEGIN
		SET @sql = @sql + '
		AND p.MarkAsNew = 1
		AND (getutcdate() BETWEEN ISNULL(p.MarkAsNewStartDateTimeUtc, ''1/1/1900'') and ISNULL(p.MarkAsNewEndDateTimeUtc, ''1/1/2999''))'
	END
	
	--filter by product tag
	IF ISNULL(@ProductTagId, 0) != 0
	BEGIN
		SET @sql = @sql + '
		AND pptm.ProductTag_Id = ' + CAST(@ProductTagId AS nvarchar(max))
	END
	
	--"Published" property
	IF (@OverridePublished is null)
	BEGIN
		--process according to "showHidden"
		IF @ShowHidden = 0
		BEGIN
			SET @sql = @sql + '
			AND p.Published = 1'
		END
	END
	ELSE IF (@OverridePublished = 1)
	BEGIN
		--published only
		SET @sql = @sql + '
		AND p.Published = 1'
	END
	ELSE IF (@OverridePublished = 0)
	BEGIN
		--unpublished only
		SET @sql = @sql + '
		AND p.Published = 0'
	END
	
	--show hidden
	IF @ShowHidden = 0
	BEGIN
		SET @sql = @sql + '
		AND p.Deleted = 0
		AND (getutcdate() BETWEEN ISNULL(p.AvailableStartDateTimeUtc, ''1/1/1900'') and ISNULL(p.AvailableEndDateTimeUtc, ''1/1/2999''))'
	END
	
	--min price
	IF @PriceMin is not null
	BEGIN
		SET @sql = @sql + '
		AND (p.Price >= ' + CAST(@PriceMin AS nvarchar(max)) + ')'
	END
	
	--max price
	IF @PriceMax is not null
	BEGIN
		SET @sql = @sql + '
		AND (p.Price <= ' + CAST(@PriceMax AS nvarchar(max)) + ')'
	END
	
	--show hidden and ACL
	IF  @ShowHidden = 0 and @FilteredCustomerRoleIdsCount > 0
	BEGIN
		SET @sql = @sql + '
		AND (p.SubjectToAcl = 0 OR EXISTS (
			SELECT 1 FROM #FilteredCustomerRoleIds [fcr]
			WHERE
				[fcr].CustomerRoleId IN (
					SELECT [acl].CustomerRoleId
					FROM [AclRecord] acl with (NOLOCK)
					WHERE [acl].EntityId = p.Id AND [acl].EntityName = ''Product''
				)
			))'
	END
	
	--filter by store
	IF @StoreId > 0
	BEGIN
		SET @sql = @sql + '
		AND (p.LimitedToStores = 0 OR EXISTS (
			SELECT 1 FROM [StoreMapping] sm with (NOLOCK)
			WHERE [sm].EntityId = p.Id AND [sm].EntityName = ''Product'' and [sm].StoreId=' + CAST(@StoreId AS nvarchar(max)) + '
			))'
	END
	
    --prepare filterable specification attribute option identifier (if requested)
    IF @LoadFilterableSpecificationAttributeOptionIds = 1
	BEGIN		
		CREATE TABLE #FilterableSpecs 
		(
			[SpecificationAttributeOptionId] int NOT NULL
		)
        DECLARE @sql_filterableSpecs nvarchar(max)
        SET @sql_filterableSpecs = '
	        INSERT INTO #FilterableSpecs ([SpecificationAttributeOptionId])
	        SELECT DISTINCT [psam].SpecificationAttributeOptionId
	        FROM [Product_SpecificationAttribute_Mapping] [psam] WITH (NOLOCK)
	            WHERE [psam].[AllowFiltering] = 1
	            AND [psam].[ProductId] IN (' + @sql + ')'

        EXEC sp_executesql @sql_filterableSpecs

		--build comma separated list of filterable identifiers
		SELECT @FilterableSpecificationAttributeOptionIds = COALESCE(@FilterableSpecificationAttributeOptionIds + ',' , '') + CAST(SpecificationAttributeOptionId as nvarchar(4000))
		FROM #FilterableSpecs

		DROP TABLE #FilterableSpecs
 	END

	--filter by specification attribution options
	SET @FilteredSpecs = isnull(@FilteredSpecs, '')	
	CREATE TABLE #FilteredSpecs
	(
		SpecificationAttributeOptionId int not null
	)
	INSERT INTO #FilteredSpecs (SpecificationAttributeOptionId)
	SELECT CAST(data as int) FROM [nop_splitstring_to_table](@FilteredSpecs, ',') 

    CREATE TABLE #FilteredSpecsWithAttributes
	(
        SpecificationAttributeId int not null,
		SpecificationAttributeOptionId int not null
	)
	INSERT INTO #FilteredSpecsWithAttributes (SpecificationAttributeId, SpecificationAttributeOptionId)
	SELECT sao.SpecificationAttributeId, fs.SpecificationAttributeOptionId
    FROM #FilteredSpecs fs INNER JOIN SpecificationAttributeOption sao ON sao.Id = fs.SpecificationAttributeOptionId
    ORDER BY sao.SpecificationAttributeId 

    DECLARE @SpecAttributesCount int	
	SET @SpecAttributesCount = (SELECT COUNT(1) FROM #FilteredSpecsWithAttributes)
	IF @SpecAttributesCount > 0
	BEGIN
		--do it for each specified specification option
		DECLARE @SpecificationAttributeOptionId int
        DECLARE @SpecificationAttributeId int
        DECLARE @LastSpecificationAttributeId int
        SET @LastSpecificationAttributeId = 0
		DECLARE cur_SpecificationAttributeOption CURSOR FOR
		SELECT SpecificationAttributeId, SpecificationAttributeOptionId
		FROM #FilteredSpecsWithAttributes

		OPEN cur_SpecificationAttributeOption
        FOREACH:
            FETCH NEXT FROM cur_SpecificationAttributeOption INTO @SpecificationAttributeId, @SpecificationAttributeOptionId
            IF (@LastSpecificationAttributeId <> 0 AND @SpecificationAttributeId <> @LastSpecificationAttributeId OR @@FETCH_STATUS <> 0) 
			    SET @sql = @sql + '
        AND p.Id in (select psam.ProductId from [Product_SpecificationAttribute_Mapping] psam with (NOLOCK) where psam.AllowFiltering = 1 and psam.SpecificationAttributeOptionId IN (SELECT SpecificationAttributeOptionId FROM #FilteredSpecsWithAttributes WHERE SpecificationAttributeId = ' + CAST(@LastSpecificationAttributeId AS nvarchar(max)) + '))'
            SET @LastSpecificationAttributeId = @SpecificationAttributeId
		IF @@FETCH_STATUS = 0 GOTO FOREACH
		CLOSE cur_SpecificationAttributeOption
		DEALLOCATE cur_SpecificationAttributeOption
	END

	--sorting
	SET @sql_orderby = ''	
	IF @OrderBy = 5 /* Name: A to Z */
		SET @sql_orderby = ' p.[Name] ASC'
	ELSE IF @OrderBy = 6 /* Name: Z to A */
		SET @sql_orderby = ' p.[Name] DESC'
	ELSE IF @OrderBy = 10 /* Price: Low to High */
		SET @sql_orderby = ' p.[Price] ASC'
	ELSE IF @OrderBy = 11 /* Price: High to Low */
		SET @sql_orderby = ' p.[Price] DESC'
	ELSE IF @OrderBy = 15 /* creation date */
		SET @sql_orderby = ' p.[CreatedOnUtc] DESC'
	ELSE /* default sorting, 0 (position) */
	BEGIN
		--category position (display order)
		IF @CategoryIdsCount > 0 SET @sql_orderby = ' pcm.DisplayOrder ASC'
		
		--manufacturer position (display order)
		IF @ManufacturerId > 0
		BEGIN
			IF LEN(@sql_orderby) > 0 SET @sql_orderby = @sql_orderby + ', '
			SET @sql_orderby = @sql_orderby + ' pmm.DisplayOrder ASC'
		END
		
		--name
		IF LEN(@sql_orderby) > 0 SET @sql_orderby = @sql_orderby + ', '
		SET @sql_orderby = @sql_orderby + ' p.[Name] ASC'
	END
	
	SET @sql = @sql + '
	ORDER BY' + @sql_orderby
	
    SET @sql = '
    INSERT INTO #DisplayOrderTmp ([ProductId])' + @sql

	--PRINT (@sql)
	EXEC sp_executesql @sql

	DROP TABLE #FilteredCategoryIds
	DROP TABLE #FilteredSpecs
    DROP TABLE #FilteredSpecsWithAttributes
	DROP TABLE #FilteredCustomerRoleIds
	DROP TABLE #KeywordProducts

	CREATE TABLE #PageIndex 
	(
		[IndexId] int IDENTITY (1, 1) NOT NULL,
		[ProductId] int NOT NULL
	)
	INSERT INTO #PageIndex ([ProductId])
	SELECT ProductId
	FROM #DisplayOrderTmp
	GROUP BY ProductId
	ORDER BY min([Id])

	--total records
	SET @TotalRecords = @@rowcount
	
	DROP TABLE #DisplayOrderTmp

	--return products
	SELECT TOP (@RowsToReturn)
		p.*
	FROM
		#PageIndex [pi]
		INNER JOIN Product p with (NOLOCK) on p.Id = [pi].[ProductId]
	WHERE
		[pi].IndexId > @PageLowerBound AND 
		[pi].IndexId < @PageUpperBound
	ORDER BY
		[pi].IndexId
	
	DROP TABLE #PageIndex
END


GO
/****** Object:  StoredProcedure [dbo].[ProductTagCountLoadAll]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductTagCountLoadAll]
(
	@StoreId int,
	@AllowedCustomerRoleIds	nvarchar(MAX) = null	--a list of customer role IDs (comma-separated list) for which a product should be shown (if a subject to ACL)
)
AS
BEGIN
	SET NOCOUNT ON
		
	--filter by customer role IDs (access control list)
	SET @AllowedCustomerRoleIds = isnull(@AllowedCustomerRoleIds, '')	
	CREATE TABLE #FilteredCustomerRoleIds
	(
		CustomerRoleId int not null
	)
		
	INSERT INTO #FilteredCustomerRoleIds (CustomerRoleId)
	SELECT CAST(data as int) FROM [nop_splitstring_to_table](@AllowedCustomerRoleIds, ',')
	DECLARE @FilteredCustomerRoleIdsCount int	
	SET @FilteredCustomerRoleIdsCount = (SELECT COUNT(1) FROM #FilteredCustomerRoleIds)
	
	SELECT pt.Id as [ProductTagId], COUNT(p.Id) as [ProductCount]
	FROM ProductTag pt with (NOLOCK)
	LEFT JOIN Product_ProductTag_Mapping pptm with (NOLOCK) ON pt.[Id] = pptm.[ProductTag_Id]
	LEFT JOIN Product p with (NOLOCK) ON pptm.[Product_Id] = p.[Id]
	WHERE
		p.[Deleted] = 0
		AND p.Published = 1
		AND (@StoreId = 0 or (p.LimitedToStores = 0 OR EXISTS (
			SELECT 1 FROM [StoreMapping] sm with (NOLOCK)
			WHERE [sm].EntityId = p.Id AND [sm].EntityName = 'Product' and [sm].StoreId=@StoreId
			)))
		AND (@FilteredCustomerRoleIdsCount = 0 or (p.SubjectToAcl = 0 OR EXISTS (
			SELECT 1 FROM #FilteredCustomerRoleIds [fcr]
			WHERE
				[fcr].CustomerRoleId IN (
					SELECT [acl].CustomerRoleId
					FROM [AclRecord] acl with (NOLOCK)
					WHERE [acl].EntityId = p.Id AND [acl].EntityName = 'Product'
				))
			))
	GROUP BY pt.Id
	ORDER BY pt.Id
END


GO
/****** Object:  StoredProcedure [dbo].[UpdateShoppingCartByCartId]    Script Date: 3/30/2020 12:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateShoppingCartByCartId] 
	@Quantity int = 0,
	@CartItemId int = 0,
	@AttributeXml nvarchar(MAX) = '',
	@CurrentTime datetime = ''
AS
BEGIN	

	if(@AttributeXml = '')
	BEGIN
	SELECT @AttributeXml = dbo.ShoppingCartItem.AttributesXml FROM dbo.ShoppingCartItem 
	WHERE dbo.ShoppingCartItem.Id = @CartItemId 
	END
	UPDATE dbo.ShoppingCartItem SET Quantity = @Quantity,
	AttributesXml = @AttributeXml,
	UpdatedOnUtc = @CurrentTime 
	WHERE dbo.ShoppingCartItem.Id = @CartItemId
	Return @CartItemId
END


GO
USE [master]
GO
ALTER DATABASE [myventures_bluebell] SET  READ_WRITE 
GO
