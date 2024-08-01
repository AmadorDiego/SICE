<%--
  Created by IntelliJ IDEA.
  User: eriks
  Date: 31/07/2024
  Time: 08:32 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Bienvenido</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='CSS/bootstrap.css'>
    <link rel='stylesheet' type='text/css' media='screen' href='CSS/adicionales.css'>
</head>


<body style="background-color: #D9D9D9">
<!-- //////////////////////////// Navbar /////////////////////////////////-->
<header>
    <nav class="navbar navbar-light bg-blue-utz">
        <div class="container-fluid">
            <a class="navbar-brand" href="VistaDocente.html">
                <img src="IMG/LogoUtez.png" alt="" width="80" height="auto" class="d-inline-block align-text-top">
                <h3 class="d-inline-block align-text-top text-white">SICE</h3>
            </a>
        </div>
    </nav>
</header>


<!--////////////////////////// Encabezado ////////////////////////////////////-->
<div class="container-fluid">
    <div class="row align-items-center">
        <div class="col-6 p-4">
            <h1 class="text-white">¡Bienvenido Docente!</h1>
        </div>
        <div class="col-6 p-4 d-flex flex-row-reverse bd-highlight gap-2">
            <a href="#" class="btn bg-green-SICE-obscuro position-relative text-white">Anteriores</a>
            <a href="#" class="btn bg-green-SICE-obscuro position-relative text-white">Crear</a>
            <a href="#" class="btn bg-green-SICE-obscuro position-relative text-white">Inactivos</a>
        </div>
    </div>

    <hr style="color: white">


    <!--////////////////////////////// Contenido principal(Tarjetas) ////////////////////////////-->
    <div class="row">
        <div class="col-6 p-4">
            <div class="card rounded-5">
                <div class="card-header bg-green-SICE-obscuro">
                </div>
                <div class="card-body bg-gray-SICE">
                    <h4 class="card-title green-SICE-resaltados"><strong>Examen unidad 1</strong></h4>
                    <p class="card-text text-white">Contestar examen, Buena tarde.</p>
                    <div class="p-4 d-flex flex-row-reverse bd-highlight gap-2">
                        <a href="#" class="btn bg-red-SICE text-white">Eliminar</a>
                        <a href="#" class="btn bg-green-SICE-obscuro text-white">Asignar</a>
                        <a href="#" class="btn bg-blue-utz text-white">Modificar</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script src='JS/bootstrap.js'></script>

</body>
</html>
