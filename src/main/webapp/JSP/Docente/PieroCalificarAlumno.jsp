<%--
  Created by IntelliJ IDEA.
  User: corey
  Date: 04/08/2024
  Time: 08:33 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calificar Estudiante</title>
    <link href="../../CSS/bootstrap.css" rel="stylesheet">
    <style>
        .filter-group {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: nowrap;
            padding: 10px 0;
        }
        .filter-group input {
            margin-right: 10px;
            flex-grow: 1;
        }
        .home-boton-container {
            margin-left: auto;
        }
        .table th, .table td {
            vertical-align: middle;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="navbar"></div>
<div class="container">
    <h1>Calificar Estudiante</h1>
    <h3>Grupo de <span>3</span> <span>A</span></h3>
    <div class="filter-group mb-3">
        <input type="text" id="buscar_alumno" placeholder="Buscar Alumno" class="form-control">
        <div class="home-boton-container">
            <button class="home-boton btn btn-outline-secondary" onclick="location.href='../index.html';">
                <img src="../img/home-boton.png" alt="Home">
            </button>
        </div>
    </div>
    <table class="table table-striped mt-4">
        <thead>
        <tr>
            <th>Nombres</th>
            <th>Apellidos</th>
            <th>Matrícula</th>
            <th>Calificar</th>
        </tr>
        </thead>
        <tbody>
        <!-- Aquí irían los datos -->
        </tbody>
    </table>
</div>
<script src="../js/bootstrap.bundle.min.js"></script>
</body>
</html>

