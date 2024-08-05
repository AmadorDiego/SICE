
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
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
</head>
<body>
<!-- //////////////////////////// Navbar /////////////////////////////////-->
<header>
    <nav class="navbar navbar-expand-lg navbar-light bg-blue-utz">
        <div class="container-fluid">
            <h2 class="text-white p-2 me-4">SICE</h2>
            <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
                <ul class="navbar-nav mb-1">
                    <li class="nav-item me-2">
                        <a class="text-white btn bg-green-utz d-flex align-items-center justify-content-center" href="loginSICE.jsp"><h6 class="mb-0 p-1">Iniciar Sesion</h6></a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>

<!--////////////////////////////////////Fondo//////////////////////////////////////////////-->
<div class="bg-container">
    <div class="area" >
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
    <div class="row">
        <div class="col-12 col-md-6 position-absolute top-50 start-20 translate-middle-y p-2">
            <h1 class="blue-utz">¡Bienvenido a SICE!</h1>
            <h2 class="blue-utz">(Sistema de Creacion de Examenes)</h2>
        </div>


        <div class="col-md-6 position-absolute top-50 end-0 translate-middle-y p-3">
            <div class="bg-blue-utz rounded-5 p-3">
                <h2 class="text-white p-3">Crea examenes, calificalos y contestalos de manera rapida y eficiente.</h2>
                <a type="button" class="btn bg-green-utz p-2 text-white" href="loginSICE.jsp">¡Empezar ahora!</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
