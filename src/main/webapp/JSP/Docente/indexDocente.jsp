
<%@ page import="mx.edu.utez.sice.model.Examen" %>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page import="java.util.ArrayList" %><%--
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
        Usuario usuario = (Usuario) sesion.getAttribute("usuario");
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
        <!--<h2 class="text-white p-2 me-4"></h2>-->
        <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
            <ul class="navbar-nav mb-1">
                <li class="nav-item me-2">
                    <!-- <a class="text-white btn bg-green-utz d-flex align-items-center justify-content-center" href="loginSICE.jsp"><h6 class="mb-0 p-1">Iniciar Sesion</h6></a>-->
                    <button class="text-white btn bg-green-utz d-flex align-items-center justify-content-center"
                            type="button" data-toggle="modal" data-target="#modalContra">Cambiar contraseña</button>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="modal fade" id="modalContra" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Ingrese su nueva contraseña</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label class="form-label text-white h5">Ingrese su contraseña actual</label>
                        <input type="password" class="password" name="contrasena1" placeholder="Contraseaña actual" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label text-white h5">Ingrese su nueva contraseña</label>
                        <input type="password" class="password" name="contrasena2" placeholder="Nueva contraseña" required>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-primary">Guardar cambios</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
            </div>

        </div>
    </div>
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
                    <!--<div class="form-outline" data-mdb-input-init>
                    </div>-->
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
                            <th>Descripción</th>
                        </tr>
                        </thead>
                        <tbody class="bg-green-SICE">
                        <%
                            ArrayList<Examen> examenes = (ArrayList<Examen>)request.getAttribute("examenes");
                            if(examenes != null && !examenes.isEmpty()) {
                                for(Examen examen : examenes) {
                        %>
                        <tr class="h6">
                            <td><%= examen.getNombre_examen() %></td>
                            <td><%= examen.getDescripcion() %></td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="2">No hay exámenes disponibles.</td>
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