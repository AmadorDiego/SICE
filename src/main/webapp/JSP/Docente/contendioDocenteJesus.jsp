<%--
  Created by IntelliJ IDEA.
  User: Joseb
  Date: 02/08/2024
  Time: 02:15 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil docente</title>
    <link rel="stylesheet" href="../css/bootstrap.css">

</head>

<body class="pagina3">

<header class="encabezado">
    <a href="../index.html">
        <img id="logo" src="../recursos/logo.png" alt="Logo Izquierda">
    </a>
    <img id="logo_Utez" src="../recursos/LogoUtez.png" alt="Logo Derecha">
</header>
<div class="conic-gradient">
    <img id="imagen_arriba" src="../recursos/colorArriba.png" alt="Imagen Arriba">

    <h2 id="h2_Docente">Bienvenido Docente!</h2>

    <button class="Crear_Examen" onclick="location.href='../html/Creacion_Examen.html'">Crear nuevo</button>
    <br><br><br>
    <div class="Examen  ">
        <div class="titulo">Título del Contenedor</div>
        <div class="descripcion">Descripción del contenido del contenedor.</div>
        <div class="fecha">Fecha: 9 de julio de 2024</div>
        <button class="boton" onclick="location.href=''">Ver</button>
        <button class="boton" onclick="location.href=''">Asignar</button>
    </div>

    <img id="imagen_esq_izq" src="../recursos/colorAbajo.png" alt="Esquina izquierda">
</div>
</body>
</html>
