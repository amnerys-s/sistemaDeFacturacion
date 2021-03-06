USE [master]
GO
/****** Object:  Database [LAREAL]    Script Date: 7/19/2020 1:13:58 PM ******/
CREATE DATABASE [LAREAL]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LAREAL', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\LAREAL.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'LAREAL_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\LAREAL_log.ldf' , SIZE = 1040KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [LAREAL] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LAREAL].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LAREAL] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LAREAL] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LAREAL] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LAREAL] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LAREAL] SET ARITHABORT OFF 
GO
ALTER DATABASE [LAREAL] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [LAREAL] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [LAREAL] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LAREAL] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LAREAL] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LAREAL] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LAREAL] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LAREAL] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LAREAL] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LAREAL] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LAREAL] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LAREAL] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LAREAL] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LAREAL] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LAREAL] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LAREAL] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LAREAL] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LAREAL] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LAREAL] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [LAREAL] SET  MULTI_USER 
GO
ALTER DATABASE [LAREAL] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LAREAL] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LAREAL] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LAREAL] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [LAREAL]
GO
/****** Object:  StoredProcedure [dbo].[Cliente_identificador]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Cliente_identificador]
@Identificador int
as
Begin
select f.Id_factura , D.Det_Fa, c.Id_Cliente,(c.Nombre+' '+c.Apellido) AS cliente, F.Fecha, P.Articulo,D.Cantidad, P.Precio_U, d.Precio_T
from Clientes c inner join Factura F ON C.Id_Cliente= F.Id_Cliente INNER JOIN Detalles_Fac d
on f.Id_factura = d.Id_Factura
inner join Producto p on p.ID_Pro = d.Id_Producto 
where  c.Id_Cliente = @Identificador and C.ESTADO = 'ACTIVADO'
end
GO
/****** Object:  StoredProcedure [dbo].[clientes_desactivados]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[clientes_desactivados]
@Identificador int
as
Begin
select f.Id_factura , D.Det_Fa, c.Id_Cliente,(c.Nombre+' '+c.Apellido) AS cliente, F.Fecha, P.Articulo,D.Cantidad, P.Precio_U, d.Precio_T
from Clientes c inner join Factura F ON C.Id_Cliente= F.Id_Cliente INNER JOIN Detalles_Fac d
on f.Id_factura = d.Id_Factura
inner join Producto p on p.ID_Pro = d.Id_Producto 
where  c.Id_Cliente = @Identificador and C.ESTADO = 'DESACTIVADO'
end
GO
/****** Object:  StoredProcedure [dbo].[clientes_general]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[clientes_general] 
as
select  c.Id_Cliente, C.Nombre, C.Apellido, C.Telefono, c.Cedula
from Clientes c where c.ESTADO = 'ACTIVADO' 

GO
/****** Object:  StoredProcedure [dbo].[Clientes_REPORGENERAL]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Clientes_REPORGENERAL]
as
select Id_Cliente as Identificador,(c.Nombre +' '+ c.Apellido) as Cliente,c.Cedula, c.Telefono
from Clientes c 
GO
/****** Object:  StoredProcedure [dbo].[Compras_especi]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Compras_especi]
@fecha1 date,
@fecha2 date
 as
 BEGIN
Select x.ID_Compras,u.Det_Com, x.Fecha,u.Cantidad , po.Articulo, l.Empresa, po.Precio_U, u.Precio_T
from Compras x  inner join Detalles_Com u ON x.ID_Compras  = u.Id_Compras inner join Producto po on po.ID_Pro =  u.Id_Producto inner join Proveedor l on x.Id_Proveedor = l.Id_Proveedor 

where x.Fecha between @fecha1 and @fecha2
 END
GO
/****** Object:  StoredProcedure [dbo].[Compras_general]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Compras_general]
as
select c.ID_Compras, c.Fecha,pro.Empresa, p.Articulo, dc.Precio_U, dc.Cantidad, dc.Precio_T
from Compras c inner join Detalles_Com  dc on c.ID_Compras = dc.Id_Compras inner join Producto p on 
p.ID_Pro =dc.Id_Producto  inner join Proveedor pro on pro.Id_Proveedor = p.Id_Proveedor

GO
/****** Object:  StoredProcedure [dbo].[comprasge]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[comprasge]
as
select c.ID_Compras, dc.Det_Com, c.Fecha,pro.Empresa, p.Articulo, dc.Precio_U, dc.Cantidad, dc.Precio_T
from Compras c inner join Detalles_Com  dc on c.ID_Compras = dc.Id_Compras inner join Producto p on 
p.ID_Pro =dc.Id_Producto  inner join Proveedor pro on pro.Id_Proveedor = p.Id_Proveedor
where pro.ESTADO = 'ACTIVADO' and p.ESTADO = 'ACTIVADO'
GO
/****** Object:  StoredProcedure [dbo].[Factura_fecha]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Factura_fecha]
@fecha1 date,
@fecha2 date
 as
 begin

Select f.Id_factura,d.Det_Fa,f.Fecha,(c.Nombre +' '+ c.Apellido) as CLiente, d.Cantidad, o.Articulo, d.Precio_U, d.Precio_T
 from Factura f inner join Detalles_Fac d  ON f.Id_factura  = d.Id_Factura inner join Producto o on 
 o.ID_Pro = d.Id_Producto inner join Clientes c on c.Id_Cliente= f.Id_Cliente
 where f.Fecha between @fecha1 and @fecha2

 end
GO
/****** Object:  StoredProcedure [dbo].[factura_general]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[factura_general]
as
select (c.Nombre +' '+ c.Apellido) as cliente, f.Fecha, df.Det_Fa, f.Id_factura,df.Precio_U, df.Precio_T, df.Cantidad, p.Articulo, sum(df.Precio_T) as Ganancias
from Detalles_Fac df inner join Factura f on f.Id_factura = df.Id_Factura inner join Producto p
on p.ID_Pro = df.Id_Producto inner join Clientes c on c.Id_Cliente = f.Id_Cliente
where c.ESTADO = 'ACTIVADO' and p.ESTADO = 'ACTIVADO'
group by  (c.Nombre +' '+ c.Apellido), f.Fecha,  df.Det_Fa, f.Id_factura,df.Precio_U, df.Precio_T, df.Cantidad, p.Articulo

GO
/****** Object:  StoredProcedure [dbo].[FACTURA_general_REPORT]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[FACTURA_general_REPORT]
as
select dF.Det_Fa, F.Fecha, (C.Nombre+' '+ C.Apellido) AS Cliente, p.Articulo, df.Precio_U, df.Cantidad, df.Precio_T
from Clientes c inner join Factura f on c.Id_Cliente = f.Id_Cliente inner join Detalles_Fac df on df.Id_Factura
= f.Id_factura inner join Producto p  on p.ID_Pro = DF.Id_Producto
GO
/****** Object:  StoredProcedure [dbo].[HOLA]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[HOLA]
@id int
as
select  c.ID_Compras,di.Det_Com, c.Fecha,u.Empresa, g.Articulo, di.Cantidad,di.Precio_T, di.Precio_U
from Compras c inner join Detalles_Com di on c.ID_Compras = di.Det_Com  inner join Proveedor u on c.Id_Proveedor =
u.Id_Proveedor inner join Producto g on g.ID_Pro = di.Id_Producto 
WHERE g.ID_Pro = @id and g.ESTADO = 'ACTIVADO'
GO
/****** Object:  StoredProcedure [dbo].[identificador_nombre]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[identificador_nombre]
@nombre varchar(30)
as
select  c.ID_Compras, c.Fecha,u.Id_Proveedor,u.Empresa, g.Articulo, di.Cantidad
from Compras c inner join Detalles_Com di on c.ID_Compras = di.Det_Com  inner join Proveedor u on c.Id_Proveedor =
u.Id_Proveedor inner join Producto g on g.ID_Pro = di.Id_Producto
WHERE u.Empresa = @nombre 
GO
/****** Object:  StoredProcedure [dbo].[PRODUCS_GENERAL]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PRODUCS_GENERAL]
as
select p.ID_Pro, p.Articulo, p.Precio_U, p.Cantidad, pro.Empresa as Proveedor
from Producto p inner join Proveedor pro on p.Id_Proveedor = pro.Id_Proveedor where P.ESTADO = 'ACTIVADO'
GO
/****** Object:  StoredProcedure [dbo].[producto_compras]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[producto_compras]
--@id int
as
select  c.ID_Compras, c.Fecha,u.Id_Proveedor,u.Empresa, g.Articulo,g.ID_Pro, di.Cantidad,di.Precio_T, di.Precio_U
from Compras c inner join Proveedor u on c.Id_Proveedor =
u.Id_Proveedor inner join Detalles_Com di on c.ID_Compras = di.Det_Com   inner join Producto g on g.ID_Pro = di.Id_Producto
--WHERE g.ID_Pro = @id and 
where g.ESTADO = 'DESACTIVADO'

GO
/****** Object:  StoredProcedure [dbo].[PRODUCTO_ESPECIFICO_ACTIVADO]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PRODUCTO_ESPECIFICO_ACTIVADO]
@ID INT
as
begin
select  c.ID_Compras,di.Det_Com, c.Fecha, u.Empresa, g.Articulo, di.Cantidad,di.Precio_T, di.Precio_U
from Compras c inner join Detalles_Com di on c.ID_Compras = DI.Id_Compras  inner join Proveedor u on c.Id_Proveedor =
u.Id_Proveedor inner join Producto g on g.ID_Pro = di.Id_Producto
where g.ID_Pro = @ID and g.ESTADO = 'DESACTIVADO'
end
GO
/****** Object:  StoredProcedure [dbo].[PRODUCTO_ESPECIFICO_DESACTIVADO]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[PRODUCTO_ESPECIFICO_DESACTIVADO]
@ID INT
as
begin
select  c.ID_Compras,di.Det_Com, c.Fecha, u.Empresa, g.Articulo, di.Cantidad,di.Precio_T, di.Precio_U
from Compras c inner join Detalles_Com di on c.ID_Compras = DI.Id_Compras  inner join Proveedor u on c.Id_Proveedor =
u.Id_Proveedor inner join Producto g on g.ID_Pro = di.Id_Producto
where g.ID_Pro = @ID and g.ESTADO = 'ACTIVADO'
end
GO
/****** Object:  StoredProcedure [dbo].[Producto_especifico_Identificador]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Producto_especifico_Identificador]
@identificador int
as
select f.Fecha, f.Id_factura, DF.Det_Fa, DF.Id_Producto,c.Id_Cliente,(c.Nombre+' '+c.Apellido), pro.Articulo, df.Cantidad, df.Precio_U, df.Precio_T
from factura  f inner join Detalles_Fac df on f.Id_factura = df.Det_Fa inner join Clientes c on f.Id_Cliente = c.Id_Cliente inner join Producto pro on pro.ID_Pro 
= df.Id_Producto where df.Id_Producto = @identificador and pro.ESTADO = 'ACTIVADO'
GO
/****** Object:  StoredProcedure [dbo].[Producto_especifico_Nombre]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Producto_especifico_Nombre]
@Nombre varchar(25)
as
select f.Id_factura, f.Fecha,d.Id_Producto, p.Articulo, d.Cantidad, d.Precio_T,  d.Precio_U
from Factura f inner join Detalles_Fac d  on f.Id_factura = d.Id_Factura inner join Producto p  on p.ID_Pro = d.Id_Producto
where p.Articulo = @Nombre 
GO
/****** Object:  StoredProcedure [dbo].[producto_f_desactivado]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[producto_f_desactivado]
@identificador int
as
select f.Fecha, f.Id_factura, DF.Det_Fa, DF.Id_Producto,c.Id_Cliente,(c.Nombre+' '+c.Apellido), pro.Articulo, df.Cantidad, df.Precio_U, df.Precio_T
from factura  f inner join Detalles_Fac df on f.Id_factura = df.Det_Fa inner join Clientes c on f.Id_Cliente = c.Id_Cliente inner join Producto pro on pro.ID_Pro 
= df.Id_Producto where df.Id_Producto = @identificador and pro.ESTADO = 'DESACTIVADO'
GO
/****** Object:  StoredProcedure [dbo].[producto_nombre]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[producto_nombre]
@id int
as
select  c.ID_Compras,di.Det_Com, c.Fecha,u.Id_Proveedor,u.Empresa, g.Articulo,g.ID_Pro, di.Cantidad,di.Precio_T, di.Precio_U
from Compras c inner join Detalles_Com di on c.ID_Compras = di.Det_Com  inner join Proveedor u on c.Id_Proveedor =
u.Id_Proveedor inner join Producto g on g.ID_Pro = di.Id_Producto 
WHERE g.ID_Pro = @id and g.ESTADO = 'ACTIVADO'
GO
/****** Object:  StoredProcedure [dbo].[producto_nombre_id]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[producto_nombre_id]
@id varchar(25)
as
select  c.ID_Compras, c.Fecha,u.Id_Proveedor,u.Empresa, g.Articulo,g.ID_Pro, di.Cantidad,di.Precio_T, di.Precio_U
from Compras c inner join Detalles_Com di on c.ID_Compras = di.Det_Com  inner join Proveedor u on c.Id_Proveedor =
u.Id_Proveedor inner join Producto g on g.ID_Pro = di.Id_Producto
WHERE g.Articulo = @id
GO
/****** Object:  StoredProcedure [dbo].[Productosg]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Productosg]
as
select p.ID_Pro, p.Articulo, p.Precio_U, p.Cantidad, pro.Empresa as Proveedor
from Producto p inner join Proveedor pro on p.Id_Proveedor = pro.Id_Proveedor where P.ESTADO = 'ACTIVADO'
GO
/****** Object:  StoredProcedure [dbo].[proveedor_especifico]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[proveedor_especifico]
@id int
as
select  c.ID_Compras,di.Det_Com, c.Fecha,u.Id_Proveedor,u.Empresa, g.Articulo, di.Cantidad,di.Precio_T, di.Precio_U
from Compras c inner join Detalles_Com di on c.ID_Compras = di.Det_Com  inner join Proveedor u on c.Id_Proveedor =
u.Id_Proveedor inner join Producto g on g.ID_Pro = di.Id_Producto
WHERE u.Id_Proveedor = @id AND U.ESTADO = 'ACTIVADO'
GO
/****** Object:  StoredProcedure [dbo].[PROVEEDOR_ESPECIFICO_ACTIVADO]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
cREATE proc [dbo].[PROVEEDOR_ESPECIFICO_ACTIVADO]
@ID INT
as
begin
select  c.ID_Compras,di.Det_Com, c.Fecha, u.Empresa, g.Articulo, di.Cantidad,di.Precio_T, di.Precio_U
from Compras c inner join Detalles_Com di on c.ID_Compras = DI.Id_Compras  inner join Proveedor u on c.Id_Proveedor =
u.Id_Proveedor inner join Producto g on g.ID_Pro = di.Id_Producto
where u.Id_Proveedor = @ID and u.ESTADO = 'DESACTIVADO'
end
GO
/****** Object:  StoredProcedure [dbo].[PROVEEDOR_ESPECIFICO_DESACTIVADO]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PROVEEDOR_ESPECIFICO_DESACTIVADO]
@ID INT
as
begin
select  c.ID_Compras,di.Det_Com, c.Fecha, u.Empresa, g.Articulo, di.Cantidad,di.Precio_T, di.Precio_U
from Compras c inner join Detalles_Com di on c.ID_Compras = DI.Id_Compras  inner join Proveedor u on c.Id_Proveedor =
u.Id_Proveedor inner join Producto g on g.ID_Pro = di.Id_Producto
where u.Id_Proveedor = @ID and u.ESTADO = 'ACTIVADO'
end
GO
/****** Object:  StoredProcedure [dbo].[proveedor_especificog]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[proveedor_especificog]
	--@id int
as
select  c.ID_Compras,di.Det_Com, c.Fecha,u.Empresa, g.Articulo, di.Cantidad,di.Precio_T, di.Precio_U
from Compras c inner join Detalles_Com di on c.ID_Compras = di.Det_Com  inner join Proveedor u on c.Id_Proveedor =
u.Id_Proveedor inner join Producto g on g.ID_Pro = di.Id_Producto
--WHERE u.Id_Proveedor = @id AND }+
where u.ESTADO = 'DESACTIVADO'
GO
/****** Object:  StoredProcedure [dbo].[proveedor_nombre]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[proveedor_nombre]
@id varchar(30)
as
select  c.ID_Compras, c.Fecha,u.Id_Proveedor,u.Empresa, g.Articulo, di.Cantidad,di.Precio_T, di.Precio_U
from Compras c inner join Detalles_Com di on c.ID_Compras = di.Det_Com  inner join Proveedor u on c.Id_Proveedor =
u.Id_Proveedor inner join Producto g on g.ID_Pro = di.Id_Producto
WHERE u.Empresa = @id
GO
/****** Object:  StoredProcedure [dbo].[Proveedorgeneral]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Proveedorgeneral]
as
select p.Id_Proveedor, p.Empresa, p.Direccion, p.Representante, p.Telefono
from Proveedor p where p.ESTADO = 'ACTIVADO'
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Clientes](
	[Id_Cliente] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](25) NULL,
	[Apellido] [varchar](25) NULL,
	[Cedula] [varchar](15) NULL,
	[Telefono] [varchar](15) NULL,
	[ESTADO] [varchar](17) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Compras]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Compras](
	[ID_Compras] [int] NOT NULL,
	[Id_Proveedor] [int] NULL,
	[Fecha] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Compras] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Detalles_Com]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalles_Com](
	[Det_Com] [int] IDENTITY(1,1) NOT NULL,
	[Id_Compras] [int] NULL,
	[Id_Producto] [int] NULL,
	[Cantidad] [int] NULL,
	[Precio_U] [money] NULL,
	[Precio_T] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[Det_Com] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Detalles_Fac]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalles_Fac](
	[Det_Fa] [int] IDENTITY(1,1) NOT NULL,
	[Id_Factura] [int] NULL,
	[Id_Producto] [int] NULL,
	[Cantidad] [int] NULL,
	[Precio_U] [money] NULL,
	[Precio_T] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[Det_Fa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Factura]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Factura](
	[Id_factura] [int] NOT NULL,
	[Id_Cliente] [int] NULL,
	[Fecha] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_factura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Producto]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Producto](
	[ID_Pro] [int] IDENTITY(1,1) NOT NULL,
	[Articulo] [varchar](25) NULL,
	[Cantidad] [int] NULL,
	[Precio_U] [int] NULL,
	[Id_Proveedor] [int] NULL,
	[ESTADO] [varchar](17) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Pro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Proveedor]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Proveedor](
	[Id_Proveedor] [int] IDENTITY(1,1) NOT NULL,
	[Empresa] [varchar](30) NULL,
	[Telefono] [varchar](13) NULL,
	[Direccion] [varchar](30) NULL,
	[Representante] [varchar](30) NULL,
	[ESTADO] [varchar](17) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 7/19/2020 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuarios](
	[Id_usuario] [int] IDENTITY(1,1) NOT NULL,
	[Usuario] [varchar](30) NULL,
	[Contraseña] [varchar](30) NULL,
	[Correo] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Clientes] ON 

INSERT [dbo].[Clientes] ([Id_Cliente], [Nombre], [Apellido], [Cedula], [Telefono], [ESTADO]) VALUES (2, N'Amnerys', N'Santos', N'055-0001450-0', N'809-212-2311', N'DESACTIVADO')
INSERT [dbo].[Clientes] ([Id_Cliente], [Nombre], [Apellido], [Cedula], [Telefono], [ESTADO]) VALUES (3, N'Will', N'Perez', N'055-0010696-7', N'891-221-3331', N'DESACTIVADO')
INSERT [dbo].[Clientes] ([Id_Cliente], [Nombre], [Apellido], [Cedula], [Telefono], [ESTADO]) VALUES (4, N'Edward', N'Perez', N'055-0013213-8', N'890-453-2341', N'DESACTIVADO')
INSERT [dbo].[Clientes] ([Id_Cliente], [Nombre], [Apellido], [Cedula], [Telefono], [ESTADO]) VALUES (5, N'Karla', N'Diaz', N'061-0024828-2 ', N'890-342-1211', N'ACTIVADO')
INSERT [dbo].[Clientes] ([Id_Cliente], [Nombre], [Apellido], [Cedula], [Telefono], [ESTADO]) VALUES (6, N'Jonathan', N'Peña', N'055-0031219-3', N'890-771-2331', N'ACTIVADO')
INSERT [dbo].[Clientes] ([Id_Cliente], [Nombre], [Apellido], [Cedula], [Telefono], [ESTADO]) VALUES (7, N'Janniany', N'Castillo', N'055-0026889-0', N'809-123-1114', N'ACTIVADO')
INSERT [dbo].[Clientes] ([Id_Cliente], [Nombre], [Apellido], [Cedula], [Telefono], [ESTADO]) VALUES (8, N'Naomi', N'Cepedes', N'055-0026861-9', N'890-112-3319', N'ACTIVADO')
INSERT [dbo].[Clientes] ([Id_Cliente], [Nombre], [Apellido], [Cedula], [Telefono], [ESTADO]) VALUES (9, N'Isabel', N'Rodriguez', N'055-0010616-5', N'809-443-1115', N'ACTIVADO')
INSERT [dbo].[Clientes] ([Id_Cliente], [Nombre], [Apellido], [Cedula], [Telefono], [ESTADO]) VALUES (10, N'Felipe', N'Constantino', N'402-2505339-2', N'890-665-4533', N'ACTIVADO')
INSERT [dbo].[Clientes] ([Id_Cliente], [Nombre], [Apellido], [Cedula], [Telefono], [ESTADO]) VALUES (11, N'Pedro', N'Santana', N'009-0013651-8', N'809-414-4564', N'ACTIVADO')
INSERT [dbo].[Clientes] ([Id_Cliente], [Nombre], [Apellido], [Cedula], [Telefono], [ESTADO]) VALUES (12, N'Johanna', N'Jimenez', N'002-001095-4', N'809-444-7777', N'ACTIVADO')
SET IDENTITY_INSERT [dbo].[Clientes] OFF
INSERT [dbo].[Compras] ([ID_Compras], [Id_Proveedor], [Fecha]) VALUES (6, 3, CAST(0x10410B00 AS Date))
INSERT [dbo].[Compras] ([ID_Compras], [Id_Proveedor], [Fecha]) VALUES (12, 1, CAST(0x10410B00 AS Date))
INSERT [dbo].[Compras] ([ID_Compras], [Id_Proveedor], [Fecha]) VALUES (13, 2, CAST(0x1C410B00 AS Date))
SET IDENTITY_INSERT [dbo].[Detalles_Com] ON 

INSERT [dbo].[Detalles_Com] ([Det_Com], [Id_Compras], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (3, 12, 2, 1, 100.0000, 100.0000)
INSERT [dbo].[Detalles_Com] ([Det_Com], [Id_Compras], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (4, 6, 2, 1, 100.0000, 100.0000)
INSERT [dbo].[Detalles_Com] ([Det_Com], [Id_Compras], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (5, 6, 4, 10, 150.0000, 1500.0000)
INSERT [dbo].[Detalles_Com] ([Det_Com], [Id_Compras], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (6, 13, 2, 5, 100.0000, 500.0000)
SET IDENTITY_INSERT [dbo].[Detalles_Com] OFF
SET IDENTITY_INSERT [dbo].[Detalles_Fac] ON 

INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (12, 12, 4, 3, 150.0000, 450.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (13, 12, 5, 1, 700.0000, 700.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (14, 9, 2, 1, 100.0000, 100.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (15, 13, 3, 1, 100.0000, 100.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (16, 14, 8, 3, 150.0000, 450.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (17, 15, 5, 1, 700.0000, 700.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (20, 16, 6, 1, 1000.0000, 1000.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (21, 17, 9, 3, 200.0000, 600.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (22, 17, 10, 4, 200.0000, 800.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (23, 18, 6, 1, 1000.0000, 1000.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (24, 18, 2, 1, 100.0000, 100.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (25, 19, 9, 1, 200.0000, 200.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (26, 20, 2, 1, 100.0000, 100.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (27, 20, 10, 1, 200.0000, 200.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (28, 21, 2, 1, 100.0000, 100.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (29, 21, 5, 1, 700.0000, 700.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (30, 22, 3, 1, 100.0000, 100.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (31, 22, 3, 4, 100.0000, 400.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (32, 23, 3, 1, 100.0000, 100.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (33, 23, 5, 1, 700.0000, 700.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (34, 24, 11, 1, 100.0000, 100.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (35, 24, 8, 1, 150.0000, 150.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (36, 25, 1, 4, 200.0000, 800.0000)
INSERT [dbo].[Detalles_Fac] ([Det_Fa], [Id_Factura], [Id_Producto], [Cantidad], [Precio_U], [Precio_T]) VALUES (37, 25, 9, 1, 200.0000, 200.0000)
SET IDENTITY_INSERT [dbo].[Detalles_Fac] OFF
INSERT [dbo].[Factura] ([Id_factura], [Id_Cliente], [Fecha]) VALUES (1, 2, CAST(0x10410B00 AS Date))
INSERT [dbo].[Factura] ([Id_factura], [Id_Cliente], [Fecha]) VALUES (2, 3, CAST(0x10410B00 AS Date))
INSERT [dbo].[Factura] ([Id_factura], [Id_Cliente], [Fecha]) VALUES (4, 3, CAST(0x10410B00 AS Date))
INSERT [dbo].[Factura] ([Id_factura], [Id_Cliente], [Fecha]) VALUES (9, 9, CAST(0x11410B00 AS Date))
INSERT [dbo].[Factura] ([Id_factura], [Id_Cliente], [Fecha]) VALUES (12, 3, CAST(0x11410B00 AS Date))
INSERT [dbo].[Factura] ([Id_factura], [Id_Cliente], [Fecha]) VALUES (13, 3, CAST(0x13410B00 AS Date))
INSERT [dbo].[Factura] ([Id_factura], [Id_Cliente], [Fecha]) VALUES (14, 2, CAST(0x13410B00 AS Date))
INSERT [dbo].[Factura] ([Id_factura], [Id_Cliente], [Fecha]) VALUES (15, 4, CAST(0x13410B00 AS Date))
INSERT [dbo].[Factura] ([Id_factura], [Id_Cliente], [Fecha]) VALUES (16, 6, CAST(0x13410B00 AS Date))
INSERT [dbo].[Factura] ([Id_factura], [Id_Cliente], [Fecha]) VALUES (17, 8, CAST(0x13410B00 AS Date))
INSERT [dbo].[Factura] ([Id_factura], [Id_Cliente], [Fecha]) VALUES (18, 3, CAST(0x1C410B00 AS Date))
INSERT [dbo].[Factura] ([Id_factura], [Id_Cliente], [Fecha]) VALUES (19, 3, CAST(0x1D410B00 AS Date))
INSERT [dbo].[Factura] ([Id_factura], [Id_Cliente], [Fecha]) VALUES (20, 6, CAST(0x20410B00 AS Date))
INSERT [dbo].[Factura] ([Id_factura], [Id_Cliente], [Fecha]) VALUES (21, 11, CAST(0x20410B00 AS Date))
INSERT [dbo].[Factura] ([Id_factura], [Id_Cliente], [Fecha]) VALUES (22, 7, CAST(0x20410B00 AS Date))
INSERT [dbo].[Factura] ([Id_factura], [Id_Cliente], [Fecha]) VALUES (23, 7, CAST(0x20410B00 AS Date))
INSERT [dbo].[Factura] ([Id_factura], [Id_Cliente], [Fecha]) VALUES (24, 5, CAST(0x28410B00 AS Date))
INSERT [dbo].[Factura] ([Id_factura], [Id_Cliente], [Fecha]) VALUES (25, 8, CAST(0x28410B00 AS Date))
SET IDENTITY_INSERT [dbo].[Producto] ON 

INSERT [dbo].[Producto] ([ID_Pro], [Articulo], [Cantidad], [Precio_U], [Id_Proveedor], [ESTADO]) VALUES (1, N'Martillo', 16, 200, 5, N'ACTIVADO')
INSERT [dbo].[Producto] ([ID_Pro], [Articulo], [Cantidad], [Precio_U], [Id_Proveedor], [ESTADO]) VALUES (2, N'Bailejo', -7, 100, 4, N'ACTIVADO')
INSERT [dbo].[Producto] ([ID_Pro], [Articulo], [Cantidad], [Precio_U], [Id_Proveedor], [ESTADO]) VALUES (3, N'Tarranja', -2, 100, 3, N'ACTIVADO')
INSERT [dbo].[Producto] ([ID_Pro], [Articulo], [Cantidad], [Precio_U], [Id_Proveedor], [ESTADO]) VALUES (4, N'Paleta', 27, 150, 3, N'DESACTIVADO')
INSERT [dbo].[Producto] ([ID_Pro], [Articulo], [Cantidad], [Precio_U], [Id_Proveedor], [ESTADO]) VALUES (5, N'Taladro', 0, 700, 5, N'ACTIVADO')
INSERT [dbo].[Producto] ([ID_Pro], [Articulo], [Cantidad], [Precio_U], [Id_Proveedor], [ESTADO]) VALUES (6, N'Sierra', 5, 1000, 1, N'ACTIVADO')
INSERT [dbo].[Producto] ([ID_Pro], [Articulo], [Cantidad], [Precio_U], [Id_Proveedor], [ESTADO]) VALUES (8, N'Pala', 1, 150, 1, N'ACTIVADO')
INSERT [dbo].[Producto] ([ID_Pro], [Articulo], [Cantidad], [Precio_U], [Id_Proveedor], [ESTADO]) VALUES (9, N'Hacha', 0, 200, 4, N'ACTIVADO')
INSERT [dbo].[Producto] ([ID_Pro], [Articulo], [Cantidad], [Precio_U], [Id_Proveedor], [ESTADO]) VALUES (10, N'Pico', 1, 200, 3, N'ACTIVADO')
INSERT [dbo].[Producto] ([ID_Pro], [Articulo], [Cantidad], [Precio_U], [Id_Proveedor], [ESTADO]) VALUES (11, N'Calibre', 4, 100, 1, N'ACTIVADO')
INSERT [dbo].[Producto] ([ID_Pro], [Articulo], [Cantidad], [Precio_U], [Id_Proveedor], [ESTADO]) VALUES (12, N'Calibre', 0, 100, 1, N'ACTIVADO')
SET IDENTITY_INSERT [dbo].[Producto] OFF
SET IDENTITY_INSERT [dbo].[Proveedor] ON 

INSERT [dbo].[Proveedor] ([Id_Proveedor], [Empresa], [Telefono], [Direccion], [Representante], [ESTADO]) VALUES (1, N'Centro Ferretero Moretta', N'809-424-7267', N'Av.Ecologia', N'Pablo Perez', N'ACTIVADO')
INSERT [dbo].[Proveedor] ([Id_Proveedor], [Empresa], [Telefono], [Direccion], [Representante], [ESTADO]) VALUES (2, N'Pinturas Nacional', N'809-331-2442', N'Hainamosa C. Rojas', N'Rosario Peña', N'ACTIVADO')
INSERT [dbo].[Proveedor] ([Id_Proveedor], [Empresa], [Telefono], [Direccion], [Representante], [ESTADO]) VALUES (3, N'Ramca,SRL', N'890-777-4532', N'Almirante #2', N'Julio Rosas', N'DESACTIVADO')
INSERT [dbo].[Proveedor] ([Id_Proveedor], [Empresa], [Telefono], [Direccion], [Representante], [ESTADO]) VALUES (4, N'Ferreteria Gigante', N'809-222-1231', N'Bella Vista C.Mosa', N'Orlando Perez', N'ACTIVADO')
INSERT [dbo].[Proveedor] ([Id_Proveedor], [Empresa], [Telefono], [Direccion], [Representante], [ESTADO]) VALUES (5, N'Ferreteria Americana', N'809-121-1113', N'Buenaventura C.Altiro', N'Brisnet Otaño', N'ACTIVADO')
SET IDENTITY_INSERT [dbo].[Proveedor] OFF
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([Id_usuario], [Usuario], [Contraseña], [Correo]) VALUES (1, N'Inpha', N'1234', N'amnerys123@hotmail.com')
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
ALTER TABLE [dbo].[Compras]  WITH CHECK ADD  CONSTRAINT [FK_Compras_Proveedor] FOREIGN KEY([Id_Proveedor])
REFERENCES [dbo].[Proveedor] ([Id_Proveedor])
GO
ALTER TABLE [dbo].[Compras] CHECK CONSTRAINT [FK_Compras_Proveedor]
GO
ALTER TABLE [dbo].[Detalles_Com]  WITH CHECK ADD  CONSTRAINT [FK_Detalles_Com_Compras] FOREIGN KEY([Id_Compras])
REFERENCES [dbo].[Compras] ([ID_Compras])
GO
ALTER TABLE [dbo].[Detalles_Com] CHECK CONSTRAINT [FK_Detalles_Com_Compras]
GO
ALTER TABLE [dbo].[Detalles_Com]  WITH CHECK ADD  CONSTRAINT [FK_Detalles_Com_Producto] FOREIGN KEY([Id_Producto])
REFERENCES [dbo].[Producto] ([ID_Pro])
GO
ALTER TABLE [dbo].[Detalles_Com] CHECK CONSTRAINT [FK_Detalles_Com_Producto]
GO
ALTER TABLE [dbo].[Detalles_Fac]  WITH CHECK ADD  CONSTRAINT [FK_Detalles_Fac_Factura] FOREIGN KEY([Id_Factura])
REFERENCES [dbo].[Factura] ([Id_factura])
GO
ALTER TABLE [dbo].[Detalles_Fac] CHECK CONSTRAINT [FK_Detalles_Fac_Factura]
GO
ALTER TABLE [dbo].[Detalles_Fac]  WITH CHECK ADD  CONSTRAINT [FK_Detalles_Fac_Producto] FOREIGN KEY([Id_Producto])
REFERENCES [dbo].[Producto] ([ID_Pro])
GO
ALTER TABLE [dbo].[Detalles_Fac] CHECK CONSTRAINT [FK_Detalles_Fac_Producto]
GO
ALTER TABLE [dbo].[Factura]  WITH CHECK ADD  CONSTRAINT [FK_Factura_Clientes] FOREIGN KEY([Id_Cliente])
REFERENCES [dbo].[Clientes] ([Id_Cliente])
GO
ALTER TABLE [dbo].[Factura] CHECK CONSTRAINT [FK_Factura_Clientes]
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD  CONSTRAINT [FK_Producto_Proveedor] FOREIGN KEY([Id_Proveedor])
REFERENCES [dbo].[Proveedor] ([Id_Proveedor])
GO
ALTER TABLE [dbo].[Producto] CHECK CONSTRAINT [FK_Producto_Proveedor]
GO
USE [master]
GO
ALTER DATABASE [LAREAL] SET  READ_WRITE 
GO
