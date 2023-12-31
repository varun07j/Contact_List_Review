/****** Object:  Database [Contact_List]    Script Date: 11/14/2023 4:59:29 PM ******/
CREATE DATABASE [Contact_List]  (EDITION = 'GeneralPurpose', SERVICE_OBJECTIVE = 'GP_Gen5_2', MAXSIZE = 32 GB) WITH CATALOG_COLLATION = SQL_Latin1_General_CP1_CI_AS, LEDGER = OFF;
GO
ALTER DATABASE [Contact_List] SET COMPATIBILITY_LEVEL = 160
GO
ALTER DATABASE [Contact_List] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Contact_List] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Contact_List] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Contact_List] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Contact_List] SET ARITHABORT OFF 
GO
ALTER DATABASE [Contact_List] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Contact_List] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Contact_List] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Contact_List] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Contact_List] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Contact_List] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Contact_List] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Contact_List] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Contact_List] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [Contact_List] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Contact_List] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [Contact_List] SET  MULTI_USER 
GO
ALTER DATABASE [Contact_List] SET ENCRYPTION ON
GO
ALTER DATABASE [Contact_List] SET QUERY_STORE = ON
GO
ALTER DATABASE [Contact_List] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
/*** The scripts of database scoped configurations in Azure should be executed inside the target database connection. ***/
GO
-- ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 8;
GO
/****** Object:  Table [dbo].[ActivityLog]    Script Date: 11/14/2023 4:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityLog](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[Action] [nvarchar](50) NOT NULL,
	[Timestamp] [datetime] NULL,
	[Details] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contacts]    Script Date: 11/14/2023 4:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contacts](
	[ContactID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NULL,
	[Email] [nvarchar](100) NULL,
	[Phone] [nvarchar](20) NULL,
	[Address] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 11/14/2023 4:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sessions]    Script Date: 11/14/2023 4:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sessions](
	[SessionID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[SessionToken] [nvarchar](255) NOT NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SessionID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 11/14/2023 4:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[RoleID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 11/14/2023 4:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[Email] [nvarchar](100) NULL,
	[ResetToken] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Username] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ActivityLog] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[ActivityLog]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Contacts]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Contacts]  WITH CHECK ADD  CONSTRAINT [FK_UserContacts] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [FK_UserContacts]
GO
ALTER TABLE [dbo].[Sessions]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Sessions]  WITH CHECK ADD  CONSTRAINT [FK_UserSessions] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Sessions] CHECK CONSTRAINT [FK_UserSessions]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
/****** Object:  StoredProcedure [dbo].[usp_DelContact]    Script Date: 11/14/2023 4:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[usp_DelContact]
	@ID		int
AS
BEGIN
	DELETE	FROM dbo.Contacts
	WHERE	ContactID = @ID
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_GetContact]    Script Date: 11/14/2023 4:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[usp_GetContact]
	@ID		int
AS
BEGIN
	SELECT	ContactID
			,UserID
			,FirstName
			,LastName
			,Email
			,Phone
			,Address
	FROM	dbo.Contacts
	WHERE	ContactID = @ID
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_GetContacts]    Script Date: 11/14/2023 4:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_GetContacts]
	@ID				int			= null
AS
SELECT * FROM Contacts WHERE UserID = @ID
GO
/****** Object:  StoredProcedure [dbo].[usp_InsContact]    Script Date: 11/14/2023 4:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[usp_InsContact]
	@UserID int,
	@ContactFirstName	varchar(80),
		@ContactLasttName	varchar(80),
			@Email	varchar(80),
				@Phone	varchar(80),
	@CompAddress	varchar(80)
AS
BEGIN
	INSERT INTO dbo.Contacts
			   (UserID,
			   FirstName,
			   LastName,
			   Email,
			   Phone,
			   Address)
		 VALUES
			   (@UserID
			   ,@ContactFirstName
			   ,@ContactLasttName
			   ,@Email
			   ,@Phone
			   ,@CompAddress)
END;
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdContact]    Script Date: 11/14/2023 4:59:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[usp_UpdContact]
	@ID				int			= null,
	@FirstName	varchar(80)	= null,
	@LastName	varchar(80)	= null,
	@Email	varchar(80)	= null,
	@Phone	varchar(20) = null,
	@Address	varchar(80) = null
AS
BEGIN
	UPDATE	dbo.Contacts
	SET		FirstName			= ISNULL(@FirstName	, FirstName	)
			,LastName			= ISNULL(@LastName	, LastName	)
			,Email				= ISNULL(@Email	, Email	)
			,Phone				= ISNULL(@Phone	, Phone	)
			,Address		= ISNULL(@Address	, Address	)
	WHERE	ContactID = @ID
END;
GO
ALTER DATABASE [Contact_List] SET  READ_WRITE 
GO
