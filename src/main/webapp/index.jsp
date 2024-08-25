<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>SICE Examenes</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='CSS/bootstrap.css'>
    <link rel='stylesheet' type='text/css' media='screen' href='CSS/adicionalesEBM.css'>
    <link rel='stylesheet' type='text/css' media='screen' href='CSS/fondoLandingPage.css'>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap"
          rel="stylesheet">
    <!--///////////////////////////// Iconos ////////////////////////////////////-->
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@30,600,0,0"/>
</head>
<body>
<!-- //////////////////////////// Navbar /////////////////////////////////-->
<header>
    <nav class="navbar navbar-expand-lg navbar-light bg-blue-utz">
        <div class="container-fluid">
            <img src="IMG/logoBueno.png" class="me-0 d-flex justify-content-start" width="50" height="45" alt="Logo">
            <ul class="navbar-nav mb-1">
                <li class="nav-item me-2">
                    <a class="text-white btn btn-success bg-green-utz d-flex align-items-center justify-content-end"
                       href="loginSICE.jsp">
                        <h6 class="mb-0 p-1">Iniciar Sesion</h6>
                    </a>
                </li>
            </ul>
        </div>
    </nav>
</header>

<!--////////////////////////////////////Fondo//////////////////////////////////////////////-->
<div class="bg-container">
    <div class="area">
        <ul class="circles">
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
</div>


<!--///////////////////////////////////Contenido (Descripccion)///////////////////////////////////////////-->
<div class="container">
    <div class="row d-flex mt-4 mb-5">
        <div class="col-12 mb-2">
            <h1 class="blue-utz d-flex justify-content-center"><strong>¡Bienvenido a SICE!</strong></h1>
            <h2 class="blue-utz d-flex justify-content-center"><strong>(Sistema de Creacion de Examenes)</strong></h2>
        </div>
    </div>
    <div class="row d-flex justify-content-center align-items-center mt-2">


        <div class="col-12 col-md-4">
            <div class="bg-blue-utz rounded-5 p-3 d-flex flex-column align-items-center mb-md-0 mb-2">
                <div class="d-flex justify-content-center">
                    <img width="120" height="140" src="IMG/alumicon.svg" alt="Admin icon">
                </div>
                <h2 class="text-white p-2 text-center">Alumno</h2>
                <h4 class="text-white p-2 text-center">Crea examenes, calificalos y contestalos de manera rapida y eficiente.</h4>
            </div>
        </div>

        <div class="col-12 col-md-4">
            <div class="bg-blue-utz rounded-5 p-3 d-flex flex-column align-items-center mb-md-0 mb-2">
                <div class="d-flex justify-content-center">
                    <img width="120" height="140" src="IMG/docenteicon.svg" alt="Admin icon">
                </div>
                <h2 class="text-white p-2 text-center">Docente</h2>
                <h4 class="text-white p-2 text-center">Crea examenes, asignalos y calificalos.</h4>
            </div>
        </div>

        <div class="col-12 col-md-4">
            <div class="bg-blue-utz rounded-5 p-3 d-flex flex-column align-items-center mb-md-0 mb-2">
                <div class="d-flex justify-content-center">
                    <img width="120" height="140" src="IMG/adminicon.svg" alt="Admin icon">
                </div>
                <h2 class="text-white p-2 text-center">Administrador</h2>
                <h4 class="text-white p-2 text-center">Registra, elimina, modifica grupos y alumnos.</h4>
            </div>
        </div>
    </div>
</div>
<script src="JS/bootstrap.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="JS/es-MX.json"></script>
</body>
</html>
