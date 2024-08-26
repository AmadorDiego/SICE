<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.dao.ExamenDao" %>
<%@ page import="mx.edu.utez.sice.dao.DivisionAcademicaDao" %>
<%@ page import="mx.edu.utez.sice.dao.CarreraDao" %>
<%@ page import="mx.edu.utez.sice.dao.GrupoDao" %>
<%@ page import="mx.edu.utez.sice.model.*" %><%--
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

    <title>Examenes asignados por calificar</title>
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
            <%ExamenDao examenDao = new ExamenDao();
                ArrayList<Examen> lista = examenDao.getAllAsignadosCompletados(usuario.getId_usuario());
                if (lista == null || lista.isEmpty()) {%>No tienes examenes pendientes aún</strong></h3>
        <hr><%}else {%>Examenes asignados
        </strong></h3>
        <hr>
    </div>
    <div class="row">
        <div class="col p-3">
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th style="width: 25%">Examen</th>
                        <th style="width: 60%">Descripción</th>
                        <th style="width: 5%">PDF</th>
                        <th style="width: 10%">Respuestas</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%for (Examen examen : lista) {%>
                    <tr class="h6">
                        <td class="text-wrap" style="max-width: 30%; word-break: break-word;"><%= examen.getNombre_examen() %></td>
                        <td class="text-wrap" style="max-width: 50%; word-break: break-word;"><%= examen.getDescripcion() %></td>
                        <td>
                            <a href="../../pdf?id_examen=<%=examen.getId_examen()%>"
                               class="btn btn-danger bg-red-utz">PDF</a>
                        </td>
                        <td>
                            <a href="../../RespuestasServlet?id_examen=<%=examen.getId_examen()%>"
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