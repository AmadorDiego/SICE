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
    <!--///////////////////////////// Iconos ////////////////////////////////////-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@30,600,0,0"/>
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
    <nav class="navbar bg-blue-utz">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <a class="navbar-brand text-white">
                <img src="../../IMG/logoBueno.png" width="50" height="45" alt="Logo" class="d-inline-block align-middle mt-0 mb-2">
                <h3 class="ms-2 d-inline-block align-middle">SICE</h3>
            </a>

            <div class="d-flex">
                <a href="indexAdministrador.jsp" class="btn btn-primary bg-blue-utz ms-3 text-white border-0">
                    <span class="material-symbols-rounded">home</span>
                </a>
            </div>
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
                <div class="input-group">
                    <input type="hidden" name="id_usuario" value="<%= usuario.getId_usuario() %>">
                    <label class="form-label text-white h5 me-4">Ingrese su nombre: </label>
                    <input class="form-control w-50" type="text" name="nombre_usuario" required value="<%= usuario.getNombre_usuario()%>" placeholder="<%= usuario.getNombre_usuario()%>">
                </div>
                <br>
                <div class="input-group">
                    <label class="form-label text-white h5 me-4">Ingrese su apellido: </label>
                    <input class="form-control w-50" type="text" name="apellido_usuario" required value="<%= usuario.getApellido_usuario()%>" placeholder="<%= usuario.getApellido_usuario()%>">
                </div>
                <br>
                <div class="input-group">
                    <label class="form-label text-white h5 me-4">Ingrese su correo electrónico: </label>
                    <input class="form-control w-50" type="email" name="correo_electronico" required value="<%= usuario.getCorreo_electronico()%>" placeholder="<%= usuario.getCorreo_electronico()%>">
                </div>
                <br>
                <div class="input-group">
                    <label class="form-label text-white h5 me-4">Ingrese su contraseña: </label>
                    <input class="form-control w-50" type="password" name="contrasena1">
                </div>
                <br>
                <div class="input-group">
                    <label class="form-label text-white h5 me-4">Reingrese su contraseña: </label>
                    <input class="form-control w-50" type="password" name="contrasena2">
                </div>
                <br>
                <div class="form-check form-switch">
                    <input class="form-check-input" type="checkbox" role="switch" name="estado" id="estado" <% if(usuario.getEstado()==1){%>checked<%}%>>
                    <label class="form-check-label text-white h5 me-4" for="estado">Estado</label>
                </div>
                <br>
                <div class="input-group">
                    <label class="form-label text-white h5 me-4">Seleccione el tipo de usuario: </label>
                    <select class="form-select w-25" name="id_tipo_usuario" required>
                        <option value="1" <% if(usuario.getId_tipo_usuario()==1){%>selected<%}%>>Administrador</option>
                        <option value="2" <% if(usuario.getId_tipo_usuario()==2){%>selected<%}%>>Docente</option>
                        <option value="3" <% if(usuario.getId_tipo_usuario()==3){%>selected<%}%>>Alumno</option>
                        <option value="4" <% if(usuario.getId_tipo_usuario()==4){%>selected<%}%>>Docente administrador</option>
                    </select>
                </div>
                <br>
                <input class="btn btn-primary bg-blue-utz" type="submit" value="Actualizar">
            </form>
        </div>
    </div>
</div>
<script href="../../JS/bootstrap.js"></script>
</body>
</html>
