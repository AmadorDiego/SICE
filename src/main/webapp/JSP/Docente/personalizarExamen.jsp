<%@ page import="mx.edu.utez.sice.dao.ExamenDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page import="mx.edu.utez.sice.model.Pregunta" %>
<%@ page import="mx.edu.utez.sice.model.Examen" %>
<%@ page import="mx.edu.utez.sice.dao.PreguntaDao" %><%--

  Created by IntelliJ IDEA.
  User: corey
  Date: 04/08/2024
  Time: 10:28 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Personalizar Examen</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel="stylesheet" href="../../CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/fondo.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/adicionalesEBM.css">
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

        .full-width-navbar {
            margin: 0;
            padding: 0;
            width: 100%;
        }
    </style>


</head>
<body>
<!--//////////////////////////////////////// Fondo ///////////////////////////////////////////////////-->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>

<!--////////////////////////////////////// Contenido //////////////////////////////////////////////////-->

<div class="full-width-navbar">
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="#"></a>
        </div>
    </nav>
</div>

<div class="container my-2 my-md-4">
    <h1 class="text-start mb-2 mb-md-3">Personalizar Examen</h1>
    <h3 class="text-start mb-3 mb-md-4">Probabilidad y estadística 1</h3>

    <div class="d-flex flex-wrap justify-content-start gap-2 mb-3">
        <div class="d-flex flex-column flex-md-row align-items-start align-items-md-center gap-2 mb-3">
            <span class="me-2">Modificar Examen</span>
            <button class="btn btn-primary btn-sm btn-md-lg">Modificar</button>
        </div>

        <div class="d-flex flex-column flex-md-row align-items-start align-items-md-center gap-2 mb-3">
            <span class="me-2">Eliminar Examen</span>
            <button class="btn btn-primary btn-sm btn-md-lg">Eliminar</button>
        </div>

        <div class="d-flex flex-column flex-md-row align-items-start align-items-md-center gap-2 mb-3">
            <a href="../Docente/indexDocente.jsp" class="btn btn-primary btn-sm d-inline-flex align-items-center">
                <img src="../../IMG/home.png" alt="Home" class="me-2" style="width: 20px; height: 20px;">
            </a>

        </div>

    </div>

    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="thead bg-blue-utz">
            <tr class="text-white h5">
                <th>Pregunta</th>
                <th>Tipo De Pregunta</th>
            </tr>
            </thead>
            <tbody class="bg-green-SICE">
            <%
                ExamenDao examenDao = new ExamenDao();
                Usuario usuario = new Usuario();
                PreguntaDao preguntaDao = new PreguntaDao();
                ArrayList<Examen> listaExamenes = examenDao.getAll(usuario.getId_tipo_usuario());

                for (Examen examen : listaExamenes) {
                    ArrayList<Pregunta> listaPreguntas = preguntaDao.getAll(examen.getId_examen()); // Asumiendo que necesitas el ID del examen
                    for (Pregunta pregunta : listaPreguntas) {
            %>
            <tr class="h6">
                <td><%=pregunta.getPregunta()%></td>
                <td><%=pregunta.getId_tipo_pregunta()%></td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
