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
    <nav class="navbar navbar-expand-lg navbar-light bg-blue-utz">
        <div class="container-fluid">
            <img src="<%= request.getContextPath() %>/IMG/logoBueno.png" class="me-0 d-flex justify-content-start" width="30" height="24" alt="Logo" class="d-inline-block align-middle mt-0 mb-2">
            <h6 class="ms-2 d-inline-block align-middle text-white"><strong>Error 404</strong></h6>
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
        %>http://localhost:8080/SICE_war_exploded/JSP/Administrador/indexAdministrador.jsp<%
    } else if (sesion.getAttribute("usuarioIndexDocente")!=null) {
        %>http://localhost:8080/SICE_war_exploded/JSP/Docente/indexDocente.jsp<%
    } else if (sesion.getAttribute("usuarioIndexAlumno")!=null){
        %>http://localhost:8080/SICE_war_exploded/JSP/Alumno/indexAlumno.jsp<%
    } else if (sesion.getAttribute("usuarioIndexDocenteAdministrador")!=null){
        %>http://localhost:8080/SICE_war_exploded/JSP/Docente-Administrador/indexDocenteAdministrador.jsp<%
    } else{
        %>http://localhost:8080/SICE_war_exploded/loginSICE.jsp<%
    }%>" class="btn btn-primary bg-blue-utz border-0 text-white me-0 w-100"><strong>Volver</strong></a>
</div>
</body>
</html>
