USE [Lokator]
GO

/****** Object:  StoredProcedure [dbo].[spValidateUserCredentials]    Script Date: 2017-08-31 21:42:04 ******/
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

