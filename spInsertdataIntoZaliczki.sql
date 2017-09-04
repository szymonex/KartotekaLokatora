USE [Lokator]
GO

/****** Object:  StoredProcedure [dbo].[spInsertDataIntoZaliczki]    Script Date: 2017-09-04 20:36:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spInsertDataIntoZaliczki]
@ZW money,
@CW money,
@CO money
as
Begin 
	Insert into Zaliczki (ZW, CW, CO) values (FORMAT(@ZW, 'N2'), FORMAT(@CW, 'N2'), FORMAT(@CO, 'N2'))
End
GO

