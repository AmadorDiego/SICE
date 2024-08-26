<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page import="mx.edu.utez.sice.dao.UsuarioDao" %>
<%@ page import="mx.edu.utez.sice.dao.DivisionAcademicaDao" %>
<%@ page import="mx.edu.utez.sice.model.DivisionAcademica" %>
<%@ page import="mx.edu.utez.sice.dao.GrupoDao" %>
<%@ page import="mx.edu.utez.sice.model.Grupo" %>
<%@ page import="mx.edu.utez.sice.dao.CarreraDao" %>
<%@ page import="mx.edu.utez.sice.model.Carrera" %>
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
        Usuario usuario = (Usuario) sesion.getAttribute("usuarioIndexAlumno");
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
                <a href="alumnoRelizados.jsp"
                   class="btn btn-primary bg-blue-SICE-claro ms-3 text-white border-0 d-flex align-items-center">
                    <span class="material-symbols-rounded">task</span>
                    <h6 class="mb-0 ms-2">Examenes Realizados</h6>
                </a>
                <a href="indexAlumno.jsp" class="btn btn-primary bg-blue-utz ms-3 text-white border-0 d-flex align-items-center">
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
                <h6 >Solo los administradores pueden modificar tu información, si notas algún dato erróneo, comunícate con alguno.</h6>
                <h6 >Los cambios se harán notorios hasta que vuelvas a ingresar de nuevo.</h6>
                <hr>
                <br>
                <div class="row">
                    <div class="col-md-7 col-12 p-3 shadow-lg bg-light rounded-bottom border-0">
                        <h6 class="text-center"><strong>Tu información</strong></h6>
                        <hr>
                        <div class="row">
                            <div class="col-md-6 col-12 p-3">
                                <label class="col-form-label h6">Nombre completo</label>
                                <input  class="form-control" type="text"  value="<%=usuario.getNombre_usuario()+" "+usuario.getApellido_usuario()%>" disabled>
                            </div>
                            <div class="col-md-6 col-12 p-3">
                                <label class="col-form-label h6">Correo electrónico</label>
                                <input  class="form-control" type="email" value="<%=usuario.getCorreo_electronico()%>" disabled>
                            </div>
                        </div>
                        <%GrupoDao grupoDao = new GrupoDao();
                            CarreraDao carreraDao = new CarreraDao();
                            DivisionAcademicaDao divisionAcademicaDao = new DivisionAcademicaDao();
                            Grupo grupo = grupoDao.getGrupoAlumno(usuario.getId_usuario());
                            Carrera carrera = carreraDao.getCarreraGrupo(grupo.getId_grupo());
                            DivisionAcademica divisionAcademica = divisionAcademicaDao.getDivisionCarrera(carrera.getId_carrera());
                        %>
                        <div class="row">
                            <div class="col-md-7 col-12 p-3">
                                <label class="col-form-label h6">Carrera: </label>
                                <input  class="form-control" type="email" value="<%=carrera.getCarrera()%>" disabled>
                            </div>
                            <div class="col-md-3 col-12 p-3">
                                <label class="col-form-label h6">División</label>
                                <input  class="form-control" type="text"  value="<%switch (divisionAcademica.getId_division_academica()) {case 1:%>DATID<%break;case 2:%>DAMI<%break;case 3:%>DACEA<%break;case 4:%>DATEFI<%break;default:%>divisionAcademica.getDivision_academica()<%break;}%>" disabled>
                            </div>
                            <div class="col-md-2 col-12 p-3">
                                <label class="col-form-label h6">Grupo</label>
                                <input  class="form-control" type="text"  value="<%=grupo.getGrado()+"-"+grupo.getGrupo()%>" disabled>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-1 col-12 p-3"></div>

                    <div class="col-md-4 col-12 p-3 shadow-lg bg-light rounded-bottom border-0">
                        <form method="post" action="../../CambiarContrasenaServlet">
                            <h6 class="text-center"><strong>Cambiar contraseña</strong></h6>
                            <hr>
                            <input type="hidden" value="<%=usuario.getId_usuario()%>" name="id_usuario">
                            <label class="col-form-label h6">Ingrese su contraseña: </label>
                            <input required class="form-control" type="password" name="contrasena1">
                            <br>
                            <label class="col-form-label h6">Reingrese su contraseña: </label>
                            <input required class="form-control" type="password" name="contrasena2">
                            <br>
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
        <% if ((String) request.getSession().getAttribute("mensajeAlumno") != null) {%>
        <div class="alert bg-<% if ((Boolean) request.getSession().getAttribute("flag")){%>success<%}else{%>danger<%}%> text-white alert-dismissible fade show"
             role="alert">
            <h6><%=(String) request.getSession().getAttribute("mensajeAlumno")%>
            </h6>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <%}%>
    </div>
    <script src="../../JS/bootstrap.bundle.min.js"></script>
    <%
        request.getSession().removeAttribute("mensajeAlumno");
    %>
</div>
</body>
</html>
<%} else {response.sendRedirect("../permisoDenegado.jsp");}%>