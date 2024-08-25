<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de sesión</title>
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/adicionales.css">
    <style>
        .login-container {
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
    <!-- <nav class="navbar bg-blue-utz">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <a class="navbar-brand text-white">
                <img src="IMG/logoBueno.png" width="50" height="45" alt="Logo"
                     class="d-inline-block align-middle mt-0 mb-2">
                <h3 class="ms-2 d-inline-block align-middle"><strong>Bienvenido a SICE</strong></h3>
            </a>
        </div>
    </nav> -->
    <nav class="navbar navbar-expand-lg navbar-light bg-blue-utz">
        <div class="container-fluid">
            <img src="IMG/logoBueno.png" class="me-0 d-flex justify-content-start" width="30" height="24" alt="Logo" class="d-inline-block align-middle mt-0 mb-2">
            <h6 class="ms-2 d-inline-block align-middle text-white"><strong>Bienvenido a SICE</strong></h6>
        </div>
    </nav>
</header>
<div class="login-container shadow-lg p-3 mb-5 bg-body rounded">
    <h4 class="text-center"><strong>Iniciar sesión</strong></h4>
    <%HttpSession sesion = request.getSession();
        String mensaje = (String) sesion.getAttribute("mensajeInicio");
        Boolean flag = (Boolean) sesion.getAttribute("flag");
        if (mensaje != null) {%>
    <div class="alert p-3 mb-2 alert-<%if (mensaje.equals("Se cerró sesión correctamente")){%>success<%}else{%>danger<%}%> alert-dismissible fade show"
         role="alert">
        <strong><%=mensaje%>
        </strong>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <%}%>
    <hr>
    <form method="post" action="UsuarioServlet">
        <div class="mb-3">
            <h6 for="email" class="form-label"><strong>Correo electrónico:</strong></h6>
            <input type="email" class="form-control <%if (flag!=null){ if (!flag){%>is-invalid<%}}%>" id="email" required placeholder="Nombre/matrícula@utez.edu.mx" name="correo_electronico">
        </div>
        <div class="mb-3">
            <h6 for="password" class="form-label"><strong>Contraseña:</strong></h6>
            <input type="password" class="form-control <%if (flag!=null){ if (!flag){%>is-invalid<%}}%>" id="password" required placeholder="Contraseña" name="contrasena">
        </div>
        <hr>
        <button type="button" class="btn bg-blue-utz btn-primary border-0 text-white me-0 w-100"><strong>¿Olvidaste tu contraseña?</strong></button>
        <hr>
        <button type="submit" class="btn btn-success bg-green-SICE-obscuro border-0 text-white me-0 w-100"><strong>Iniciar sesión</strong></button>
    </form>
</div>
<%sesion.removeAttribute("mensajeInicio");
sesion.removeAttribute("flag");%>
<script src="JS/bootstrap.bundle.min.js"></script>
</body>
</html>