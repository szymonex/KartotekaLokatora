USE [Lokator]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spGetUsersNameUponLogin]
@Login nvarchar(20)
as
Begin
	select CONCAT(FName,' ', LName) as FullName from UserCredentials where Login = @Login
End
GO

