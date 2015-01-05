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
	@Latitude decimal(18,12)=null,
	@Birthdate datetime=null,
	@Height varchar(50)=null,
	@Ethnicity varchar(50)=null,
	@Services nvarchar(4000)=null,
	@Bio nvarchar(4000)=null,
	@SubscriptionEndDate datetime=null,
		@PrivatePicture1URL varchar(256)=null,
		@PrivatePicture2URL varchar(256)=null,
		@PrivatePicture3URL varchar(256)=null,
		@PrivatePicture4URL varchar(256)=null,
	@Password varchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if exists (select * from Masseur m INNER JOIN [User] u on m.UserId=u.UserId where u.UserID=@UserId) begin
		update u
		set Name=isnull(@Name,Name),[Password]=isnull(@Password,[Password])
		from [User] u inner join Masseur m on m.UserId=u.UserId
		where u.UserId=@UserId
		update m
		set 
			MainPictureURL=case when @MainPictureURL='^' then null else  isnull(@MainPictureURL,MainPictureURL) end,
			CertifiedPictureURL=case when @CertifiedPictureURL='^' then null else isnull(@CertifiedPictureURL,CertifiedPictureURL) end,
			Latitude=isnull(@Latitude,Latitude),
			Longitude=isnull(@Longitude,Longitude),
			Birthdate=isnull(@Birthdate,Birthdate),
			Height=isnull(@Height,Height),
			Ethnicity=isnull(@Ethnicity,Ethnicity),
			[Services]=Isnull(@Services,[Services]),
			Bio=Isnull(@Bio,Bio),
			SubscriptionEndDate=Isnull(@SubscriptionEndDate,SubscriptionEndDate),
			PrivatePicture1URL=case when @PrivatePicture1URL='^' then null else isnull(@PrivatePicture1URL,PrivatePicture1URL) end,
			PrivatePicture2URL=case when @PrivatePicture2URL='^' then null else isnull(@PrivatePicture2URL,PrivatePicture2URL) end,
			PrivatePicture3URL=case when @PrivatePicture3URL='^' then null else isnull(@PrivatePicture3URL,PrivatePicture3URL) end,
			PrivatePicture4URL=case when @PrivatePicture4URL='^' then null else isnull(@PrivatePicture4URL,PrivatePicture4URL) end		
		from [User] u inner join Masseur m on m.UserId=u.UserId
		where m.UserId=@UserId

		SELECT u.UserId,m.MasseurId,IsOnline,[Name],URL,MainPictureURL, CertifiedPictureURL,Latitude,Longitude,
				m.Birthdate, m.Height, m.Ethnicity, m.[Services], m.Bio, m.SubscriptionEndDate,
				m.PrivatePicture1URL,m.PrivatePicture2URL,m.PrivatePicture3URL,m.PrivatePicture4URL,m.IsCertified, m.CertificationNumber,u.[password]
		FROM Masseur m Inner Join [User] u ON u.UserId=m.UserId
		where m.UserId=@UserId
	end

END
GO
