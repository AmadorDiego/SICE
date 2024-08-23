<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.dao.GrupoDao" %>
<%@ page import="mx.edu.utez.sice.dao.CarreraDao" %>
<%@ page import="mx.edu.utez.sice.dao.DivisionAcademicaDao" %>
<%@ page import="mx.edu.utez.sice.model.*" %>
<%@ page import="mx.edu.utez.sice.dao.UsuarioDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Asignar Examen</title>
    <link href="../../CSS/bootstrap.css" rel="stylesheet">
    <link href="../../CSS/adicionalesEBM.css" rel="stylesheet">
    <link href="../../CSS/fondo.css" rel="stylesheet">

    <!--///////////////////////////// Iconos ////////////////////////////////////-->
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@30,600,0,0"/>
</head>
<body>
<%
    HttpSession sesion = request.getSession();
    Examen examen = (Examen) sesion.getAttribute("examen");
    Usuario usuario = (Usuario) sesion.getAttribute("usuarioIndexDocente");
%>
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
                <a href="PieroCalificarExamen.jsp"
                   class="btn btn-primary bg-blue-utz ms-3 text-white border-0 d-flex align-items-center">
                    <span class="material-symbols-rounded">pending_actions</span>
                    <h6 class="mb-0 ms-2">Calificar examenes</h6>
                </a>
                <a href="indexDocente.jsp"
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
                    <ul class="dropdown-menu bg-green-utz-claro" aria-labelledby="dropdownMenuButton">
                        <li class="p-2">
                            <a class="btn btn-success bg-green-utz d-flex align-items-center">
                                <span class="material-symbols-rounded">person</span>
                                <h6 class="mb-0 ms-2">Perfil</h6>
                            </a>
                        </li>
                        <li class="p-2">
                            <a class="btn btn-danger bg-red-SICE d-flex align-items-center">
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


<!--//////////////////////////////////// Contenido /////////////////////////////////////////////-->
<%
    DivisionAcademicaDao divisionAcademicaDao = new DivisionAcademicaDao();
    ArrayList<DivisionAcademica> divisiones = divisionAcademicaDao.getAll();
%>

<div class="container">
    <br>
    <h1 class="blue-utz"><%=examen.getNombre_examen()%>
    </h1>
    <a class="btn btn-primary bg-blue-utz mb-4" href="indexDocente.jsp"> Regresar </a>

    <div class="row mt-2">
        <div class="col-11 me-0">
            <form method="post" action="../../AsignarGrupoExamenServlet" id="asignar_examen">
                <div>
                    <table class="table">
                        <thead class="bg-blue-utz text-white">
                        <tr>
                            <th scope="col">Division</th>
                            <th scope="col" class="w-75">Carrera</th>
                            <th scope="col">Grupo</th>
                            <th scope="col">Seleccionar</th>
                        </tr>
                        </thead>
                        <tbody class="bg-green-utz text-white">

                        <!-- ///////////////////////////////////////////////////////////////////////////////////////////////////// -->
                        <%
                            for (DivisionAcademica divisionAcademica : divisiones) {%>
                        <tr><%
                            CarreraDao carreraDao = new CarreraDao();
                            ArrayList<Carrera> carreras = carreraDao.getAll(divisionAcademica.getId_division_academica());
                            for (Carrera carrera : carreras) {
                                GrupoDao grupoDao = new GrupoDao();
                                ArrayList<Grupo> grupos = grupoDao.getAll(carrera.getId_carrera());
                                for (Grupo grupo : grupos) {
                                    if (grupoDao.imparteDocenteGrupo(grupo.getId_grupo(), usuario.getId_usuario())) {%>
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
                                }%></th>

                            <td class="bg-green-utz">
                                <input type="text" class="form-control bg-green-utz" disabled
                                       value="<%=carrera.getCarrera()%>">
                            </td>

                            <td><%=grupo.getGrado() + "-" + grupo.getGrupo()%>
                            </td>
                            <td>
                                <input type="hidden" name="id_examen" value="<%=examen.getId_examen()%>">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" role="switch" name="id_grupo[]"
                                           value="<%=grupo.getId_grupo()%>">
                                </div>
                            </td>
                        </tr>
                        <%
                                        }
                                    }
                                }
                            }
                        %>
                        </tbody>
                    </table>
                </div>
                <input type="hidden" name="id_usuario" value="<%=usuario.getId_usuario()%>">
                <input type="submit" form="asignar_examen"
                       class="btn btn-primary bg-blue-utz justify-content-center mb-0">
            </form>
        </div>

        <div class="col-1 ms-0">
            <div>
                <table class="table">
                    <thead class="bg-blue-utz text-white">
                    <tr>
                        <th scope="col">Alumnos</th>
                    </tr>
                    </thead>
                    <tbody class="bg-green-utz">
                    <!-- ///////////////////////////////////////////////////////////////////////////////////////////////////// -->
                    <%
                        for (DivisionAcademica divisionAcademica : divisiones) {%>
                    <tr><%
                        CarreraDao carreraDao = new CarreraDao();
                        ArrayList<Carrera> carreras = carreraDao.getAll(divisionAcademica.getId_division_academica());
                        for (Carrera carrera : carreras) {
                            GrupoDao grupoDao = new GrupoDao();
                            ArrayList<Grupo> grupos = grupoDao.getAll(carrera.getId_carrera());
                            for (Grupo grupo : grupos) {
                                if (grupoDao.imparteDocenteGrupo(grupo.getId_grupo(), usuario.getId_usuario())) {%>
                        <th scope="row">
                            <button type="button" class="btn btn-primary bg-blue-utz justify-content-center mb-0"
                                    data-bs-toggle="modal" data-bs-target="#alumnos_grupo_<%= grupo.getId_grupo() %>">
                                <span class="material-symbols-rounded d-flex justify-content-center mb-0-0">visibility</span>
                            </button>

                            <!-- Modal para asignar examen a alumnos -->
                            <div class="modal fade" id="alumnos_grupo_<%= grupo.getId_grupo() %>" tabindex="-1"
                                 aria-labelledby="exampleModalLabel_<%= grupo.getId_grupo()  %>" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header bg-blue-utz">
                                            <h1 class="modal-title fs-5 text-white"
                                                id="exampleModalLabel_<%= grupo.getId_grupo()  %>">
                                                Alumnos del <%=grupo.getGrado() + "-" + grupo.getGrupo()%>:
                                            </h1>
                                            <button type="button" class="btn-close-white" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <form method="post" action="../../AsignarAlumnoExamenServlet"
                                                  id="asignar_examen_alumno">
                                                <table class="table">
                                                    <thead>
                                                    <tr>
                                                        <th scope="col">Correo electrónico:</th>
                                                        <th scope="col">Nombre:</th>
                                                        <th scope="col">Asignar</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <input type="hidden" name="id_examen"
                                                           value="<%=examen.getId_examen()%>">
                                                    <%
                                                        UsuarioDao usuarioDao = new UsuarioDao();
                                                        ArrayList<Usuario> alumnos = usuarioDao.getAllAlumnosConGrupo(grupo.getId_grupo());
                                                        for (Usuario u : alumnos) {%>
                                                    <tr>
                                                        <th scope="row"><%=u.getCorreo_electronico()%>
                                                        </th>
                                                        <td><%=u.getApellido_usuario() + " " + u.getNombre_usuario()%>
                                                        </td>
                                                        <td>
                                                            <div class="form-check form-switch">
                                                                <input class="form-check-input" type="checkbox"
                                                                       role="switch" name="id_usuario"
                                                                       value="<%=u.getId_usuario()%>">
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <%}%>
                                                    </tbody>
                                                </table>
                                                <input type="hidden" name="id_usuario"
                                                       value="<%=usuario.getId_usuario()%>">
                                            </form>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                                                    id="botonCancelar_<%= grupo.getId_grupo() %>">
                                                Cancelar
                                            </button>
                                            <button type="submit" form="asignar_examen_alumno"
                                                    class="btn btn-primary bg-blue-utz justify-content-center mb-0"
                                                    value="Asignar">
                                                <p class="mb-0">Asignar</p>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </th>
                    </tr>
                    <%
                                    }
                                }
                            }
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="../../JS/bootstrap.js"></script>
<script src="../../JS/bootstrap.bundle.min.js"></script>
</body>
</html>






