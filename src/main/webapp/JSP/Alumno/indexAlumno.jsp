<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page import="mx.edu.utez.sice.model.Examen" %>
<%@ page import="mx.edu.utez.sice.dao.ExamenDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.dao.UsuarioDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Bienvenido Alumno</title>
    <link rel='stylesheet' type='text/css' media='screen' href='../../CSS/bootstrap.css'>
    <link rel='stylesheet' type='text/css' media='screen' href='../../CSS/fondo.css'>
    <link rel='stylesheet' type='text/css' media='screen' href='../../CSS/adicionalesEBM.css'>
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
<!--/////////////////////////////////// Fondo //////////////////////////////////////////-->

<!-- //////////////////////////// Navbar /////////////////////////////////-->
<header>
    <nav class="navbar bg-blue-utz">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <a class="navbar-brand text-white">
                <img src="../../IMG/logoBueno.png" width="50" height="45" alt="Logo"
                     class="d-inline-block align-middle mt-0 mb-2">
                <h3 class="ms-2 d-inline-block align-middle"><strong>Bienvenido <%=usuario.getNombre_usuario() + " " + usuario.getApellido_usuario()%></strong>
                    </h3>
            </a>
            <div class="d-flex">
                <a href="alumnoRelizados.jsp"
                   class="btn btn-primary bg-blue-SICE-claro ms-3 text-white border-0 d-flex align-items-center">
                    <span class="material-symbols-rounded">task</span>
                    <h6 class="mb-0 ms-2">Examenes Realizados</h6>
                </a>
                <a href="indexAlumno.jsp"
                   class="btn btn-primary bg-blue-utz ms-3 text-white border-0 d-flex align-items-center">
                    <span class="material-symbols-rounded">home</span>
                    <h6 class="mb-0 ms-2">Inicio</h6>
                </a>

                <!------------- Boton dezplegable ---------------->
                <div class="dropdown dropstart">
                    <button class="btn btn-primary bg-blue-utz ms-3 text-white border-0" type="button"
                            id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                        <span class="material-symbols-rounded">arrow_drop_down</span>
                    </button>
                    <ul class="dropdown-menu bg-blue-utz" aria-labelledby="dropdownMenuButton">
                        <li class="p-2">
                            <a class="btn btn-success bg-green-utz d-flex align-items-center">
                                <span class="material-symbols-rounded">person</span>
                                <h6 class="mb-0 ms-2">Perfil</h6>
                            </a>
                        </li>
                        <li class="p-2">
                            <a href="../../CerrarSesionServlet" class="btn btn-danger bg-red-SICE d-flex align-items-center">
                                <span class="material-symbols-rounded">logout</span>
                                <h6 class="mb-0 ms-2">Cerrar Sesion</h6>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
</header>


<!--////////////////////////// Encabezado ////////////////////////////////////-->
<div class="container-fluid">
    <!--////////////////////////////// Contenido principal(Tarjetas) ////////////////////////////-->
    <div class="row">
        <div class="col-12">
            <hr>
            <h3 class="text-center"><strong>
                <%ExamenDao examenDao = new ExamenDao();
                    UsuarioDao usuarioDao = new UsuarioDao();
                    ArrayList<Examen> examenes = examenDao.getAll(usuario.getId_usuario());
                    if (examenes == null || examenes.isEmpty()) {%>¡Genial, no tienes examenes pendientes aún!</strong></h3>
            <hr><%}else {%>Examenes pendientes
            </strong></h3>
            <hr>
        </div>
        <%for (Examen examen : examenes) {%>
        <div class="col-12 col-md-6 p-4">
            <div class="card rounded-5 border-0 bg-blue-utz">
                <div class="card-header bg-blue-utz border-0 rounded-5"><br></div>
                <div class="card-body shadow-lg bg-light rounded-bottom border-0">
                    <h3 class="card-title blue-utz"><strong><%=examen.getNombre_examen()%>
                    </strong></h3>
                    <h6 class="card-text "><%=examen.getDescripcion()%>
                    </h6>
                    <div class="p-4 d-flex flex-row-reverse bd-highlight gap-2">
                        <a href="../../ContestarExamenServlet?id_examen=<%=examen.getId_examen()%>"
                           class="btn btn-primary bg-blue-utz text-white">Realizar</a>
                        <%Usuario docente = usuarioDao.getDocentePorExamen(examen.getId_examen());%>
                        <h6 class="align-content-center ms-1">Hecho por el docente: <%=docente.getNombre_usuario() + " " + docente.getApellido_usuario()%>
                        </h6>
                    </div>
                </div>
            </div>
        </div>
        <%
            }}
        %>
    </div>
    <div class="position-fixed bottom-0 start-0 p-3" style="width: 400px;">
        <% if ((String) request.getSession().getAttribute("mensajeAlumno") != null) {%>
        <div class="alert p-3 mb-2 bg-<% if ((Boolean) request.getSession().getAttribute("flag")){%>success<%}else{%>danger<%}%> text-white alert-dismissible fade show"
             role="alert">
            <h6><%=(String) request.getSession().getAttribute("mensajeAlumno")%></h6>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <%}%>
    </div>
</div>
<%
    request.getSession().removeAttribute("mensajeAlumno");
%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script href="../../JS/bootstrap.js"></script>
</body>
</html>
<%} else {response.sendRedirect("../permisoDenegado.jsp");}%>