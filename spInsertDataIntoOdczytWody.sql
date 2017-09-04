USE [Lokator]
GO

/****** Object:  StoredProcedure [dbo].[spInsertDataIntoOdczytWody]    Script Date: 2017-09-04 20:35:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spInsertDataIntoOdczytWody]      
@StanObecnyZW int,      
@StanObecnyCW int      
as      
Begin     
 DECLARE @StanPoprzedniZW int    
 DECLARE @StanPoprzedniCW int    
 DECLARE @BiezaceZuzycieZW int    
 DECLARE @BiezaceZuzycieCW int    
 SET @StanPoprzedniZW = dbo.fnOdczytajPoprzedniStanLicznikaZW()    
 SET @StanPoprzedniCW = dbo.fnOdczytajPoprzedniStanLicznikaCW()    
 SET @BiezaceZuzycieZW = @StanObecnyZW - @StanPoprzedniZW    
 SET @BiezaceZuzycieCW = @StanObecnyCW - @StanPoprzedniCW    
 Insert into OdczytWody (ZW, CW, KosztZW, KosztCW, KosztZWCW, ZuzycieZW, ZuzycieCW) values (@StanObecnyZW, @StanObecnyCW, FORMAT(@BiezaceZuzycieZW*8.58 + @BiezaceZuzycieCW*8.58, 'N2'), FORMAT(@BiezaceZuzycieCW *27.41, 'N2'), FORMAT(@BiezaceZuzycieZW*8.58 + @BiezaceZuzycieCW*27.41 + @BiezaceZuzycieCW*8.58, 'N2'), @BiezaceZuzycieZW + @BiezaceZuzycieCW, @BiezaceZuzycieCW)      
End
GO

