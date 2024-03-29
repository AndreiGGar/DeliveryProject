/****** Object:  Database [xyzdb]    Script Date: 29/03/2023 7:56:58 ******/
CREATE DATABASE [xyzdb]  (EDITION = 'Basic', SERVICE_OBJECTIVE = 'Basic', MAXSIZE = 2 GB) WITH CATALOG_COLLATION = SQL_Latin1_General_CP1_CI_AS, LEDGER = OFF;
GO
ALTER DATABASE [xyzdb] SET COMPATIBILITY_LEVEL = 150
GO
ALTER DATABASE [xyzdb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [xyzdb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [xyzdb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [xyzdb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [xyzdb] SET ARITHABORT OFF 
GO
ALTER DATABASE [xyzdb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [xyzdb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [xyzdb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [xyzdb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [xyzdb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [xyzdb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [xyzdb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [xyzdb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [xyzdb] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [xyzdb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [xyzdb] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [xyzdb] SET  MULTI_USER 
GO
ALTER DATABASE [xyzdb] SET ENCRYPTION ON
GO
ALTER DATABASE [xyzdb] SET QUERY_STORE = ON
GO
ALTER DATABASE [xyzdb] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 7), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 10, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
/*** The scripts of database scoped configurations in Azure should be executed inside the target database connection. ***/
GO
-- ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 8;
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 29/03/2023 7:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Image] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoriesRestaurants]    Script Date: 29/03/2023 7:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoriesRestaurants](
	[RestaurantId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
 CONSTRAINT [PK_CategoriesRestaurant] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC,
	[RestaurantId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OpeningRestaurants]    Script Date: 29/03/2023 7:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpeningRestaurants](
	[RestaurantId] [int] NOT NULL,
	[WeekDay] [int] NOT NULL,
	[OpeningTime] [time](7) NOT NULL,
	[ClosingTime] [time](7) NOT NULL,
	[TwoTimes] [bit] NOT NULL,
	[OpeningTime2] [time](7) NULL,
	[ClosingTime2] [time](7) NULL,
 CONSTRAINT [PK_OpeningRestaurants] PRIMARY KEY CLUSTERED 
(
	[RestaurantId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Restaurants]    Script Date: 29/03/2023 7:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Restaurants](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Address] [nvarchar](255) NOT NULL,
	[ZipCode] [nvarchar](10) NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[Country] [nvarchar](50) NOT NULL,
	[Maps] [nvarchar](max) NOT NULL,
	[Phone] [nvarchar](50) NULL,
	[ContactEmail] [nvarchar](100) NULL,
	[Website] [nvarchar](max) NULL,
	[MinimumAmount] [decimal](10, 2) NOT NULL,
	[DeliveryFee] [decimal](10, 2) NOT NULL,
	[DeliveryActive] [bit] NOT NULL,
	[DeliveryMinTime] [int] NOT NULL,
	[DeliveryMaxTime] [int] NOT NULL,
	[DateAdd] [datetime] NOT NULL,
	[DateEdit] [datetime] NULL,
	[CreatedBy] [int] NOT NULL,
	[EditedBy] [int] NULL,
	[Image] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_RESTAURANT] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[ViewRestaurants]    Script Date: 29/03/2023 7:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewRestaurants]
AS
SELECT Restaurants.Id as RestaurantId, CategoryId, Restaurants.Name as RestaurantName, Categories.Name as CategoryName, Restaurants.Image as RestaurantImage, Categories.Image as CategoryImage, 
Description, Address, ZipCode, City, Country, Maps, Phone, ContactEmail, Website, MinimumAmount, DeliveryFee, DeliveryActive, DateAdd, DateEdit, CreatedBy, EditedBy, WeekDay, OpeningTime, ClosingTime
FROM Restaurants
JOIN CategoriesRestaurants
ON Restaurants.Id = CategoriesRestaurants.RestaurantId
JOIN Categories
ON Categories.Id = CategoriesRestaurants.CategoryId
JOIN
OpeningRestaurants
ON Restaurants.Id = OpeningRestaurants.RestaurantId
GO
/****** Object:  Table [dbo].[CategoriesProducts]    Script Date: 29/03/2023 7:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoriesProducts](
	[Id] [int] NOT NULL,
	[RestaurantId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_CategoriesProducts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Coupons]    Script Date: 29/03/2023 7:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Coupons](
	[Id] [int] NOT NULL,
	[Code] [nvarchar](255) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[Discount] [int] NOT NULL,
	[MinimumPurchase] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
 CONSTRAINT [PK_Coupons] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 29/03/2023 7:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] NOT NULL,
	[RestaurantId] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Price] [decimal](10, 2) NOT NULL,
	[DiscountPrice] [decimal](10, 2) NULL,
	[IsDiscounted] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsAvailable] [bit] NOT NULL,
	[Category] [int] NOT NULL,
	[DateAdd] [datetime] NOT NULL,
	[DateEdit] [datetime] NULL,
	[CreatedBy] [int] NOT NULL,
	[EditedBy] [int] NULL,
	[Image] [nvarchar](max) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchasedProducts]    Script Date: 29/03/2023 7:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchasedProducts](
	[PurchaseId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_PurchasedProducts] PRIMARY KEY CLUSTERED 
(
	[PurchaseId] ASC,
	[ProductId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Purchases]    Script Date: 29/03/2023 7:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Purchases](
	[Id] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[RestaurantId] [int] NOT NULL,
	[Coupon] [int] NOT NULL,
	[ShippingFee] [decimal](10, 2) NULL,
	[TotalPrice] [decimal](10, 2) NOT NULL,
	[Status] [nvarchar](100) NOT NULL,
	[Delivery] [bit] NOT NULL,
	[RequestDate] [datetime] NOT NULL,
	[CompletedDate] [datetime] NULL,
	[Code] [nvarchar](255) NULL,
	[DeliveryAddress] [nvarchar](255) NULL,
	[DeliveryMethod] [nvarchar](50) NOT NULL,
	[Products] [nvarchar](250) NULL,
	[PaymentMethod] [nvarchar](50) NULL,
 CONSTRAINT [PK_Purchases] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 29/03/2023 7:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[EncryptedPassword] [varbinary](max) NOT NULL,
	[Salt] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Address] [nvarchar](255) NULL,
	[Rol] [nvarchar](50) NOT NULL,
	[Image] [nvarchar](50) NULL,
	[DateAdd] [datetime] NOT NULL,
	[DateEdit] [datetime] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wishlist]    Script Date: 29/03/2023 7:56:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wishlist](
	[Id] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[RestaurantId] [int] NOT NULL,
	[DateAdd] [nvarchar](255) NOT NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Categories] ([Id], [Name], [Image]) VALUES (1, N'Italiana', N'1-italian.png')
INSERT [dbo].[Categories] ([Id], [Name], [Image]) VALUES (2, N'Americana', N'2-american.png')
INSERT [dbo].[Categories] ([Id], [Name], [Image]) VALUES (3, N'Española', N'3-spanish.png')
INSERT [dbo].[Categories] ([Id], [Name], [Image]) VALUES (4, N'Mexicana', N'4-mexican.png')
INSERT [dbo].[Categories] ([Id], [Name], [Image]) VALUES (5, N'Japonesa', N'5-japanese.png')
INSERT [dbo].[Categories] ([Id], [Name], [Image]) VALUES (6, N'China', N'6-chinese.png')
INSERT [dbo].[Categories] ([Id], [Name], [Image]) VALUES (7, N'India', N'7-indian.png')
INSERT [dbo].[Categories] ([Id], [Name], [Image]) VALUES (8, N'Turca', N'8-turkish.png')
INSERT [dbo].[Categories] ([Id], [Name], [Image]) VALUES (9, N'Tailandesa', N'9-tailandese.png')
INSERT [dbo].[Categories] ([Id], [Name], [Image]) VALUES (10, N'Francesa', N'10-french.png')
INSERT [dbo].[Categories] ([Id], [Name], [Image]) VALUES (11, N'Alemana', N'11-german.png')
INSERT [dbo].[Categories] ([Id], [Name], [Image]) VALUES (12, N'Vietnamita', N'12-vietnamese.png')
INSERT [dbo].[Categories] ([Id], [Name], [Image]) VALUES (13, N'Vegana', N'13-vegan.png')
INSERT [dbo].[Categories] ([Id], [Name], [Image]) VALUES (14, N'Pescado', N'14-seafood.png')
INSERT [dbo].[Categories] ([Id], [Name], [Image]) VALUES (15, N'Griega', N'15-greek.png')
INSERT [dbo].[Categories] ([Id], [Name], [Image]) VALUES (16, N'Pizza', N'16-pizza.png')
INSERT [dbo].[Categories] ([Id], [Name], [Image]) VALUES (17, N'Hamburguesa', N'17-hamburger.png')
INSERT [dbo].[Categories] ([Id], [Name], [Image]) VALUES (18, N'Poke', N'18-poke.png')
INSERT [dbo].[Categories] ([Id], [Name], [Image]) VALUES (19, N'Desayuno', N'19-desayuno.png')
GO
INSERT [dbo].[CategoriesProducts] ([Id], [RestaurantId], [Name]) VALUES (1, 1, N'Promociones')
INSERT [dbo].[CategoriesProducts] ([Id], [RestaurantId], [Name]) VALUES (2, 1, N'Novedades')
INSERT [dbo].[CategoriesProducts] ([Id], [RestaurantId], [Name]) VALUES (3, 1, N'Menú Parrilla')
INSERT [dbo].[CategoriesProducts] ([Id], [RestaurantId], [Name]) VALUES (4, 1, N'Menú Pollo')
INSERT [dbo].[CategoriesProducts] ([Id], [RestaurantId], [Name]) VALUES (5, 1, N'100% vegetariano')
INSERT [dbo].[CategoriesProducts] ([Id], [RestaurantId], [Name]) VALUES (6, 1, N'King JR.')
INSERT [dbo].[CategoriesProducts] ([Id], [RestaurantId], [Name]) VALUES (7, 1, N'Entrantes')
INSERT [dbo].[CategoriesProducts] ([Id], [RestaurantId], [Name]) VALUES (8, 1, N'Sin gluten')
INSERT [dbo].[CategoriesProducts] ([Id], [RestaurantId], [Name]) VALUES (9, 1, N'Postres')
INSERT [dbo].[CategoriesProducts] ([Id], [RestaurantId], [Name]) VALUES (10, 1, N'Hamburguesas')
INSERT [dbo].[CategoriesProducts] ([Id], [RestaurantId], [Name]) VALUES (11, 1, N'Salsas')
INSERT [dbo].[CategoriesProducts] ([Id], [RestaurantId], [Name]) VALUES (12, 1, N'Bebidas')
INSERT [dbo].[CategoriesProducts] ([Id], [RestaurantId], [Name]) VALUES (13, 2, N'Entrantes')
INSERT [dbo].[CategoriesProducts] ([Id], [RestaurantId], [Name]) VALUES (14, 2, N'Pizzas clásicas')
INSERT [dbo].[CategoriesProducts] ([Id], [RestaurantId], [Name]) VALUES (15, 2, N'Bebidas')
INSERT [dbo].[CategoriesProducts] ([Id], [RestaurantId], [Name]) VALUES (16, 5, N'TOP VENTAS')
INSERT [dbo].[CategoriesProducts] ([Id], [RestaurantId], [Name]) VALUES (17, 5, N'COMPLEMENTOS')
INSERT [dbo].[CategoriesProducts] ([Id], [RestaurantId], [Name]) VALUES (18, 5, N'POSTRES')
INSERT [dbo].[CategoriesProducts] ([Id], [RestaurantId], [Name]) VALUES (19, 5, N'ENSALADAS')
GO
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (4, 1)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (6, 1)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (7, 1)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (8, 1)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (9, 1)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (10, 1)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (12, 1)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (1, 2)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (2, 2)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (4, 2)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (5, 2)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (7, 2)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (8, 2)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (9, 2)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (11, 2)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (12, 2)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (3, 3)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (7, 3)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (8, 3)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (10, 3)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (7, 4)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (8, 4)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (9, 4)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (10, 4)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (7, 5)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (8, 5)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (7, 6)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (8, 6)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (7, 7)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (8, 7)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (7, 8)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (8, 8)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (7, 9)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (8, 9)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (7, 10)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (8, 10)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (7, 11)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (8, 11)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (7, 12)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (8, 12)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (4, 13)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (6, 13)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (7, 13)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (8, 13)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (7, 14)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (8, 14)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (7, 15)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (8, 15)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (2, 16)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (5, 16)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (7, 16)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (8, 16)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (11, 16)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (12, 16)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (1, 17)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (4, 17)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (6, 17)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (7, 17)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (8, 17)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (4, 18)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (6, 18)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (7, 18)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (8, 18)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (10, 18)
INSERT [dbo].[CategoriesRestaurants] ([RestaurantId], [CategoryId]) VALUES (4, 19)
GO
INSERT [dbo].[Coupons] ([Id], [Code], [Type], [Discount], [MinimumPurchase], [StartDate], [EndDate]) VALUES (1, N'SAVEMORE2023', N'discount', 5, 20, CAST(N'2023-03-01' AS Date), CAST(N'2023-12-31' AS Date))
INSERT [dbo].[Coupons] ([Id], [Code], [Type], [Discount], [MinimumPurchase], [StartDate], [EndDate]) VALUES (2, N'LOVEPIZZA', N'percentage', 5, 15, CAST(N'2023-03-15' AS Date), CAST(N'2023-03-28' AS Date))
INSERT [dbo].[Coupons] ([Id], [Code], [Type], [Discount], [MinimumPurchase], [StartDate], [EndDate]) VALUES (3, N'MARCHDISCOUNT', N'percentage', 15, 15, CAST(N'2023-03-01' AS Date), CAST(N'2023-03-31' AS Date))
INSERT [dbo].[Coupons] ([Id], [Code], [Type], [Discount], [MinimumPurchase], [StartDate], [EndDate]) VALUES (4, N'FEBRUARYDISCOUNT', N'percentage', 15, 15, CAST(N'2023-02-01' AS Date), CAST(N'2023-02-28' AS Date))
INSERT [dbo].[Coupons] ([Id], [Code], [Type], [Discount], [MinimumPurchase], [StartDate], [EndDate]) VALUES (5, N'WEEKENDMARCH', N'discount', 10, 20, CAST(N'2023-03-24' AS Date), CAST(N'2023-03-26' AS Date))
GO
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (1, 1, CAST(N'13:00:00' AS Time), CAST(N'23:30:00' AS Time), 0, NULL, NULL)
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (2, 1, CAST(N'13:00:00' AS Time), CAST(N'23:30:00' AS Time), 0, NULL, NULL)
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (3, 1, CAST(N'13:00:00' AS Time), CAST(N'23:30:00' AS Time), 0, NULL, NULL)
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (4, 1, CAST(N'13:00:00' AS Time), CAST(N'23:30:00' AS Time), 0, NULL, NULL)
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (5, 1, CAST(N'13:00:00' AS Time), CAST(N'00:30:00' AS Time), 0, NULL, NULL)
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (6, 1, CAST(N'12:30:00' AS Time), CAST(N'00:30:00' AS Time), 0, NULL, NULL)
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (7, 1, CAST(N'12:30:00' AS Time), CAST(N'23:59:00' AS Time), 0, NULL, NULL)
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (8, 2, CAST(N'13:30:00' AS Time), CAST(N'15:30:00' AS Time), 1, CAST(N'20:00:00' AS Time), CAST(N'23:30:00' AS Time))
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (9, 2, CAST(N'13:30:00' AS Time), CAST(N'15:30:00' AS Time), 1, CAST(N'20:00:00' AS Time), CAST(N'23:30:00' AS Time))
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (10, 2, CAST(N'13:30:00' AS Time), CAST(N'15:30:00' AS Time), 1, CAST(N'20:00:00' AS Time), CAST(N'23:30:00' AS Time))
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (11, 2, CAST(N'13:30:00' AS Time), CAST(N'15:30:00' AS Time), 1, CAST(N'20:00:00' AS Time), CAST(N'23:30:00' AS Time))
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (12, 2, CAST(N'13:30:00' AS Time), CAST(N'15:30:00' AS Time), 0, NULL, NULL)
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (13, 2, CAST(N'13:30:00' AS Time), CAST(N'15:30:00' AS Time), 1, CAST(N'20:00:00' AS Time), CAST(N'23:30:00' AS Time))
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (14, 2, CAST(N'13:30:00' AS Time), CAST(N'15:30:00' AS Time), 1, CAST(N'20:00:00' AS Time), CAST(N'23:30:00' AS Time))
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (15, 3, CAST(N'13:00:00' AS Time), CAST(N'23:00:00' AS Time), 0, NULL, NULL)
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (16, 3, CAST(N'13:00:00' AS Time), CAST(N'23:00:00' AS Time), 0, NULL, NULL)
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (17, 3, CAST(N'13:00:00' AS Time), CAST(N'23:00:00' AS Time), 0, NULL, NULL)
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (18, 3, CAST(N'13:00:00' AS Time), CAST(N'23:00:00' AS Time), 0, NULL, NULL)
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (19, 3, CAST(N'13:00:00' AS Time), CAST(N'23:00:00' AS Time), 0, NULL, NULL)
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (20, 3, CAST(N'13:00:00' AS Time), CAST(N'23:00:00' AS Time), 0, NULL, NULL)
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (21, 3, CAST(N'13:00:00' AS Time), CAST(N'23:00:00' AS Time), 0, NULL, NULL)
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (22, 4, CAST(N'12:00:00' AS Time), CAST(N'23:30:00' AS Time), 0, NULL, NULL)
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (23, 4, CAST(N'12:00:00' AS Time), CAST(N'23:30:00' AS Time), 0, NULL, NULL)
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (24, 4, CAST(N'12:00:00' AS Time), CAST(N'23:30:00' AS Time), 0, NULL, NULL)
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (25, 4, CAST(N'12:00:00' AS Time), CAST(N'23:30:00' AS Time), 0, NULL, NULL)
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (26, 4, CAST(N'12:00:00' AS Time), CAST(N'00:30:00' AS Time), 0, NULL, NULL)
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (27, 4, CAST(N'12:00:00' AS Time), CAST(N'00:30:00' AS Time), 0, NULL, NULL)
INSERT [dbo].[OpeningRestaurants] ([RestaurantId], [WeekDay], [OpeningTime], [ClosingTime], [TwoTimes], [OpeningTime2], [ClosingTime2]) VALUES (28, 4, CAST(N'12:00:00' AS Time), CAST(N'23:30:00' AS Time), 0, NULL, NULL)
GO
INSERT [dbo].[Products] ([Id], [RestaurantId], [Name], [Description], [Price], [DiscountPrice], [IsDiscounted], [IsActive], [IsAvailable], [Category], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (1, 1, N'2x1: NUGGETS (x6) + NUGGETS (x6)', N'¿Salir o no salir de casa? Esa es la cuestión… Ahora con este 2x1 en Nuggets®, tendrás al menos dos deliciosas razones para quedarte en casita. Añádelo a tu pedido y disfruta el doble sin moverte del sofá.', CAST(3.75 AS Decimal(10, 2)), NULL, 0, 1, 1, 1, CAST(N'2023-03-21T19:52:06.320' AS DateTime), NULL, 1, NULL, N'1-nuggets.jpg')
INSERT [dbo].[Products] ([Id], [RestaurantId], [Name], [Description], [Price], [DiscountPrice], [IsDiscounted], [IsActive], [IsAvailable], [Category], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (2, 1, N'2x1 King Fries (Cheddar Bacon Cebolla)', NULL, CAST(4.45 AS Decimal(10, 2)), NULL, 0, 1, 1, 1, CAST(N'2023-03-21T20:07:40.320' AS DateTime), NULL, 1, NULL, N'2-kingfries.jpg')
INSERT [dbo].[Products] ([Id], [RestaurantId], [Name], [Description], [Price], [DiscountPrice], [IsDiscounted], [IsActive], [IsAvailable], [Category], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (3, 1, N'Menú Cheesy Doritos', N'Todo el sabor de Doritos®, a la parrilla: Dos piezas de un crujiente snack relleno de queso Doritos®, sobre dos jugosas hamburguesas a la parrilla, acompañado de lonchas de queso cheddar, salsa cheddar Doritos, pan de cheddar y tomate.', CAST(11.95 AS Decimal(10, 2)), NULL, 0, 1, 1, 2, CAST(N'2023-03-21T00:00:00.000' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [RestaurantId], [Name], [Description], [Price], [DiscountPrice], [IsDiscounted], [IsActive], [IsAvailable], [Category], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (4, 1, N'Menú Duo Bacon Cheddar Brioche', N'Las segundas partes no son buenas... son mejores! Porque tu Duo favorita, ahora tiene pan brioche. Y vuelve con todo: deliciosa salsa de queso cheddar, la estrella del show, acompañada de dos lonchas de bacon, dos lonchas de queso cheddar, cebolla frita y tomate. Súmale tu bebida y un complemento, todavía tienes dudas?


', CAST(11.45 AS Decimal(10, 2)), NULL, 0, 1, 1, 3, CAST(N'2023-03-21T00:00:00.000' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [RestaurantId], [Name], [Description], [Price], [DiscountPrice], [IsDiscounted], [IsActive], [IsAvailable], [Category], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (5, 1, N'Menú Cheesy Doritos Crispy Chicken®
', N'El sabor de Doritos®, el doble de crujiente: Dos piezas de un snack de queso Doritos® rebozado, sobre dos de nuestro mítico pollo Crispy, acompañado de lonchas de queso cheddar, salsa cheddar Doritos®, pan de cheddar y tomate.


', CAST(10.45 AS Decimal(10, 2)), NULL, 0, 1, 1, 4, CAST(N'2023-03-21T00:00:00.000' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [RestaurantId], [Name], [Description], [Price], [DiscountPrice], [IsDiscounted], [IsActive], [IsAvailable], [Category], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (6, 1, N'King Jr®
', NULL, CAST(4.95 AS Decimal(10, 2)), NULL, 0, 1, 1, 6, CAST(N'2023-03-21T00:00:00.000' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [RestaurantId], [Name], [Description], [Price], [DiscountPrice], [IsDiscounted], [IsActive], [IsAvailable], [Category], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (7, 2, N'Barbacoa', N'Masa fresca, Bacon, pollo, fundido para pizza, salsa barbacoa y doble de carne de vacuno.


', CAST(16.95 AS Decimal(10, 2)), NULL, 0, 1, 1, 14, CAST(N'2023-03-21T00:00:00.000' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [RestaurantId], [Name], [Description], [Price], [DiscountPrice], [IsDiscounted], [IsActive], [IsAvailable], [Category], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (8, 2, N'Pepperoni', NULL, CAST(17.95 AS Decimal(10, 2)), NULL, 0, 1, 1, 14, CAST(N'2023-03-21T00:00:00.000' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [RestaurantId], [Name], [Description], [Price], [DiscountPrice], [IsDiscounted], [IsActive], [IsAvailable], [Category], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (9, 2, N'Coca-Cola', NULL, CAST(2.95 AS Decimal(10, 2)), NULL, 0, 1, 1, 15, CAST(N'2023-03-21T00:00:00.000' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [RestaurantId], [Name], [Description], [Price], [DiscountPrice], [IsDiscounted], [IsActive], [IsAvailable], [Category], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (10, 2, N'Fanta', NULL, CAST(2.55 AS Decimal(10, 2)), NULL, 0, 1, 1, 15, CAST(N'2023-03-21T00:00:00.000' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [RestaurantId], [Name], [Description], [Price], [DiscountPrice], [IsDiscounted], [IsActive], [IsAvailable], [Category], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (11, 2, N'Red Bull', NULL, CAST(3.25 AS Decimal(10, 2)), NULL, 0, 1, 1, 15, CAST(N'2023-03-21T00:00:00.000' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [RestaurantId], [Name], [Description], [Price], [DiscountPrice], [IsDiscounted], [IsActive], [IsAvailable], [Category], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (12, 2, N'Pizzolinos Bacon
', NULL, CAST(4.95 AS Decimal(10, 2)), NULL, 0, 1, 1, 13, CAST(N'2023-03-21T00:00:00.000' AS DateTime), NULL, 1, NULL, N'12-pizzolinos.jpg')
INSERT [dbo].[Products] ([Id], [RestaurantId], [Name], [Description], [Price], [DiscountPrice], [IsDiscounted], [IsActive], [IsAvailable], [Category], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (13, 5, N'Menú McCrispy BBQ y Bacon
', N'Disfruta de nuestra nueva hamburguesa de pollo con deliciosas salsas BBQ y Bacon. Tan crujiente, Tan McCrispy, Tan McDonald''s.


', CAST(8.50 AS Decimal(10, 2)), CAST(7.50 AS Decimal(10, 2)), 1, 1, 1, 16, CAST(N'2023-03-21T00:00:00.000' AS DateTime), NULL, 1, NULL, N'13-mccrispy.jpg')
INSERT [dbo].[Products] ([Id], [RestaurantId], [Name], [Description], [Price], [DiscountPrice], [IsDiscounted], [IsActive], [IsAvailable], [Category], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (14, 5, N'McMenú® Big Mac®
', N'Carne, pepinillos, lechuga, cebolla y queso fundido


', CAST(9.50 AS Decimal(10, 2)), CAST(9.00 AS Decimal(10, 2)), 1, 1, 1, 16, CAST(N'2023-03-21T00:00:00.000' AS DateTime), NULL, 1, NULL, N'14-bigmac.jpg')
INSERT [dbo].[Products] ([Id], [RestaurantId], [Name], [Description], [Price], [DiscountPrice], [IsDiscounted], [IsActive], [IsAvailable], [Category], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (15, 5, N'Top Fries Bacon & Cheese para Compartir
', N'Patatas con salsa de queso y bacon


', CAST(5.50 AS Decimal(10, 2)), CAST(4.50 AS Decimal(10, 2)), 1, 1, 1, 17, CAST(N'2023-03-21T00:00:00.000' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [RestaurantId], [Name], [Description], [Price], [DiscountPrice], [IsDiscounted], [IsActive], [IsAvailable], [Category], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (16, 5, N'Mini McFlurry® M&M''s® Cacahuete
', N'¡Ha vuelto! Disfruta de nuestro delicioso McFlurry con trocitos de M&M''s rellenos de chocolate con leche y cacahuete tostado


', CAST(2.80 AS Decimal(10, 2)), NULL, 0, 1, 0, 18, CAST(N'2023-03-21T00:00:00.000' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [RestaurantId], [Name], [Description], [Price], [DiscountPrice], [IsDiscounted], [IsActive], [IsAvailable], [Category], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (17, 5, N'McCrispy Honey Mustard
', NULL, CAST(6.50 AS Decimal(10, 2)), NULL, 0, 1, 0, 19, CAST(N'2023-03-21T00:00:00.000' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [RestaurantId], [Name], [Description], [Price], [DiscountPrice], [IsDiscounted], [IsActive], [IsAvailable], [Category], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (18, 1, N'Patatas Clásicas', N'Las famosas patatas fritas de las que tanto has oído hablar, si estás son, las mejores.', CAST(3.25 AS Decimal(10, 2)), CAST(2.50 AS Decimal(10, 2)), 1, 1, 0, 7, CAST(N'2023-03-21T00:00:00.000' AS DateTime), NULL, 1, NULL, N'18-patatas.png')
GO
INSERT [dbo].[Purchases] ([Id], [UserId], [RestaurantId], [Coupon], [ShippingFee], [TotalPrice], [Status], [Delivery], [RequestDate], [CompletedDate], [Code], [DeliveryAddress], [DeliveryMethod], [Products], [PaymentMethod]) VALUES (1, 2, 5, 0, NULL, CAST(11.00 AS Decimal(10, 2)), N'Pending', 1, CAST(N'2023-03-27T19:09:19.790' AS DateTime), NULL, NULL, N'asd', N'Delivery', N'15,17', N'Tarjeta de crédito')
GO
INSERT [dbo].[Restaurants] ([Id], [Name], [Description], [Address], [ZipCode], [City], [Country], [Maps], [Phone], [ContactEmail], [Website], [MinimumAmount], [DeliveryFee], [DeliveryActive], [DeliveryMinTime], [DeliveryMaxTime], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (1, N'Burger King - Carretas 8', N'Cadena de restaurantes de comida rápida especializada en hamburguesas', N'Calle de Carretas, 8', N'28012', N'Madrid', N'España', N'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3037.693923518037!2d-3.7077856676710916!3d40.41563086992652!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd42287e2c4217ad%3A0xb2de4c140dc1afb0!2sBurger%20King!5e0!3m2!1ses!2ses!4v1679046502982!5m2!1ses!2ses', N'918526745', NULL, N'https://www.burgerking.es', CAST(10.00 AS Decimal(10, 2)), CAST(3.50 AS Decimal(10, 2)), 1, 15, 30, CAST(N'2023-03-17T10:56:25.583' AS DateTime), NULL, 1, NULL, N'1-burgerking.jpg')
INSERT [dbo].[Restaurants] ([Id], [Name], [Description], [Address], [ZipCode], [City], [Country], [Maps], [Phone], [ContactEmail], [Website], [MinimumAmount], [DeliveryFee], [DeliveryActive], [DeliveryMinTime], [DeliveryMaxTime], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (2, N'Telepizza Quevedo', N'Telepizza es una cadena de pizzerías originaria de España.', N'Calle de Bravo Murillo, 8', N'28015', N'Madrid', N'España', N'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d6074.079508401749!2d-3.7107616696252568!3d40.43011861112616!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd42285f95506f4d%3A0xe2b17097e97a5e40!2sTelepizza%20Quevedo%20-%20Comida%20a%20Domicilio!5e0!3m2!1ses!2ses!4v1679048608050!5m2!1ses!2ses', N'915934413', N'atencionalcliente@telepizza.com', N'https://www.telepizza.es/', CAST(10.00 AS Decimal(10, 2)), CAST(2.50 AS Decimal(10, 2)), 1, 20, 40, CAST(N'2023-03-17T12:45:16.277' AS DateTime), NULL, 1, NULL, N'2-telepizza.jpg')
INSERT [dbo].[Restaurants] ([Id], [Name], [Description], [Address], [ZipCode], [City], [Country], [Maps], [Phone], [ContactEmail], [Website], [MinimumAmount], [DeliveryFee], [DeliveryActive], [DeliveryMinTime], [DeliveryMaxTime], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (3, N'100 Montaditos - Narváez 49', N'100 Montaditos es una franquicia española de bocadillos y cervezas.', N'Calle de Narváez, 49', N'28009', N'Madrid', N'España', N'https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d14448.199640472127!2d-3.709203012629176!3d40.4230306978482!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1s100%20Montaditos!5e0!3m2!1ses!2ses!4v1679049513026!5m2!1ses!2ses', N'910742848', N'attcliente@gruporestalia.com', N'https://spain.100montaditos.com/es', CAST(5.00 AS Decimal(10, 2)), CAST(1.50 AS Decimal(10, 2)), 1, 30, 40, CAST(N'2023-03-17T12:45:16.277' AS DateTime), NULL, 1, NULL, N'3-100-montaditos.jpg')
INSERT [dbo].[Restaurants] ([Id], [Name], [Description], [Address], [ZipCode], [City], [Country], [Maps], [Phone], [ContactEmail], [Website], [MinimumAmount], [DeliveryFee], [DeliveryActive], [DeliveryMinTime], [DeliveryMaxTime], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (4, N'VIPS - Cartagena 18', N'Cadena de restaurantes de comida internacional.', N'Calle del Conde de Cartagena, 18', N'28007', N'Madrid', N'España', N'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d12151.250880310763!2d-3.7094175904283913!3d40.4129994475957!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd42261b696bbd6b%3A0x5383304c4f717fc6!2sVIPS!5e0!3m2!1ses!2ses!4v1679054633525!5m2!1ses!2ses', N'638589057', NULL, N'https://www.vips.es/', CAST(10.00 AS Decimal(10, 2)), CAST(3.50 AS Decimal(10, 2)), 1, 25, 40, CAST(N'2023-03-17T13:06:29.710' AS DateTime), NULL, 1, NULL, N'4-vips.jpg')
INSERT [dbo].[Restaurants] ([Id], [Name], [Description], [Address], [ZipCode], [City], [Country], [Maps], [Phone], [ContactEmail], [Website], [MinimumAmount], [DeliveryFee], [DeliveryActive], [DeliveryMinTime], [DeliveryMaxTime], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (5, N'McDonalds', N'Restaurante de comida rápida', N'Paseo de la Castellana, 140', N'28046', N'Madrid', N'España', N'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d48637.37819420865!2d-3.83576804179689!3d40.36815760000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd4189b51093999d%3A0xd852665aa1c988a4!2sMcDonald&#39;s!5e0!3m2!1ses!2ses!4v1680047175275!5m2!1ses!2ses', N'+34 915 63 34 58', N'contacto@mcdonalds.es', N'https://www.mcdonalds.es/', CAST(10.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), 1, 10, 30, CAST(N'2023-03-27T09:20:53.523' AS DateTime), NULL, 1, NULL, N'5-mcdonalds.jpg')
INSERT [dbo].[Restaurants] ([Id], [Name], [Description], [Address], [ZipCode], [City], [Country], [Maps], [Phone], [ContactEmail], [Website], [MinimumAmount], [DeliveryFee], [DeliveryActive], [DeliveryMinTime], [DeliveryMaxTime], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (6, N'Goiko Grill', N'Hamburguesas gourmet con ingredientes de alta calidad', N'Calle de Fuencarral, 95', N'28004', N'Madrid', N'España', N'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d48601.60779731671!2d-3.7792647227395615!3d40.41770044350216!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd422857e0ee40db%3A0x4c56ae047b90f595!2sGoiko!5e0!3m2!1ses!2ses!4v1679936498430!5m2!1ses!2ses', N'+34 914 45 75 34', N'info@goikogrill.com', N'https://goikogrill.com/', CAST(10.00 AS Decimal(10, 2)), CAST(3.00 AS Decimal(10, 2)), 1, 20, 40, CAST(N'2023-03-27T09:22:23.013' AS DateTime), CAST(N'1900-01-02T00:00:00.000' AS DateTime), 1, NULL, N'6-goikogrill.jpg')
INSERT [dbo].[Restaurants] ([Id], [Name], [Description], [Address], [ZipCode], [City], [Country], [Maps], [Phone], [ContactEmail], [Website], [MinimumAmount], [DeliveryFee], [DeliveryActive], [DeliveryMinTime], [DeliveryMaxTime], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (7, N'DiverXO', N'Restaurante de alta cocina creativa', N'Calle del Padre Damián, 23', N'28036', N'Madrid', N'España', N'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3035.7848267551926!2d-3.6879651848555364!3d40.457899179360325!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd422903801a427d%3A0x979c36aff4f18245!2sRestaurante%20DiverXO!5e0!3m2!1ses!2ses!4v1679936524253!5m2!1ses!2ses', N'+34 915 70 07 66', N'info@diverxo.com', N'https://www.diverxo.com/', CAST(100.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(10, 2)), 1, 60, 120, CAST(N'2023-03-27T09:23:30.740' AS DateTime), NULL, 1, NULL, N'7-DiverXO.jpg')
INSERT [dbo].[Restaurants] ([Id], [Name], [Description], [Address], [ZipCode], [City], [Country], [Maps], [Phone], [ContactEmail], [Website], [MinimumAmount], [DeliveryFee], [DeliveryActive], [DeliveryMinTime], [DeliveryMaxTime], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (8, N'Santceloni', N'Restaurante de alta cocina tradicional', N'Calle de Zurbano, 5', N'28010', N'Madrid', N'España', N'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3036.6450399566243!2d-3.693701584856169!3d40.43885817936261!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd4228ee0b4f1111%3A0x5b3c83c54c1f4644!2sRestaurante%20Santceloni!5e0!3m2!1ses!2ses!4v1679936542493!5m2!1ses!2ses', N'+34 912 10 88 40', N'info@santceloni.com', N'https://www.restaurantesantceloni.com/', CAST(80.00 AS Decimal(10, 2)), CAST(8.00 AS Decimal(10, 2)), 1, 45, 90, CAST(N'2023-03-27T09:24:20.710' AS DateTime), NULL, 1, NULL, N'8-santceloni.jpg')
INSERT [dbo].[Restaurants] ([Id], [Name], [Description], [Address], [ZipCode], [City], [Country], [Maps], [Phone], [ContactEmail], [Website], [MinimumAmount], [DeliveryFee], [DeliveryActive], [DeliveryMinTime], [DeliveryMaxTime], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (9, N'Taco Bell', N'Restaurante de comida rápida especializado en comida mexicana como burritos, tacos y nachos.', N'Calle de Fuencarral, 98', N'28004', N'Madrid', N'España', N'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d24289.847701270424!2d-3.7386506795883063!3d40.44802479390568!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd42291b3eea9e9f%3A0xe05ca647621e66b5!2sTaco%20Bell!5e0!3m2!1ses!2ses!4v1679936568027!5m2!1ses!2ses', N'+34 912 17 48 06', N'info@tacobell.es', N'https://www.tacobell.es/', CAST(10.00 AS Decimal(10, 2)), CAST(2.50 AS Decimal(10, 2)), 1, 30, 45, CAST(N'2023-03-27T09:32:34.347' AS DateTime), NULL, 1, NULL, N'9-tacobell.jpg')
INSERT [dbo].[Restaurants] ([Id], [Name], [Description], [Address], [ZipCode], [City], [Country], [Maps], [Phone], [ContactEmail], [Website], [MinimumAmount], [DeliveryFee], [DeliveryActive], [DeliveryMinTime], [DeliveryMaxTime], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (10, N'Subway', N'Franquicia de restauración rápida especializada en la elaboración de bocadillos y ensaladas personalizables.', N'Calle de Alcalá, 219', N'28027', N'Madrid', N'España', N'https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d29099.38691221565!2d-3.718116789548801!3d40.43783681386162!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1sSubway!5e0!3m2!1ses!2ses!4v1679936594508!5m2!1ses!2ses', N'+34 913 77 22 95', N'info@subway.es', N'https://www.subway.es/', CAST(8.00 AS Decimal(10, 2)), CAST(2.99 AS Decimal(10, 2)), 1, 20, 35, CAST(N'2023-03-27T09:32:50.630' AS DateTime), NULL, 1, NULL, N'10-subway.jpg')
INSERT [dbo].[Restaurants] ([Id], [Name], [Description], [Address], [ZipCode], [City], [Country], [Maps], [Phone], [ContactEmail], [Website], [MinimumAmount], [DeliveryFee], [DeliveryActive], [DeliveryMinTime], [DeliveryMaxTime], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (11, N'KFC', N'Restaurante de comida rápida especializado en pollo frito, hamburguesas, ensaladas y complementos.', N'Calle de Alcalá, 224', N'28027', N'Madrid', N'España', N'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d48587.06150063799!2d-3.718116801829365!3d40.43783302370209!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd422f173ab8134f%3A0x4c895d897ba2e5a6!2sRestaurante%20KFC!5e0!3m2!1ses!2ses!4v1679936623127!5m2!1ses!2ses', N'+34 910 02 51 11', N'info@kfc.es', N'https://www.kfc.es/', CAST(12.00 AS Decimal(10, 2)), CAST(3.50 AS Decimal(10, 2)), 1, 25, 40, CAST(N'2023-03-27T09:32:59.703' AS DateTime), NULL, 1, NULL, N'11-kfc.jpg')
INSERT [dbo].[Restaurants] ([Id], [Name], [Description], [Address], [ZipCode], [City], [Country], [Maps], [Phone], [ContactEmail], [Website], [MinimumAmount], [DeliveryFee], [DeliveryActive], [DeliveryMinTime], [DeliveryMaxTime], [DateAdd], [DateEdit], [CreatedBy], [EditedBy], [Image]) VALUES (12, N'Pizza Hut', N'Cadena de restaurantes de comida rápida especializados en pizza.', N'Calle de Orense, 11', N'28020', N'Madrid', N'España', N'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d48587.069136871716!2d-3.718116836066891!3d40.43782245706702!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd4229aa5a1e1de5%3A0x451826df670e6558!2sPizza%20Hut!5e0!3m2!1ses!2ses!4v1679936675416!5m2!1ses!2ses', N'+34 914 02 71 17', N'info@pizzahut.es', N'https://www.pizzahut.es/', CAST(15.00 AS Decimal(10, 2)), CAST(4.00 AS Decimal(10, 2)), 0, 30, 50, CAST(N'2023-03-27T09:33:03.873' AS DateTime), NULL, 1, NULL, N'12-pizzahut.jpg')
GO
INSERT [dbo].[Users] ([Id], [Password], [EncryptedPassword], [Salt], [Email], [Name], [Address], [Rol], [Image], [DateAdd], [DateEdit]) VALUES (1, N'asd', 0xCA89A19B836BD91354EA0EEFFB5E5EF5C38844375BD45247EBCEDB3905334A2E538B3DDEA5FC809F4645B2FC9C005CEB48FE5ABCAF40DB705887982E8A2E437A, N'dx2¨­''`ë§ûÇu]óßd£Qö{,øî¯	AÑ§"$]ª¯', N'prueba@gmail.com', N'asd', NULL, N'admin', N'0-user.png', CAST(N'2023-03-27T05:20:44.960' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [Password], [EncryptedPassword], [Salt], [Email], [Name], [Address], [Rol], [Image], [DateAdd], [DateEdit]) VALUES (2, N'prueba', 0xEB74387EF29080CDB68F8CE7ACD8BC92055DC43FF2D9DD844F404E49A1ADFF5374F412A9BB92F03EBCD1495CBCD0D3A5DAAD4FA8FC68A41B1EC118827351F23D, N'/$±:FÍ¤.§:óíÝ¥aßo×ö	éûT$|~=I2½¹ÞYý', N'prueba@g.es', N'prueba', NULL, N'user', N'0-user.png', CAST(N'2023-03-27T11:04:28.937' AS DateTime), NULL)
GO
ALTER TABLE [dbo].[CategoriesRestaurants]  WITH CHECK ADD  CONSTRAINT [FK_CategoriesRestaurant_Categories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[CategoriesRestaurants] CHECK CONSTRAINT [FK_CategoriesRestaurant_Categories]
GO
ALTER TABLE [dbo].[PurchasedProducts]  WITH CHECK ADD  CONSTRAINT [FK_PurchasedProducts_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[PurchasedProducts] CHECK CONSTRAINT [FK_PurchasedProducts_Products]
GO
ALTER TABLE [dbo].[PurchasedProducts]  WITH CHECK ADD  CONSTRAINT [FK_PurchasedProducts_Purchases] FOREIGN KEY([PurchaseId])
REFERENCES [dbo].[Purchases] ([Id])
GO
ALTER TABLE [dbo].[PurchasedProducts] CHECK CONSTRAINT [FK_PurchasedProducts_Purchases]
GO
ALTER TABLE [dbo].[Purchases]  WITH CHECK ADD  CONSTRAINT [FK_Purchases_Restaurant] FOREIGN KEY([RestaurantId])
REFERENCES [dbo].[Restaurants] ([Id])
GO
ALTER TABLE [dbo].[Purchases] CHECK CONSTRAINT [FK_Purchases_Restaurant]
GO
ALTER TABLE [dbo].[Purchases]  WITH CHECK ADD  CONSTRAINT [FK_Purchases_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Purchases] CHECK CONSTRAINT [FK_Purchases_Users]
GO
ALTER TABLE [dbo].[Wishlist]  WITH CHECK ADD  CONSTRAINT [FK_Wishlist_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Wishlist] CHECK CONSTRAINT [FK_Wishlist_Users]
GO
/****** Object:  StoredProcedure [dbo].[SP_EMP_DEPT]    Script Date: 29/03/2023 7:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_EMP_DEPT]
(@DEPARTAMENTO NVARCHAR(50))
AS
    select EMP.APELLIDO, EMP.OFICIO, EMP.SALARIO
    , DEPT.DNOMBRE AS DEPARTAMENTO
    , DEPT.LOC AS LOCALIDAD
    FROM EMP
    INNER JOIN DEPT
    ON EMP.DEPT_NO = DEPT.DEPT_NO
    WHERE DEPT.DNOMBRE = @DEPARTAMENTO

GO
/****** Object:  StoredProcedure [dbo].[SP_INCREMENTO_SALARIO_EMP]    Script Date: 29/03/2023 7:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_INCREMENTO_SALARIO_EMP]
(@APELLIDO NVARCHAR(30), @INCREMENTO INT)
AS
	update EMP SET SALARIO = SALARIO + @INCREMENTO
	WHERE APELLIDO = @APELLIDO
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Coupons'
GO
ALTER DATABASE [xyzdb] SET  READ_WRITE 
GO
