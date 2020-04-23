-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hisham Asghar
-- Create date: 03/04/2020
-- Description:	
-- =============================================
CREATE PROCEDURE CreateCustomerFromIdentityUser
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
