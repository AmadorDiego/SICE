<%--
  Created by IntelliJ IDEA.
  User: corey
  Date: 04/08/2024
  Time: 08:33 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="mx.edu.utez.sice.dao.ExamenDao" %>
<%@ page import="mx.edu.utez.sice.dao.GrupoDao" %>
<%@ page import="mx.edu.utez.sice.dao.CarreraDao" %>
<%@ page import="mx.edu.utez.sice.dao.DivisionAcademicaDao" %>
<%@ page import="mx.edu.utez.sice.model.Examen" %>
<%@ page import="mx.edu.utez.sice.model.Grupo" %>
<%@ page import="mx.edu.utez.sice.model.Carrera" %>
<%@ page import="mx.edu.utez.sice.model.DivisionAcademica" %>
<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calificar Exámenes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f6f7; /* Cambia el color del fondo para que coincida con el diseño original */
        }
        .navbar {
            background-color: #1f3c88; /* Cambia el color de la barra superior a azul más oscuro */
            color: white;
            padding: 10px;
            font-size: 1.5rem;
        }
        .filter-container {
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 15px;
            margin-top: 20px;
            flex-wrap: wrap;
        }
        .filter-group {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        .filter-group .form-group {
            min-width: 150px; /* Ajusta el ancho mínimo de los selectores */
        }
        .table-container {
            margin-top: 20px;
        }
        .filters select {
            flex-grow: 1;
        }
        button a {
            color: white;
            text-decoration: none;
        }
    </style>
</head>
<body>
<nav class="navbar">
    Calificar Exámenes
</nav>

<div class="container">
    <h2 class="mt-4">Exámenes contestados</h2>

    <div class="filter-container">
        <form action="PieroCalificarExamen.jsp" method="get" class="filters">
            <div class="filter-group">
                <div class="form-group">
                    <select id="id_grado" name="grado" class="form-control">
                        <option value="">Grado</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                    </select>
                </div>
                <div class="form-group">
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
                </div>
                <div class="form-group">
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
                </div>
                <div class="form-group">
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
                </div>
                <div class="form-group">
                    <select id="id_examen" name="examen" class="form-control">
                        <option value="">Examen</option>
                        <%
                            ExamenDao examenDao = new ExamenDao();
                            Usuario usuario = (Usuario) session.getAttribute("usuario");

                            if (usuario != null) {
                                ArrayList<Examen> lista = examenDao.getAll(usuario.getId_usuario());
                                for (Examen examen : lista) {
                        %>
                        <option value="<%= examen.getId_examen() %>"><%= examen.getNombre_examen() %></option>
                        <%
                                }
                            } else {
                                out.println("<option value=''>No se puede obtener los exámenes</option>");
                            }
                        %>
                    </select>
                </div>
            </div>
            <div class="filter-group">
                <button type="submit" class="btn btn-primary">Filtrar</button>
                <button class="btn btn-outline-secondary">
                    <a href="indexDocente.jsp">home</a>
                </button>
            </div>
        </form>
    </div>

    <div class="table-container">
        <table class="table table-striped">
            <thead>
            <tr>
                <th>Examen</th>
                <th>Grado</th>
                <th>Grupo</th>
                <th>División</th>
                <th>Carrera</th>
                <th>Calificar</th>
                <th>Reporte</th>
            </tr>
            </thead>
            <tbody>
            <!-- Aquí irían las filas generadas por la consulta -->
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
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>