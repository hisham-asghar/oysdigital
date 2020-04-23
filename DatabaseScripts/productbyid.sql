USE [myventures_bluebell]
GO

/****** Object:  StoredProcedure [dbo].[GetProductByIdOrGuid]    Script Date: 3/24/2020 7:18:10 PM ******/
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

