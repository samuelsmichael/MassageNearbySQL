SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		MikeSamuels
-- Create date: 11/29/2014
-- Description:	Get User Info
-- =============================================
CREATE PROCEDURE uspUserGet 
	-- Add the parameters for the stored procedure here
	@name varchar(100) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT * FROM [User] where (@name is null or [Name]=@name)

END
GO
