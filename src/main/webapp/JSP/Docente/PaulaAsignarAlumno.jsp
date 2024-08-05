<%--
  Created by IntelliJ IDEA.
  User: corey
  Date: 04/08/2024
  Time: 08:34 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Asignar alumnos</title>
    <link href="../../CSS/bootstrap.css" rel="stylesheet">
    <style>
        .navbar{
            background-color: #003366 !important;
        }
        .navbar-light .navbar-nav .nav-link {
            color: white !important;
        }
        .full-width-navbar {
            margin: 0;
            padding: 0;
            width: 100%;
        }
    </style>
</head>
<body>
<div class="full-width-navbar">
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="#"></a>
        </div>
    </nav>
</div>
<div class="navbar"></div>
<div class="container">
    <br>
    <h1>Asignar alumnos</h1>
    <div class="group-info">
        <h3>Grupo de 3 A</h3>
    </div>
    <div class="search-and-select row align-items-center">
        <div class="col">
            <input type="text" placeholder="Buscar Alumno" class="form-control">
        </div>
        <div class="col-auto">
            <div class="form-check">
                <input class="form-check-input" type="checkbox" id="selectAll">
                <label class="form-check-label" for="selectAll">
                    Seleccionar a todos
                </label>
            </div>
        </div>
        <div class="col-auto">
            <button class="home-boton">
                <img src="../img/home_icon.png" alt="Home">
            </button>
        </div>
    </div>
    <table class="table">
        <thead>
        <tr>
            <th>Seleccionar</th>
            <th>Nombres</th>
            <th>Apellidos</th>
            <th>Matrícula</th>
        </tr>
        </thead>
        <tbody>
        <!-- Aquí irían los datos de los alumnos -->
        </tbody>
    </table>
    <div class="text-end">
            <button class="btn btn-primary">Guardar</button>
        </div>
    </div>
</body>
</html>
