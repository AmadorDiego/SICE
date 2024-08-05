<%@ page import="mx.edu.utez.sice.model.Examen" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: amado
  Date: 27/07/2024
  Time: 02:30 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Inicio docente</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link href="CSS/bootstrap.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f0f0;
        }
        .navbar {
            background-color: #002E60 !important;
        }
        .navbar-light .navbar-nav .nav-link {
            color: white !important;
        }
        .navbar-light .navbar-toggler-icon {
            background-image: url("/img/menu.png") !important; /* Cambiado a la imagen local */
            background-size: cover;
        }
        .btn-primary {
            background-color: #00604C !important;
            border-color: #00604C !important;
        }
        .btn-success {
            background-color: #00604C !important;
            border-color: #00604C !important;
        }
        .thead {
            background-color: #002E60;
            color: white;
        }
    </style>

</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="#"></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="row">
                <div class="col"></div>
                <div class="navbar-nav">
                    <!--<a class="nav-link active" aria-current="page" href="#">Home</a>-->
                    <a class="nav-link" href="#">Boton1</a>
                    <a class="nav-link" href="#">Boton2</a>
                    <a class="nav-link" href="#">Boton3</a>
                    <a class="nav-link" href="#">Boton4</a>
                    <!--<a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>-->
                </div>
            </div>


        </div>
    </div>
</nav>

<!--Modofique container-->
<div class="container my-2 my-md-4">
    <div class="row"> <!--Aqui todo lo meti por medio de un div y class row-->
        <h1 class="text-start mb-3">¡Bienvenido Docente!</h1>
        <h3 class="text-start mb-4">Exámenes creados</h3>

        <div class="d-flex justify-content-between align-items-center mb-3">
            <div class="d-flex align-items-center">
                <span class="me-2">Crear examen</span>
                <button class="btn btn-primary">Crear</button>
                <div>
                    <!--Separe lo que fue crear y examenes por div y agregue clases a cada uno-->
                </div class="d-flex align-items-center">
                <span class="me-2">Exámenes por calificar</span>
                <button class="btn btn-primary">Ver</button>
            </div>
        </div>

        <!--Modifique las tablas para ajustarlas-->
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead class="thead">
                <tr>
                    <th>Examen</th>
                    <th>Descripcion</th>
                </tr>
                </thead>
                <tbody>
                <!-- Aqui se van a agregar los datos de la tabla -->
                </tbody>
            </table>
        </div>
    </div>

</div>
<script src="../../JS/jquery-3.7.0.js"></script>
<script src="../../JS/bootstrap.js"></script>
</body>
</html>