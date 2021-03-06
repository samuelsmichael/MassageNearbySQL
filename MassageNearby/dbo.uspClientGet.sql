SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		MikeSamuels
-- Create date: 11/29/2014
-- Description:	Get Client Info
/*
EXEC uspClientGet
fe80::cc3a:61ff:fe02:d1ac%p2p0
EXEC uspClientGet @Name='Fred', @url='10.10.10.332'
EXEC uspClientGet @ClientId=41

delete from [client]
delete from [masseur]
delete from [user]

*/
-- =============================================
alter PROCEDURE uspClientGet 
	@name varchar(100) = null,
	@url varchar(255) = null,
	@clientId int = null,
	@password varchar(50)=null,
	@email varchar(255)=null,
	@port int = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @userid int
	if @name is not null begin
		if exists (select * from [User] where name=@name) begin
			if @url is not null or @email is not null or @password is not null or @port is not null begin
				update [User] set port=isnull(@port,port), url=isnull(@url,url), email=isnull(@email,email), [Password]=isnull(@password,[password]) where [name]=@name
				update c
				/*gotta put something here*/ set c.UserId=u.UserId
				from [User] u inner join Client c on c.Userid=c.UserId
				where [name]=@name
			end
		end 

	end else begin
		if @clientid is not null begin
			update c
			/*gotta put something here*/ set c.UserId=u.Userid
			from [User] u inner join Client c on c.Userid=u.UserId
			where clientId=@clientid
		end
	end 
	SELECT u.UserId,c.ClientId,[Name],URL,[Password],Email,Port
	FROM Client c Inner Join [User] u ON u.UserId=c.UserId
	where (@name is null or [Name]=@name)

END
GO
