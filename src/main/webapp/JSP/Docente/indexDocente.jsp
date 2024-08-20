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

    <title>Bienvenido docente</title>
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
    %>
</head>
<body>
<!--//////////////////////////////////////// Fondo ///////////////////////////////////////////////////-->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>

<!-- //////////////////////////////////////////NavBar//////////////////////////////////////////////////////  -->
<header>
    <nav class="navbar bg-blue-utz">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <a class="navbar-brand text-white">
                <img src="../../IMG/logoBueno.png" width="50" height="45" alt="Logo"
                     class="d-inline-block align-middle mt-0 mb-2">
                <h3 class="ms-2 d-inline-block align-middle">SICE</h3>
            </a>
            <div class="d-flex">
                <a href="indexDocente.jsp" class="btn btn-primary bg-blue-utz ms-3 text-white border-0">
                    <span class="material-symbols-rounded">home</span>
                </a>
                <a href="PieroCalificarExamen.jsp" class="btn btn-primary bg-blue-utz ms-3 text-white border-0">
                    <span class="material-symbols-rounded">pending_actions</span>
                </a>
                <a href="#" class="btn btn-primary bg-blue-utz ms-3 text-white border-0" data-bs-toggle="modal"
                   data-bs-target="#asignarGrupoDocente" data-bs-whatever="@getbootstrap">
                    <span class="material-symbols-rounded">groups</span>
                </a>
            </div>
        </div>
    </nav>
</header>


<!--////////////////////////////////////// Contenido //////////////////////////////////////////////////-->
<div class="modal fade" id="modalContra" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <!-- ... (código del modal sin cambios) ... -->
</div>

<div class="container my-2 my-md-4">
    <div class="row">
        <div class="col p-3">
            <h1 class="text-start mb-3 blue-utz">
                Bienvenido <%=usuario.getNombre_usuario() %> <%=usuario.getApellido_usuario()%>
            </h1>
            <h3 class="text-start mb-4 blue-utz">Exámenes creados:</h3>

            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="d-flex align-items-center">
                    <span class="me-2 text-white h5">Crear examen</span>
                    <a class="btn btn-primary bg-blue-utz h6" href="examen.jsp">Crear</a>
                </div>
                <div class="d-flex align-items-center">
                    <span class="me-2 text-white h5">Exámenes por calificar</span>
                    <a class="btn btn-primary bg-blue-utz h6" href="PieroCalificarExamen.jsp">Ver</a>
                </div>
            </div>

            <!--boton de busqueda-->
            <div class="d-flex mb-4">
                <div class="input-group-append">
                    <input id="search-input" type="search" class="form-control d-block" placeholder="Search">
                    <button id="search-button" type="button" class="btn btn-primary bg-blue-utz d-block">
                        <i class="fas fa-search"></i>
                        <h6>Buscar</h6>
                    </button>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-striped table-hover rounded-3">
                    <thead class="thead bg-blue-utz">
                    <tr class="text-white h5">
                        <th>Examen</th>
                        <th>Cantidad de preguntas</th>
                        <th></th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody class="bg-green-SICE">
                    <%
                        ExamenDao examenDao = new ExamenDao();
                        ArrayList<Examen> lista = examenDao.getAll(usuario.getId_usuario());
                        for (Examen examen : lista) {
                    %>
                    <tr class="h6">
                        <td><%= examen.getNombre_examen() %>
                        </td>
                        <td><%= examen.getCantidad_preguntas() %>
                        </td>
                        <td>
                            <a href="../../ModificarExamenServlet?id_examen=<%=examen.getId_examen()%>"
                               class="btn btn-primary bg-blue-utz">Ver</a>
                        </td>
                        <td>
<<<<<<< HEAD
                            <a href="${pageContext.request.contextPath}/asignarExamen?id_examen=<%=examen.getId_examen()%>"
=======
                            <a href="../../AsignarGrupoExamenServlet?id_examen=<%=examen.getId_examen()%>"
>>>>>>> a8497aa762f2cd13c0d9cc6a53617c0dc69cddb7
                               class="btn btn-success bg-green-SICE-obscuro">Asignar</a>
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
    <div class="position-fixed bottom-0 end-0 col-3 p-3">
        <% if ((String) request.getSession().getAttribute("mensajeDocente") != null) {%>
        <div class="alert alert-<% if ((Boolean) request.getSession().getAttribute("flag")){%>success<%}else{%>danger<%}%> alert-dismissible fade show"
             role="alert">
            <strong><%=(String) request.getSession().getAttribute("mensajeDocente")%>
            </strong>
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