SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		MikeSamuels
-- Create date: 11/29/2014
-- Description:	Set Masseur Info
/*
exec uspMasseurSet @UserId=64, @MainPictureURL='himom'
exec uspMasserSet @UserId=64, @Latitude=39.7144534, @Longitude=105.0592715




delete from [masseur]
delete from [user]

*/
-- =============================================
alter PROCEDURE uspMasseurSet 
	@UserId int,
	@Name varchar(100) = null,
	@MainPictureURL varchar(256)=null,
	@CertifiedPictureURL varchar(256)=null,
	@Longitude decimal(18,12)=null,
	@Latitude decimal(18,12)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if exists (select * from Masseur m INNER JOIN [User] u on m.UserId=u.UserId where u.UserID=@UserId) begin
		update u
		set Name=isnull(@Name,Name)
		from [User] u inner join Masseur m on m.UserId=u.UserId
		where u.UserId=@UserId
		update m
		set 
			MainPictureURL=isnull(@MainPictureURL,MainPictureURL),
			CertifiedPictureURL=isnull(@CertifiedPictureURL,CertifiedPictureURL),
			Latitude=isnull(@Latitude,Latitude),
			Longitude=isnull(@Longitude,Longitude)
		
		from [User] u inner join Masseur m on m.UserId=u.UserId
		where m.UserId=@UserId

		SELECT u.UserId,m.MasseurId,IsOnline,[Name],URL,MainPictureURL, CertifiedPictureURL,Latitude,Longitude
		FROM Masseur m Inner Join [User] u ON u.UserId=m.UserId
		where m.UserId=@UserId
	end

END
GO
