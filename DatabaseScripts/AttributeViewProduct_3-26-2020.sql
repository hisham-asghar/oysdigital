USE [myventures_bluebell]
GO

/****** Object:  View [dbo].[ProductAttributeView]    Script Date: 3/26/2020 8:17:01 PM ******/
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

