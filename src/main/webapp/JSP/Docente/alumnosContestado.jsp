<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.model.*" %>
<%@ page import="mx.edu.utez.sice.dao.*" %><%--
  Created by IntelliJ IDEA.
  User: amado
  Date: 27/07/2024
  Time: 02:30 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="es">
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>

    <title>Examen contestado</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/fondo.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/adicionalesEBM.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/Docentes.css">
    <!--///////////////////////////// Iconos ////////////////////////////////////-->
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@30,600,0,0"/>
    <%
        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuarioIndexDocente");
        if (usuario != null){
            Examen examen = (Examen) sesion.getAttribute("examen");
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
                <h3 class="ms-2 d-inline-block align-middle"><strong>Bienvenido <%=usuario.getNombre_usuario() + " " + usuario.getApellido_usuario()%></strong></h3>
            </a>
            <div class="d-flex">
                <a href="examen.jsp"
                   class="btn btn-primary bg-blue-utz ms-3 text-white border-0 d-flex align-items-center">
                    <span class="material-symbols-rounded">task</span>
                    <h6 class="mb-0 ms-2">Crear examen</h6>
                </a>
                <a href="#" class="btn btn-primary bg-blue-utz ms-3 text-white border-0 d-flex align-items-center" data-bs-toggle="modal"
                   data-bs-target="#asignarGrupoDocente" data-bs-whatever="@getbootstrap">
                    <span class="material-symbols-rounded">groups</span>
                    <h6 class="mb-0 ms-2">Grupos</h6>
                </a>
                <a href="indexDocente.jsp" class="btn btn-primary bg-blue-utz ms-3 text-white border-0 d-flex align-items-center">
                    <span class="material-symbols-rounded">home</span>
                    <h6 class="mb-0 ms-2">Inicio</h6>
                </a>

                <!------------- Boton dezplegable ---------------->
                <div class="dropdown dropstart">
                    <button class="btn btn-primary bg-blue-utz ms-3 text-white border-0" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                        <span class="material-symbols-rounded">arrow_drop_down</span>
                    </button>
                    <ul class="dropdown-menu bg-blue-utz" aria-labelledby="dropdownMenuButton">
                        <li class="p-2">
                            <a href="perfilDocente.jsp" class="btn btn-success bg-green-utz d-flex align-items-center">
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

<div class="container-xl">
    <div class="col-12">
        <hr>
        <h3 class="text-center"><strong>
            <%UsuarioDao usuarioDao = new UsuarioDao();
                ArrayList<Usuario> usuarios = usuarioDao.getAllAlumnosExamenContestado(examen.getId_examen());
                System.out.println(examen.getId_examen());
                if (usuarios == null || usuarios.isEmpty()) {%>No tienes respuestas del examen aún</strong></h3>
        <hr><%}else {%>Respuestas de alumnos
        </strong></h3>
        <hr>

        <div class="row">
            <div class="col-md-8 col-12 p-3">
                <% //clase usuario
                    if (request.getSession().getAttribute("examenAlumno") != null) {
                Usuario alumno = (Usuario) request.getSession().getAttribute("examenAlumno");%>
                <div class="container-fluid">
                    <!-- Contenido -->
                    <div class="row align-items-center mt-3">
                        <div class="col bg-white rounded-4 mx-5 p-5">

                            <form action="../../CalificarExamenServlet" method="post">
                                <%
                                    PreguntaDao preguntaDao = new PreguntaDao();
                                    ArrayList<Pregunta> listaPreguntas = preguntaDao.getAll(examen.getId_examen());
                                    int i = 0;
                                    for (Pregunta pregunta : listaPreguntas) {
                                        i++;
                                %>
                                <div class="card rounded-4 border-0 mb-4">
                                    <div class="card-header bg-blue-utz text-white">
                                        <h6>Pregunta <%= i %>: <%= pregunta.getPregunta() %></h6>
                                    </div>
                                    <div class="card-body shadow-lg bg-light rounded-bottom border-0 p-4">
                                        <% AplicacionDao aplicacionDao = new AplicacionDao();
                                        ArrayList<Aplicacion> aplicaciones = aplicacionDao.getAplicacionByAlumnoExamen(alumno.getId_usuario(), examen.getId_examen());

                                            if (pregunta.getId_tipo_pregunta() == 2) { %>
                                        <div class="mb-3">
                                            <%
                                                OpcionDao opcionDao = new OpcionDao();
                                                ArrayList<Opcion> listaOpciones = opcionDao.getAll(pregunta.getId_pregunta());
                                                int j = 0;
                                                for (Opcion opcion : listaOpciones) {
                                                    PreguntaOpcion preguntaOpcion = opcionDao.getOpcionCorrecta(opcion.getId_opcion());
                                                    j++;
                                            %>
                                            <div class="form-check">
                                                <input required class="form-check-input" type="radio" name="pregunta_<%=pregunta.getId_pregunta()%>" id="opcion_<%= i %>_<%= j %>" value="<%= opcion.getId_opcion() %>">
                                                <label class="form-check-label" for="opcion_<%= i %>_<%= j %>">
                                                    <%= opcion.getOpcion() %>
                                                </label>
                                            </div>
                                            <% } %>
                                        </div>
                                        <% } else { %>
                                        <div class="mb-3">
                                            <label for="preguntaAbierta_<%= i %>">Ingresa una respuesta:</label>
                                            <input type="text" class="form-control rounded-3" id="preguntaAbierta_<%= i %>" name="pregunta_<%=pregunta.getId_pregunta()%>" required>
                                        </div>
                                        <% } %>
                                    </div>
                                </div>
                                <% } %>

                                <div class="text-center">
                                    <button type="submit" class="btn btn-success rounded-3 p-2">
                                        Enviar calificación
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <%}%>
            </div>
            <div class="col-md-3 col-12 p-3">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>
                            <th style="width: 25%">Nombre</th>
                            <th style="width: 5%">Calificar</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Usuario alumno : usuarios) {%>
                        <tr class="h6">
                            <td class="text-wrap" style="max-width: 30%; word-break: break-word;"><%=alumno.getApellido_usuario()+" "+alumno.getNombre_usuario()%></td>
                            <td>
                                <a href="../../CalificarExamenServlet?id_alumno=<%=alumno.getId_usuario()%>"
                                   class="btn btn-success bg-green-SICE-obscuro">Respuestas</a>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <%}%>
    </div>



    <!-------------------------------------- Modal para asignar grupos al docente ------------------------------------------------------->
    <div class="modal fade" id="asignarGrupoDocente" tabindex="-1" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-blue-utz">
                    <h1 class="modal-title fs-5 text-white">Grupos que impartes:</h1>
                    <button type="button" class="btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form method="post" action="../../AsignarGrupoDocenteServlet" id="asignar_grupo_docente">
                        <input type="hidden" name="id_usuario" value="<%=usuario.getId_usuario()%>">
                        <div>
                            <table class="table">
                                <thead>
                                <tr>
                                    <th scope="col">Division</th>
                                    <th scope="col">Carrera</th>
                                    <th scope="col">Grado y grupo</th>
                                    <th scope="col">Seleccionar</th>
                                </tr>
                                </thead>
                                <tbody>
                                <!-- ///////////////////////////////////////////////////////////////////////////////////////////////////// -->
                                <%
                                    DivisionAcademicaDao divisionAcademicaDao = new DivisionAcademicaDao();
                                    ArrayList<DivisionAcademica> divisiones = divisionAcademicaDao.getAll();
                                    for (DivisionAcademica divisionAcademica : divisiones) {%>
                                <tr><%
                                    CarreraDao carreraDao = new CarreraDao();
                                    ArrayList<Carrera> carreras = carreraDao.getAll(divisionAcademica.getId_division_academica());
                                    for (Carrera carrera : carreras) {
                                        GrupoDao grupoDao = new GrupoDao();
                                        ArrayList<Grupo> grupos = grupoDao.getAll(carrera.getId_carrera());
                                        for (Grupo grupo : grupos) {%>
                                    <th scope="row">
                                        <%
                                            switch (divisionAcademica.getId_division_academica()) {
                                                case 1:%>
                                        DATID<%
                                            break;
                                        case 2:%>
                                        DAMI<%
                                            break;
                                        case 3:%>
                                        DACEA<%
                                            break;
                                        case 4:%>
                                        DATEFI<%
                                            break;
                                        default:%>
                                        divisionAcademica.getDivision_academica()<%
                                                break;
                                        }%>
                                    </th>
                                    <td><%=carrera.getCarrera()%>
                                    </td>
                                    <td><%=grupo.getGrado() + "-" + grupo.getGrupo()%>
                                    </td>
                                    <td>
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" role="switch"
                                                   name="id_grupo" value="<%=grupo.getId_grupo()%>"
                                                <%if (grupoDao.imparteDocenteGrupo(grupo.getId_grupo(), usuario.getId_usuario())){%>
                                                   checked disabled<%}%>>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                            }
                                        }
                                    }
                                %>
                                </tbody>
                            </table>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary bg-gray-SICE" data-bs-dismiss="modal">Cancelar
                    </button>
                    <button type="submit" form="asignar_grupo_docente"
                            class="btn btn-primary bg-blue-utz justify-content-center mb-0" value="Asignar">
                        <p class="mb-0">Asignar</p>
                    </button>
                </div>
            </div>
        </div>
    </div>
    <script>
        const myModalasignarGrupoDocente = document.getElementById('asignarGrupoDocente')
        const myInput = document.getElementById('recipient-name')

        myModalasignarGrupoDocente.addEventListener('shown.bs.modal', () => {
            myInput.focus()
        })
    </script>
    <div class="position-fixed bottom-0 start-0 p-3">
        <% if ((String) request.getSession().getAttribute("mensajeDocente") != null) {%>
        <div class="alert bg-<% if ((Boolean) request.getSession().getAttribute("flag")){%>success<%}else{%>danger<%}%> text-white alert-dismissible fade show"
             role="alert">
            <h6><%=(String) request.getSession().getAttribute("mensajeDocente")%>
            </h6>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <%}%>
    </div>
    <%
        request.getSession().removeAttribute("mensajeDocente");
    %>
</div>

<script src="../../JS/bootstrap.js"></script>
<script src="../../JS/bootstrap.bundle.min.js"></script>
</body>
</html>
<%} else {response.sendRedirect("../permisoDenegado.jsp");}%>