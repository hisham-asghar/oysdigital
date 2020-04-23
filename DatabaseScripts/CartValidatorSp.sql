USE [Nop]
GO

/****** Object:  StoredProcedure [dbo].[CartValidator]    Script Date: 3/20/2020 5:20:15 PM ******/
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

