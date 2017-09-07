USE [Lokator]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spGetYearlySumCOFromZaliczki]  
as  
Begin  
 Select SUM(CO) from ZaliczkiCO  
End
GO

