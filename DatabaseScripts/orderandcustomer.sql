USE [Nop]
GO
/****** Object:  View [dbo].[CustomerDetailView]    Script Date: 3/9/2020 2:03:11 PM ******/
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
            (SELECT * 
			FROM Address a,CustomerAddresses ca
			where  a.Id = ca.Address_Id and 
			ca.Customer_Id = cust.Id
            FOR XML PATH('Address'), ROOT('Addresses'), TYPE ) as AddressesXml
			
			
			          	  		
from  dbo.Customer cust









GO
/****** Object:  View [dbo].[OrderDetailView]    Script Date: 3/9/2020 2:03:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE View  [dbo].[OrderDetailView]
as
select ord.*,
(select * from dbo.[Address] WHERE dbo.[Address].Id = ord.BillingAddressId  FOR XML PATH('Address') ) as BillingAddressXml,
(select * from dbo.[Address] WHERE dbo.[Address].Id = ord.ShippingAddressId  FOR XML PATH('Address') ) as ShippingAddressXml,

            (SELECT o.*
            FROM OrderItem o,Product p
			where o.OrderId = ord.Id
			and o.ProductId = p.Id
            FOR XML PATH('OrderItem'),Root ('OrderItems'),Type ) as OrderItems
			
            

from dbo.[Order] ord, dbo.Customer cust , dbo.AspNetUsers  asp
where 
cust.Id = ord.CustomerId


GO
