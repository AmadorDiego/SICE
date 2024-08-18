
<%@ page import="mx.edu.utez.sice.model.Examen" %>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.dao.ExamenDao" %><%--
  Created by IntelliJ IDEA.
  User: amado
  Date: 27/07/2024
  Time: 02:30 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="es">
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>

    <title>Bienvenido docente</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/fondo.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/adicionalesEBM.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/Docentes.css">
    <%
        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuarioIndexDocente");
    %>
</head>
<body>
<!--//////////////////////////////////////// Fondo ///////////////////////////////////////////////////-->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>

<!--////////////////////////////////////// Contenido //////////////////////////////////////////////////-->

<nav class="navbar navbar-expand-lg navbar-light bg-blue-utz">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
            <ul class="navbar-nav mb-1">
                <li class="nav-item me-2">
                    <button class="text-white btn bg-green-utz d-flex align-items-center justify-content-center"
                            type="button" data-toggle="modal" data-target="#modalContra">Cambiar contraseña</button>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="modal fade" id="modalContra" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <!-- ... (código del modal sin cambios) ... -->
</div>

<div class="container my-2 my-md-4">
    <div class="row">
        <div class="col p-3">
            <h1 class="text-start mb-3 blue-utz">Bienvenido <%=usuario.getNombre_usuario() %> <%=usuario.getApellido_usuario()%></h1>
            <h3 class="text-start mb-4 blue-utz">Exámenes creados:</h3>

            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="d-flex align-items-center">
                    <span class="me-2 text-white h5">Crear examen</span>
                    <a class="btn btn-primary bg-blue-utz h6" href="examen.jsp">Crear</a>
                </div>
                <div class="d-flex align-items-center">
                    <span class="me-2 text-white h5">Exámenes por calificar</span>
                    <a class="btn btn-primary bg-blue-utz h6" href="PieroCalificarExamen.jsp">Ver</a>
                </div>
            </div>

            <!--boton de busqueda-->
            <div class="input-group">
                <div class="input-group-append">
                    <input id="search-input" type="search" class="form-control" placeholder="Search">

                    <div class="input-group-append">
                        <button id="search-button" type="button" class="btn btn-primary">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>

                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="thead bg-blue-utz">
                    <tr class="text-white h5">
                        <th>Examen</th>
                        <th>Cantidad de preguntas</th>
                        <th></th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody class="bg-green-SICE">
                    <%
                        ExamenDao examenDao = new ExamenDao();
                        ArrayList<Examen> lista = examenDao.getAll(usuario.getId_usuario());
                        for (Examen examen : lista) {
                    %>
                    <tr class="h6">
                        <td><%= examen.getNombre_examen() %></td>
                        <td><%= examen.getCantidad_preguntas() %></td>
                        <td>
                            <a href="../../ModificarExamenServlet?id_examen=<%=examen.getId_examen()%>" class="btn btn-primary">Ver</a>
                        </td>
                        <td>
                            <a href="../../AsignarExamenServlet?id_examen=<%=examen.getId_examen()%>" class="btn btn-success">Asignar</a>
                        </td>
                    </tr>

                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="../../JS/jquery-3.7.0.js"></script>
<script src="../../JS/bootstrap.js"></script>
<script src="../../JS/Ajustes.js"></script>
<script src="../../JS/bootstrap.bundle.min.js"></script>
</body>
</html>