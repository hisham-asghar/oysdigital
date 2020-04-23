USE [Nop]
GO

/****** Object:  View [dbo].[AddressDetailView]    Script Date: 3/17/2020 12:40:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE view [dbo].[AddressDetailView]
as
select ad.*,ct.Name as CountryName,ct.ThreeLetterIsoCode as CountryCode,st.Name as StateProvinceName  from dbo.[Address] ad  LEFT JOIN   dbo.[StateProvince] st ON ad.StateProvinceId = st.Id  LEFT JOIN  dbo.[Country]ct
ON ad.CountryId = ct.Id











GO

