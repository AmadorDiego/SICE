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
    <title>Calificar Examenes</title>
    <link href="../../CSS/bootstrap.css" rel="stylesheet">
    <style>
        .filter-group {
            display: flex;
            align-items: center;
            padding: 10px;
            flex-wrap: wrap;
        }
        .filter-group select, .filter-group span {
            margin-right: 10px;
            margin-bottom: 10px;
        }
        .filter-group select {
            width: 100%;
        }
        @media (min-width: 576px) {
            .filter-group #id_grado,
            .filter-group #id_grupo {
                width: 100px;
            }
            .filter-group #id_division {
                width: 150px;
            }
            .filter-group #id_carrera {
                width: 300px;
            }
        }
        .home-boton-container {
            margin-left: auto;
        }
        .filters {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            width: 100%;
        }
        .filters select {
            flex-grow: 1;
        }
        .table th, .table td {
            vertical-align: middle;
            text-align: center;
        }
        .table .examen-col, .table .calificar-col, .table .reporte-col {
            padding-left: 20px;
            padding-right: 20px;
        }
    </style>
</head>
<body>
<div class="navbar"></div>
<div class="container">
    <h1>Calificar Examenes</h1>
    <h3>Examenes contestados</h3>
    <div class="filter-group">
        <div class="filters">
            <span>Filtros:</span>
            <select id="id_grado" name="grado" class="form-control">
                <option value="">Grado</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
            </select>
            <select id="id_grupo" name="grupo" class="form-control">
                <option value="">Grupo</option>
                <option value="A">A</option>
                <option value="B">B</option>
                <option value="C">C</option>
            </select>
            <select id="id_division" name="division" class="form-control">
                <option value="">División</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
            </select>
            <select id="id_carrera" name="carrera" class="form-control">
                <option value="">Carrera</option>
                <option value="ing">Ingeniería</option>
                <option value="med">Medicina</option>
                <option value="adm">Administración</option>
            </select>
        </div>
        <div class="home-boton-container">
            <button class="home-boton btn btn-outline-secondary" onclick="location.href='../index.html';">
                <img src="../img/home-boton.png" alt="Home">
            </button>
        </div>
    </div>
    <table class="table table-striped mt-4">
        <thead>
        <tr>
            <th class="examen-col">Examen</th>
            <th>Grado</th>
            <th>Grupo</th>
            <th>División</th>
            <th>Carrera</th>
            <th class="calificar-col">Calificar</th>
            <th class="reporte-col">Reporte</th>
        </tr>
        </thead>
        <tbody>
        <!-- Aquí irían los datos de examen -->
        </tbody>
    </table>
</div>
<script src="../js/bootstrap.bundle.min.js"></script>
</body>
</html>
