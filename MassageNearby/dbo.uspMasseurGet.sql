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
EXEC uspMasseurGet @Name='m', @url='10.10.10.332'
EXEC uspMasseurGet @MasseurId=41


delete from [masseur]
delete from [client]
delete from [user]

*/
-- =============================================
ALTER PROCEDURE uspMasseurGet 
	-- Add the parameters for the stored procedure here
	@name varchar(100) = null,
	@masseurId int = null,
	@password varchar(50)=null,
	@email varchar(255) = null,
	@isDoingLogin bit = null,
	@port int=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @userid int
	if @name is not null begin
		if @isDoingLogin is null or @isDoingLogin!=1 begin
			if exists (select * from [User] where name=@name) begin
					if @Password is not null begin
						update [User] set [password]=isnull(@password,[password]), email=isnull(@email,email) where [name]=@name
					end
			end else begin
				insert into [user]
				select @name,null,@password,@email,null
				select @userid=scope_identity()
				insert into masseur (UserId)
				select @userid
			end
		end
		SELECT u.UserId,m.MasseurId, case when u.Port is not null and u.URL is not null then 1 else 0 end,[Name],URL,MainPictureURL, CertifiedPictureURL, m.Longitude, m.Latitude,
				m.Birthdate, m.Height, m.Ethnicity, m.[Services], m.Bio, m.SubscriptionEndDate,
				m.PrivatePicture1URL,m.PrivatePicture2URL,m.PrivatePicture3URL,m.PrivatePicture4URL,m.IsCertified, m.CertificationNumber, u.[Password], u.email,
				u.Port,m.IsOnline
		FROM Masseur m Inner Join [User] u ON u.UserId=m.UserId
		where ([Name]=@name)

	end else begin
		if @masseurid is not null begin
			update u
			set u.Port=null, u.URL=null
			from [User] u inner join Masseur m on m.Userid=u.UserId
			where masseurid=@masseurid
		end
		SELECT u.UserId,m.MasseurId, case when u.Port is not null and u.URL is not null then 1 else 0 end,[Name],URL,MainPictureURL, CertifiedPictureURL, Longitude, Latitude,
				m.Birthdate, m.Height, m.Ethnicity, m.[Services], m.Bio, m.SubscriptionEndDate,
				m.PrivatePicture1URL,m.PrivatePicture2URL,m.PrivatePicture3URL,m.PrivatePicture4URL,m.IsCertified, m.CertificationNumber, u.[Password], u.email,
				u.Port,m.IsOnline
		FROM Masseur m Inner Join [User] u ON u.UserId=m.UserId
		where (@name is null or [Name]=@name)
	end 



END
GO
