USE [Nop]
GO

/****** Object:  View [dbo].[CustomerDetailView]    Script Date: 3/17/2020 12:40:19 PM ******/
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
            (SELECT a.* 
			FROM AddressDetailView a,CustomerAddresses ca
			where  a.Id = ca.Address_Id and 
			ca.Customer_Id = cust.Id
            FOR XML PATH('Address'), ROOT('Addresses'), TYPE ) as AddressesXml,
			(SELECT * FROM dbo.OrderDetailView od WHERE od.CustomerId = cust.Id
			FOR XML PATH('Order'),Root('Orders'),Type) as OrdersXml
			
			
			          	  		
from  dbo.Customer cust













GO

