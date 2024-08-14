<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.model.Grupo" %>
<%@ page import="mx.edu.utez.sice.model.Carrera" %>
<%@ page import="mx.edu.utez.sice.model.DivisionAcademica" %>
<%@ page import="mx.edu.utez.sice.dao.GrupoDao" %>
<%@ page import="mx.edu.utez.sice.dao.CarreraDao" %>
<%@ page import="mx.edu.utez.sice.dao.DivisionAcademicaDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Asignar Examen</title>
    <link href="../../CSS/bootstrap.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.min.css" rel="stylesheet">
    <style>
        .navbar {
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

    <div class="filters d-flex align-items-center mb-4">
        <span class="me-2">Filtros </span>

        <select id="id_grupo" name="grupo" class="form-select me-2">
            <option value="">Seleccione Grupo</option>
            <%
                GrupoDao grupoDao = new GrupoDao();
                ArrayList<Grupo> grupos = grupoDao.getAll();
                for (Grupo g : grupos) {
            %>
            <option value="<%= g.getGrado() %> - <%= g.getGrupo() %>"><%= g.getGrado() %> - <%= g.getGrupo() %></option>
            <%
                }
            %>
        </select>

        <select id="id_division_academica" name="division_academica" class="form-select me-2">
            <option value="">Seleccione División</option>
            <%
                DivisionAcademicaDao divisionDao = new DivisionAcademicaDao();
                ArrayList<DivisionAcademica> divisiones = divisionDao.getAll();
                for (DivisionAcademica d : divisiones) {
            %>
            <option value="<%= d.getDivision_academica() %>"><%= d.getDivision_academica() %></option>
            <%
                }
            %>
        </select>

        <select class="form-select carrera me-2" id="id_carrera" name="carrera">
            <option value="">Seleccione Carrera</option>
            <%
                CarreraDao carreraDao = new CarreraDao();
                ArrayList<Carrera> carreras = carreraDao.getAll();
                for (Carrera c : carreras) {
            %>
            <option value="<%= c.getCarrera() %>"><%= c.getCarrera() %></option>
            <%
                }
            %>
        </select>

        <div class="col-auto">
            <a class="btn btn-primary" href="indexDocente.jsp"> Regresar </a>
        </div>
    </div>

    <table id="tablaExamenes" class="display">
        <thead>
        <tr>
            <th>Grupo</th>
            <th>Grado</th>
            <th>División</th>
            <th>Carrera</th>
            <th>Seleccionar Grupo</th>
        </tr>
        </thead>
        <tbody>
        <%
            ArrayList<Grupo> grupoInfo = grupoDao.getInfo();
            for (Grupo g : grupoInfo) {
                Carrera carrera = new Carrera();
                DivisionAcademica divisionAcademica = new DivisionAcademica();
        %>
        <tr>
            <td><%= g.getGrupo() %></td>
            <td><%= g.getGrado() %></td>
            <td><%= divisionAcademica.getDivision_academica() %></td>
            <td><%= carrera.getCarrera() %></td>
            <td><button class="btn btn-success">Asignar</button></td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>
<script>
    $(document).ready(function() {
        $('#tablaExamenes').DataTable();
    });
</script>
</body>
</html>
