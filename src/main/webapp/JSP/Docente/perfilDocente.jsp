<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Perfil</title>
    <link rel="stylesheet" type="text/css" href="../../CSS/datatables.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/adicionalesEBM.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/fondo.css">
    <!--///////////////////////////// Iconos ////////////////////////////////////-->
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@30,600,0,0"/>
    <%
        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuarioIndexDocente");
        if (usuario != null){
    %>
    <style>
        .btn-primary {
            background-color: #003e81;
        }
    </style>
</head>
<body>
<!--//////////////////////////////////////// Fondo ///////////////////////////////////////////////////-->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>


<!-- //////////////////////////////////////////NavBar//////////////////////////////////////////////////////  -->
<header>
    <nav class="navbar bg-blue-utz">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <a class="navbar-brand text-white">
                <img src="../../IMG/logoBueno.png" width="50" height="45" alt="Logo"
                     class="d-inline-block align-middle mt-0 mb-2">
                <h3 class="ms-2 d-inline-block align-middle">SICE</h3>
            </a>
            <div class="d-flex">
                <a href="indexDocente.jsp.jsp"
                   class="btn btn-primary bg-blue-utz ms-3 text-white border-0 d-flex align-items-center">
                    <span class="material-symbols-rounded">home</span>
                    <h6 class="mb-0 ms-2">Inicio</h6>
                </a>

                <!------------- Boton dezplegable ---------------->
                <div class="dropdown dropstart">
                    <button class="btn btn-primary bg-blue-utz ms-3 text-white border-0" type="button"
                            id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                        <span class="material-symbols-rounded">arrow_drop_down</span>
                    </button>
                    <ul class="dropdown-menu bg-green-utz-claro" aria-labelledby="dropdownMenuButton">
                        <li class="p-2">
                            <a class="btn btn-success bg-green-utz d-flex align-items-center">
                                <span class="material-symbols-rounded">person</span>
                                <h6 class="mb-0 ms-2">Perfil</h6>
                            </a>
                        </li>
                        <li class="p-2">
                            <a href="../../CerrarSesionServlet" class="btn btn-danger bg-red-SICE d-flex align-items-center">
                                <span class="material-symbols-rounded">logout</span>
                                <h6 class="mb-0 ms-2">Cerrar Sesion</h6>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
</header>


<!--////////////////////////////////////// Contenido //////////////////////////////////////////////////-->
<div class="container mt-4">
    <div class="row rounded-4 bg-green-utz">
        <div class="col-md-7 col-12 p-4">
            <h2 class="blue-utz mb-4">Perfil</h2>

            <div class="mb-3">
                <h4 class="text-white">Nombre/s</h4>
                <input type="text" class="form-control w-75" disabled="" value="Nombre">
            </div>
            <div class="mb-3">
                <h4 class="text-white">Apellido/s</h4>
                <input type="text" class="form-control w-75" disabled="" value="Apellido">
            </div>
            <div>
                <h4 class="text-white">Correo</h4>
                <input type="text" class="form-control w-75" disabled="" value="Correo">
            </div>
        </div>


        <div class="col-md-5 col-12 p-3">
            <h2 class="blue-utz mb-4">Cambiar Contraseña</h2>
            <br>
            <div class="mb-3">
                <h4 class="text-white">Nueva Contraseña</h4>
                <input type="text" class="form-control" disabled="">
            </div>
            <div class="mb-3">
                <h4 class="text-white">Confirmar Contraseña</h4>
                <input type="text" class="form-control" disabled="">
            </div>
            <button type="submit" class="btn btn-primary bg-blue-utz">
                <h6 class="d-flex align-items-center">Cambiar contraseña</h6>
            </button>
        </div>
    </div>
</div>
    <script src="../../JS/bootstrap.js"></script>
    <script src="../../JS/bootstrap.bundle.min.js"></script>
</body>
</html>
<%} else {response.sendRedirect("../permisoDenegado.jsp");}%>