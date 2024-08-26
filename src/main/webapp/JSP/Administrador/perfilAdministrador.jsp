<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page import="mx.edu.utez.sice.dao.UsuarioDao" %>
<%@ page import="mx.edu.utez.sice.dao.DivisionAcademicaDao" %>
<%@ page import="mx.edu.utez.sice.model.DivisionAcademica" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tu perfil</title>
    <link rel="stylesheet" type="text/css" href="../../CSS/datatables.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/adicionalesEBM.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/fondo.css">
    <!--///////////////////////////// Iconos ////////////////////////////////////-->
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@30,600,0,0"/>
    <%
        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuarioIndexAdministrador");
        if (usuario != null){
    %>
    <style>
        .btn-primary {
            background-color: #003e81;
        }
    </style>
</head>

<body>
<!-- //////////////////////////////////////////NavBar//////////////////////////////////////////////////////  -->
<header>
    <nav class="navbar bg-blue-utz align-items-center">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <a class="navbar-brand text-white">
                <img src="../../IMG/logoBueno.png" width="50" height="45" alt="Logo"
                     class="d-inline-block align-middle mt-0 mb-2">
                <h3 class="ms-2 d-inline-block align-middle"><strong>Bienvenido <%=usuario.getNombre_usuario() %> <%=usuario.getApellido_usuario()%></strong></h3>
            </a>

            <div class="d-flex">
                <a href="grupos.jsp" class="btn btn-primary bg-blue-utz ms-3 text-white border-0 d-flex align-items-center">
                    <span class="material-symbols-rounded">group_add</span>
                    <h6 class="mb-0 ms-2">Grupos</h6>
                </a>
                <a href="indexAdministrador.jsp" class="btn btn-primary bg-blue-utz ms-3 text-white border-0 d-flex align-items-center">
                    <span class="material-symbols-rounded">home</span>
                    <h6 class="mb-0 ms-2">Inicio</h6>
                </a>
            </div>
        </div>
    </nav>
</header>

<!--/////////////////////////////////////////////// Encabezado //////////////////////////////////////////////////////////////////////-->
<div class="container-xl">
    <div class="row">
        <div class="col-12">

        </div>
        <!---//////////////////////////////////////Contenido//////////////////////////////////////////////////-->
        <div class="row">
            <div class="col-md-1 col-12 p-3"></div>
            <div class="col-md-10 col-12 p-3">
                <hr>
                <h3 ><strong>Tu perfil</strong></h3>
                <h6 >Solamente tú puedes modificar tu información, asegurate de que sea correcta.</h6>
                <h6 >Los cambios se harán notorios hasta que vuelvas a ingresar de nuevo.</h6>
                <hr>
                <br>
                <div class="row">
                    <div class="col-md-7 col-12 p-3 shadow-lg bg-light rounded-bottom border-0">
                        <form method="post" action="../../ActualizarUsuarioServlet" id="actualizar_usuario">
                            <h6 class="text-center"><strong>Actualizar tu información</strong></h6>
                            <hr>
                            <input type="hidden" value="<%=usuario.getId_usuario()%>" name="id_usuario">
                            <input type="hidden" value="<%=usuario.getEstado()%>" name="estado">
                            <div class="row">
                                <div class="col-md-6 col-12 p-3">
                                    <label class="col-form-label h6">Ingrese su nombre: </label>
                                    <input required class="form-control" type="text" name="nombre_usuario" value="<%=usuario.getNombre_usuario()%>"
                                           placeholder="<%=usuario.getNombre_usuario()%>">
                                </div>
                                <div class="col-md-6 col-12 p-3">
                                    <label class="col-form-label h6">Ingrese su apellido: </label>
                                    <input required class="form-control" type="text" name="apellido_usuario" value="<%=usuario.getApellido_usuario()%>"
                                           placeholder="<%=usuario.getApellido_usuario()%>">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-7 col-12 p-3">
                                    <label class="col-form-label h6">Ingrese su correo electrónico: </label>
                                    <input required class="form-control" type="email" name="correo_electronico" value="<%=usuario.getCorreo_electronico()%>"
                                           placeholder="<%=usuario.getCorreo_electronico()%>">
                                </div>
                                <div class="col-md-5 col-12 p-3">
                                    <label class="col-form-label h6">Ingrese el tipo de usuario: </label>
                                    <select required class="form-control" name="id_tipo_usuario" id="id_tipo_usuario">
                                        <option value="1" <%if (usuario.getId_tipo_usuario()==1){%>selected<%}%>>Administrador</option>
                                        <option value="2" <%if (usuario.getId_tipo_usuario()==2){%>selected<%}%>>Docente</option>
                                        <option value="3" <%if (usuario.getId_tipo_usuario()==3){%>selected<%}%>>Alumno</option>
                                    </select>
                                </div>
                            </div>
                            <input type="submit" class="btn btn-success bg-green-utz justify-content-center mb-0 text-center w-100" value="Actualizar mi información">
                        </form>
                    </div>

                    <div class="col-md-1 col-12 p-3"></div>

                    <div class="col-md-4 col-12 p-3 shadow-lg bg-light rounded-bottom border-0">
                        <form method="post" action="../../CambiarContrasenaServlet">
                            <h6 class="text-center"><strong>Cambiar contraseña</strong></h6>
                            <hr>
                            <input type="hidden" value="<%=usuario.getId_usuario()%>" name="id_usuario">
                            <div class="row">
                                <div class="col-md-12 col-12 p-3">
                                    <label class="col-form-label h6">Ingrese su contraseña: </label>
                                    <input required class="form-control" type="password" name="contrasena1">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-12 p-3">
                                    <label class="col-form-label h6">Reingrese su contraseña: </label>
                                    <input required class="form-control" type="password" name="contrasena2">
                                </div>
                            </div>
                            <input type="submit" class="btn btn-primary bg-blue-utz justify-content-center mb-0 text-center w-100" value="Actualizar mi contraseña">
                        </form>
                    </div>
                </div>
                <br>
                <div class="row">
                    <br>
                    <hr>
                    <div class="justify-content-lg-end">
                        <a href="../../CerrarSesionServlet" class="justify-content-lg-end btn btn-danger bg-red-SICE mb-0 w-25 text-center">
                            <h6 class="mb-0 ms-2">Cerrar Sesion</h6>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-md-1 col-12 p-3"></div>
        </div>
    </div>
    <div class="position-fixed bottom-0 end-0 p-3">
        <% if ((String) request.getSession().getAttribute("mensajeAdministrador") != null) {%>
        <div class="alert bg-<% if ((Boolean) request.getSession().getAttribute("flag")){%>success<%}else{%>danger<%}%> text-white alert-dismissible fade show"
             role="alert">
            <h6><%=(String) request.getSession().getAttribute("mensajeAdministrador")%>
            </h6>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <%}%>
    </div>
    <script src="../../JS/bootstrap.bundle.min.js"></script>
    <%
        request.getSession().removeAttribute("mensajeAdministrador");
    %>
</div>
</body>
</html>
<%} else {response.sendRedirect("../permisoDenegado.jsp");}%>