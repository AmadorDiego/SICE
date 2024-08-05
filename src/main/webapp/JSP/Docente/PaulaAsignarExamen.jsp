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
    <title>Asignar Examen</title>
    <link href="../css/style.css" rel="stylesheet">
    <link href="../css/bootstrap.css" rel="stylesheet">

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
<div class="container">
    <br>
    <h1>Asignar Examen</h1>
    <h3>Exámenes por asignar</h3>
    <h3 id="id_periodo"><strong>Mayo-Agosto 2024</strong></h3>

    <div class="filters d-flex align-items-center">
        <span class="me-2">Filtros </span>
        <select id="id_grado" name="grado" class="form-select me-2">
            <option>Grado</option>
            <option>3</option>
            <option>6</option>
            <option>9</option>
        </select>
        <select id="id_grupo" name="grupo" class="form-select me-2">
            <option>Grupo</option>
            <option>A</option>
            <option>B</option>
            <option>C</option>
            <option>D</option>
            <option>E</option>
            <option>F</option>
        </select>
        <select id="id_division_academica" name="division" class="form-select me-2">
            <option>División</option>
            <option>DATID</option>
            <option>DAMI</option>
            <option>DACEA</option>
            <option>DATEFI</option>
        </select>
        <select class="form-select carrera me-2" id="id_carrera" name="carrera">
            <option>Carrera</option>
            <option>Desarrollo Software Multiplataforma</option>
            <option>Redes Digitales</option>
            <option>Terapia Física Área Rehabilitación</option>
            <option>Mantenimiento Industrial</option>
        </select>
        <button class="home-boton">
            <img src="../img/home_icon.png" alt="Home">
        </button>
    </div>

    <table class="table table-striped mt-4">
        <thead>
        <tr>
            <th scope="col">Grado</th>
            <th scope="col">Grupo</th>
            <th scope="col">División</th>
            <th scope="col">Carrera</th>
            <th scope="col">Asignar</th>
        </tr>
        </thead>
        <tbody>
        <!-- Las filas de datos irían aquí :) -->
        </tbody>
    </table>
</div>

</body>
</html>

