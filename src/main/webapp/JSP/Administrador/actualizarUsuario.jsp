<%@ page import="mx.edu.utez.sice.model.Usuario" %><%--
  Created by IntelliJ IDEA.
  User: amado
  Date: 30/07/2024
  Time: 03:05 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Actualizar datos</title>
    <link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/fondo.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/adicionalesEBM.css">
</head>
<body>
<%
    HttpSession sesion = request.getSession();
    Usuario usuario = (Usuario) sesion.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("loginSICE.jsp"); // Redirect if user is not found
        return;
    }
%>
<!--///////////////////////////////////////////////// Navbar /////////////////////////////////////////////////////////////-->
<header>
    <div class="collapse" id="navbarToggleExternalContent">
        <div class="bg-blue-utz p-2">
            <h2 class="text-white p-2 ms-2">SICE</h2>
            <div class="d-flex flex-column ms-2">
                <a href="registroUsuario.jsp" class="btn w-25 text-white btn-brillo-efecto bg-blue-utz"><h6>Registrar
                    Usuario</h6></a>
                <a href="verUsuarioEliminado.jsp" class="btn w-25 text-white btn-brillo-efecto bg-blue-utz"><h6>Usuarios
                    Eliminados</h6></a>
            </div>
        </div>
    </div>
    <nav class="navbar bg-blue-utz">
        <div class="container-fluid">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
    </nav>
</header>


<!--///////////////////////////////////////////////// Fondo //////////////////////////////////////////////////////////////-->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>
<!--//////////////////////////////////////////// Contenido principal /////////////////////////////////////////////////////-->
<div class="container-md">
    <div class="row">
        <div class="col-12">
            <form class="form-control rounded-5 p-3 mt-4 border-0 bg-green-utz" method="post" action="../../ActualizarUsuarioServlet">
                <h1 class="blue-utz">Actualizar datos</h1>
                <br>
                <input type="hidden" name="id_usuario" value="<%= usuario.getId_usuario() %>">
                <label class="form-label text-white h5">Ingrese su nombre: </label>
                <input class="form-control" type="text" name="nombre_usuario" required value="<%= usuario.getNombre_usuario()%>" placeholder="<%= usuario.getNombre_usuario()%>">
                <br>
                <label class="form-label text-white h5">Ingrese su apellido: </label>
                <input class="form-control" type="text" name="apellido_usuario" required value="<%= usuario.getApellido_usuario()%>" placeholder="<%= usuario.getApellido_usuario()%>">
                <br>
                <label class="form-label text-white h5">Ingrese su correo electrónico: </label>
                <input class="form-control" type="email" name="correo_electronico" required value="<%= usuario.getCorreo_electronico()%>" placeholder="<%= usuario.getCorreo_electronico()%>">
                <br>
                <label class="form-label text-white h5">Ingrese su contraseña: </label>
                <input class="form-control" type="password" name="contrasena1" required>
                <br>
                <label class="form-label text-white h5">Reingrese su contraseña: </label>
                <input class="form-control" type="password" name="contrasena2" required>
                <br>
                <div class="form-check form-switch">
                    <input class="form-check-input" type="checkbox" role="switch" name="estado" id="estado" <% if(usuario.getEstado()==1){%>checked<%}%>>
                    <label class="form-check-label text-white h5" for="estado">Estado</label>
                </div>
                <br>
                <label class="form-label text-white h5">Seleccione el tipo de usuario: </label>
                <select class="form-control" name="id_tipo_usuario" required>
                    <option value="1" <% if(usuario.getId_tipo_usuario()==1){%>selected<%}%>>Administrador</option>
                    <option value="2" <% if(usuario.getId_tipo_usuario()==2){%>selected<%}%>>Docente</option>
                    <option value="3" <% if(usuario.getId_tipo_usuario()==3){%>selected<%}%>>Alumno</option>
                    <option value="4" <% if(usuario.getId_tipo_usuario()==4){%>selected<%}%>>Docente administrador</option>
                </select>
                <br>
                <input class="btn btn-primary bg-blue-utz" type="submit" value="Actualizar">
            </form>
        </div>
    </div>
</div>
<script href="../../JS/bootstrap.js"></script>
</body>
</html>
