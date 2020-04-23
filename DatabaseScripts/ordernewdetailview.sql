USE [Nop]
GO

/****** Object:  View [dbo].[OrderDetailView]    Script Date: 3/17/2020 12:40:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE View  [dbo].[OrderDetailView]
as
select ord.*,
(select * from dbo.[AddressDetailView] WHERE dbo.[AddressDetailView].Id = ord.BillingAddressId  FOR XML PATH('Address'),Type ) as BillingAddressXml,
(select * from dbo.[AddressDetailView] WHERE dbo.[AddressDetailView].Id = ord.ShippingAddressId  FOR XML PATH('Address'),Type ) as ShippingAddressXml,

            (SELECT o.*,p.Name as ProductName
            FROM OrderItem o,Product p
			where o.OrderId = ord.Id
			and o.ProductId = p.Id
            FOR XML PATH('OrderItem'),Root ('OrderItems'),Type ) as OrderItemsXml
			
            

from dbo.[Order] ord, dbo.Customer cust 
where 
cust.Id = ord.CustomerId







GO

