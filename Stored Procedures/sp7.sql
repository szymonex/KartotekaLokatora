USE [Lokator]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spInsertDataIntoOdczytEnergii]
@StanObecnyT1 int,
@StanObecnyT2 int
as
Begin 
	DECLARE @StanPoprzedniT1 int
	DECLARE @StanPoprzedniT2 int
	DECLARE @BiezaceZuzycieT1 int
	DECLARE @BiezaceZuzycieT2 int
	SET @StanPoprzedniT1 = dbo.fnOdczytajPoprzedniStanLicznikaT1()
	SET @StanPoprzedniT2 = dbo.fnOdczytajPoprzedniStanLicznikaT2()
	SET @BiezaceZuzycieT1 = @StanObecnyT1 - @StanPoprzedniT1
	SET @BiezaceZuzycieT2 = @StanObecnyT2 - @StanPoprzedniT2

	Insert into OdczytEnergii (LicznikT1, LicznikT2, Koszt, ZuzycieT1, ZuzycieT2, ZuzycieT1T2) values (@StanObecnyT1, @StanObecnyT2, 
	FORMAT((@BiezaceZuzycieT1*0.2759 + @BiezaceZuzycieT2*0.072 + @BiezaceZuzycieT1*0.2947 + @BiezaceZuzycieT2*0.1917 + (@BiezaceZuzycieT1 + @BiezaceZuzycieT2)*0.0037 + 7.65 + 0.58 + 1.90)*1.23, 'N2'),
	@BiezaceZuzycieT1, @BiezaceZuzycieT2, @BiezaceZuzycieT1+@BiezaceZuzycieT2)

End
GO

