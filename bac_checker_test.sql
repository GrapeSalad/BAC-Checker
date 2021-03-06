USE [master]
GO
/****** Object:  Database [bac_checker_test]    Script Date: 6/22/2017 3:03:59 PM ******/
CREATE DATABASE [bac_checker_test]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'bac_checker', FILENAME = N'C:\Users\epicodus\bac_checker_test.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'bac_checker_log', FILENAME = N'C:\Users\epicodus\bac_checker_test_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [bac_checker_test] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [bac_checker_test].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [bac_checker_test] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [bac_checker_test] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [bac_checker_test] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [bac_checker_test] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [bac_checker_test] SET ARITHABORT OFF 
GO
ALTER DATABASE [bac_checker_test] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [bac_checker_test] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [bac_checker_test] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [bac_checker_test] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [bac_checker_test] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [bac_checker_test] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [bac_checker_test] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [bac_checker_test] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [bac_checker_test] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [bac_checker_test] SET  DISABLE_BROKER 
GO
ALTER DATABASE [bac_checker_test] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [bac_checker_test] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [bac_checker_test] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [bac_checker_test] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [bac_checker_test] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [bac_checker_test] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [bac_checker_test] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [bac_checker_test] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [bac_checker_test] SET  MULTI_USER 
GO
ALTER DATABASE [bac_checker_test] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [bac_checker_test] SET DB_CHAINING OFF 
GO
ALTER DATABASE [bac_checker_test] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [bac_checker_test] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [bac_checker_test] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [bac_checker_test] SET QUERY_STORE = OFF
GO
USE [bac_checker_test]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [bac_checker_test]
GO
/****** Object:  Table [dbo].[bartenders]    Script Date: 6/22/2017 3:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bartenders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[drinks]    Script Date: 6/22/2017 3:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[drinks](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[drink_type] [varchar](50) NULL,
	[abv] [decimal](3, 1) NULL,
	[cost] [decimal](4, 2) NULL,
	[instances] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[foods]    Script Date: 6/22/2017 3:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[foods](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[food_type] [varchar](50) NULL,
	[description] [text] NULL,
	[cost] [decimal](4, 2) NULL,
	[bac_removal] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[orders]    Script Date: 6/22/2017 3:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[patrons_id] [int] NULL,
	[drinks_id] [int] NULL,
	[foods_id] [int] NULL,
	[bartenders_id] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[patrons]    Script Date: 6/22/2017 3:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[patrons](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NULL,
	[gender] [varchar](25) NULL,
	[weight] [int] NULL,
	[height] [int] NULL,
	[bmi] [decimal](4, 2) NULL
) ON [PRIMARY]

GO
USE [master]
GO
ALTER DATABASE [bac_checker_test] SET  READ_WRITE 
GO
