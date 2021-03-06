USE [VinhCinema]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 3/17/2017 3:16:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 3/17/2017 3:16:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](200) NOT NULL,
	[IdentityCard] [nvarchar](50) NOT NULL,
	[UniqueKey] [uniqueidentifier] NOT NULL,
	[DateOfBirth] [datetime] NOT NULL,
	[Mobile] [nvarchar](10) NULL,
	[RegistrationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.Customer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Error]    Script Date: 3/17/2017 3:16:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Error](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Message] [nvarchar](max) NULL,
	[StackTrace] [nvarchar](max) NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.Error] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Genre]    Script Date: 3/17/2017 3:16:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genre](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.Genre] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Movie]    Script Date: 3/17/2017 3:16:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movie](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](2000) NOT NULL,
	[Image] [nvarchar](max) NULL,
	[GenreID] [int] NOT NULL,
	[Director] [nvarchar](100) NOT NULL,
	[Writer] [nvarchar](50) NOT NULL,
	[Producer] [nvarchar](50) NOT NULL,
	[ReleaseDate] [datetime] NOT NULL,
	[Rating] [tinyint] NOT NULL,
	[TrailerURI] [nvarchar](200) NULL,
 CONSTRAINT [PK_dbo.Movie] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Rental]    Script Date: 3/17/2017 3:16:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rental](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[StockID] [int] NOT NULL,
	[RentalDate] [datetime] NOT NULL,
	[ReturnedDate] [datetime] NULL,
	[Status] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_dbo.Rental] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Role]    Script Date: 3/17/2017 3:16:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_dbo.Role] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Stock]    Script Date: 3/17/2017 3:16:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stock](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MovieId] [int] NOT NULL,
	[UniqueKey] [uniqueidentifier] NOT NULL,
	[IsAvailable] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Stock] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 3/17/2017 3:16:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](200) NOT NULL,
	[HashedPassword] [nvarchar](200) NOT NULL,
	[Salt] [nvarchar](200) NOT NULL,
	[IsLocked] [bit] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 3/17/2017 3:16:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.UserRole] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'201612091739266_First DB Scheme', N'VinhCinema.Data.Migrations.Configuration', 0x1F8B0800000000000400ED5D5F6FDCB8117F2FD0EF20EC535BE4BCB683035A637D0767ED5C8D2671E075D2BE19B444AF89E8CF9E44B9368AFB64F7D08FD4AF504A2225FE954849ABB51D232F6B52FC71C8190E6748CEE47FBFFF77F1F343147AF730CD50121FCF0EF6F6671E8CFD2440F1FA7896E3DB1FFE3AFBF9A73FFE617116440FDE57F6DDDBE23BD232CE8E6777186F8EE6F3CCBF8311C8F622E4A74996DCE23D3F89E62048E687FBFB7F9B1F1CCC218198112CCF5B5CE63146112CFF207F2E93D8871B9C83F06312C030A3E5A46655A27A9F4004B30DF0E1F1EC2B8AEF962826A57BA700839977122240C858C1F076E681384E30C084C8A32F195CE13489D7AB0D2900E1D5E30692EF6E4198414AFC51F3B9ED38F60F8B71CC9B860CCACF339C448E80076FE9C4CCE5E6BDA677564F1C99BA3332C5F8B11875397DC7B365D9054C679EDCD9D1324C8B0F85D92DDB2398EDB1766F3C4DED9B5A2888EC14FFDE78CB3CC4790A8F6398E314846FBCCFF94D88FC7FC0C7ABE41B8C8FE33C0C794A09ADA44E2820459FD3640353FC78096F29FDE7A7336F2EB69BCB0DEB665C9B6A64E7317E7B38F33E91CEC14D086B41E06661859314FE026398020C83CF006398123E9E07B09C4AA577A9AFF728CD70F1937549C48F2CA399F7113C7C80F11ADF9105B64F16CE7BF400035642C9F81223B2EA48239CE65043667BD71FC0AE7A3E8B000A5BBA3DDC4EB78C274B90062DBDFFB895CE49EB5F7348448FF5FC4B8E026714A2BDE0C5ED3B94E23B8653145DA1C89DA28FC90D0ADBB96F3511EDBD5CC235CAC8922E164B41AA23D98B79A3925A15D5599A26CE5AAA6CF4AAA23AE404661958B7090AF93982A4AC30F0BF5DA564C3DE7A5785F02D53584CC7B6E491CC770A5DE5B16CF42A8FEDCCEBD8B34652DF9FC03D5A97F42A6AF39EF063E65DC2B0ACCEEED0A6B224F7CAAA6BCAF9F769125D26216B51155F5F81740D31213F51EB56499EFA7DE5AD047295B7B2D1ABBCB5CBDB15C21DDBE4560C865398F929DA54767D9BA9B41D5B299A42E59772DFCDCB8E894229F471B1F94FCDA27FA608C3B67EB7634A923F83DCDF41C744E54190C11E669C068BACCD82E80AE6DD23768720B6023160D32F97E723F812B6EA9F6AF77EDA9F69789DF6673B832D2144ABF9DFDAF621F6814C4A556EA08556EA88B1DE8A4A0CD7ADA86CF4BA1575B96C8447E7C1307D398E277A9E9DDC93E557B4A81771420409C4436D2BAD4897E2714DEB1B89E68A1581E6EB5C17D725E10721BD8594FA0B99185A612087D50E5A601588EB0AAB5ABD2EB176B966079743AD9292DD43412A968DB3DF42C2CE18067AB04ECF1CE7D9F093A2DE7A81EE28FD17A3EC76E9976ABFC59884CE7E57D1E67521EEDCCDB7E6F1970CA67DF8CCDABDF2BAC32421F334D4AC29E6D919C36C0094DCD6281CC6D2EBEA8B46E10815CAEE2FD60EDAFD0BA83E82F82A84DD42187F4FF7617F07D95D314F59F6EFA4F5466C4BFDAF408877700B987D207B7F73F06FEDB58C7687D0A677989ED0BB1E45ED35F789A87D9A1AADFAE1AA5DF4CF4996253E2A29E1BD347AD0210EEB2C0EBC96538F8AD3F50905E13651356843940BE9F778F617659AF478B531D7E0D1531711EF60262BA58BF814861043EFC4AF9E5B2C41E68340E50F998B402C217A0CA6852201E192F0846846146355E9A1D8471B109AA9969A586ACA82A41A5CAE39851B18174ACE3CF736BDD687B16AD7750FD22C754DCA62CE494FBB50F10EBE4908B4DE7E2304D44BB0172ADD09419790EE5EA834544F20549AB9B7E9B53EB1DAA15031EFB05D0C94739B0EC11A55104CC468A4921DFE7489F900D992A66232E992466DD36F7DCCB213F9120EDADBB72EF9D47D4A3563A045235C962A74C06628CEC364BBA138E4A7AFB94437D3C44E83CFD9F0B339B8B0DF15F5AE2AAF813480BBDF16B5644F205F5A1ED8F4CB0E2C76265F9C27D1260B3AB74294B0899497C189E925EEBD454C9D8D89644C1DB94DC7EC646D0221ABDC47D206931630A50434674E450D7CC09AA32B42243DBDCAA8532F8B4081BC8258BAA35915EC6FBC562A04CD937545C58930E5EB4F3D067D4DDA01507A4C7A00EA907600947B8C1E805A051D00E5B6A607A05B7907406572E91198A5D9054164D200502EC58EE64CACF510CD8AB680314328CD391996D8C15E70705F681E78C8CBA9FDE4A3269667B9B224DB4F3B388C46EE64ED290ECB62C8C2BDBA3A64A357DEE99773E43642DA32649D2F6E316DBD875C5F199A06ADF51A2DFCC67E03971D3E0E855BA283C72EBE0C3289B8CEA1E97669FA09B9E48B58CC5E8F614B9736EAB85BCC6D0B839B235AD0662D83D71BD93CD7F5203D07CF1F1AEB476F32066DCC4169FC3663D7D87176B3D83201EC04BB3641EABAC5BC8A09A4058BB9217870F1116C36285E73C184B4C45B559184CB1F56EE5176518531F785B9950DA6BA279CA4600DA55AD235A1B40C172B42186F4071ABB00C22E533D5E0326C9CAC3FD5A65259C7B654D6A6F82DDB77656865637DA9D6296DFC9E8C2E2A6CDBF2BE8EE3BAB9A95704758210A49AEBC16512E6516C36B3CDADB9D83B1E842BB6C76A82E978A8A6D41E895E06F230B4C81E438C74136648A8B147E41E0DF2705CB13D9610C4C6A30915F6782C908D876265F6286AA01A8FA7D6AAC88BB924E18ACFA52C24C5F915D7A6D5CAADDD9821CBB67278DCD7ACA1DD76166C1D8926709A15DAE3F091663C145FEE26CEF545B02CCE75C5931197DA7918222E5A27C8425C0CEDB6232EAA3E36E9E21DB1A2369387B042EB9C59B0C2D06E3BACA031543C002D7258677C4094B0CEF80A874D325274092DB2C7A8EFCC7914E3457ACBD8EA1826616075A93D128B49E27158993D4A1362C4E334A52EDB2A173324EEA85C85031E8D1B12A06899833C72A143825072E54F464DD48EF01035511D07BAAB0943BB2D6DF0ECCE4D34E50C1771669C31AD5521D045181A5FF16484A5392D1A222DF4E8D75D5C4C0DB7232F7CB0068FC297BB9885F42D8168131A1E189871F8A80D51E335E52E687CE08688C7D73899BF65388764FA96654F478EE9F1CF2029D61CE6D9C8B0B6D9776AA3F247714378515FE4B8F3C3DC743B3C6177A6C2D661B84735A3B0EB7D61C51AAEFC77CADD3138DB93AB53723456565A533AEDE99CFCEE9E0793EB1CB47AF99A5ED0E965898BA5C35EC68B660E2B7DE64722CAF580FC49DD7B7D4D205D072CE8D17C77C241E5ACBEFA64E69189BA4741714EBF7ACC308CA871FE6BB80C11196FF3C14710A35B98E12AE66676B87F7028A52D7C3A2904E75916849AAB0D5D1E41915F13040EA162563B43831C833F94B47DF13D48FD3B90AAE14203B3F28D062C041969510F7BA0EA72EA69C17F74C7561215E465012ABBBC45C539C4F0F4790129C2C3D3E719D8C4A30EC9966749A563B6BC97B116A5FC748C137F8AC0C39F5DE75FCD4137084E1323363627756158CF95939D7AAF538938A64B7B19D32624281B6DBFD0E41F33ED1A3DB68D68AC152BA5102B275879607A1E07F0E178F69FB2CD9177FEAF6BDAEC8D77911263EBC8DBF77E1B9C786CB4A917F38A8DB59D7E96D2868D85ABC90AD67B5315B38291DF8F2543072706B3B177546973CC78F532B4899463CA7641D1668316D4F8069F264BD50DEA1228D73C4C2F83EF6AE2A33E4B4F4A7B642B3DB4D920E9519325F557439A64493A304B93924B9E64E1270C9248355AECB9CAE384C6A0FE80F9D9CE9C984DC7760956AD86AD4021058F6DC7552B878EDD32E5BC1C9EC6CFE758489F5A6634783E73CC7847595262986E43610A87BF5FFA151AC33469861429B2A34FBE975E5199A6B788DB89247F21A9542C59B4CD2417D3261E982C8BC533482EE090166567795058F0E9A4994FA61012E3D3AAE79BDCE4558F7C9F7AC42E494915733965FE1035CC72CA2C1186574E5B4B3CF2A2928DEC32B7C8D482627838B55B41D979C21035CC55E6993E19486B2690EAF90D71C66E12C2E1CA0973CB13624E12A2C376C81F624E1EA20376C82B624E2AA20376C837624E36A20376C943D292844407ED90A0C4989D448BEB92B7A43569890EDD29A589319F89095941DD5EA613417CB9F03E557728F622D7462F783BCA6462499ECE08556266C61AD258994ABA49D43A606A70C7F0818D9986E4C9706BB42423BC56690212DA0625EB22F1D9FC38431B31858842E6248373480FA2BEF325660EF7DF8F13132B43EB06A2F8CFC863E80B064EFDCD797C9B303B4BA2887DA2BC68C32020D6CF498AD12DF031A9F66196952F23BE82302F8FED6F60701E5FE4789363326418DD8442585B61AFB5F55FE64011695E5C94AF7DB2318640C844C5C9F745FC2E476150D3FD5E73F26D80280C417A8352F0B2781509D78F35D2A724B604A2D357DBAF5730DA84042CBB8857E01EF6A18D88DF07B806FE237BAE6D06E9668438ED8B5304D62988328AD1B4277F12190EA2879FFE0F89003D85857F0000, N'6.1.3-40302')
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (1, N'Eleanora', N'Jones', N'geraldine_crist@grady.com', N'26bd7b94-a3e6-46cd-81c9-53fd37203d90', N'ff6e7634-6a11-4772-885b-4db82b74c567', CAST(N'1985-10-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-02-21 10:59:43.583' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (2, N'Johnson', N'Veum', N'elissa@sipesturcotte.us', N'741046ef-4e40-4463-87ed-a63670d206a2', N'5a636ce4-8658-4126-a2d7-69d5ec212620', CAST(N'1985-11-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-02-22 10:59:43.583' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (3, N'Virgie', N'Dibbert', N'shawna@millsarmstrong.biz', N'35cfb5f1-0cee-4b52-8bdf-53c16ad031b4', N'0a892e62-6a3e-48ef-977c-70eed78dd29d', CAST(N'1985-12-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-02-23 10:59:43.587' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (4, N'Earl', N'Hansen', N'rosie.jacobson@alanna.ca', N'353baf23-22d5-42a3-b675-ed907ceefc9c', N'5069912d-c575-41aa-b7a6-7e5917ac2220', CAST(N'1986-01-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-02-24 10:59:43.593' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (5, N'Elmo', N'Jast', N'carolanne@walterhintz.info', N'f87cdb01-236d-4876-9197-97043ba9a8e4', N'29937180-fc1b-4934-a84d-abf8f167d975', CAST(N'1986-03-02 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-02-25 10:59:43.593' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (6, N'Hoyt', N'Dicki', N'august@okuneva.com', N'85ad58f7-f305-4cd1-a126-23ea02ffd0c4', N'65c7e996-ae37-4d18-879e-105a48f3023c', CAST(N'1986-03-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-02-26 10:59:43.593' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (7, N'Keeley', N'Volkman', N'tabitha@hilll.info', N'b98ae615-b667-4899-96aa-aa782b148ce3', N'30bf356f-efeb-4bfb-b501-b34287c8a827', CAST(N'1986-04-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-02-27 10:59:43.597' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (8, N'Shana', N'Nicolas', N'micheal.conroy@pouros.com', N'780cabf3-5d17-4766-9bb0-50e42d658589', N'3a9b79af-1b2a-439d-853f-dad6a37dc791', CAST(N'1986-05-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-02-28 10:59:43.597' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (9, N'Lauriane', N'Torp', N'alejandrin_will@rippin.uk', N'78a8c97a-576e-4836-b9a8-8560bfc7d8a6', N'f0af1009-dd43-4ec9-86cd-a5ae65165be1', CAST(N'1986-06-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-01 10:59:43.597' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (10, N'Samir', N'Feest', N'clarabelle@goldner.co.uk', N'c7b35ea1-5a88-43bb-bfb4-1f3d178acdd9', N'b324bfe2-cbc5-46dd-ba7b-387f12bcca63', CAST(N'1986-07-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-02 10:59:43.597' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (11, N'Cloyd', N'Lind', N'treva.fay@spencer.biz', N'ddd58aa9-c9b7-4db5-b2ba-faedff3faa13', N'612f160d-8105-442a-9a8f-60c70a012ad3', CAST(N'1986-08-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-03 10:59:43.597' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (12, N'Niko', N'Greenholt', N'mireya.berge@jacobi.ca', N'758dff44-298c-4892-b505-a8221e4b0bf9', N'ba41a224-3c4d-4f64-95ae-8337290e43d0', CAST(N'1986-09-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-04 10:59:43.597' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (13, N'Travon', N'Kirlin', N'euna_predovic@nolan.uk', N'4e83f4d9-7b02-4f68-a840-ad7019aec533', N'040e7b1b-3d82-49d2-bb4e-6635130efbba', CAST(N'1986-10-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-05 10:59:43.600' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (14, N'Jovani', N'Skiles', N'carroll.hudson@madisyn.biz', N'aa07d255-a601-40b8-b6cb-77a8e4cc5005', N'9ca439fd-0e50-4d4c-b6b1-97d2834e869b', CAST(N'1986-11-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-06 10:59:43.603' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (15, N'Brittany', N'Padberg', N'wilfred@luettgen.co.uk', N'543edd90-210e-4768-9e4b-ec192576574d', N'44120254-a32b-4e52-8683-89567a1a1398', CAST(N'1986-12-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-07 10:59:43.603' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (16, N'Dorothea', N'Cassin', N'abbey_damore@ollie.ca', N'33bf8e57-6a07-445b-9755-51729068a05f', N'efbdbda2-9267-4e34-a795-01242d7db4bd', CAST(N'1987-01-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-08 10:59:43.607' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (17, N'Dalton', N'Nicolas', N'reuben.walker@rosenbaumfarrell.info', N'74c2a11c-0a6f-4701-ae78-1aac4ffe45e1', N'50411349-18aa-4d84-a3e0-822391c1ca6b', CAST(N'1987-03-02 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-09 10:59:43.607' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (18, N'Emmalee', N'Jakubowski', N'ludwig_schinner@edmund.com', N'2bb585e4-c3d3-4fac-9740-f64411b952d8', N'0c079bfc-bc28-4bdd-bcda-755942112d41', CAST(N'1987-03-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-10 10:59:43.610' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (19, N'Samara', N'Mante', N'ervin@robb.biz', N'b0e52d04-3770-415c-97c5-2e0b4905ec6d', N'f6fcbca7-40e8-4543-a810-ba9a6b582f17', CAST(N'1987-04-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-11 10:59:43.610' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (20, N'Liana', N'Marvin', N'bianka.brekke@starkheathcote.co.uk', N'b0b25d07-b709-4dba-9045-6970f11c6232', N'0cf1791a-c61d-400d-83b8-628c95533d31', CAST(N'1987-05-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-12 10:59:43.610' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (21, N'Theresia', N'Schmeler', N'elouise_raynor@hermiston.uk', N'0e20af1b-c53b-4b44-93bc-764e69097e18', N'd2b7964c-ac33-47d6-aa2e-3d62e53304ec', CAST(N'1987-06-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-13 10:59:43.613' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (22, N'Vivianne', N'Kub', N'mabelle.hermann@langosh.uk', N'a44f98f9-355b-41f4-b858-5cb26912df74', N'bff08a14-f752-4307-a798-997dc17dfa7f', CAST(N'1987-07-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-14 10:59:43.613' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (23, N'Asia', N'Bruen', N'javon.roberts@loma.com', N'c42a08bc-7d78-4419-a255-92a93409d17c', N'b2a8acd3-a283-407c-86c1-c6a3af33a321', CAST(N'1987-08-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-15 10:59:43.617' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (24, N'Tierra', N'Weissnat', N'kirsten@wiegandgerlach.co.uk', N'c4e42814-3adf-489c-82ba-887245d031e0', N'c8271532-ea28-429c-ae60-2d9c79ecb5bc', CAST(N'1987-09-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-16 10:59:43.617' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (25, N'Leopold', N'Parisian', N'fletcher@satterfieldcole.info', N'0d681381-539f-473c-bd47-70c98b9fed86', N'7a2493d7-3563-4e8a-9a8e-1eff43c80e2b', CAST(N'1987-10-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-17 10:59:43.617' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (26, N'Rupert', N'Reichel', N'aliyah@hermann.name', N'f6d10f2b-90af-49c5-942e-1c90053f7988', N'5ee17908-f9d0-4870-843e-ad3f395e8426', CAST(N'1987-11-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-18 10:59:43.617' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (27, N'Ramon', N'Bartell', N'carmelo@schumm.co.uk', N'99b02b2f-67ef-4a0e-8143-08a8149aae48', N'a8f1e2c0-9799-452b-93af-dd02918e23ca', CAST(N'1987-12-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-19 10:59:43.620' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (28, N'Curt', N'Dare', N'karina@binsbeer.uk', N'e4f0af08-6fe3-4cb6-97f4-c5a4f1d9acc4', N'3961effb-4926-42c7-a98d-680a7ff091cf', CAST(N'1988-01-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-20 10:59:43.623' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (29, N'Raheem', N'Kessler', N'morgan_roob@price.name', N'9b176549-a9b5-4bfe-a5db-7524e0bf7b53', N'abdef5ff-d9e6-4f40-897e-49e983bcc62c', CAST(N'1988-03-01 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-21 10:59:43.627' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (30, N'Alverta', N'Vandervort', N'louisa@marks.us', N'740e7c06-e285-42f4-9ac2-749310353672', N'dbd633d9-1364-4e2b-8531-ed0a9b1860e9', CAST(N'1988-03-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-22 10:59:43.627' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (31, N'Nyah', N'Hackett', N'barry_schimmel@herman.uk', N'dd47d782-6514-4179-8c3c-63de9cc8927d', N'672619e4-583b-46bb-b271-38988a5ee530', CAST(N'1988-04-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-23 10:59:43.627' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (32, N'Myron', N'McGlynn', N'oswaldo@nolanfay.biz', N'1c963939-4c27-4f6b-96aa-8a4e3417b7b2', N'1a1bd079-2b4b-43fb-9b2d-69f7d8fa20a5', CAST(N'1988-05-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-24 10:59:43.627' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (33, N'Jaqueline', N'Doyle', N'amos@myrna.info', N'79d4181a-7882-4162-89a6-8fe0fbd4f0e6', N'4ac96dbe-6369-4deb-800b-b553a78b1eff', CAST(N'1988-06-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-25 10:59:43.630' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (34, N'Joaquin', N'Wehner', N'angie.lemke@haag.name', N'ecba3421-21dc-4ceb-a746-a89365fb3c75', N'c528b302-2028-4779-bd22-1181bcee34d6', CAST(N'1988-07-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-26 10:59:43.633' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (35, N'Meghan', N'McClure', N'jamey@morissette.name', N'1b0c2035-1a72-42d1-ad7e-0c852fe6577b', N'8d40f029-8e72-4390-9476-e05fbb9bb5e4', CAST(N'1988-08-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-27 10:59:43.633' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (36, N'Hildegard', N'Quitzon', N'delta@jakubowskikoss.co.uk', N'fe4beff2-7575-4e9b-88f0-21295ee5f04c', N'14c74058-48da-4705-9b5a-d68ca23a76c9', CAST(N'1988-09-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-28 10:59:43.633' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (37, N'Rachelle', N'Yost', N'hipolito_willms@bahringerrosenbaum.uk', N'e3acc877-ab0c-4d6c-bbac-5b721f118cbe', N'2c9a9ec3-6474-4f00-b9e0-16fcc8bbb434', CAST(N'1988-10-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-29 10:59:43.633' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (38, N'Keith', N'Hirthe', N'amiya@kozey.biz', N'f413a620-515b-4108-879d-b315860cb5d2', N'e9967854-b7e6-4c59-b329-cca2843a4713', CAST(N'1988-11-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-30 10:59:43.640' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (39, N'Judy', N'Berge', N'myles@kerluke.info', N'e8725a2a-059d-49c5-9ab0-a2b44ce1406c', N'dab2cd5e-8487-419b-bfc7-1a779e78aa43', CAST(N'1988-12-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-03-31 10:59:43.640' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (40, N'Merritt', N'Lebsack', N'derrick.daniel@hirthereinger.com', N'50def8d1-232f-468a-8cce-b3fcfe50a49b', N'e77eb1c6-312c-4374-88c6-b379b055f003', CAST(N'1989-01-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-01 10:59:43.640' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (41, N'Lauriane', N'Hamill', N'nayeli@annabelle.co.uk', N'ad018207-6469-44bd-9a99-cf7c605a4772', N'f6ee54be-3af5-48ac-aa70-1f6b729185c9', CAST(N'1989-03-02 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-02 10:59:43.643' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (42, N'Eulah', N'Pouros', N'lenore@euna.uk', N'50e308b0-83ed-420e-a591-83fe18ca681c', N'bbbf6ec8-878e-4aff-8549-f9aa7d98837c', CAST(N'1989-03-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-03 10:59:43.643' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (43, N'Merlin', N'Bernier', N'dorian.zieme@bradtke.ca', N'0ff1904e-9d3f-4283-85a9-7ddf1490c516', N'fcda1e4c-cd07-4d71-a55a-9d36529fcae6', CAST(N'1989-04-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-04 10:59:43.647' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (44, N'Aiden', N'Howe', N'sigmund.walker@landen.co.uk', N'd9f472fa-0ab5-4056-a4ac-d0b1f156dfa9', N'd4b2c8de-5c13-4f48-859e-04ac7c01249b', CAST(N'1989-05-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-05 10:59:43.647' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (45, N'Emilie', N'Barrows', N'geovanny@art.biz', N'0542bad7-95c6-4804-a72e-6aa80b1e6481', N'170a6233-5b31-4488-ad3c-0ed8a1bc31fb', CAST(N'1989-06-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-06 10:59:43.650' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (46, N'Terence', N'Mitchell', N'christiana@okongrady.us', N'3af0f1df-2fc5-4058-94c4-961d3ea0cd7d', N'1f2251e1-48ea-4902-ae64-d04347210e31', CAST(N'1989-07-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-07 10:59:43.650' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (47, N'Amelia', N'Casper', N'rubye@dubuqueshields.biz', N'6b62730b-233b-44bd-9b29-5f211a0b6101', N'c68b4b0e-650a-4aed-b22c-b49397649c12', CAST(N'1989-08-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-08 10:59:43.650' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (48, N'Kayla', N'Schmitt', N'marlen@neil.us', N'8c5535ef-3e89-4ee7-8862-c25cb5e7f7d4', N'924877b4-e8dd-4da5-9554-838a04660a01', CAST(N'1989-09-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-09 10:59:43.653' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (49, N'Glennie', N'Bauch', N'sigrid.veum@christian.uk', N'f77f03fb-7141-4c2d-abed-a4698f751b9f', N'fd9557b5-bb41-41e8-b50f-c10ae119db59', CAST(N'1989-10-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-10 10:59:43.657' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (50, N'Audrey', N'Miller', N'marcel@luettgenlind.ca', N'8a55e695-c1c0-4afd-b08d-03eccac7795d', N'13d9417b-0cf2-4740-9efa-fa7bcf912779', CAST(N'1989-11-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-11 10:59:43.657' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (51, N'Dylan', N'Fritsch', N'rene.ratke@gottlieb.com', N'f9067dff-aaab-4cf9-9c51-e2d2f3e934a1', N'99d4a41d-52f5-48c6-a060-b772fc673668', CAST(N'1989-12-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-12 10:59:43.657' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (52, N'Randall', N'Cummings', N'clemens@dominic.uk', N'637ce129-02df-4504-b060-244004fb8ed2', N'd67cf52d-6302-4c79-a341-1fe30e0ff5c1', CAST(N'1990-01-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-13 10:59:43.660' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (53, N'Lemuel', N'Ebert', N'marco_mraz@mayerwilkinson.ca', N'9584f2a3-5536-43b5-a636-1f6c95aedff7', N'cb2b833c-2c94-4b3a-a2fa-2579dab7b6d1', CAST(N'1990-03-02 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-14 10:59:43.660' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (54, N'Geoffrey', N'Bayer', N'cordelia@schuppebeahan.biz', N'95d0eb7e-d9c6-406e-b49e-bf1a95260f99', N'0f07d5e0-dcc3-409e-bc4f-6512b9db608d', CAST(N'1990-03-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-15 10:59:43.660' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (55, N'Cyrus', N'Fay', N'charity@muellerwilderman.name', N'004df1fc-2701-4fe3-8111-3468d8d88a83', N'1f822b43-f28d-44b9-9982-b1785d781db3', CAST(N'1990-04-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-16 10:59:43.663' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (56, N'Haven', N'Witting', N'michele_bechtelar@champlin.us', N'e2ce7800-c47e-48df-8050-01d6e0455392', N'9605fed1-b50a-49b2-aad7-db97b7403e19', CAST(N'1990-05-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-17 10:59:43.663' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (57, N'Matilde', N'McCullough', N'colten@collins.biz', N'25803a2d-5e72-427a-b189-9fe2558d485a', N'8cfbcfcd-9d90-4f83-a062-c807c76d8b78', CAST(N'1990-06-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-18 10:59:43.667' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (58, N'Sven', N'Dibbert', N'victor@gail.uk', N'7a3572bd-1494-4fb3-9be6-537d1b3521e2', N'3ebf7a8e-6c6d-4d78-a1fc-3a9b2ec4361f', CAST(N'1990-07-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-19 10:59:43.667' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (59, N'Guiseppe', N'Funk', N'kobe@milford.uk', N'8a21bb08-05ce-4d98-9f7e-99fda7823c6f', N'24422f6c-287d-41e6-ba44-2c5b17fa2888', CAST(N'1990-08-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-20 10:59:43.667' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (60, N'Mariano', N'Ferry', N'ernie.ernser@hermiston.uk', N'3b88a59c-b910-4bf8-b44a-d1851152e36e', N'f84f5217-5cf8-4005-87ed-34fe7dede8d4', CAST(N'1990-09-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-21 10:59:43.667' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (61, N'Linwood', N'Armstrong', N'aliya@titus.ca', N'f1f27e2d-5637-432a-867b-522af06895d5', N'6f539dfe-7980-47de-b49c-f70439e8b92f', CAST(N'1990-10-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-22 10:59:43.673' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (62, N'Jacklyn', N'Deckow', N'shanelle.ohara@swiftkutch.biz', N'996ad514-4cc4-4ea4-b4e3-f726fcd6ece9', N'3e561d84-6d9a-4125-b8dc-aa738b7b7691', CAST(N'1990-11-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-23 10:59:43.673' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (63, N'Montana', N'Stracke', N'zoey@klockoblanda.co.uk', N'7e60ca9e-d958-4dc0-b5c3-5c3f6eb64d94', N'e07bc93f-75e8-4cb8-8730-977ae6ef7da6', CAST(N'1990-12-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-24 10:59:43.677' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (64, N'Kirsten', N'Considine', N'marquis@framihills.co.uk', N'a46efd30-6b7c-49f1-ad51-15f928699ae9', N'f5739639-b16c-4656-81f8-dde81edc3261', CAST(N'1991-01-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-25 10:59:43.677' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (65, N'Geovanny', N'Daugherty', N'kenyon@franeckiwilderman.us', N'8dae7893-ebb5-4b9e-96ab-9aea1915bb75', N'7a955a0d-b93d-40fb-93e9-63cb6bc8a3d0', CAST(N'1991-03-02 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-26 10:59:43.677' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (66, N'Nelda', N'Gerhold', N'flossie@pagac.us', N'7890c04f-6c1f-410c-bced-48ce5b2dd01f', N'1c84aa58-9aef-44a5-b25d-ad987aedb5c6', CAST(N'1991-03-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-27 10:59:43.680' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (67, N'Ola', N'Nienow', N'leann@auerolson.ca', N'f8174e89-fd79-4f35-b7a8-43dd3626db67', N'b1114658-afa6-42e0-b412-fa12496ae556', CAST(N'1991-04-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-28 10:59:43.683' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (68, N'Parker', N'Sporer', N'lillie@runte.us', N'9f61873f-fe88-45ec-a9ca-b401b83b4d40', N'f69859e7-2646-44b3-8701-e8bf63f42677', CAST(N'1991-05-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-29 10:59:43.683' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (69, N'Johathan', N'Gutkowski', N'hector@weberbernier.uk', N'625833d6-fea6-4c44-b4b4-78eb9a644db3', N'7e874fab-0512-4924-993c-eab0d4dd7928', CAST(N'1991-06-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-04-30 10:59:43.683' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (70, N'Talia', N'Wisoky', N'ellis@ratke.name', N'14ce51bd-ef6c-4476-ac0a-3fd9f47a3106', N'9ec3eb84-1766-4d82-83e8-8469341f7e7a', CAST(N'1991-07-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-01 10:59:43.683' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (71, N'Maxwell', N'Towne', N'pearlie_runte@hicklelarkin.biz', N'd642ce3c-d852-4fd7-93e9-18dc51d0ba77', N'eeb1fb8b-232b-44e7-a013-47d65736bfbe', CAST(N'1991-08-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-02 10:59:43.687' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (72, N'Orville', N'Schneider', N'esmeralda@wilfrid.info', N'4939d2e1-5018-4625-a227-378a2bbf0ea9', N'6c9736b2-f294-498c-bf31-96e97e84520e', CAST(N'1991-09-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-03 10:59:43.687' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (73, N'Aaliyah', N'Jaskolski', N'mary@kenyatta.uk', N'd766dc4f-06c8-4e7e-9f94-82f32a835960', N'9ef0c659-7134-4733-b7b5-61d5632102ea', CAST(N'1991-10-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-04 10:59:43.690' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (74, N'Ocie', N'Hermiston', N'antwan@ferry.uk', N'357b6149-be56-4cd4-9963-55d481d68880', N'1b315f51-21c8-4cbc-bd4b-77cf7b6b872c', CAST(N'1991-11-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-05 10:59:43.690' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (75, N'Roy', N'Williamson', N'nannie@summer.com', N'eedecf19-f82b-4ffd-8c91-3a0d2f2a6a14', N'33985425-0e5e-4784-b6e5-50059aa433f9', CAST(N'1991-12-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-06 10:59:43.693' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (76, N'Dixie', N'Hilpert', N'yesenia.schinner@streichsauer.uk', N'9ac2255a-18cd-4c67-ba31-5e9d9847ccb1', N'271a302e-9432-4ca4-89d2-15bfe77a97b8', CAST(N'1992-01-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-07 10:59:43.693' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (77, N'Marianna', N'Dooley', N'dangelo@arely.com', N'70835732-fdab-42fe-8998-0a4e87809f53', N'd76c5527-25b9-4922-9a36-29f0dccbabd9', CAST(N'1992-03-01 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-08 10:59:43.693' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (78, N'Forrest', N'Quigley', N'sandy.mcdermott@lockman.co.uk', N'513b489e-2ee3-4709-9dcd-4221e004ca3d', N'a326cc67-de46-4f2e-9bbd-5263c0f9d7dd', CAST(N'1992-03-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-09 10:59:43.697' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (79, N'Elyssa', N'Kutch', N'malika@eliseo.uk', N'692d035f-843f-400e-8f83-95d80bf2b330', N'7d54d724-c06f-4c00-8d2b-6935d6bd4499', CAST(N'1992-04-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-10 10:59:43.697' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (80, N'Jerry', N'Macejkovic', N'corbin.rohan@dickinson.biz', N'344613fa-a4b9-42ed-bd3d-405467ee6150', N'250e941c-0186-4f2d-a06e-b2e04976e7f5', CAST(N'1992-05-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-11 10:59:43.700' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (81, N'Jewell', N'Ondricka', N'elnora_oreilly@lednerkuvalis.com', N'272677a9-fcc4-4ab7-95db-40f9f1235013', N'5e6a9945-3e4c-43d6-a3c0-de0b9091a587', CAST(N'1992-06-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-12 10:59:43.700' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (82, N'Gunner', N'Conroy', N'zoila@jan.ca', N'0c1555ad-284a-43e9-b798-b653d3740a91', N'6907eb4c-85d4-4d87-a1dd-bd0f661c3f24', CAST(N'1992-07-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-13 10:59:43.700' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (83, N'Greyson', N'Walsh', N'viola@barbara.uk', N'4141ae16-10ae-40a4-aafb-887a4f6d5232', N'af2881c9-0969-4eee-9705-6c78eeb216c5', CAST(N'1992-08-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-14 10:59:43.703' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (84, N'Jade', N'Carter', N'giovanny@schummweber.uk', N'c35edb4c-6336-4c9a-a4d6-c2506efaf0de', N'92d85c81-a097-47ea-a376-d61814b592f7', CAST(N'1992-09-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-15 10:59:43.707' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (85, N'Rahul', N'Donnelly', N'zoila@ryan.name', N'bdaa2a2c-1e2a-4184-aaa4-fee57b6dd5ec', N'13993920-ff85-40a5-9bec-c3e7af166980', CAST(N'1992-10-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-16 10:59:43.707' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (86, N'Alia', N'Herman', N'rodolfo@schulistruecker.biz', N'f814da9c-e371-485a-aae9-5ec0265e859a', N'fb9c47f5-a26e-4504-8375-85ed9e15a86d', CAST(N'1992-11-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-17 10:59:43.707' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (87, N'Maegan', N'Hilll', N'bessie_runolfsdottir@corkery.name', N'7050cf04-fcd4-44a2-a5cc-0e4825e63343', N'9718d760-82eb-4b2a-b0b5-053ed54294d7', CAST(N'1992-12-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-18 10:59:43.707' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (88, N'Annamae', N'Howe', N'adrian@hilda.biz', N'5251b869-25d4-446b-967e-c24b22f40f3b', N'1913ff31-710d-48a4-896a-d79ee1889343', CAST(N'1993-01-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-19 10:59:43.707' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (89, N'Patrick', N'Davis', N'cedrick.heller@prohaska.us', N'67e4a340-d9c6-4229-a63a-a6f7951cc659', N'd7b401be-a46b-44ef-8407-3f3aa551bcff', CAST(N'1993-03-02 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-20 10:59:43.710' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (90, N'Marquis', N'Beatty', N'flavio.reynolds@adela.co.uk', N'06eafae2-e07f-4123-853c-e97524d9b2f9', N'6606df4f-7ee1-4944-8142-c6edbd839498', CAST(N'1993-03-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-21 10:59:43.713' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (91, N'Yoshiko', N'Farrell', N'earnestine_oconner@alberta.info', N'1c3b103e-cfad-49d9-8e82-fc5e9f6866f9', N'ff82062c-68ce-476f-b896-84369dcd0cd8', CAST(N'1993-04-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-22 10:59:43.713' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (92, N'Bridget', N'Crist', N'joany.donnelly@rueckerparisian.co.uk', N'6d2c50c8-1664-4bb1-bbaf-0edf05954d07', N'027a12a2-e331-47d4-9f48-5d39cdb4badc', CAST(N'1993-05-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-23 10:59:43.713' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (93, N'Jaiden', N'Stracke', N'stanley@bartellleannon.us', N'194003e5-7671-4ff8-996c-760aebdf5adc', N'1e0630ad-170e-4f96-9858-96742dd51295', CAST(N'1993-06-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-24 10:59:43.717' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (94, N'Phoebe', N'Johnson', N'kevin@schmelerwiegand.biz', N'1944a79c-59bc-47ae-8722-2a83a31780fd', N'4548bbc0-5e78-41a8-b33d-bd0a40e5dcc6', CAST(N'1993-07-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-25 10:59:43.717' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (95, N'Sid', N'Kertzmann', N'aric_daugherty@veumvolkman.uk', N'47e385ac-66ff-4ded-a372-38ed821cbaa0', N'f5faa710-baf8-4616-9974-e032e3b2795f', CAST(N'1993-08-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-26 10:59:43.717' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (96, N'Gerald', N'Wiza', N'paula.beier@wunsch.us', N'5a20d6ad-1f80-4aa1-acb8-dfb888b170ec', N'fd53250e-1081-488d-8056-3d85c6341ade', CAST(N'1993-09-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-27 10:59:43.720' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (97, N'Guido', N'Homenick', N'libbie@robertsrussel.uk', N'7bac49ae-7445-48af-aba6-eef23e53ef42', N'1adf0b51-56e5-417d-8485-c6cc0169067f', CAST(N'1993-10-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-28 10:59:43.720' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (98, N'Kaia', N'Mann', N'chadd_kiehn@emmerich.ca', N'32ae51cd-9a31-45ad-830d-f534eb282fea', N'b2829278-73a8-4377-871a-fe9372df720f', CAST(N'1993-11-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-29 10:59:43.723' AS DateTime))
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (99, N'Geovany', N'Goyette', N'kareem@torrance.biz', N'4c7837e7-bcbf-47a4-9672-c2f824ce7f87', N'e74ab4c4-29bb-45d5-9521-1199fbf346e6', CAST(N'1993-12-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-30 10:59:43.723' AS DateTime))
GO
INSERT [dbo].[Customer] ([ID], [FirstName], [LastName], [Email], [IdentityCard], [UniqueKey], [DateOfBirth], [Mobile], [RegistrationDate]) VALUES (100, N'Abraham', N'Bernier', N'jodie@gleichnermcdermott.us', N'52ae4f9c-89b7-4b73-8d6e-2850162004bd', N'3c603d06-d8bb-48bd-964c-0add5afae28d', CAST(N'1994-01-30 00:00:00.000' AS DateTime), N'1234567890', CAST(N'2017-05-31 10:59:43.723' AS DateTime))
SET IDENTITY_INSERT [dbo].[Customer] OFF
SET IDENTITY_INSERT [dbo].[Genre] ON 

INSERT [dbo].[Genre] ([ID], [Name]) VALUES (1, N'Comedy')
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (2, N'Sci-fi')
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (3, N'Action')
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (4, N'Horror')
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (5, N'Romance')
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (6, N'Comedy')
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (7, N'Crime')
SET IDENTITY_INSERT [dbo].[Genre] OFF
SET IDENTITY_INSERT [dbo].[Movie] ON 

INSERT [dbo].[Movie] ([ID], [Title], [Description], [Image], [GenreID], [Director], [Writer], [Producer], [ReleaseDate], [Rating], [TrailerURI]) VALUES (1, N'Minions', N'Minions Stuart, Kevin and Bob are recruited by Scarlet Overkill, a super-villain who, alongside her inventor husband Herb, hatches a plot to take over the world.', N'minions.jpg', 1, N'Kyle Bald', N'Brian Lynch', N'Janet Healy', CAST(N'2015-07-10 00:00:00.000' AS DateTime), 3, N'https://www.youtube.com/watch?v=Wfql_DoHRKc')
INSERT [dbo].[Movie] ([ID], [Title], [Description], [Image], [GenreID], [Director], [Writer], [Producer], [ReleaseDate], [Rating], [TrailerURI]) VALUES (2, N'Ted 2', N'Newlywed couple Ted and Tami-Lynn want to have a baby, but in order to qualify to be a parent, Ted will have to prove he''s a person in a court of law.', N'ted2.jpg', 1, N'Seth MacFarlane', N'Seth MacFarlane', N'Jason Clark', CAST(N'2015-06-27 00:00:00.000' AS DateTime), 4, N'https://www.youtube.com/watch?v=S3AVcCggRnU')
INSERT [dbo].[Movie] ([ID], [Title], [Description], [Image], [GenreID], [Director], [Writer], [Producer], [ReleaseDate], [Rating], [TrailerURI]) VALUES (3, N'Trainwreck', N'Having thought that monogamy was never possible, a commitment-phobic career woman may have to face her fears when she meets a good guy.', N'trainwreck.jpg', 2, N'Judd Apatow', N'Amy Schumer', N'Judd Apatow', CAST(N'2015-07-17 00:00:00.000' AS DateTime), 5, N'https://www.youtube.com/watch?v=2MxnhBPoIx4')
INSERT [dbo].[Movie] ([ID], [Title], [Description], [Image], [GenreID], [Director], [Writer], [Producer], [ReleaseDate], [Rating], [TrailerURI]) VALUES (4, N'Inside Out', N'After young Riley is uprooted from her Midwest life and moved to San Francisco, her emotions - Joy, Fear, Anger, Disgust and Sadness - conflict on how best to navigate a new city, house, and school.', N'insideout.jpg', 1, N'Pete Docter', N'Pete Docter', N'John Lasseter', CAST(N'2015-06-19 00:00:00.000' AS DateTime), 4, N'https://www.youtube.com/watch?v=seMwpP0yeu4')
INSERT [dbo].[Movie] ([ID], [Title], [Description], [Image], [GenreID], [Director], [Writer], [Producer], [ReleaseDate], [Rating], [TrailerURI]) VALUES (5, N'Home', N'Oh, an alien on the run from his own people, lands on Earth and makes friends with the adventurous Tip, who is on a quest of her own.', N'home.jpg', 1, N'Tim Johnson', N'Tom J. Astle', N'Suzanne Buirgy', CAST(N'2015-05-27 00:00:00.000' AS DateTime), 4, N'https://www.youtube.com/watch?v=MyqZf8LiWvM')
INSERT [dbo].[Movie] ([ID], [Title], [Description], [Image], [GenreID], [Director], [Writer], [Producer], [ReleaseDate], [Rating], [TrailerURI]) VALUES (6, N'Batman v Superman: Dawn of Justice', N'Fearing the actions of a god-like Super Hero left unchecked, Gotham City''s own formidable, forceful vigilante takes on Metropolis most revered, modern-day savior, while the world wrestles with what sort of hero it really needs. And with Batman and Superman at war with one another, a new threat quickly arises, putting mankind in greater danger than it''s ever known before.', N'batmanvssuperman.jpg', 2, N'Zack Snyder', N'Chris Terrio', N'Wesley Coller', CAST(N'2015-03-25 00:00:00.000' AS DateTime), 4, N'https://www.youtube.com/watch?v=0WWzgGyAH6Y')
INSERT [dbo].[Movie] ([ID], [Title], [Description], [Image], [GenreID], [Director], [Writer], [Producer], [ReleaseDate], [Rating], [TrailerURI]) VALUES (7, N'Ant-Man', N'Armed with a super-suit with the astonishing ability to shrink in scale but increase in strength, cat burglar Scott Lang must embrace his inner hero and help his mentor, Dr. Hank Pym, plan and pull off a heist that will save the world.', N'antman.jpg', 2, N'Payton Reed', N'Edgar Wright', N'Victoria Alonso', CAST(N'2015-07-17 00:00:00.000' AS DateTime), 5, N'https://www.youtube.com/watch?v=1HpZevFifuo')
INSERT [dbo].[Movie] ([ID], [Title], [Description], [Image], [GenreID], [Director], [Writer], [Producer], [ReleaseDate], [Rating], [TrailerURI]) VALUES (8, N'Jurassic World', N'A new theme park is built on the original site of Jurassic Park. Everything is going well until the park''s newest attraction--a genetically modified giant stealth killing machine--escapes containment and goes on a killing spree.', N'jurassicworld.jpg', 2, N'Colin Trevorrow', N'Rick Jaffa', N'Patrick Crowley', CAST(N'2015-06-12 00:00:00.000' AS DateTime), 4, N'https://www.youtube.com/watch?v=RFinNxS5KN4')
INSERT [dbo].[Movie] ([ID], [Title], [Description], [Image], [GenreID], [Director], [Writer], [Producer], [ReleaseDate], [Rating], [TrailerURI]) VALUES (9, N'Fantastic Four', N'Four young outsiders teleport to an alternate and dangerous universe which alters their physical form in shocking ways. The four must learn to harness their new abilities and work together to save Earth from a former friend turned enemy.', N'fantasticfour.jpg', 2, N'Josh Trank', N'Simon Kinberg', N'Avi Arad', CAST(N'2015-08-07 00:00:00.000' AS DateTime), 2, N'https://www.youtube.com/watch?v=AAgnQdiZFsQ')
INSERT [dbo].[Movie] ([ID], [Title], [Description], [Image], [GenreID], [Director], [Writer], [Producer], [ReleaseDate], [Rating], [TrailerURI]) VALUES (10, N'Mad Max: Fury Road', N'In a stark desert landscape where humanity is broken, two rebels just might be able to restore order: Max, a man of action and of few words, and Furiosa, a woman of action who is looking to make it back to her childhood homeland.', N'madmax.jpg', 2, N'George Miller', N'George Miller', N'Bruce Berman', CAST(N'2015-05-15 00:00:00.000' AS DateTime), 3, N'https://www.youtube.com/watch?v=hEJnMQG9ev8')
INSERT [dbo].[Movie] ([ID], [Title], [Description], [Image], [GenreID], [Director], [Writer], [Producer], [ReleaseDate], [Rating], [TrailerURI]) VALUES (11, N'True Detective', N'An anthology series in which police investigations unearth the personal and professional secrets of those involved, both within and outside the law.', N'truedetective.jpg', 6, N'Nic Pizzolatto', N'Bill Bannerman', N'Richard Brown', CAST(N'2015-05-15 00:00:00.000' AS DateTime), 4, N'https://www.youtube.com/watch?v=TXwCoNwBSkQ')
INSERT [dbo].[Movie] ([ID], [Title], [Description], [Image], [GenreID], [Director], [Writer], [Producer], [ReleaseDate], [Rating], [TrailerURI]) VALUES (12, N'The Longest Ride', N'After an automobile crash, the lives of a young couple intertwine with a much older man, as he reflects back on a past love.', N'thelongestride.jpg', 5, N'Nic Pizzolatto', N'George Tillman Jr.', N'Marty Bowen', CAST(N'2015-05-15 00:00:00.000' AS DateTime), 5, N'https://www.youtube.com/watch?v=FUS_Q7FsfqU')
INSERT [dbo].[Movie] ([ID], [Title], [Description], [Image], [GenreID], [Director], [Writer], [Producer], [ReleaseDate], [Rating], [TrailerURI]) VALUES (13, N'The Walking Dead', N'Sheriff''s Deputy Rick Grimes leads a group of survivors in a world overrun by zombies.', N'thewalkingdead.jpg', 4, N'Frank Darabont', N'David Alpert', N'Gale Anne Hurd', CAST(N'2015-03-28 00:00:00.000' AS DateTime), 5, N'https://www.youtube.com/watch?v=R1v0uFms68U')
INSERT [dbo].[Movie] ([ID], [Title], [Description], [Image], [GenreID], [Director], [Writer], [Producer], [ReleaseDate], [Rating], [TrailerURI]) VALUES (14, N'Southpaw', N'Boxer Billy Hope turns to trainer Tick Willis to help him get his life back on track after losing his wife in a tragic accident and his daughter to child protection services.', N'southpaw.jpg', 3, N'Antoine Fuqua', N'Kurt Sutter', N'Todd Black', CAST(N'2015-08-17 00:00:00.000' AS DateTime), 4, N'https://www.youtube.com/watch?v=Mh2ebPxhoLs')
INSERT [dbo].[Movie] ([ID], [Title], [Description], [Image], [GenreID], [Director], [Writer], [Producer], [ReleaseDate], [Rating], [TrailerURI]) VALUES (15, N'Specter', N'A cryptic message from Bond''s past sends him on a trail to uncover a sinister organization. While M battles political forces to keep the secret service alive, Bond peels back the layers of deceit to reveal the terrible truth behind SPECTRE.', N'spectre.jpg', 3, N'Sam Mendes', N'Ian Fleming', N'Zakaria Alaoui', CAST(N'2015-11-05 00:00:00.000' AS DateTime), 5, N'https://www.youtube.com/watch?v=LTDaET-JweU')
SET IDENTITY_INSERT [dbo].[Movie] OFF
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([ID], [Name]) VALUES (1, N'Admin')
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[Stock] ON 

INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (1, 1, N'67465980-30e1-4a4d-a86c-afad8351f2b8', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (2, 1, N'508e2ac7-df38-486a-9cd1-a15a3b9f672c', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (3, 1, N'ec62f49c-0633-40f3-8ef6-30de44ef93b0', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (4, 2, N'7dab4db9-31ab-46fb-97e6-626afde4820d', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (5, 2, N'b9039f58-6b38-474c-8420-bf778c9ebc17', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (6, 2, N'5a38ed5f-ab8b-427a-bfa6-293407012854', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (7, 3, N'8980a817-830c-45ca-9973-7f70050c20fd', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (8, 3, N'1aff94ce-da09-4c39-9d61-fc17f441ad6b', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (9, 3, N'84db1095-2d66-432f-8323-85b776907a53', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (10, 4, N'0f4864e3-2d35-4d24-add9-e18eb4df2d03', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (11, 4, N'6b10a681-2df4-4b76-acac-6bf6c0673644', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (12, 4, N'741fb227-a241-4843-9b0d-646f2da06bf6', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (13, 5, N'49f60be3-653c-428e-b404-14ba3f06f978', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (14, 5, N'43c16e85-43a9-454e-9314-8087442e7e74', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (15, 5, N'2abe9156-09cf-4ff9-8c7f-78e3d915d9a4', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (16, 6, N'431cbfd8-506a-4eb5-ab75-d238b9295602', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (17, 6, N'8816b4ad-fd7a-45e1-8867-c2bca351813b', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (18, 6, N'84fc5f34-6f38-4c0b-a2a6-5ec05fc17102', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (19, 7, N'6f40462d-5d0c-4692-b8cc-fbb0aeca0f6c', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (20, 7, N'7d7c3a5f-775a-4767-9eeb-de73567b2de6', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (21, 7, N'bc97d36e-f9d5-47ca-b7e7-36f8b8b279e2', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (22, 8, N'7e961858-aa6f-476f-871c-f82c2a6c97b7', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (23, 8, N'9170cd1f-3d84-4cdf-bdec-67b0f6b757a3', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (24, 8, N'226a413c-4ab1-42ef-8de4-240fe87e1407', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (25, 9, N'c7543a41-301c-4f8a-8e74-e7ac34e72b4d', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (26, 9, N'9723526a-f1bc-4261-b0a5-1c08fb39b7e1', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (27, 9, N'a700f6e6-9df5-48b0-ae56-5784c279cfb2', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (28, 10, N'd5bd2815-0a31-46d7-bf5b-fa19977c7c14', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (29, 10, N'1dc3a50e-70fb-4336-a41f-3d2b665ffa30', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (30, 10, N'ec64a75e-e021-4320-bf24-d8f8693ec7da', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (31, 11, N'7bf6bd15-7b37-4a8a-b94f-882a91415bdd', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (32, 11, N'd2616b2a-4461-450c-b02d-b091ded084c6', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (33, 11, N'7698bb13-c2e6-4b96-b87f-d19b577fcf54', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (34, 12, N'abe0bb46-3750-4110-92c2-8f48aa385954', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (35, 12, N'e107492f-cc68-4150-9454-13f957a5d588', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (36, 12, N'68de263b-4607-42aa-977d-fb531e5c9a63', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (37, 13, N'0b871c76-902a-485a-8576-a3b0030d6ad8', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (38, 13, N'278e4f00-7c09-421e-8377-02b2a7d39a23', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (39, 13, N'af16f4b4-19b1-40ed-b7e6-7a73ab19fab8', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (40, 14, N'9a0f8252-bb93-4757-b346-69ddde36c2c3', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (41, 14, N'03ccaa07-5d6a-4a00-845b-8eb1ece64b6a', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (42, 14, N'1e439f05-b36c-4628-ac2b-b89cc0b62229', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (43, 15, N'bd75b1fa-2b53-462c-ba80-1b37e076ea24', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (44, 15, N'0331c407-637c-4a0f-b690-2d4e11c80a3b', 1)
INSERT [dbo].[Stock] ([ID], [MovieId], [UniqueKey], [IsAvailable]) VALUES (45, 15, N'e2d2f4eb-6058-47a2-b830-de15610951b5', 1)
SET IDENTITY_INSERT [dbo].[Stock] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([ID], [Username], [Email], [HashedPassword], [Salt], [IsLocked], [DateCreated]) VALUES (1, N'chsakell', N'chsakells.blog@gmail.com', N'XwAQoiq84p1RUzhAyPfaMDKVgSwnn80NCtsE8dNv3XI=', N'mNKLRbEFCH8y1xIyTXP4qA==', 0, CAST(N'2017-02-21 10:59:43.957' AS DateTime))
INSERT [dbo].[User] ([ID], [Username], [Email], [HashedPassword], [Salt], [IsLocked], [DateCreated]) VALUES (2, N'VinhCinema256', N'abc@gmail.com', N'BhLSRhoOVyd6IzzK61xvWOIUIvvSGfqmm87LThnAANk=', N'hoMKQYXWwEg8SeIhpf3AFw==', 0, CAST(N'2017-02-21 11:01:48.847' AS DateTime))
SET IDENTITY_INSERT [dbo].[User] OFF
SET IDENTITY_INSERT [dbo].[UserRole] ON 

INSERT [dbo].[UserRole] ([ID], [UserId], [RoleId]) VALUES (1, 1, 1)
INSERT [dbo].[UserRole] ([ID], [UserId], [RoleId]) VALUES (2, 2, 1)
SET IDENTITY_INSERT [dbo].[UserRole] OFF
ALTER TABLE [dbo].[Movie]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Movie_dbo.Genre_GenreID] FOREIGN KEY([GenreID])
REFERENCES [dbo].[Genre] ([ID])
GO
ALTER TABLE [dbo].[Movie] CHECK CONSTRAINT [FK_dbo.Movie_dbo.Genre_GenreID]
GO
ALTER TABLE [dbo].[Rental]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Rental_dbo.Stock_StockID] FOREIGN KEY([StockID])
REFERENCES [dbo].[Stock] ([ID])
GO
ALTER TABLE [dbo].[Rental] CHECK CONSTRAINT [FK_dbo.Rental_dbo.Stock_StockID]
GO
ALTER TABLE [dbo].[Stock]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Stock_dbo.Movie_MovieId] FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movie] ([ID])
GO
ALTER TABLE [dbo].[Stock] CHECK CONSTRAINT [FK_dbo.Stock_dbo.Movie_MovieId]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserRole_dbo.Role_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([ID])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_dbo.UserRole_dbo.Role_RoleId]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserRole_dbo.User_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_dbo.UserRole_dbo.User_UserId]
GO
