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
    <title>Permiso denegado</title>
    <link rel="stylesheet" href="../CSS/bootstrap.css">
    <link rel="stylesheet" href="../CSS/adicionales.css">
    <style>
        .container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f0f0f0;
            border-radius: 8px;
        }
    </style>
</head>
<body>
<header>
    <nav class="navbar navbar-expand-lg navbar-light bg-blue-utz">
        <div class="container-fluid">
            <img src="../IMG/logoBueno.png" class="me-0 d-flex justify-content-start" width="30" height="24" alt="Logo" class="d-inline-block align-middle mt-0 mb-2">
            <h6 class="ms-2 d-inline-block align-middle text-white"><strong>Acceso denegado</strong></h6>
        </div>
    </nav>
</header>
<div class="container shadow-lg p-3 mb-5 bg-body rounded">
    <h4 class="text-center"><strong>Permiso denegado al recurso requerido</strong></h4>
    <hr>
    <h6 class="text-center">No tienes permiso para acceder a la página que solicitaste o intestaste ingresar a nuestro sitio sin haber iniciado sesión, por favor, regresa.</h6>
    <hr>
    <a href="../CerrarSesionServlet?denegado=true" class="btn btn-primary bg-blue-utz border-0 text-white me-0 w-100"><strong>Volver</strong></a>
</div>
</body>
</html>
