
<%@ page import="mx.edu.utez.sice.model.Examen" %>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.sice.model.Usuario" %><%--
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
                        <button class="btn btn-primary bg-blue-utz h6">Ver</button>
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
                        <c:forEach var="examen" items="${examenes}">
                            <tr class="h6">
                                <td>${examen.nombre_examen}</td>
                                <td>${examen.descripcion}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>


<script src="../../JS/jquery-3.7.0.js"></script>
<script src="../../JS/bootstrap.js"></script>
</body>
</html>