<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de Sesión</title>
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
<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand mb-0 h1"><strong>Inicio de sesión</strong></span>
        <a href="#" class="btn-outline-light"><strong>¿Olvidaste tu contraseña?</strong></a>
    </div>
</nav>

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
        <button type="submit" class="btn btn-success bg-green-SICE-obscuro border-0 text-white me-0 w-100"><strong>Iniciar sesión</strong></button>
    </form>
</div>
<%sesion.removeAttribute("mensajeInicio");%>
<script src="JS/bootstrap.bundle.min.js"></script>
</body>
</html>