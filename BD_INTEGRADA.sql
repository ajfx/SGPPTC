USE [master]
GO
/****** Object:  Database [BD_SGPPTC]    Script Date: 07/11/2013 0:27:21 ******/
CREATE DATABASE [BD_SGPPTC]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BD_SGPPTC', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\BD_SGPPTC.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BD_SGPPTC_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\BD_SGPPTC_log.ldf' , SIZE = 1040KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BD_SGPPTC] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BD_SGPPTC].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BD_SGPPTC] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BD_SGPPTC] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BD_SGPPTC] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BD_SGPPTC] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BD_SGPPTC] SET ARITHABORT OFF 
GO
ALTER DATABASE [BD_SGPPTC] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BD_SGPPTC] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [BD_SGPPTC] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BD_SGPPTC] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BD_SGPPTC] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BD_SGPPTC] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BD_SGPPTC] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BD_SGPPTC] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BD_SGPPTC] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BD_SGPPTC] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BD_SGPPTC] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BD_SGPPTC] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BD_SGPPTC] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BD_SGPPTC] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BD_SGPPTC] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BD_SGPPTC] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BD_SGPPTC] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BD_SGPPTC] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BD_SGPPTC] SET RECOVERY FULL 
GO
ALTER DATABASE [BD_SGPPTC] SET  MULTI_USER 
GO
ALTER DATABASE [BD_SGPPTC] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BD_SGPPTC] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BD_SGPPTC] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BD_SGPPTC] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'BD_SGPPTC', N'ON'
GO
USE [BD_SGPPTC]
GO
/****** Object:  StoredProcedure [dbo].[usp_ActualizarEstadoPedido]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_ActualizarEstadoPedido]
@IDPedido int,
@Estado nvarchar(20)	
AS
Update T_Pedido
Set estado = @Estado
where IDPedido = @IDPedido;


GO
/****** Object:  StoredProcedure [dbo].[usp_BuscarPedidos]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_BuscarPedidos]
@cadena nvarchar(50)
  as
  
  SELECT     T_Cliente.nombres, T_Cliente.apellidopaterno, T_Cliente.apellidomaterno, T_Origen.fechaRecojo, T_Destino.fechaEnvio,T_Pedido.IDPedido, T_Pedido.estado, T_Pedido.Activo
FROM         T_Pedido INNER JOIN
                      T_Cliente ON T_Pedido.IDCliente = T_Cliente.IDCliente AND T_Pedido.IDCliente = T_Cliente.IDCliente INNER JOIN
                      T_Origen ON T_Pedido.IDPedido = T_Origen.IDPedido INNER JOIN
                      T_Destino ON T_Pedido.IDPedido = T_Destino.IDPedido
					  WHERE T_Pedido.Activo = 'True' AND T_Cliente.nombres like @cadena OR T_cliente.apellidopaterno like @cadena OR T_Cliente.apellidomaterno like @cadena

GO
/****** Object:  StoredProcedure [dbo].[usp_BuscarPedidosEliminados]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_BuscarPedidosEliminados]
@cadena nvarchar(50)
  as
  
  SELECT     T_Cliente.nombres, T_Cliente.apellidopaterno, T_Cliente.apellidomaterno, T_Origen.fechaRecojo, T_Destino.fechaEnvio,T_Pedido.IDPedido, T_Pedido.estado, T_Pedido.Activo
FROM         T_Pedido INNER JOIN
                      T_Cliente ON T_Pedido.IDCliente = T_Cliente.IDCliente AND T_Pedido.IDCliente = T_Cliente.IDCliente INNER JOIN
                      T_Origen ON T_Pedido.IDPedido = T_Origen.IDPedido INNER JOIN
                      T_Destino ON T_Pedido.IDPedido = T_Destino.IDPedido
					  WHERE T_Pedido.Activo = 'False' AND T_Cliente.nombres like @cadena OR T_cliente.apellidopaterno like @cadena OR T_Cliente.apellidomaterno like @cadena

GO
/****** Object:  StoredProcedure [dbo].[usp_CompletaPedido]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_CompletaPedido]
(@IDDxP int,
@IDDxV int,
@Estado nvarchar(20),
@costototal float,
@IDPedido int)
AS
Update T_Pedido
Set estado = @Estado,
[IDDxP] = @IDDxP,
[IDDxV] =@IDDxV, 
costototal=@costototal
where IDPedido = @IDPedido;


GO
/****** Object:  StoredProcedure [dbo].[usp_CompletaPedidoP]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_CompletaPedidoP] (@IDPedido int,
@IDDxP int,
@Estado nvarchar(20),
@costototal float)	
AS
Update T_Pedido
Set estado = @Estado,
IDDxP = @IDDxP,
costototal=@costototal
where IDPedido = @IDPedido;


GO
/****** Object:  StoredProcedure [dbo].[usp_CompletaPedidoV]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_CompletaPedidoV] (@IDPedido int,
@IDDxV int,
@Estado nvarchar(20),
@costototal float)	
AS
Update T_Pedido
Set estado = @Estado,
[IDDxV] = @IDDxV,
costototal=@costototal
where IDPedido = @IDPedido;


GO
/****** Object:  StoredProcedure [dbo].[usp_EliminarPedido]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_EliminarPedido]
@IDPedido int
AS
Update T_Pedido
Set Activo = 'False'
where IDPedido = @IDPedido;

GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarClienteNuevo]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_InsertarClienteNuevo](@nombres nvarchar(60),@apellidopaterno nvarchar(60),@apellidomaterno nvarchar(60),@tipopersona nvarchar(60),
 @nombreEmpresa nvarchar(60),@RUC int,@rubro nvarchar(60),@dni int,@direccion nvarchar(60),@email nvarchar(60),
 @fechanacimiento date,@telefono int,@celular int,@IDUsuario int)
as
insert into T_Cliente (nombres,apellidopaterno,apellidomaterno,tipopersona,nombreEmpresa,RUC,rubro,dni,direccion,email,fechanacimiento,telefono,celular,IDUsuario) VALUES  (@nombres,@apellidopaterno,@apellidomaterno,@tipopersona,@nombreEmpresa,@RUC,@rubro,@dni,@direccion,@email,@fechanacimiento,@telefono,@celular,@IDUsuario)


GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarDestino]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarDestino](@fechaEnvio nvarchar(20),@IDDistrito int,@direccionEnvio nvarchar(20),@IDPedido int, @IDProvincia int)
  as
  insert T_Destino (fechaEnvio,IDDistrito,direccionEnvio,IDPedido, IDProvincia) values (@fechaEnvio,@IDDistrito,@direccionEnvio,@IDPedido,@IDProvincia)


GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarDistribucion]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_InsertarDistribucion]
	@IDTranportista int,
	@placa nvarchar(20),
	@IDAuxiliarcarga int,
	@IDPedido int
AS
insert into T_Distribucion values(@IDTranportista,
	@placa,
	@IDAuxiliarcarga ,
	@IDPedido);

update T_Pedido set estado = 'ASIGNADO' where IDPedido = @IDPedido;

GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarOrigen]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_InsertarOrigen](@fechaRecojo nvarchar(20),@IDDistrito int,@direccionRecojo nvarchar(20),@IDPedido int)
  as
  insert T_Origen (fechaRecojo,IDDistrito,direccionRecojo,IDPedido) values (@fechaRecojo,@IDDistrito,@direccionRecojo,@IDPedido)


GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarPedidoCliente]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_InsertarPedidoCliente](@peso int,@cantidad int,@altura float,@ancho float,@largo float,@descripcion nvarchar(50),@fragilidad bit,@embalaje bit,@estado nvarchar(20),@IDCliente int, @IDTipoCarga int, @Activo int)
as
insert T_Pedido (peso,cantidad,altura,ancho,largo,descripcion,fragilidad,embalaje,estado,IDCliente, IDTipocarga, Activo) VALUES (@peso,@cantidad,@altura,@ancho,@largo,@descripcion,@fragilidad,@embalaje,@estado,@IDCliente,@IDTipoCarga, @Activo)


GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarUsuario]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_InsertarUsuario](@nombreusuario nvarchar(60),@contraseña nvarchar(60),@IDPerfil int)
  as
  insert into T_Usuario (nombreusuario,contraseña,IDPerfil) values (@nombreusuario,@contraseña,@IDPerfil)


GO
/****** Object:  StoredProcedure [dbo].[usp_ListarPedidos]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_ListarPedidos]
  as
  
  SELECT     T_Cliente.nombres, T_Cliente.apellidopaterno, T_Cliente.apellidomaterno, T_Origen.fechaRecojo, T_Destino.fechaEnvio,T_Pedido.IDPedido, T_Pedido.estado, T_Pedido.Activo
FROM         T_Pedido INNER JOIN
                      T_Cliente ON T_Pedido.IDCliente = T_Cliente.IDCliente AND T_Pedido.IDCliente = T_Cliente.IDCliente INNER JOIN
                      T_Origen ON T_Pedido.IDPedido = T_Origen.IDPedido INNER JOIN
                      T_Destino ON T_Pedido.IDPedido = T_Destino.IDPedido
					  WHERE T_Pedido.Activo = 'True'

GO
/****** Object:  StoredProcedure [dbo].[usp_ListarPedidosCliente]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_ListarPedidosCliente]
@IdCliente int
  as
  
  SELECT     T_Cliente.nombres, T_Cliente.apellidopaterno, T_Cliente.apellidomaterno, T_Origen.fechaRecojo, T_Destino.fechaEnvio,T_Pedido.IDPedido, T_Pedido.estado, T_Pedido.Activo,T_Pedido.estadoPago
FROM         T_Pedido INNER JOIN
                      T_Cliente ON T_Pedido.IDCliente = T_Cliente.IDCliente AND T_Pedido.IDCliente = T_Cliente.IDCliente INNER JOIN
                      T_Origen ON T_Pedido.IDPedido = T_Origen.IDPedido INNER JOIN
                      T_Destino ON T_Pedido.IDPedido = T_Destino.IDPedido
					  WHERE T_Pedido.Activo = 'True' and T_Pedido.IDCliente = @IdCliente

GO
/****** Object:  StoredProcedure [dbo].[usp_ListarPedidosEliminados]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_ListarPedidosEliminados]
  as
  
  SELECT     T_Cliente.nombres, T_Cliente.apellidopaterno, T_Cliente.apellidomaterno, T_Origen.fechaRecojo, T_Destino.fechaEnvio,T_Pedido.IDPedido, T_Pedido.estado, T_Pedido.Activo
FROM         T_Pedido INNER JOIN
                      T_Cliente ON T_Pedido.IDCliente = T_Cliente.IDCliente AND T_Pedido.IDCliente = T_Cliente.IDCliente INNER JOIN
                      T_Origen ON T_Pedido.IDPedido = T_Origen.IDPedido INNER JOIN
                      T_Destino ON T_Pedido.IDPedido = T_Destino.IDPedido
					  WHERE T_Pedido.Activo = 'False'

GO
/****** Object:  StoredProcedure [dbo].[usp_ModificarDestino]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_ModificarDestino]
@fechaEnvio nvarchar(20),
@IDDistrito int,
@direccionEnvio nvarchar(20),
@IDPedido int,
@IDProvincia int
AS
Update T_Destino
Set fechaEnvio = @fechaEnvio,
	IDDistrito = @IDDistrito,
	direccionEnvio = @direccionEnvio,
	IDProvincia = @IDProvincia
where IDPedido = @IDPedido;

GO
/****** Object:  StoredProcedure [dbo].[usp_ModificarOrigen]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_ModificarOrigen]
@fechaRecojo nvarchar(20),
@IDDistrito int,
@direccionRecojo nvarchar(20),
@IDPedido int,
@IDProvincia int
AS
Update T_Origen
Set fechaRecojo = @fechaRecojo,
	IDDistrito = @IDDistrito,
	direccionRecojo = @direccionRecojo,
	IDProvincia = @IDProvincia
where IDPedido = @IDPedido;

GO
/****** Object:  StoredProcedure [dbo].[usp_ModificarPedido]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_ModificarPedido]
@IDPedido int,
@peso int,
@cantidad int,
@altura float,
@ancho float,
@largo float,
@descripcion nvarchar(50),
@fragilidad bit,
@embalaje bit,
@estado nvarchar(20),
@idcliente int,
@IDTipoCarga int	
AS
Update T_Pedido
Set peso = @peso,
	cantidad = @cantidad,
	altura = @altura,
	ancho = @ancho,
	largo = @largo,
	descripcion = @descripcion,
	fragilidad = @fragilidad,
	embalaje = @embalaje,
	estado = @estado,
	IDCliente = @idcliente,
	IDTipocarga = @IDTipoCarga
where IDPedido = @IDPedido;

GO
/****** Object:  StoredProcedure [dbo].[usp_ObtenerDatos]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_ObtenerDatos]
@Peso float,
@Distancia float,
@Volumen float
AS
--Logica 
declare @Precio float,@IdDxP int,@IdDxV int	;
set @Precio = 120;
set @IdDxP = 1;
set @IdDxV = 3;

Select IdDxP = @IdDxP,@IdDxV as IdDxV,Precio = @Precio


GO
/****** Object:  StoredProcedure [dbo].[usp_ObtenerDatosAuxiliar]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_ObtenerDatosAuxiliar]
as
select * from T_AuxiliarCarga




GO
/****** Object:  StoredProcedure [dbo].[usp_ObtenerDatosPedidos]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[usp_ObtenerDatosPedidos]
AS
select * from T_Pedido


GO
/****** Object:  StoredProcedure [dbo].[usp_ObtenerDatosTransportista]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_ObtenerDatosTransportista]
as
select * from T_Transportista




GO
/****** Object:  StoredProcedure [dbo].[usp_ObtenerDatosVehiculos]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_ObtenerDatosVehiculos]
as
select * from T_Vehiculo

GO
/****** Object:  StoredProcedure [dbo].[usp_ObtenerPedidoByID]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[usp_ObtenerPedidoByID]
@IDPedido int
AS
select * from T_Pedido
where IDPedido = @IDPedido;

GO
/****** Object:  StoredProcedure [dbo].[usp_RestaurarPedido]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[usp_RestaurarPedido]
@IDPedido int
AS
Update T_Pedido
Set Activo = 'True'
where IDPedido = @IDPedido;

GO
/****** Object:  Table [dbo].[T_Almacen]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Almacen](
	[IDAlmacen] [int] IDENTITY(1,1) NOT NULL,
	[nombrealmacen] [nvarchar](30) NULL,
	[cantidadpaquetes] [int] NULL,
	[IDLocal] [int] NOT NULL,
 CONSTRAINT [PK__T_Almace__BDDB718D4DF6E648] PRIMARY KEY CLUSTERED 
(
	[IDAlmacen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_AuxiliarCarga]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_AuxiliarCarga](
	[IDAuxiliarcarga] [int] IDENTITY(1,1) NOT NULL,
	[nombreauxiliar] [nvarchar](60) NULL,
	[IDUsuario] [int] NOT NULL,
 CONSTRAINT [PK__T_Auxili__6CC236DCE431E7FF] PRIMARY KEY CLUSTERED 
(
	[IDAuxiliarcarga] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Cliente]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Cliente](
	[IDCliente] [int] IDENTITY(1,1) NOT NULL,
	[nombres] [nvarchar](60) NULL,
	[apellidopaterno] [nvarchar](60) NULL,
	[apellidomaterno] [nvarchar](60) NULL,
	[tipopersona] [nvarchar](60) NULL,
	[nombreEmpresa] [nvarchar](60) NULL,
	[RUC] [int] NULL,
	[rubro] [nvarchar](60) NULL,
	[dni] [int] NULL,
	[direccion] [nvarchar](70) NULL,
	[email] [nvarchar](70) NULL,
	[fechanacimiento] [date] NULL,
	[telefono] [int] NULL,
	[celular] [int] NULL,
	[IDUsuario] [int] NOT NULL,
 CONSTRAINT [PK__T_client__95BA769A259BA908] PRIMARY KEY CLUSTERED 
(
	[IDCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Departamento]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Departamento](
	[IDDepartamento] [int] IDENTITY(1,1) NOT NULL,
	[nombredepartamento] [nvarchar](30) NULL,
 CONSTRAINT [PK__T_Depart__5BDCB260F4D7E136] PRIMARY KEY CLUSTERED 
(
	[IDDepartamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Destino]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Destino](
	[IDDestiono] [int] IDENTITY(1,1) NOT NULL,
	[fechaEnvio] [date] NULL,
	[direccionEnvio] [nvarchar](50) NULL,
	[IDDistrito] [int] NULL,
	[IDPedido] [int] NULL,
	[IDProvincia] [int] NULL,
 CONSTRAINT [PK_T_Emision] PRIMARY KEY CLUSTERED 
(
	[IDDestiono] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Distancia]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Distancia](
	[IDDistancia] [int] NOT NULL,
	[intervaloMenorD] [float] NULL,
	[intervaloMayorD] [float] NULL,
 CONSTRAINT [PK_T_Distancia] PRIMARY KEY CLUSTERED 
(
	[IDDistancia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Distribucion]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Distribucion](
	[IDDistribucion] [int] IDENTITY(1,1) NOT NULL,
	[IDTranportista] [int] NOT NULL,
	[placa] [nvarchar](20) NOT NULL,
	[IDAuxiliarcarga] [int] NOT NULL,
	[IDPedido] [int] NOT NULL,
 CONSTRAINT [PK__T_Distri__ED15B337BB6CD1FB] PRIMARY KEY CLUSTERED 
(
	[IDDistribucion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Distrito]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Distrito](
	[IDDistrito] [int] IDENTITY(1,1) NOT NULL,
	[nombredistrito] [nvarchar](60) NULL,
	[IDProvincia] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDDistrito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_DXP]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_DXP](
	[IDDxP] [int] NOT NULL,
	[IDDistancia] [int] NULL,
	[IDPeso] [int] NULL,
	[costoDXP] [float] NULL,
 CONSTRAINT [PK_T_DXP] PRIMARY KEY CLUSTERED 
(
	[IDDxP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_DXV]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_DXV](
	[IDDxV] [int] NOT NULL,
	[IDDistancia] [int] NULL,
	[IDVolumen] [int] NULL,
	[costoDXV] [float] NULL,
 CONSTRAINT [PK_T_DXV] PRIMARY KEY CLUSTERED 
(
	[IDDxV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_EstadoVehiculo]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_EstadoVehiculo](
	[IDEstadovehiculo] [int] IDENTITY(1,1) NOT NULL,
	[estadovehiculo] [nvarchar](30) NULL,
	[descripcion] [nvarchar](260) NULL,
 CONSTRAINT [PK__T_Estado__C4AC71284E56F110] PRIMARY KEY CLUSTERED 
(
	[IDEstadovehiculo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Factura]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Factura](
	[IDFactura] [int] IDENTITY(1,1) NOT NULL,
	[numerofactura] [nvarchar](30) NULL,
	[IGV] [int] NULL,
	[fechafacturacion] [date] NULL,
	[IDPedido] [int] NOT NULL,
 CONSTRAINT [PK__T_Factur__492FE93926376365] PRIMARY KEY CLUSTERED 
(
	[IDFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Flota]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Flota](
	[IDFlota] [int] IDENTITY(1,1) NOT NULL,
	[nombreflota] [nvarchar](30) NULL,
	[totalvehiculos] [int] NULL,
	[descripcion] [nvarchar](50) NULL,
	[IDLocal] [int] NOT NULL,
 CONSTRAINT [PK__T_Flota__221C67E66E2C88A6] PRIMARY KEY CLUSTERED 
(
	[IDFlota] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_GuiaEntrada]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_GuiaEntrada](
	[IDGuiaentrada] [int] IDENTITY(1,1) NOT NULL,
	[fecharegistro] [datetime] NULL,
	[observacion] [nvarchar](250) NULL,
	[IDPedido] [int] NOT NULL,
 CONSTRAINT [PK__T_GuiaEn__8326C6B10CF3AAAC] PRIMARY KEY CLUSTERED 
(
	[IDGuiaentrada] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_GuiaRemision]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_GuiaRemision](
	[IDGuiaRemision] [int] IDENTITY(1,1) NOT NULL,
	[numeroguiaremision] [int] NULL,
	[descripcion] [nvarchar](60) NULL,
	[IDPedido] [int] NOT NULL,
 CONSTRAINT [PK__T_GuiaRe__C5036A222466A480] PRIMARY KEY CLUSTERED 
(
	[IDGuiaRemision] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_GuiaSalida]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_GuiaSalida](
	[IDGuiaSalida] [int] IDENTITY(1,1) NOT NULL,
	[observacion] [nvarchar](30) NULL,
	[fechasalida] [datetime] NULL,
	[IDPedido] [int] NOT NULL,
 CONSTRAINT [PK__T_GuiaSa__8634ADA88BE24120] PRIMARY KEY CLUSTERED 
(
	[IDGuiaSalida] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Local]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Local](
	[IDLocal] [int] IDENTITY(1,1) NOT NULL,
	[nombreLocal] [nvarchar](30) NULL,
	[direccion] [nvarchar](30) NULL,
	[telefono] [int] NULL,
	[IDDistrito] [int] NOT NULL,
 CONSTRAINT [PK__T_Local__E694E680BF8270C8] PRIMARY KEY CLUSTERED 
(
	[IDLocal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Origen]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Origen](
	[IDOrigen] [int] IDENTITY(1,1) NOT NULL,
	[fechaRecojo] [date] NULL,
	[direccionRecojo] [nvarchar](50) NULL,
	[IDDistrito] [int] NULL,
	[IDPedido] [int] NULL,
	[IDProvincia] [int] NULL,
 CONSTRAINT [PK_T_Recepcion] PRIMARY KEY CLUSTERED 
(
	[IDOrigen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Pedido]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Pedido](
	[IDPedido] [int] IDENTITY(1,1) NOT NULL,
	[peso] [int] NULL,
	[cantidad] [int] NULL,
	[altura] [float] NULL,
	[ancho] [float] NULL,
	[largo] [float] NULL,
	[descripcion] [nvarchar](50) NULL,
	[fragilidad] [bit] NULL,
	[fecharegistro] [datetime] NULL,
	[embalaje] [bit] NULL,
	[IDAlmacen] [int] NULL,
	[IDTipocarga] [int] NULL,
	[IDCliente] [int] NULL,
	[estado] [nvarchar](20) NULL,
	[costototal] [float] NULL,
	[IDDxP] [int] NULL,
	[IDDxV] [int] NULL,
	[Activo] [bit] NULL,
	[estadoPago] [nvarchar](20) NULL,
 CONSTRAINT [PK__T_Pedido__00C11F99F368266C] PRIMARY KEY CLUSTERED 
(
	[IDPedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Perfil]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Perfil](
	[IDPerfil] [int] IDENTITY(1,1) NOT NULL,
	[nombreperfil] [nvarchar](70) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPerfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Perfilxpermiso]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Perfilxpermiso](
	[IDPerfilxpermiso] [int] NOT NULL,
	[IDPerfil] [int] NOT NULL,
	[IDPermiso] [int] NOT NULL,
 CONSTRAINT [PK__T_perfil__4B9FC4685D6E62F1] PRIMARY KEY CLUSTERED 
(
	[IDPerfilxpermiso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Permiso]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Permiso](
	[IDPermiso] [int] IDENTITY(1,1) NOT NULL,
	[nombrePermiso] [nvarchar](60) NULL,
	[ruta] [nvarchar](60) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPermiso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Peso]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Peso](
	[IDPeso] [int] NOT NULL,
	[intervaloMenorP] [float] NULL,
	[intervaloMayorP] [float] NULL,
 CONSTRAINT [PK_T_Peso] PRIMARY KEY CLUSTERED 
(
	[IDPeso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Provincia]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Provincia](
	[IDProvincia] [int] IDENTITY(1,1) NOT NULL,
	[nombreprovincia] [nvarchar](60) NULL,
	[IDDepartamento] [int] NOT NULL,
 CONSTRAINT [PK__T_Provin__471443E58BCC287A] PRIMARY KEY CLUSTERED 
(
	[IDProvincia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Tipocarga]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Tipocarga](
	[IDTipoCarga] [int] NOT NULL,
	[tipocarga] [nvarchar](50) NOT NULL,
	[descripcion] [nvarchar](150) NULL,
 CONSTRAINT [PK_T_Tipocarga] PRIMARY KEY CLUSTERED 
(
	[IDTipoCarga] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Trabajador]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Trabajador](
	[IDtrabajador] [int] IDENTITY(1,1) NOT NULL,
	[tipotrabajador] [nvarchar](30) NULL,
	[nombres] [nvarchar](60) NULL,
	[apellidopaterno] [nvarchar](60) NULL,
	[apellidomaterno] [nvarchar](60) NULL,
	[fechanacimiento] [datetime] NULL,
	[dnitrabajador] [int] NULL,
	[estadocivil] [nvarchar](20) NULL,
	[IDUsuario] [int] NOT NULL,
 CONSTRAINT [PK__T_trabaj__89C718030D7D7A05] PRIMARY KEY CLUSTERED 
(
	[IDtrabajador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Transportista]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Transportista](
	[IDTransportista] [int] IDENTITY(1,1) NOT NULL,
	[nombretransportista] [nvarchar](60) NULL,
	[fechaentrada] [date] NULL,
	[IDUsuario] [int] NOT NULL,
 CONSTRAINT [PK__T_transp__125DB25015B1E0DA] PRIMARY KEY CLUSTERED 
(
	[IDTransportista] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Usuario]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Usuario](
	[IDUsuario] [int] IDENTITY(1,1) NOT NULL,
	[nombreusuario] [nvarchar](50) NULL,
	[contraseña] [nvarchar](60) NULL,
	[IDPerfil] [int] NULL,
 CONSTRAINT [PK__T_usuari__52311169C9DBD1CE] PRIMARY KEY CLUSTERED 
(
	[IDUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Vehiculo]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Vehiculo](
	[placa] [nvarchar](20) NOT NULL,
	[modelo] [nvarchar](30) NULL,
	[pesobruto] [float] NULL,
	[pesoneto] [float] NULL,
	[pesotara] [float] NULL,
	[altura] [float] NULL,
	[ancho] [float] NULL,
	[marca] [nvarchar](20) NULL,
	[soat] [nvarchar](20) NULL,
	[IDFlota] [int] NOT NULL,
	[IDEstadovehiculo] [int] NOT NULL,
 CONSTRAINT [PK__T_Vehicu__0C057424D39DD08A] PRIMARY KEY CLUSTERED 
(
	[placa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Volumen]    Script Date: 07/11/2013 0:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Volumen](
	[IDVolumen] [int] NOT NULL,
	[intervaloMenorV] [float] NULL,
	[intervaloMayorV] [float] NULL,
 CONSTRAINT [PK_T_Volumen] PRIMARY KEY CLUSTERED 
(
	[IDVolumen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[T_AuxiliarCarga] ON 

INSERT [dbo].[T_AuxiliarCarga] ([IDAuxiliarcarga], [nombreauxiliar], [IDUsuario]) VALUES (1, N'estibador john', 2014)
SET IDENTITY_INSERT [dbo].[T_AuxiliarCarga] OFF
SET IDENTITY_INSERT [dbo].[T_Cliente] ON 

INSERT [dbo].[T_Cliente] ([IDCliente], [nombres], [apellidopaterno], [apellidomaterno], [tipopersona], [nombreEmpresa], [RUC], [rubro], [dni], [direccion], [email], [fechanacimiento], [telefono], [celular], [IDUsuario]) VALUES (14, N'carlos', N'montaño', N'carbajal', N'Natural', N'-------------------', 0, N'-------------------', 4444444, N'fbdfgfg', N'carlos_zanx91@hotmail.com', CAST(0x30170B00 AS Date), 3333, 3333, 2010)
INSERT [dbo].[T_Cliente] ([IDCliente], [nombres], [apellidopaterno], [apellidomaterno], [tipopersona], [nombreEmpresa], [RUC], [rubro], [dni], [direccion], [email], [fechanacimiento], [telefono], [celular], [IDUsuario]) VALUES (15, N'Angel', N'Farro', N'Lazo', N'Natural', N'-------------------', 0, N'-------------------', 45562259, N'assa', N'ajfx@outlook.com', CAST(0xC7370B00 AS Date), 13113, 3131, 2011)
INSERT [dbo].[T_Cliente] ([IDCliente], [nombres], [apellidopaterno], [apellidomaterno], [tipopersona], [nombreEmpresa], [RUC], [rubro], [dni], [direccion], [email], [fechanacimiento], [telefono], [celular], [IDUsuario]) VALUES (16, N'Jose', N'Farro', N'Lazo', N'Natural', N'-------------------', 0, N'-------------------', 45562259, N'av lima 123', N'ajfx@outlook.com', CAST(0xC6370B00 AS Date), 2798910, 9546110, 2012)
INSERT [dbo].[T_Cliente] ([IDCliente], [nombres], [apellidopaterno], [apellidomaterno], [tipopersona], [nombreEmpresa], [RUC], [rubro], [dni], [direccion], [email], [fechanacimiento], [telefono], [celular], [IDUsuario]) VALUES (17, N'ax', N'xa', N'ax', N'Natural', N'-------------------', 0, N'-------------------', 123456, N'ttgf', N'axsa@ass.com', CAST(0xCD370B00 AS Date), 435, 3553, 2013)
SET IDENTITY_INSERT [dbo].[T_Cliente] OFF
SET IDENTITY_INSERT [dbo].[T_Departamento] ON 

INSERT [dbo].[T_Departamento] ([IDDepartamento], [nombredepartamento]) VALUES (1, N'Lima')
SET IDENTITY_INSERT [dbo].[T_Departamento] OFF
SET IDENTITY_INSERT [dbo].[T_Destino] ON 

INSERT [dbo].[T_Destino] ([IDDestiono], [fechaEnvio], [direccionEnvio], [IDDistrito], [IDPedido], [IDProvincia]) VALUES (197, CAST(0xCB370B00 AS Date), N'eert', 2, 198, NULL)
INSERT [dbo].[T_Destino] ([IDDestiono], [fechaEnvio], [direccionEnvio], [IDDistrito], [IDPedido], [IDProvincia]) VALUES (198, CAST(0xD2370B00 AS Date), N'jhg', 4, 212, NULL)
INSERT [dbo].[T_Destino] ([IDDestiono], [fechaEnvio], [direccionEnvio], [IDDistrito], [IDPedido], [IDProvincia]) VALUES (199, CAST(0xD1370B00 AS Date), N'av grau barranco lim', 8, 213, NULL)
SET IDENTITY_INSERT [dbo].[T_Destino] OFF
INSERT [dbo].[T_Distancia] ([IDDistancia], [intervaloMenorD], [intervaloMayorD]) VALUES (1, 0, 10)
INSERT [dbo].[T_Distancia] ([IDDistancia], [intervaloMenorD], [intervaloMayorD]) VALUES (2, 10, 25)
INSERT [dbo].[T_Distancia] ([IDDistancia], [intervaloMenorD], [intervaloMayorD]) VALUES (3, 25, 32)
INSERT [dbo].[T_Distancia] ([IDDistancia], [intervaloMenorD], [intervaloMayorD]) VALUES (4, 32, 55)
SET IDENTITY_INSERT [dbo].[T_Distribucion] ON 

INSERT [dbo].[T_Distribucion] ([IDDistribucion], [IDTranportista], [placa], [IDAuxiliarcarga], [IDPedido]) VALUES (1, 3, N'KQ-1316', 1, 213)
SET IDENTITY_INSERT [dbo].[T_Distribucion] OFF
SET IDENTITY_INSERT [dbo].[T_Distrito] ON 

INSERT [dbo].[T_Distrito] ([IDDistrito], [nombredistrito], [IDProvincia]) VALUES (1, N'Cercado', 1)
INSERT [dbo].[T_Distrito] ([IDDistrito], [nombredistrito], [IDProvincia]) VALUES (2, N'San Juan Miraflores', 1)
INSERT [dbo].[T_Distrito] ([IDDistrito], [nombredistrito], [IDProvincia]) VALUES (3, N'Comas', 1)
INSERT [dbo].[T_Distrito] ([IDDistrito], [nombredistrito], [IDProvincia]) VALUES (4, N'Breña', 1)
INSERT [dbo].[T_Distrito] ([IDDistrito], [nombredistrito], [IDProvincia]) VALUES (5, N'Chorillos', 1)
INSERT [dbo].[T_Distrito] ([IDDistrito], [nombredistrito], [IDProvincia]) VALUES (6, N'Ancon', 1)
INSERT [dbo].[T_Distrito] ([IDDistrito], [nombredistrito], [IDProvincia]) VALUES (7, N'Ate Vitarte', 1)
INSERT [dbo].[T_Distrito] ([IDDistrito], [nombredistrito], [IDProvincia]) VALUES (8, N'Barranco', 1)
SET IDENTITY_INSERT [dbo].[T_Distrito] OFF
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (1, 1, 1, 65)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (2, 1, 2, 80)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (3, 1, 3, 95)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (4, 1, 4, 120)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (5, 1, 5, 150)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (6, 1, 6, 165)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (7, 1, 7, 225)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (8, 1, 8, 300)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (9, 1, 9, 350)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (10, 2, 1, 90)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (11, 2, 2, 100)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (12, 2, 3, 120)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (13, 2, 4, 140)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (14, 2, 5, 165)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (15, 2, 6, 195)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (16, 2, 7, 260)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (17, 2, 8, 335)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (18, 2, 9, 380)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (19, 3, 1, 100)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (20, 3, 2, 120)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (21, 3, 3, 140)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (22, 3, 4, 165)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (23, 3, 5, 195)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (24, 3, 6, 225)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (25, 3, 7, 300)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (26, 3, 8, 360)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (27, 3, 9, 410)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (28, 4, 1, 125)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (29, 4, 2, 145)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (30, 4, 3, 165)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (31, 4, 4, 195)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (32, 4, 5, 225)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (33, 4, 6, 265)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (34, 4, 7, 340)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (35, 4, 8, 390)
INSERT [dbo].[T_DXP] ([IDDxP], [IDDistancia], [IDPeso], [costoDXP]) VALUES (36, 4, 9, 450)
INSERT [dbo].[T_DXV] ([IDDxV], [IDDistancia], [IDVolumen], [costoDXV]) VALUES (1, 1, 1, 120)
INSERT [dbo].[T_DXV] ([IDDxV], [IDDistancia], [IDVolumen], [costoDXV]) VALUES (2, 1, 2, 165)
INSERT [dbo].[T_DXV] ([IDDxV], [IDDistancia], [IDVolumen], [costoDXV]) VALUES (3, 1, 3, 300)
INSERT [dbo].[T_DXV] ([IDDxV], [IDDistancia], [IDVolumen], [costoDXV]) VALUES (4, 2, 1, 140)
INSERT [dbo].[T_DXV] ([IDDxV], [IDDistancia], [IDVolumen], [costoDXV]) VALUES (5, 2, 2, 195)
INSERT [dbo].[T_DXV] ([IDDxV], [IDDistancia], [IDVolumen], [costoDXV]) VALUES (6, 2, 3, 335)
INSERT [dbo].[T_DXV] ([IDDxV], [IDDistancia], [IDVolumen], [costoDXV]) VALUES (7, 3, 1, 165)
INSERT [dbo].[T_DXV] ([IDDxV], [IDDistancia], [IDVolumen], [costoDXV]) VALUES (8, 3, 2, 225)
INSERT [dbo].[T_DXV] ([IDDxV], [IDDistancia], [IDVolumen], [costoDXV]) VALUES (9, 3, 3, 360)
INSERT [dbo].[T_DXV] ([IDDxV], [IDDistancia], [IDVolumen], [costoDXV]) VALUES (10, 4, 1, 195)
INSERT [dbo].[T_DXV] ([IDDxV], [IDDistancia], [IDVolumen], [costoDXV]) VALUES (11, 4, 2, 265)
INSERT [dbo].[T_DXV] ([IDDxV], [IDDistancia], [IDVolumen], [costoDXV]) VALUES (12, 4, 3, 390)
SET IDENTITY_INSERT [dbo].[T_EstadoVehiculo] ON 

INSERT [dbo].[T_EstadoVehiculo] ([IDEstadovehiculo], [estadovehiculo], [descripcion]) VALUES (1, N'Operativo', N'Vehiculo listo para el transporte')
SET IDENTITY_INSERT [dbo].[T_EstadoVehiculo] OFF
SET IDENTITY_INSERT [dbo].[T_Flota] ON 

INSERT [dbo].[T_Flota] ([IDFlota], [nombreflota], [totalvehiculos], [descripcion], [IDLocal]) VALUES (1, N'Furgones carga seca', 18, N'Vehiculos para transporte de carga', 1)
INSERT [dbo].[T_Flota] ([IDFlota], [nombreflota], [totalvehiculos], [descripcion], [IDLocal]) VALUES (2, N'Furgones isotermicos', 10, N'Isotermicos', 1)
INSERT [dbo].[T_Flota] ([IDFlota], [nombreflota], [totalvehiculos], [descripcion], [IDLocal]) VALUES (3, N'Furgones frigorificos', 8, N'refrigerados', 1)
INSERT [dbo].[T_Flota] ([IDFlota], [nombreflota], [totalvehiculos], [descripcion], [IDLocal]) VALUES (4, N'camionetas pickup', 6, N'carga suave', 1)
SET IDENTITY_INSERT [dbo].[T_Flota] OFF
SET IDENTITY_INSERT [dbo].[T_Local] ON 

INSERT [dbo].[T_Local] ([IDLocal], [nombreLocal], [direccion], [telefono], [IDDistrito]) VALUES (1, N'sede SJM', N'Av los Heroes 432', 4660170, 2)
SET IDENTITY_INSERT [dbo].[T_Local] OFF
SET IDENTITY_INSERT [dbo].[T_Origen] ON 

INSERT [dbo].[T_Origen] ([IDOrigen], [fechaRecojo], [direccionRecojo], [IDDistrito], [IDPedido], [IDProvincia]) VALUES (198, CAST(0xC9370B00 AS Date), N'rter', 3, 198, NULL)
INSERT [dbo].[T_Origen] ([IDOrigen], [fechaRecojo], [direccionRecojo], [IDDistrito], [IDPedido], [IDProvincia]) VALUES (199, CAST(0xC7370B00 AS Date), N'dsasd', 2, 212, NULL)
INSERT [dbo].[T_Origen] ([IDOrigen], [fechaRecojo], [direccionRecojo], [IDDistrito], [IDPedido], [IDProvincia]) VALUES (200, CAST(0xC7370B00 AS Date), N'Av los heroes san ju', 2, 213, NULL)
SET IDENTITY_INSERT [dbo].[T_Origen] OFF
SET IDENTITY_INSERT [dbo].[T_Pedido] ON 

INSERT [dbo].[T_Pedido] ([IDPedido], [peso], [cantidad], [altura], [ancho], [largo], [descripcion], [fragilidad], [fecharegistro], [embalaje], [IDAlmacen], [IDTipocarga], [IDCliente], [estado], [costototal], [IDDxP], [IDDxV], [Activo], [estadoPago]) VALUES (198, 44, 34, 0, 0, 0, N'ertretr', 0, NULL, 0, NULL, NULL, 14, N'CONFIRMADO', 4250, 1, NULL, NULL, NULL)
INSERT [dbo].[T_Pedido] ([IDPedido], [peso], [cantidad], [altura], [ancho], [largo], [descripcion], [fragilidad], [fecharegistro], [embalaje], [IDAlmacen], [IDTipocarga], [IDCliente], [estado], [costototal], [IDDxP], [IDDxV], [Activo], [estadoPago]) VALUES (212, 23, 34, 0, 0, 0, N'sqasa', 0, NULL, 0, NULL, NULL, 15, N'CONFIRMADO', 3400, 1, NULL, NULL, NULL)
INSERT [dbo].[T_Pedido] ([IDPedido], [peso], [cantidad], [altura], [ancho], [largo], [descripcion], [fragilidad], [fecharegistro], [embalaje], [IDAlmacen], [IDTipocarga], [IDCliente], [estado], [costototal], [IDDxP], [IDDxV], [Activo], [estadoPago]) VALUES (213, 120, 2, 0, 0, 0, N'Mueble', 0, NULL, 0, NULL, NULL, 16, N'ASIGNADO', 200, 2, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[T_Pedido] OFF
SET IDENTITY_INSERT [dbo].[T_Perfil] ON 

INSERT [dbo].[T_Perfil] ([IDPerfil], [nombreperfil]) VALUES (1, N'Administrador')
INSERT [dbo].[T_Perfil] ([IDPerfil], [nombreperfil]) VALUES (2, N'Cliente')
INSERT [dbo].[T_Perfil] ([IDPerfil], [nombreperfil]) VALUES (3, N'Recepcionista')
INSERT [dbo].[T_Perfil] ([IDPerfil], [nombreperfil]) VALUES (4, N'Jefe Unidad Transporte')
INSERT [dbo].[T_Perfil] ([IDPerfil], [nombreperfil]) VALUES (5, N'Transportista')
INSERT [dbo].[T_Perfil] ([IDPerfil], [nombreperfil]) VALUES (6, N'Auxiliar de Carga')
INSERT [dbo].[T_Perfil] ([IDPerfil], [nombreperfil]) VALUES (7, N'Jefe Matenimiento')
INSERT [dbo].[T_Perfil] ([IDPerfil], [nombreperfil]) VALUES (8, N'Jefe Almacen')
SET IDENTITY_INSERT [dbo].[T_Perfil] OFF
INSERT [dbo].[T_Peso] ([IDPeso], [intervaloMenorP], [intervaloMayorP]) VALUES (1, 0, 100)
INSERT [dbo].[T_Peso] ([IDPeso], [intervaloMenorP], [intervaloMayorP]) VALUES (2, 100, 300)
INSERT [dbo].[T_Peso] ([IDPeso], [intervaloMenorP], [intervaloMayorP]) VALUES (3, 300, 500)
INSERT [dbo].[T_Peso] ([IDPeso], [intervaloMenorP], [intervaloMayorP]) VALUES (4, 500, 1000)
INSERT [dbo].[T_Peso] ([IDPeso], [intervaloMenorP], [intervaloMayorP]) VALUES (5, 1000, 2000)
INSERT [dbo].[T_Peso] ([IDPeso], [intervaloMenorP], [intervaloMayorP]) VALUES (6, 2000, 3000)
INSERT [dbo].[T_Peso] ([IDPeso], [intervaloMenorP], [intervaloMayorP]) VALUES (7, 3000, 4000)
INSERT [dbo].[T_Peso] ([IDPeso], [intervaloMenorP], [intervaloMayorP]) VALUES (8, 4000, 5000)
INSERT [dbo].[T_Peso] ([IDPeso], [intervaloMenorP], [intervaloMayorP]) VALUES (9, 5000, 7000)
SET IDENTITY_INSERT [dbo].[T_Provincia] ON 

INSERT [dbo].[T_Provincia] ([IDProvincia], [nombreprovincia], [IDDepartamento]) VALUES (1, N'Lima', 1)
SET IDENTITY_INSERT [dbo].[T_Provincia] OFF
INSERT [dbo].[T_Tipocarga] ([IDTipoCarga], [tipocarga], [descripcion]) VALUES (801, N'Muebles', NULL)
INSERT [dbo].[T_Tipocarga] ([IDTipoCarga], [tipocarga], [descripcion]) VALUES (802, N'Ropa y Calzado', NULL)
INSERT [dbo].[T_Tipocarga] ([IDTipoCarga], [tipocarga], [descripcion]) VALUES (803, N'Madera y minerales', NULL)
INSERT [dbo].[T_Tipocarga] ([IDTipoCarga], [tipocarga], [descripcion]) VALUES (804, N'Productos Agricolas y Pesca', NULL)
INSERT [dbo].[T_Tipocarga] ([IDTipoCarga], [tipocarga], [descripcion]) VALUES (805, N'Electrodomesticos', NULL)
INSERT [dbo].[T_Tipocarga] ([IDTipoCarga], [tipocarga], [descripcion]) VALUES (806, N'Equipos Industriales', NULL)
INSERT [dbo].[T_Tipocarga] ([IDTipoCarga], [tipocarga], [descripcion]) VALUES (807, N'Vidrios', NULL)
INSERT [dbo].[T_Tipocarga] ([IDTipoCarga], [tipocarga], [descripcion]) VALUES (808, N'Productos comestibles', NULL)
INSERT [dbo].[T_Tipocarga] ([IDTipoCarga], [tipocarga], [descripcion]) VALUES (809, N'otros', NULL)
INSERT [dbo].[T_Tipocarga] ([IDTipoCarga], [tipocarga], [descripcion]) VALUES (810, N'Material Oficina', NULL)
SET IDENTITY_INSERT [dbo].[T_Transportista] ON 

INSERT [dbo].[T_Transportista] ([IDTransportista], [nombretransportista], [fechaentrada], [IDUsuario]) VALUES (3, N'Chofer Juan', CAST(0x64220B00 AS Date), 2001)
SET IDENTITY_INSERT [dbo].[T_Transportista] OFF
SET IDENTITY_INSERT [dbo].[T_Usuario] ON 

INSERT [dbo].[T_Usuario] ([IDUsuario], [nombreusuario], [contraseña], [IDPerfil]) VALUES (100, N'Administrador', N'123', 1)
INSERT [dbo].[T_Usuario] ([IDUsuario], [nombreusuario], [contraseña], [IDPerfil]) VALUES (101, N'Recepcionista Ana', N'12345', 3)
INSERT [dbo].[T_Usuario] ([IDUsuario], [nombreusuario], [contraseña], [IDPerfil]) VALUES (102, N'Jefe Wilmer', N'12345', 4)
INSERT [dbo].[T_Usuario] ([IDUsuario], [nombreusuario], [contraseña], [IDPerfil]) VALUES (1001, N'Carlos', N'12345', 2)
INSERT [dbo].[T_Usuario] ([IDUsuario], [nombreusuario], [contraseña], [IDPerfil]) VALUES (2001, N'Chofer Juan', N'12345', 5)
INSERT [dbo].[T_Usuario] ([IDUsuario], [nombreusuario], [contraseña], [IDPerfil]) VALUES (2002, N'El_Dark', N'123', 2)
INSERT [dbo].[T_Usuario] ([IDUsuario], [nombreusuario], [contraseña], [IDPerfil]) VALUES (2003, N'fgdfg', N'234234', 2)
INSERT [dbo].[T_Usuario] ([IDUsuario], [nombreusuario], [contraseña], [IDPerfil]) VALUES (2004, N'il', N'123', 2)
INSERT [dbo].[T_Usuario] ([IDUsuario], [nombreusuario], [contraseña], [IDPerfil]) VALUES (2006, N'gdfg', N'2', 2)
INSERT [dbo].[T_Usuario] ([IDUsuario], [nombreusuario], [contraseña], [IDPerfil]) VALUES (2007, N'gdfgdfh', N'123', 2)
INSERT [dbo].[T_Usuario] ([IDUsuario], [nombreusuario], [contraseña], [IDPerfil]) VALUES (2008, N'fbfdghfg', N'123', 2)
INSERT [dbo].[T_Usuario] ([IDUsuario], [nombreusuario], [contraseña], [IDPerfil]) VALUES (2009, N'fbfdghfg', N'123', 2)
INSERT [dbo].[T_Usuario] ([IDUsuario], [nombreusuario], [contraseña], [IDPerfil]) VALUES (2010, N'TheBest', N'12345', 2)
INSERT [dbo].[T_Usuario] ([IDUsuario], [nombreusuario], [contraseña], [IDPerfil]) VALUES (2011, N'yo', N'123', 2)
INSERT [dbo].[T_Usuario] ([IDUsuario], [nombreusuario], [contraseña], [IDPerfil]) VALUES (2012, N'joseangel', N'1234', 2)
INSERT [dbo].[T_Usuario] ([IDUsuario], [nombreusuario], [contraseña], [IDPerfil]) VALUES (2013, N'xaxaxa', N'123', 2)
INSERT [dbo].[T_Usuario] ([IDUsuario], [nombreusuario], [contraseña], [IDPerfil]) VALUES (2014, N'johnjohn', N'123', 6)
SET IDENTITY_INSERT [dbo].[T_Usuario] OFF
INSERT [dbo].[T_Vehiculo] ([placa], [modelo], [pesobruto], [pesoneto], [pesotara], [altura], [ancho], [marca], [soat], [IDFlota], [IDEstadovehiculo]) VALUES (N'KQ-1316', N'Furgoneta basica', 2700, 1000, 1700, 3.2, 2.2, N'Volswagen', N'53214863', 1, 1)
INSERT [dbo].[T_Volumen] ([IDVolumen], [intervaloMenorV], [intervaloMayorV]) VALUES (1, 0, 5)
INSERT [dbo].[T_Volumen] ([IDVolumen], [intervaloMenorV], [intervaloMayorV]) VALUES (2, 5, 10)
INSERT [dbo].[T_Volumen] ([IDVolumen], [intervaloMenorV], [intervaloMayorV]) VALUES (3, 10, 20)
ALTER TABLE [dbo].[T_Almacen]  WITH CHECK ADD  CONSTRAINT [FK_T_Almacen_T_Local] FOREIGN KEY([IDLocal])
REFERENCES [dbo].[T_Local] ([IDLocal])
GO
ALTER TABLE [dbo].[T_Almacen] CHECK CONSTRAINT [FK_T_Almacen_T_Local]
GO
ALTER TABLE [dbo].[T_AuxiliarCarga]  WITH CHECK ADD  CONSTRAINT [FK_T_AuxiliarCarga_T_Usuario] FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[T_Usuario] ([IDUsuario])
GO
ALTER TABLE [dbo].[T_AuxiliarCarga] CHECK CONSTRAINT [FK_T_AuxiliarCarga_T_Usuario]
GO
ALTER TABLE [dbo].[T_Cliente]  WITH CHECK ADD  CONSTRAINT [clienteusuario] FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[T_Usuario] ([IDUsuario])
GO
ALTER TABLE [dbo].[T_Cliente] CHECK CONSTRAINT [clienteusuario]
GO
ALTER TABLE [dbo].[T_Destino]  WITH CHECK ADD  CONSTRAINT [FK_T_Destino_T_Pedido] FOREIGN KEY([IDPedido])
REFERENCES [dbo].[T_Pedido] ([IDPedido])
GO
ALTER TABLE [dbo].[T_Destino] CHECK CONSTRAINT [FK_T_Destino_T_Pedido]
GO
ALTER TABLE [dbo].[T_Destino]  WITH CHECK ADD  CONSTRAINT [FK_T_Emision_T_Distrito] FOREIGN KEY([IDDistrito])
REFERENCES [dbo].[T_Distrito] ([IDDistrito])
GO
ALTER TABLE [dbo].[T_Destino] CHECK CONSTRAINT [FK_T_Emision_T_Distrito]
GO
ALTER TABLE [dbo].[T_Distribucion]  WITH CHECK ADD  CONSTRAINT [DistribucionTransportista] FOREIGN KEY([IDTranportista])
REFERENCES [dbo].[T_Transportista] ([IDTransportista])
GO
ALTER TABLE [dbo].[T_Distribucion] CHECK CONSTRAINT [DistribucionTransportista]
GO
ALTER TABLE [dbo].[T_Distribucion]  WITH CHECK ADD  CONSTRAINT [FK_T_Distribucion_T_AuxiliarCarga] FOREIGN KEY([IDAuxiliarcarga])
REFERENCES [dbo].[T_AuxiliarCarga] ([IDAuxiliarcarga])
GO
ALTER TABLE [dbo].[T_Distribucion] CHECK CONSTRAINT [FK_T_Distribucion_T_AuxiliarCarga]
GO
ALTER TABLE [dbo].[T_Distribucion]  WITH CHECK ADD  CONSTRAINT [FK_T_Distribucion_T_Pedido] FOREIGN KEY([IDPedido])
REFERENCES [dbo].[T_Pedido] ([IDPedido])
GO
ALTER TABLE [dbo].[T_Distribucion] CHECK CONSTRAINT [FK_T_Distribucion_T_Pedido]
GO
ALTER TABLE [dbo].[T_Distribucion]  WITH CHECK ADD  CONSTRAINT [FK_T_Distribucion_T_Vehiculo] FOREIGN KEY([placa])
REFERENCES [dbo].[T_Vehiculo] ([placa])
GO
ALTER TABLE [dbo].[T_Distribucion] CHECK CONSTRAINT [FK_T_Distribucion_T_Vehiculo]
GO
ALTER TABLE [dbo].[T_Distrito]  WITH CHECK ADD  CONSTRAINT [FK_T_Distrito_T_Provincia] FOREIGN KEY([IDProvincia])
REFERENCES [dbo].[T_Provincia] ([IDProvincia])
GO
ALTER TABLE [dbo].[T_Distrito] CHECK CONSTRAINT [FK_T_Distrito_T_Provincia]
GO
ALTER TABLE [dbo].[T_DXP]  WITH CHECK ADD  CONSTRAINT [FK_T_DXP_T_Distancia] FOREIGN KEY([IDDistancia])
REFERENCES [dbo].[T_Distancia] ([IDDistancia])
GO
ALTER TABLE [dbo].[T_DXP] CHECK CONSTRAINT [FK_T_DXP_T_Distancia]
GO
ALTER TABLE [dbo].[T_DXP]  WITH CHECK ADD  CONSTRAINT [FK_T_DXP_T_Peso] FOREIGN KEY([IDPeso])
REFERENCES [dbo].[T_Peso] ([IDPeso])
GO
ALTER TABLE [dbo].[T_DXP] CHECK CONSTRAINT [FK_T_DXP_T_Peso]
GO
ALTER TABLE [dbo].[T_DXV]  WITH CHECK ADD  CONSTRAINT [FK_T_DXV_T_Distancia] FOREIGN KEY([IDDistancia])
REFERENCES [dbo].[T_Distancia] ([IDDistancia])
GO
ALTER TABLE [dbo].[T_DXV] CHECK CONSTRAINT [FK_T_DXV_T_Distancia]
GO
ALTER TABLE [dbo].[T_DXV]  WITH CHECK ADD  CONSTRAINT [FK_T_DXV_T_Volumen] FOREIGN KEY([IDVolumen])
REFERENCES [dbo].[T_Volumen] ([IDVolumen])
GO
ALTER TABLE [dbo].[T_DXV] CHECK CONSTRAINT [FK_T_DXV_T_Volumen]
GO
ALTER TABLE [dbo].[T_Factura]  WITH CHECK ADD  CONSTRAINT [FacturaPedido] FOREIGN KEY([IDPedido])
REFERENCES [dbo].[T_Pedido] ([IDPedido])
GO
ALTER TABLE [dbo].[T_Factura] CHECK CONSTRAINT [FacturaPedido]
GO
ALTER TABLE [dbo].[T_Flota]  WITH CHECK ADD  CONSTRAINT [FK_T_Flota_T_Local] FOREIGN KEY([IDLocal])
REFERENCES [dbo].[T_Local] ([IDLocal])
GO
ALTER TABLE [dbo].[T_Flota] CHECK CONSTRAINT [FK_T_Flota_T_Local]
GO
ALTER TABLE [dbo].[T_GuiaEntrada]  WITH CHECK ADD  CONSTRAINT [FK_T_GuiaEntrada_T_Pedido] FOREIGN KEY([IDPedido])
REFERENCES [dbo].[T_Pedido] ([IDPedido])
GO
ALTER TABLE [dbo].[T_GuiaEntrada] CHECK CONSTRAINT [FK_T_GuiaEntrada_T_Pedido]
GO
ALTER TABLE [dbo].[T_GuiaRemision]  WITH CHECK ADD  CONSTRAINT [guiaremisionPedido] FOREIGN KEY([IDPedido])
REFERENCES [dbo].[T_Pedido] ([IDPedido])
GO
ALTER TABLE [dbo].[T_GuiaRemision] CHECK CONSTRAINT [guiaremisionPedido]
GO
ALTER TABLE [dbo].[T_GuiaSalida]  WITH CHECK ADD  CONSTRAINT [FK_T_GuiaSalida_T_Pedido] FOREIGN KEY([IDPedido])
REFERENCES [dbo].[T_Pedido] ([IDPedido])
GO
ALTER TABLE [dbo].[T_GuiaSalida] CHECK CONSTRAINT [FK_T_GuiaSalida_T_Pedido]
GO
ALTER TABLE [dbo].[T_Local]  WITH CHECK ADD  CONSTRAINT [FK_T_Local_T_Distrito1] FOREIGN KEY([IDDistrito])
REFERENCES [dbo].[T_Distrito] ([IDDistrito])
GO
ALTER TABLE [dbo].[T_Local] CHECK CONSTRAINT [FK_T_Local_T_Distrito1]
GO
ALTER TABLE [dbo].[T_Origen]  WITH CHECK ADD  CONSTRAINT [FK_T_Recepcion_T_Distrito] FOREIGN KEY([IDDistrito])
REFERENCES [dbo].[T_Distrito] ([IDDistrito])
GO
ALTER TABLE [dbo].[T_Origen] CHECK CONSTRAINT [FK_T_Recepcion_T_Distrito]
GO
ALTER TABLE [dbo].[T_Origen]  WITH CHECK ADD  CONSTRAINT [FK_T_Recepcion_T_Pedido] FOREIGN KEY([IDPedido])
REFERENCES [dbo].[T_Pedido] ([IDPedido])
GO
ALTER TABLE [dbo].[T_Origen] CHECK CONSTRAINT [FK_T_Recepcion_T_Pedido]
GO
ALTER TABLE [dbo].[T_Pedido]  WITH CHECK ADD  CONSTRAINT [FK_T_Pedido_T_Almacen] FOREIGN KEY([IDAlmacen])
REFERENCES [dbo].[T_Almacen] ([IDAlmacen])
GO
ALTER TABLE [dbo].[T_Pedido] CHECK CONSTRAINT [FK_T_Pedido_T_Almacen]
GO
ALTER TABLE [dbo].[T_Pedido]  WITH CHECK ADD  CONSTRAINT [FK_T_Pedido_T_Cliente] FOREIGN KEY([IDCliente])
REFERENCES [dbo].[T_Cliente] ([IDCliente])
GO
ALTER TABLE [dbo].[T_Pedido] CHECK CONSTRAINT [FK_T_Pedido_T_Cliente]
GO
ALTER TABLE [dbo].[T_Pedido]  WITH CHECK ADD  CONSTRAINT [FK_T_Pedido_T_DXP] FOREIGN KEY([IDDxP])
REFERENCES [dbo].[T_DXP] ([IDDxP])
GO
ALTER TABLE [dbo].[T_Pedido] CHECK CONSTRAINT [FK_T_Pedido_T_DXP]
GO
ALTER TABLE [dbo].[T_Pedido]  WITH CHECK ADD  CONSTRAINT [FK_T_Pedido_T_DXV] FOREIGN KEY([IDDxV])
REFERENCES [dbo].[T_DXV] ([IDDxV])
GO
ALTER TABLE [dbo].[T_Pedido] CHECK CONSTRAINT [FK_T_Pedido_T_DXV]
GO
ALTER TABLE [dbo].[T_Pedido]  WITH CHECK ADD  CONSTRAINT [FK_T_Pedido_T_Tipocarga] FOREIGN KEY([IDTipocarga])
REFERENCES [dbo].[T_Tipocarga] ([IDTipoCarga])
GO
ALTER TABLE [dbo].[T_Pedido] CHECK CONSTRAINT [FK_T_Pedido_T_Tipocarga]
GO
ALTER TABLE [dbo].[T_Perfilxpermiso]  WITH CHECK ADD  CONSTRAINT [FK_T_Perfilxpermiso_T_Perfil] FOREIGN KEY([IDPerfil])
REFERENCES [dbo].[T_Perfil] ([IDPerfil])
GO
ALTER TABLE [dbo].[T_Perfilxpermiso] CHECK CONSTRAINT [FK_T_Perfilxpermiso_T_Perfil]
GO
ALTER TABLE [dbo].[T_Perfilxpermiso]  WITH CHECK ADD  CONSTRAINT [FK_T_Perfilxpermiso_T_Permiso] FOREIGN KEY([IDPermiso])
REFERENCES [dbo].[T_Permiso] ([IDPermiso])
GO
ALTER TABLE [dbo].[T_Perfilxpermiso] CHECK CONSTRAINT [FK_T_Perfilxpermiso_T_Permiso]
GO
ALTER TABLE [dbo].[T_Provincia]  WITH CHECK ADD  CONSTRAINT [FK_T_Provincia_T_Departamento] FOREIGN KEY([IDDepartamento])
REFERENCES [dbo].[T_Departamento] ([IDDepartamento])
GO
ALTER TABLE [dbo].[T_Provincia] CHECK CONSTRAINT [FK_T_Provincia_T_Departamento]
GO
ALTER TABLE [dbo].[T_Trabajador]  WITH CHECK ADD  CONSTRAINT [FK_T_Trabajador_T_Usuario] FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[T_Usuario] ([IDUsuario])
GO
ALTER TABLE [dbo].[T_Trabajador] CHECK CONSTRAINT [FK_T_Trabajador_T_Usuario]
GO
ALTER TABLE [dbo].[T_Usuario]  WITH CHECK ADD  CONSTRAINT [FK_T_Usuario_T_Perfil] FOREIGN KEY([IDPerfil])
REFERENCES [dbo].[T_Perfil] ([IDPerfil])
GO
ALTER TABLE [dbo].[T_Usuario] CHECK CONSTRAINT [FK_T_Usuario_T_Perfil]
GO
ALTER TABLE [dbo].[T_Vehiculo]  WITH CHECK ADD  CONSTRAINT [FK_T_Vehiculo_T_EstadoVehiculo] FOREIGN KEY([IDEstadovehiculo])
REFERENCES [dbo].[T_EstadoVehiculo] ([IDEstadovehiculo])
GO
ALTER TABLE [dbo].[T_Vehiculo] CHECK CONSTRAINT [FK_T_Vehiculo_T_EstadoVehiculo]
GO
ALTER TABLE [dbo].[T_Vehiculo]  WITH CHECK ADD  CONSTRAINT [FK_T_Vehiculo_T_Flota] FOREIGN KEY([IDFlota])
REFERENCES [dbo].[T_Flota] ([IDFlota])
GO
ALTER TABLE [dbo].[T_Vehiculo] CHECK CONSTRAINT [FK_T_Vehiculo_T_Flota]
GO
USE [master]
GO
ALTER DATABASE [BD_SGPPTC] SET  READ_WRITE 
GO
