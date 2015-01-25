SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		MikeSamuels
-- Create date: 01/21/2015
-- Description:	Get Masseur Info
/*
	uspSetAllPortsAndURLs @URL=null, @Port=null
*/
-- =============================================
alter PROCEDURE uspSetAllPortsAndURLs 
	-- Add the parameters for the stored procedure here
	@Port int,
	@URL varchar(256)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Update [User] set URL=@Url, Port=@Port
	Update [Masseur] set IsOnline=0

END
GO
