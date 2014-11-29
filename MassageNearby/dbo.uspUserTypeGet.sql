USE [MassageNearby]
GO

/****** Object:  StoredProcedure [dbo].[uspUserTypeGet]    Script Date: 11/22/2014 1:36:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Mike Samuels
-- Create date: 11/22/2014
-- Description:	Gets values from UserType table
-- =============================================
/*
	exec uspUserTypeGet
*/
ALTER PROCEDURE [dbo].[uspUserTypeGet] 

AS
BEGIN
	SET NOCOUNT ON;
	Select * from UserType
END

GO

