SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		MikeSamuels
-- Create date: 1/14/2015
-- Description:	Set Client Info
/*
exec uspClientSet @UserId=64, @MainPictureURL='himom'
exec uspClientSet @UserId=64, @Latitude=39.7144534, @Longitude=105.0592715




delete from [masseur]
delete from [user]
delete from [client]

*/
-- =============================================
alter PROCEDURE uspClientSet 
	@UserId int out,
	@Name varchar(100) = null,
	@URL varchar(100) = null,
	@Password varchar(50)=null,
	@Email varchar(255)=null,
	@Port int = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if @UserId!=0 and exists (select * from Client m INNER JOIN [User] u on m.UserId=u.UserId where u.UserID=@UserId) begin
		update u
		set Port=isnull(@Port,port), Name=isnull(@Name,Name),[Password]=isnull(@Password,[Password]), email=isnull(@email,email), url=isnull(@url,url)
		from [User] u inner join Client m on m.UserId=u.UserId
		where u.UserId=@UserId


	end else begin 
		insert into [user]
		select @name,@Url,@password,@email,@port
		select @userid=scope_identity()
		insert into client (UserId)
		select @userId
	end
	SELECT u.UserId,c.ClientId,[Name],URL,[Password],Email,Port
	FROM Client c Inner Join [User] u ON u.UserId=c.UserId
	where c.UserId=@UserId

END
GO
