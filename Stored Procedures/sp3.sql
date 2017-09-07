USE [Lokator]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

  CREATE PROCEDURE [dbo].[spGetQuaterlySumCWFromZaliczki]  
 as  
 Begin  
  Select SUM(CW) from ZaliczkiZWCW where DATEPART(QUARTER, Tytułem) = DATEPART(QUARTER, GetDate()) AND YEAR(Tytułem) = YEAR(GetDate())  
 End
GO

