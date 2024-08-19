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
    <link rel="stylesheet" type="text/css" href="../../CSS/datatables.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.css">
    <script src="../../JS/dataTables.bootstrap5.js"></script>
    <link rel="stylesheet" type="text/css" href="../../CSS/adicionalesEBM.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/fondo.css">
    <!--///////////////////////////// Iconos ////////////////////////////////////-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@30,600,0,0"/>
    <style>
        .content-container {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            margin-top: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .filter-container {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }
        .filter-container select, .filter-container button {
            height: 38px;
        }
        .table-container {
            margin-top: 20px;
        }
        .btn-sm {
            padding: .25rem .5rem;
            font-size: .875rem;
            line-height: 1.5;
            border-radius: .2rem;
        }
        .btn-calificar {
            background-color: #28a745;
            color: white;
        }
        .btn-reporte {
            background-color: #007bff;
            color: white;
        }
    </style>
</head>
<body>
<!-- //////////////////////////////////////////NavBar//////////////////////////////////////////////////////  -->
<header>
    <nav class="navbar bg-blue-utz">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <a class="navbar-brand text-white">
                <img src="../../IMG/logoBueno.png" width="50" height="45" alt="Logo" class="d-inline-block align-middle mt-0 mb-2">
                <h3 class="ms-2 d-inline-block align-middle">SICE</h3>
            </a>
            <div class="d-flex">
                <a href="indexDocente.jsp" class="btn btn-primary bg-blue-utz ms-3 text-white border-0">
                    <span class="material-symbols-rounded">home</span>
                </a>
            </div>
        </div>
    </nav>
</header>

<!--///////////////////////////////////////////// Fondo //////////////////////////////////////////////////////////////-->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>


<!--//////////////////////////////////// Encabezado ////////////////////////////////////////////////-->
<div class="container content-container">
    <h3 class="mb-4 blue-utz">Exámenes contestados</h3>



<!--////////////////////////////////////// Contenido /////////////////////////////////////////////////////////-->
    <div class="filter-container">
        <strong>Filtros:</strong>
        <select id="id_grado" name="grado" class="form-select">
            <option value="">Grado</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
        </select>
        <select id="id_grupo" name="grupo" class="form-select">
            <option value="">Grupo</option>
            <%
                GrupoDao grupoDao = new GrupoDao();
                ArrayList<Grupo> grupos = grupoDao.getAll();
                for (Grupo g : grupos) {
            %>
            <option value="<%= g.getId_grupo() %>"><%= g.getGrado() %> - <%= g.getGrupo() %></option>
            <% } %>
        </select>
        <select id="id_division" name="division" class="form-select">
            <option value="">División</option>
            <%
                DivisionAcademicaDao divisionDao = new DivisionAcademicaDao();
                ArrayList<DivisionAcademica> divisiones = divisionDao.getAll();
                for (DivisionAcademica d : divisiones) {
            %>
            <option value="<%= d.getId_division_academica() %>"><%= d.getDivision_academica() %></option>
            <% } %>
        </select>
        <select id="id_carrera" name="carrera" class="form-select">
            <option value="">Carrera</option>
            <%
                CarreraDao carreraDao = new CarreraDao();
                ArrayList<Carrera> carreras = carreraDao.getAll();
                for (Carrera c : carreras) {
            %>
            <option value="<%= c.getId_carrera() %>"><%= c.getCarrera() %></option>
            <% } %>
        </select>
        <select id="id_examen" name="examen" class="form-select">
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
            %>
            <option value="">No se puede obtener los exámenes</option>
            <% } %>
        </select>
        <button type="button" id="filterButton" class="btn btn-primary bg-blue-utz">Filtrar</button>
    </div>

    <div class="table-container">
        <table id="tablaExamenes" class="table table-striped display">
            <thead class="bg-blue-utz text-white">
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
            <tbody id="contenido" class="bg-green-SICE">
            <!-- Aquí se llenará la tabla dinámicamente -->
            </tbody>
        </table>
    </div>
</div>

<script src="../../JS/jquery-3.7.0.js"></script>
<script src="../../JS/datatables.js"></script>
<script src="../../JS/bootstrap.js"></script>

<script>
    $(document).ready(function() {
        $('#tablaExamenes').DataTable({
            "language": {
                "url": "//cdn.datatables.net/plug-ins/1.10.21/i18n/Spanish.json"
            }
        });

        $('#filterButton').click(function() {
            let id_grado = $('#id_grado').val();
            let id_grupo = $('#id_grupo').val();
            let id_division = $('#id_division').val();
            let id_carrera = $('#id_carrera').val();
            let id_examen = $('#id_examen').val();

            fetch(`../../filtrarExamenes?id_grado=${id_grado}&id_grupo=${id_grupo}&id_division=${id_division}&id_carrera=${id_carrera}&id_examen=${id_examen}`, {
                method: 'GET'
            }).then(response => response.json())
                .then(data => {
                    let tbody = $('#contenido');
                    tbody.empty();

                    data.forEach(examen => {
                        let fila = `
                        <tr>
                            <td>${examen.nombre}</td>
                            <td>${examen.grado}</td>
                            <td>${examen.grupo}</td>
                            <td>${examen.division}</td>
                            <td>${examen.carrera}</td>
                            <td>
                                <button class="btn btn-calificar btn-sm" onclick="calificar(${examen.id})">
                                    <i class="fas fa-check-circle"></i> Calificar
                                </button>
                            </td>
                            <td>
                                <button class="btn btn-reporte btn-sm" onclick="reporte(${examen.id})">
                                    <i class="fas fa-file-alt"></i> Reporte
                                </button>
                            </td>
                        </tr>`;
                        tbody.append(fila);
                    });
                }).catch(error => console.error('Error:', error));
        });
    });

    function calificar(id) {
        console.log("Calificar examen con ID:", id);
    }

    function reporte(id) {
        console.log("Generar reporte para examen con ID:", id);
    }
</script>
</body>
</html>