USE [Nop]
GO

/****** Object:  StoredProcedure [dbo].[UpdateShoppingCartByCartId]    Script Date: 3/20/2020 5:19:49 PM ******/
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

