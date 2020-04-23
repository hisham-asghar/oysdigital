USE [Nop]
GO

/****** Object:  StoredProcedure [dbo].[CreateUpdateShoppingCart]    Script Date: 3/19/2020 6:14:10 PM ******/
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



GO

