SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		MikeSamuels
-- Create date: 11/29/2014
-- Description:	Get Masseur Info
/*
EXEC uspMasseurGet
fe80::cc3a:61ff:fe02:d1ac%p2p0
EXEC uspMasseurGet @Name='Fred', @url='10.10.10.332'
EXEC uspMasseurGet @MasseurId=41


delete from [masseur]
delete from [client]
delete from [user]

*/
-- =============================================
ALTER PROCEDURE uspMasseurGet 
	-- Add the parameters for the stored procedure here
	@name varchar(100) = null,
	@url varchar(255) = null,
	@masseurId int = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @userid int
	if @name is not null begin
		if exists (select * from [User] where name=@name) begin
			if @url is not null begin
				update [User] set url=@url where [name]=@name
				update m
				set m.IsOnline = 1
				from [User] u inner join Masseur m on m.Userid=u.UserId
				where [name]=@name
			end
		end else begin
			insert into [user]
			select @name,@url
			select @userid=scope_identity()
			insert into masseur (UserId,IsOnline)
			select @userid,1
		end
		SELECT u.UserId,m.MasseurId,IsOnline,[Name],URL,MainPictureURL, CertifiedPictureURL, m.Longitude, m.Latitude
		FROM Masseur m Inner Join [User] u ON u.UserId=m.UserId
		where ([Name]=@name)

	end else begin
		if @masseurid is not null begin
			update m
			set m.IsOnline = 0
			from [User] u inner join Masseur m on m.Userid=u.UserId
			where masseurid=@masseurid
		end
		SELECT u.UserId,m.MasseurId,IsOnline,[Name],URL,MainPictureURL, CertifiedPictureURL, Longitude, Latitude
		FROM Masseur m Inner Join [User] u ON u.UserId=m.UserId
		where (@name is null or [Name]=@name)
	end 



END
GO
