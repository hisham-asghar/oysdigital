
GO

/****** Object:  StoredProcedure [dbo].[DeleteOrder]    Script Date: 3/9/2020 7:01:04 PM ******/
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


