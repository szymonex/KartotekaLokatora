USE [Lokator]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 CREATE PROCEDURE [dbo].[spGetQuaterlyKosztCWFromOdczytWody]   
 as    
 Begin    
  Select SUM(KosztCW) from OdczytWody where DATEPART(QUARTER, DataOdczytu) = DATEPART(QUARTER, GetDate()) AND YEAR(DataOdczytu) = YEAR(GetDate())    
 End
GO

