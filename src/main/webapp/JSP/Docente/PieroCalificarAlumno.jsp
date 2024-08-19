<%--
  Created by IntelliJ IDEA.
  User: corey
  Date: 04/08/2024
  Time: 08:33 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page import="mx.edu.utez.sice.dao.UsuarioDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calificar Estudiante</title>
    <link href="../../CSS/bootstrap.css" rel="stylesheet">
    <link href="../../CSS/datatables.css" rel="stylesheet">
    <link href="../../CSS/docente.css" rel="stylesheet">
    <style>
        body {
            background-color: #f2f2f2; /* Fondo gris claro */
        }
        .navbar {
            background-color: #002e60; /* Barra azul */
            height: 50px;
        }
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
<div class="navbar"></div> <!-- Barra azul -->
<div class="container">
    <h1>Calificar Estudiante</h1>
    <h3>Grupo de <span>3</span> <span>A</span></h3>
    <div class="filter-group mb-3">
        <input type="text" id="buscar_alumno" placeholder="Buscar Alumno" class="form-control">
        <div class="home-boton-container">
            <button class="home-boton btn btn-outline-secondary" onclick="location.href='../index.html';">
                <img src="../../images/home_icon.png" alt="Home" style="width: 20px; height: 20px;">
            </button>
        </div>
    </div>
    <div class="table-responsive">
        <table id="usuarios" class="table table-striped table-hover mt-4">
            <thead>
            <tr>
                <th>Nombres</th>
                <th>Apellidos</th>
                <th>Matrícula</th>
                <th>Calificar</th>
            </tr>
            </thead>
            <tbody id="usuarioTabla">
            <%
                UsuarioDao dao = new UsuarioDao();
                ArrayList<Usuario> lista = dao.getAll();
                for (Usuario u : lista) {
                    if (u.getEstado() != 2) {
            %>
            <tr>
                <td><%= u.getNombre_usuario() %></td>
                <td><%= u.getApellido_usuario() %></td>
                <td><%= u.getCorreo_electronico() %></td>
                <td>
                    <form action="calificarAlumno" method="get">
                        <button type="submit" class="btn btn-primary">Calificar</button>
                        <input type="hidden" name="alumnoId" value="<%= u.getId_usuario() %>">
                    </form>
                </td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<script src="../../JS/jquery-3.7.0.js"></script>
<script src="../../JS/bootstrap.js"></script>
<script src="../../JS/datatables.js"></script>
<script src="../../JS/dataTables.bootstrap5.js"></script>
<script src="../../JS/es-MX.json"></script>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        // Inicializar DataTable
        const table = $('#usuarios').DataTable({
            language: {
                url: '../../JS/es-MX.json'
            }
        });

        // Filtro de búsqueda
        document.getElementById('buscar_alumno').addEventListener('input', function() {
            table.search(this.value).draw();
        });
    });
</script>
</body>
</html>
