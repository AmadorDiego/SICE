<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page import="mx.edu.utez.sice.dao.CarreraDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.model.Carrera" %>
<%@ page import="mx.edu.utez.sice.dao.GrupoDao" %>
<%@ page import="mx.edu.utez.sice.model.Grupo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registrar nuevo usuario</title>
    <link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/adicionalesEBM.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/fondo.css">
    <!--///////////////////////////// Iconos ////////////////////////////////////-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@30,600,0,0"/>
</head>
<body>
<%
    HttpSession sesion = request.getSession();
    Usuario usuario = (Usuario) sesion.getAttribute("usuario");
%>

<!--/////////////////////////////////////////////// Fondo /////////////////////////////////////////////////////////////-->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>


<!--///////////////////////////////////////////// NavBar //////////////////////////////////////////////////////-->
<header>
    <nav class="navbar bg-blue-utz">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <a class="navbar-brand text-white">
                <img src="../../IMG/logoBueno.png" width="50" height="45" alt="Logo" class="d-inline-block align-middle mt-0 mb-2">
                <h3 class="ms-2 d-inline-block align-middle">SICE</h3>
            </a>

            <div class="d-flex">
                <a href="registroUsuario.jsp" class="btn btn-primary bg-blue-utz ms-3 text-white border-0">
                    <span class="material-symbols-rounded">person_add</span>
                </a>
                <a href="indexAdministrador.jsp" class="btn btn-primary bg-blue-utz ms-3 text-white border-0">
                    <span class="material-symbols-rounded">home</span>
                </a>
            </div>
        </div>
    </nav>
</header>

<!--//////////////////////////////////////////// Contenido ////////////////////////////////////////////////////////////-->
<div class="container ">
    <form class="form-control bg-green-utz p-3 mt-5 rounded-4 border-0 bg-opacity-75" method="post" action="../../RegistrarUsuarioServlet">
        <div class="row">
            <div class="col-12">
                <h1 class="blue-utz">Registrar nuevo usuario</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 col-12 p-3">
                <label class="form-label text-white h6">Ingrese su nombre: </label>
                <input required class="form-control" type="text" name="nombre_usuario" value="">
                <br>
                <label class="form-label text-white h6">Ingrese su apellido: </label>
                <input required class="form-control" type="text" name="apellido_usuario" value="">
                <br>
                <label class="form-label text-white h6">Ingrese su correo electrónico: </label>
                <input required class="form-control" type="email" name="correo_electronico" value="">
            </div>

            <div class="col-md-6 col-12 p-3">
                <label class="form-label text-white h6">Ingrese su contraseña: </label>
                <input required class="form-control" type="password" name="contrasena1">
                <br>
                <label class="form-label text-white h6">Reingrese su contraseña: </label>
                <input required class="form-control" type="password" name="contrasena2">
                <br>
                <label class="form-label text-white h6">Ingrese el tipo de usuario: </label>
                <select required class="form-control" name="id_tipo_usuario" id="id_tipo_usuario">
                    <option value="4">Docente administrador</option>
                    <option value="1">Administrador</option>
                    <option value="2">Docente</option>
                    <option value="3">Alumno</option>
                </select>
            </div>
        </div>
        <div class="row">
            <div class="col-3">
                <br>
                <button type="submit" class="btn btn-primary bg-blue-utz justify-content-center mb-0" value="Registrar">
                    <span class="material-symbols-rounded mb-0 justify-content-center">add</span>
                    <p class="mb-0">Registrar</p>
                </button>
            </div>
        </div>
    </form>
</div>
</body>
</html>