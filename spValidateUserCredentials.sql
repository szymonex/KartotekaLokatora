USE [Lokator]
GO

/****** Object:  StoredProcedure [dbo].[spValidateUserCredentials]    Script Date: 2017-09-04 20:36:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spValidateUserCredentials] 
@Login nvarchar (20),
@Password nvarchar (20)
as
Begin
	IF EXISTS (select * from UserCredentials where Login = @Login AND Password = @Password)
	SELECT 1
	ELSE
	SELECT 0
End
GO

