<%--
  Created by IntelliJ IDEA.
  User: Joseb
  Date: 02/08/2024
  Time: 02:13 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil docente/Administrador</title>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/formulario.css">

</head>
<body class="pagina2">
<header class="encabezado">
    <img id="logo" src="../recursos/logo.png" alt="Logo Izquierda">
    <img id="logo_Utez" src="../recursos/LogoUtez.png" alt="Logo Derecha">
</header>
<div class="conic-gradient">

    <img id="imagen_arriba" src="../recursos/colorArriba.png" alt="Imagen Arriba">

    <main class="contenedor">

        <h2>Escoge tu perfil:</h2>
        <br><br>
        <div class="contenedor">
            <div class="contenido" onclick="location.href='../html/Contenido_Docente.html'">
                <img src="../recursos/docente.png" alt="Perfil docente" class="img-fluid">
                <br><br>
                <h3><strong>Docente</strong></h3>
            </div>
            <div class="contenido" onclick="location.href='../html/Contenido_Administrativo.html'">
                <img src="../recursos/administrador.png" alt="Perfil Administrador" class="img-fluid">
                <br><br>
                <h3><strong>Administrativo</strong></h3>
            </div>
            <button class="btn-iniciar-sesion" onclick="location.href='../index.html'">Iniciar Sesión</button>
        </div>

    </main>
    <br><br><br>

    <img id="imagen_esq_izq" src="../recursos/colorAbajo.png" alt="Esquina izquierda">
</div>
</body>
</html>
