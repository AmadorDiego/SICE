<%--
  Created by IntelliJ IDEA.
  User: amado
  Date: 24/08/2024
  Time: 11:54 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error 404</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/adicionales.css">
    <style>
        .container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f0f0f0;
            border-radius: 8px;
        }
        .btn-primary {
            background-color: #003e81;
        }
    </style>
</head>
<body>
<header>
    <nav class="navbar bg-blue-utz">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <a class="navbar-brand text-white">
                <img src="<%= request.getContextPath() %>/IMG/logoBueno.png" width="50" height="45" alt="Logo"
                     class="d-inline-block align-middle mt-0 mb-2">
                <h3 class="ms-2 d-inline-block align-middle"><strong>Error 404</strong></h3>
            </a>
        </div>
    </nav>
</header>
<div class="text-center container shadow-lg p-3 mb-5 bg-body rounded">
    <h4 class="text-center"><strong>Recurso requerido no disponible</strong></h4>
    <hr>
    <h6 class="text-center">El recurso que solicitaste no está disponible o no existe, regresa a tu página principal.</h6>
    <hr>
    <a href="<%HttpSession sesion = request.getSession();
    if (sesion.getAttribute("usuarioIndexAdministrador")!=null){
        %><%= request.getContextPath() %>/JSP/Administrador/indexAdministrador.jsp<%
    } else if (sesion.getAttribute("usuarioIndexDocente")!=null) {
        %><%= request.getContextPath() %>/JSP/Docente/indexDocente.jsp<%
    } else if (sesion.getAttribute("usuarioIndexAlumno")!=null){
        %><%= request.getContextPath() %>/JSP/Alumno/indexAlumno.jsp<%
    } else if (sesion.getAttribute("usuarioIndexDocenteAdministrador")!=null){
        %><%= request.getContextPath() %>/JSP/Docente-Administrador/indexDocenteAdministrador.jsp<%
    } else{
        %><%= request.getContextPath() %>/loginSICE.jsp<%
    }%>" class="btn btn-primary bg-blue-utz border-0 text-white me-0 w-100"><strong>Volver</strong></a>
</div>
</body>
</html>
