USE [myventures_bluebell]
GO
/****** Object:  UserDefinedFunction [dbo].[nop_splitstring_to_table]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  View [dbo].[PictureJsonView]    Script Date: 3/11/2020 2:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PictureJsonView] AS
SELECT Id,
'{ "Id": ' + CAST(P.Id AS nvarchar(10)) + ', "MimeType":"' + ISNULL(P.MimeType,'') + '", "SeoFilename":"' + ISNULL(P.SeoFilename,'')  + '" }' Json
	
FROM dbo.Picture P

GO
/****** Object:  View [dbo].[ProductsView]    Script Date: 3/11/2020 2:12:43 PM ******/
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
	  ,P.ProductTypeId
	  
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
/****** Object:  View [dbo].[AddressesView]    Script Date: 3/11/2020 2:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AddressesView] AS
SELECT Addresses.*,CustomerAddresses.Customer_Id CustomerId, Country.Name CountryName, Country.TwoLetterIsoCode CountryCode, StateProvince.Name StateProvinceName 
FROM dbo.Address Addresses INNER JOIN dbo.CustomerAddresses CustomerAddresses
	ON Addresses.Id = CustomerAddresses.Address_Id
	LEFT OUTER JOIN dbo.Country Country ON Addresses.CountryId = Country.Id
	LEFT OUTER JOIN dbo.StateProvince StateProvince ON Addresses.StateProvinceId = StateProvince.Id
	
GO
/****** Object:  View [dbo].[OrderDetailView]    Script Date: 3/11/2020 2:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW  [dbo].[OrderDetailView]
AS
SELECT ord.*,
(SELECT * FROM dbo.[AddressesView]
 WHERE dbo.[AddressesView].Id = ord.BillingAddressId  
 FOR XML PATH('Address') ) AS BillingAddressXml,

(SELECT * FROM dbo.[AddressesView] 
WHERE dbo.[AddressesView].Id = ord.ShippingAddressId  
FOR XML PATH('Address') ) AS ShippingAddressXml,

(SELECT o.*
FROM OrderItem o,Product p
WHERE o.OrderId = ord.Id
and o.ProductId = p.Id
FOR XML PATH('OrderItem'),Root ('OrderItems'),Type ) as OrderItems
		
FROM dbo.[Order] ord, dbo.Customer Customer
WHERE Customer.Id = ord.CustomerId




GO
/****** Object:  View [dbo].[TopMenuCategories]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  View [dbo].[TopMenuTopics]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  View [dbo].[TopMenu]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  View [dbo].[FooterColumn1]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  View [dbo].[FooterColumn2]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  View [dbo].[FooterColumn3]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  View [dbo].[FooterColumns]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  View [dbo].[LayoutItems]    Script Date: 3/11/2020 2:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[LayoutItems] AS
SELECT *
FROM
dbo.TopMenu,dbo.FooterColumns


GO
/****** Object:  View [dbo].[CategoryView]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  View [dbo].[CustomerDetailView]    Script Date: 3/11/2020 2:12:43 PM ******/
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
            (SELECT * 
			FROM Address a,CustomerAddresses ca
			where  a.Id = ca.Address_Id and 
			ca.Customer_Id = cust.Id
            FOR XML PATH('Address'), ROOT('Addresses'), TYPE ) as AddressesXml
			
			
			          	  		
from  dbo.Customer cust










GO
/****** Object:  View [dbo].[ShoppingCartView]    Script Date: 3/11/2020 2:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ShoppingCartView] AS
SELECT CartItem.*,Prices.Price PricePerUnit, Prices.Price * CartItem.Quantity TotalPrice FROM dbo.ShoppingCartItem CartItem
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
) Prices

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
/****** Object:  StoredProcedure [dbo].[CategoryLoadAllPaged]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CreateCustomerFromIdentityUser]    Script Date: 3/11/2020 2:12:43 PM ******/
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
	@phoneNumber nvarchar(450),
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
           (@onCreated,0,@lastName,'LastName','Customer',@customerId),
           (@onCreated,0,@phoneNumber,'PhoneNumber','Customer',@customerId)



END


GO
/****** Object:  StoredProcedure [dbo].[DeleteGuests]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  StoredProcedure [dbo].[DeleteOrder]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  StoredProcedure [dbo].[FullText_Disable]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  StoredProcedure [dbo].[FullText_Enable]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  StoredProcedure [dbo].[FullText_IsSupported]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetProductByIdOrGuid]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  StoredProcedure [dbo].[LanguagePackImport]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ProductLoadAllPaged]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ProductTagCountLoadAll]    Script Date: 3/11/2020 2:12:43 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateCustomerShoppingCartStatus]    Script Date: 3/11/2020 2:12:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hisham Asghar
-- Create date: 03/05/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[UpdateCustomerShoppingCartStatus] 
	-- Add the parameters for the stored procedure here
	@customerId int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @count int;
	DECLARE @hasItems bit;
	SELECT @count = COUNT(*) FROM ShoppingCartItem
	WHERE CustomerId = 20
	SELECT @hasItems = (CASE WHEN @count > 0 THEN 1 ELSE 0 END);
	UPDATE dbo.Customer
	SET HasShoppingCartItems = @hasItems
	WHERE Id = @customerId; 
END

GO
