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
	@UserId int out,
	@Name varchar(100) = null,
	@URL varchar(100) = null,
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
	@Password varchar(50)=null,
	@Email varchar(255)=null,
	@CertificationNumber int = null,
	@Port int = null,
	@IsOnline bit = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if @UserId!=0 and exists (select * from Masseur m INNER JOIN [User] u on m.UserId=u.UserId where u.UserID=@UserId) begin
		update u
		set Port=isnull(@Port,Port),Name=isnull(@Name,Name),[Password]=isnull(@Password,[Password]), email=isnull(@email,email), url=isnull(@url,url)
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
			PrivatePicture4URL=case when @PrivatePicture4URL='^' then null else isnull(@PrivatePicture4URL,PrivatePicture4URL) end,
			CertificationNumber=isnull(@CertificationNumber,CertificationNumber),
			IsOnline=isnull(@IsOnline,IsOnline)
		from [User] u inner join Masseur m on m.UserId=u.UserId
		where m.UserId=@UserId

	end else begin 
		insert into [user]
		select @name,@Url,@password,@email,@Port
		select @userid=scope_identity()
		insert into masseur (UserId,MainPictureURL,CertifiedPictureURL,Latitude,Longitude,Birthdate,Height,Ethnicity,
							[Services],Bio,SubscriptionEndDate,PrivatePicture1URL,
							PrivatePicture2URL,PrivatePicture3URL,PrivatePicture4URL,IsCertified,CertificationNumber, IsOnline)
		select @userid,
				case when @MainPictureURL='^' then null else  isnull(@MainPictureURL,@MainPictureURL) end,case when @CertifiedPictureURL='^' then null else isnull(@CertifiedPictureURL,@CertifiedPictureURL) end,@Latitude,@Longitude,@Birthdate,@Height,@Ethnicity,
				@Services,@Bio,@SubscriptionEndDate,case when @PrivatePicture1URL='^' then null else isnull(@PrivatePicture1URL,@PrivatePicture1URL) end,
				case when @PrivatePicture2URL='^' then null else isnull(@PrivatePicture2URL,@PrivatePicture2URL) end,case when @PrivatePicture3URL='^' then null else isnull(@PrivatePicture3URL,@PrivatePicture3URL) end,case when @PrivatePicture4URL='^' then null else isnull(@PrivatePicture4URL,@PrivatePicture4URL) end,
				0,@CertificationNumber,isNull(@IsOnline,0)
	end
	SELECT u.UserId,m.MasseurId, case when u.Port is not null and u.URL is not null then 1 else 0 end,[Name],URL,MainPictureURL, CertifiedPictureURL,Latitude,Longitude,
			m.Birthdate, m.Height, m.Ethnicity, m.[Services], m.Bio, m.SubscriptionEndDate,
			m.PrivatePicture1URL,m.PrivatePicture2URL,m.PrivatePicture3URL,m.PrivatePicture4URL,m.IsCertified, m.CertificationNumber,u.[password],u.email,
			u.Port,m.IsOnline
	FROM Masseur m Inner Join [User] u ON u.UserId=m.UserId
	where m.UserId=@UserId

END
GO
