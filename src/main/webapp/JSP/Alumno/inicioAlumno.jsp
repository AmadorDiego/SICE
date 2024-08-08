
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Bienvenido Alumno</title>
    <link rel='stylesheet' type='text/css' media='screen' href='../../CSS/bootstrap.css'>
    <link rel='stylesheet' type='text/css' media='screen' href='../../CSS/fondo.css'>
    <link rel='stylesheet' type='text/css' media='screen' href='../../CSS/adicionalesEBM.css'>
</head>
<body>
<!--/////////////////////////////////// Fondo //////////////////////////////////////////-->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>


<!-- //////////////////////////// Navbar /////////////////////////////////-->
<header>
    <div class="collapse" id="navbarToggleExternalContent">
        <div class="bg-blue-utz p-2">
            <h2 class="text-white p-2 ms-2">SICE</h2>
            <div class="d-flex flex-column ms-2">
                <a href="inicioAlumno.jsp" class="btn w-25 text-white btn-brillo-efecto bg-blue-utz"><h6>Inicio</h6></a>
                <a href="alumnoRelizados.jsp" class="btn w-25 text-white btn-brillo-efecto bg-blue-utz"><h6></h6></a>
            </div>
        </div>
    </div>
    <nav class="navbar bg-blue-utz">
        <div class="container-fluid">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
    </nav>
</header>


<!--////////////////////////// Encabezado ////////////////////////////////////-->
<div class="container-fluid">
    <div class="row align-items-center">
        <div class="col-6 p-4">
            <h1 class="text-white">¡Bienvenido Alumno!</h1>
        </div>
        <div class="col-6 p-4 d-flex flex-row-reverse bd-highlight gap-2">
            <a href="#" class="btn bg-green-SICE-obscuro position-relative text-white">Pendientes</a>
            <a href="#" class="btn bg-green-SICE-obscuro position-relative text-white">Realizados</a>
        </div>
    </div>


    <hr style="color: white">

    <!--////////////////////////////// Contenido principal(Tarjetas) ////////////////////////////-->
    <div class="row">
        <div class="col-12 col-md-6 p-4">
            <div class="card rounded-5 border-0 bg-blue-utz">
                <div class="card-header bg-blue-utz border-0 rounded-5"><br></div>
                <div class="card-body bg-gray-SICE rounded-bottom border-0">
                    <h3 class="card-title blue-utz"><strong>Examen unidad 1</strong></h3>
                    <h6 class="card-text text-white">Contestar examen, Buena tarde.</h6>
                    <div class="p-4 d-flex flex-row-reverse bd-highlight gap-2">
                        <a href="#" class="btn bg-blue-utz text-white">Realizar</a>
                        <strong class="text-white align-content-center">DD-MM-AAAA</strong>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-md-6 p-4">
            <div class="card rounded-5 border-0 bg-blue-utz">
                <div class="card-header bg-blue-utz rounded-5 border-0"><br></div>
                <div class="card-body bg-gray-SICE rounded-bottom border-0">
                    <h3 class="card-title blue-utz"><strong>Examen unidad 1</strong></h3>
                    <h6 class="card-text text-white">Contestar examen, Buena tarde.</h6>
                    <div class="p-4 d-flex flex-row-reverse bd-highlight gap-2">
                        <a href="#" class="btn bg-blue-utz text-white">Realizar</a>
                        <strong class="text-white align-content-center">DD-MM-AAAA</strong>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<script href="../../JS/bootstrap.js"></script>
</body>
</html>
