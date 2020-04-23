USE [myventures_bluebell]
GO
/****** Object:  View [dbo].[PictureJsonView]    Script Date: 3/3/2020 10:10:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PictureJsonView] AS
SELECT Id,
'{ "Id": ' + CAST(P.Id AS nvarchar(10)) + ', "MimeType":"' + ISNULL(P.MimeType,'') + '", "SeoFilename":"' + ISNULL(P.SeoFilename,'')  + '" }' Json
	
FROM dbo.Picture P

GO
/****** Object:  View [dbo].[ProductsView]    Script Date: 3/3/2020 10:10:02 AM ******/
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
/****** Object:  View [dbo].[TopMenuCategories]    Script Date: 3/3/2020 10:10:02 AM ******/
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
/****** Object:  View [dbo].[TopMenuTopics]    Script Date: 3/3/2020 10:10:02 AM ******/
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
/****** Object:  View [dbo].[TopMenu]    Script Date: 3/3/2020 10:10:02 AM ******/
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
/****** Object:  View [dbo].[FooterColumn1]    Script Date: 3/3/2020 10:10:02 AM ******/
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
/****** Object:  View [dbo].[FooterColumn2]    Script Date: 3/3/2020 10:10:02 AM ******/
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
/****** Object:  View [dbo].[FooterColumn3]    Script Date: 3/3/2020 10:10:02 AM ******/
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
/****** Object:  View [dbo].[FooterColumns]    Script Date: 3/3/2020 10:10:02 AM ******/
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
/****** Object:  View [dbo].[LayoutItems]    Script Date: 3/3/2020 10:10:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[LayoutItems] AS
SELECT *
FROM
dbo.TopMenu,dbo.FooterColumns


GO
/****** Object:  View [dbo].[CategoryView]    Script Date: 3/3/2020 10:10:02 AM ******/
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
/****** Object:  StoredProcedure [dbo].[GetProductByIdOrGuid]    Script Date: 3/3/2020 10:10:02 AM ******/
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
