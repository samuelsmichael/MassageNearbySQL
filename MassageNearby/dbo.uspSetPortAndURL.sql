SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		MikeSamuels
-- Create date: 01/21/2015
-- Description:	
-- =============================================
alter PROCEDURE uspSetPortAndURL 
	-- Add the parameters for the stored procedure here
	@Port int=null,
	@URL varchar(256)=null,
	@UserId int,
	@IsOnline bit = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Update [User] set URL=isnull(@Url,URL), Port=isnull(@Port,Port) where UserId=@UserId;
	update m
		set m.IsOnline=isnull(@IsOnline,IsOnline)
		from [User] u inner join Masseur m on m.userid=u.userid
		where u.userid=@UserId

END
GO
