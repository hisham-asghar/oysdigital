USE [Nop]
GO

/****** Object:  StoredProcedure [dbo].[DeleteAddress]    Script Date: 3/11/2020 5:18:11 PM ******/
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


