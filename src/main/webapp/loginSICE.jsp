<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de sesión</title>
    <link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/fondo.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/adicionalesEBM.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/Docentes.css">
    <!--///////////////////////////// Iconos ////////////////////////////////////-->
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@30,600,0,0"/>
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/adicionales.css">
    <style>
        body {
            background-color: #1a1a1a;
            color: white;
            font-family: 'Montserrat', sans-serif;
        }
        .login-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background-color: #222;
            border-radius: 8px;
        }
        .login-container h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .form-label {
            color: #ccc;
        }
        .form-control {
            background-color: #333;
            border: none;
            color: white;
        }
        .btn-primary {
            background-color: #0056b3;
            border: none;
        }
        .forgot-password {
            color: #69d2e7;
            text-align: right;
            display: block;
            margin-top: 10px;
        }
        .navbar-dark .navbar-brand {
            color: #ddd;
        }
    </style>
</head>
<body>
<header>
    <nav class="navbar bg-blue-utz">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <a class="navbar-brand text-white">
                <img src="IMG/logoBueno.png" width="50" height="45" alt="Logo"
                     class="d-inline-block align-middle mt-0 mb-2">
                <h3 class="ms-2 d-inline-block align-middle"><strong>SICE</strong></h3>
            </a>
        </div>
    </nav>
</header>

<div class="login-container">
    <h1 class="text-center"><strong>Bienvenido a SICE</strong></h1>
    <p class="text-center"><strong>Inicio de sesión</strong></p>
    <form method="post" action="UsuarioServlet">
        <div class="mb-3">
            <label for="email" class="form-label">Correo electrónico:</label>
            <input type="email" class="form-control" id="email" required placeholder="Nombre/matrícula@utez.edu.mx" name="correo_electronico">
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Contraseña:</label>
            <input type="password" class="form-control" id="password" required placeholder="Contraseña" name="contrasena">
        </div>
        <%HttpSession sesion = request.getSession();
            String mensaje = (String) sesion.getAttribute("mensajeInicio");
            if (mensaje != null) {%>
        <div class="alert p-3 mb-2 bg-danger text-white alert-dismissible fade show"
             role="alert">
            <strong><%=mensaje%>
            </strong>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <%}%>
        <hr>
        <button type="button" class="btn bg-blue-utz btn-success border-0 text-white me-0 w-100"><strong>¿Olvidaste tu contraseña?</strong></button>
        <hr>
        <button type="submit" class="btn btn-success bg-green-SICE-obscuro border-0 text-white me-0 w-100"><strong>Iniciar sesión</strong></button>
    </form>
</div>
<%sesion.removeAttribute("mensajeInicio");%>
<script src="JS/bootstrap.bundle.min.js"></script>
</body>
</html>