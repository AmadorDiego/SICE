<%--
  Created by IntelliJ IDEA.
  User: corey
  Date: 04/08/2024
  Time: 08:33 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.model.Grupo" %>
<%@ page import="mx.edu.utez.sice.model.Carrera" %>
<%@ page import="mx.edu.utez.sice.model.DivisionAcademica" %>
<%@ page import="mx.edu.utez.sice.model.Examen" %>
<%@ page import="mx.edu.utez.sice.dao.GrupoDao" %>
<%@ page import="mx.edu.utez.sice.dao.CarreraDao" %>
<%@ page import="mx.edu.utez.sice.dao.DivisionAcademicaDao" %>
<%@ page import="mx.edu.utez.sice.dao.ExamenDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calificar Exámenes</title>
    <link href="../../CSS/bootstrap.css" rel="stylesheet">
    <style>
        body {
            background-color: rgb(242, 242, 242); /* Fondo gris claro */
        }
        .navbar {
            background-color: rgb(0, 46, 96); /* Barra azul */
            height: 50px;
        }
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
            .filter-group #id_examen {
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
<div class="navbar"></div> <!-- Barra azul -->
<div class="container">
    <h1>Calificar Exámenes</h1>
    <h3>Exámenes contestados</h3>
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
                <%
                    GrupoDao grupoDao = new GrupoDao();
                    ArrayList<Grupo> grupos = grupoDao.getAll();
                    for (Grupo g : grupos) {
                %>
                <option value="<%= g.getId_grupo() %>"><%= g.getGrado() %> - <%= g.getGrupo() %></option>
                <%
                    }
                %>
            </select>
            <select id="id_division" name="division" class="form-control">
                <option value="">División</option>
                <%
                    DivisionAcademicaDao divisionDao = new DivisionAcademicaDao();
                    ArrayList<DivisionAcademica> divisiones = divisionDao.getAll();
                    for (DivisionAcademica d : divisiones) {
                %>
                <option value="<%= d.getId_division_academica() %>"><%= d.getDivision_academica() %></option>
                <%
                    }
                %>
            </select>
            <select id="id_carrera" name="carrera" class="form-control">
                <option value="">Carrera</option>
                <%
                    CarreraDao carreraDao = new CarreraDao();
                    ArrayList<Carrera> carreras = carreraDao.getAll();
                    for (Carrera c : carreras) {
                %>
                <option value="<%= c.getId_carrera() %>"><%= c.getCarrera() %></option>
                <%
                    }
                %>
            </select>
            <select id="id_examen" name="examen" class="form-control">
                <option value="">Examen</option>
                <%
                    ExamenDao examenDao = new ExamenDao();
                    ArrayList<Examen> examenes = examenDao.getAll();
                    for (Examen e : examenes) {
                %>
                <option value="<%= e.getId_examen() %>"><%= e.getNombreExamen() %></option>
                <%
                    }
                %>
            </select>
        </div>
        <div class="home-boton-container">
            <button class="home-boton btn btn-outline-secondary" onclick="location.href='../index.html';">
                <a href="indexDocente.jsp">home</a>
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
        <tbody id="contenido">
        <c:forEach var="examen" items="${examenes}">
            <tr>
                <td>${examen.nombre}</td>
                <td>${examen.grado}</td>
                <td>${examen.grupo}</td>
                <td>${examen.division}</td>
                <td>${examen.carrera}</td>
                <td>
                    <form action="calificarExamen" method="get">
                        <button type="submit" class="btn btn-success">Calificar</button>
                        <input type="hidden" name="examenId" value="${examen.id}">
                    </form>
                </td>
                <td>
                    <form action="reporteExamen" method="get">
                        <button type="submit" class="btn btn-primary">Reporte</button>
                        <input type="hidden" name="examenId" value="${examen.id}">
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<script src="../js/bootstrap.bundle.min.js"></script>
</body>
</html>
