<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.model.*" %>
<%@ page import="mx.edu.utez.sice.dao.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Grupos existentes</title>
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
                <h3 class="ms-2 d-inline-block align-middle">SICE</h3>
            </a>

            <div class="d-flex">
                <a href="#" class="btn btn-primary bg-blue-utz ms-3 text-white border-0 d-flex align-items-center" data-bs-toggle="modal"
                   data-bs-target="#crearGrupo">
                    <span class="material-symbols-rounded">group_add</span>
                    <h6 class="mb-0 ms-2">Crear grupo</h6>
                </a>
                <a href="#" class="btn btn-primary bg-blue-utz ms-3 text-white border-0 d-flex align-items-center" data-bs-toggle="modal"
                   data-bs-target="#asignarCarreraGrupoModal">
                    <span class="material-symbols-rounded">group_add</span>
                    <h6 class="mb-0 ms-2">Agregar a grupo</h6>
                </a>
                <a href="#" class="btn btn-primary bg-blue-utz ms-3 text-white border-0 d-flex align-items-center" data-bs-toggle="modal"
                   data-bs-target="#exampleModal">
                    <span class="material-symbols-rounded">person_add</span>
                    <h6 class="mb-0 ms-2">Agregar usuario</h6>
                </a>
                <a href="indexAdministrador.jsp" class="btn btn-primary bg-blue-utz ms-3 text-white border-0 d-flex align-items-center">
                    <span class="material-symbols-rounded">home</span>
                    <h6 class="mb-0 ms-2">Inicio</h6>
                </a>

                <!------------- Boton dezplegable ---------------->
                <div class="dropdown dropstart">
                    <button class="btn btn-primary bg-blue-utz ms-3 text-white border-0" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
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

<!--/////////////////////////////////////////////// Encabezado //////////////////////////////////////////////////////////////////////-->
<div class="container-xl">
    <br>
    <div class="col-12">
        <h1 class="mt-2">Grupos existentes:
        </h1>
    </div>
    <div class="row">
        <div class="col-md-11 col-12 p-3">
            <div>
                <table class="table">
                    <thead>
                    <tr>
                        <th scope="col">Division</th>
                        <th scope="col" class="w-75">Carrera</th>
                        <th scope="col">Grupo</th>
                        <th scope="col">Editar</th>
                        <th scope="col">Eliminar</th>
                    </tr>
                    </thead>
                    <tbody>
                        <!-- ///////////////////////////////////////////////////////////////////////////////////////////////////// -->
                        <%DivisionAcademicaDao divisionAcademicaDao = new DivisionAcademicaDao();
                        ArrayList<DivisionAcademica> divisiones = divisionAcademicaDao.getAll();
                        for (DivisionAcademica divisionAcademica : divisiones) {%>
                        <tr>
                            <%CarreraDao carreraDao = new CarreraDao();
                            ArrayList<Carrera> carreras = carreraDao.getAll(divisionAcademica.getId_division_academica());
                            for (Carrera carrera : carreras) {
                                GrupoDao grupoDao = new GrupoDao();
                                ArrayList<Grupo> grupos = grupoDao.getAll(carrera.getId_carrera());
                                for (Grupo grupo : grupos) {%>
                            <th scope="row"><%
                                switch (divisionAcademica.getId_division_academica()){
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
                                        break;}%>
                            </th>
                            <td>
                                <%=carrera.getCarrera()%>
                            </td>
                            <td>
                                <%=grupo.getGrado()+"-"+grupo.getGrupo()%>
                            </td>
                            <td>
                                <button type="button" data-bs-toggle="modal" data-bs-target="#grupo_<%= grupo.getId_grupo() %>" class="btn btn-success bg-green-SICE-obscuro border-0 text-white me-0">
                                    <span class="material-symbols-rounded justify-content-center">edit</span>
                                </button>
                                <!-- Modal para editar un grupo -->
                                <div class="modal fade" id="grupo_<%= grupo.getId_grupo() %>" tabindex="-1" aria-labelledby="exampleModal_<%= grupo.getId_grupo()  %>" aria-hidden="true">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">
                                            <div class="modal-header bg-blue-utz">
                                                <h1 class="modal-title fs-5 text-white" id="exampleModal_<%= grupo.getId_grupo()  %>">
                                                    Alumnos del <%=grupo.getGrado()+"-"+grupo.getGrupo()%>:
                                                </h1>
                                                <button type="button" class="btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form method="post" action="../../ActualizarGrupoServlet" id="actualizar_grupo">
                                                    <input type="hidden" value="<%=grupo.getId_grupo()%>">
                                                    <div>
                                                        <div class="row">
                                                            <div class="col-md-8 col-12 p-3">
                                                                <label class="form-label">Carrera:</label>
                                                                <select required class="form-control" name="id_carrera">
                                                                    <option disabled selected> Selecciona una carrera</option>
                                                                    <%ArrayList<Carrera> carreras1 = carreraDao.getAll();
                                                                        for (Carrera carrera1 : carreras1){%>
                                                                    <option value="<%=carrera1.getId_carrera()%>"><%=carrera1.getCarrera()%></option>
                                                                    <%}%>
                                                                </select>
                                                            </div>
                                                            <div class="col-md-2 col-12 p-3">
                                                                <label class="form-label">Grado:</label>
                                                                <input required class="form-control" type="number" min="1" max="10" name="grado" placeholder="Grado">
                                                            </div>
                                                            <div class="col-md-2 col-12 p-3">
                                                                <label class="form-label">Grupo:</label>
                                                                <select required class="form-control" name="grupo">
                                                                    <option disabled selected>Grupo</option>
                                                                    <option value="A">A</option>
                                                                    <option value="B">B</option>
                                                                    <option value="C">C</option>
                                                                    <option value="D">D</option>
                                                                    <option value="E">E</option>
                                                                    <option value="F">F</option>
                                                                    <option value="G">G</option>
                                                                    <option value="H">H</option>
                                                                    <option value="I">I</option>
                                                                    <option value="J">J</option>
                                                                </select>
                                                            </div>
                                                            <div>
                                                                <label class="form-label">Selecciona un periodo</label>
                                                                <select required class="form-control" name="id_periodo">
                                                                    <option disabled selected> Selecciona un periodo</option>
                                                                    <% PeriodoDao periodoDao = new PeriodoDao();
                                                                        ArrayList<Periodo> periodos = periodoDao.getAll();
                                                                        for (Periodo periodo : periodos){%>
                                                                    <option value="<%=periodo.getId_periodo()%>"><%=periodo.getDescripcion()%></option>
                                                                    <%}%>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <br>
                                                    </div>
                                                </form>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="botonCancelar_<%= grupo.getId_grupo() %>">Cancelar </button>
                                                <button type="submit" form="actualizar_grupo" class="btn btn-success bg-green-utz justify-content-center mb-0" value="Actualizar">Actualizar</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <button type="button" class="btn btn-danger bg-red-SICE border-0 text-white" data-bs-toggle="modal" data-bs-target="#exampleModal2_<%=grupo.getId_grupo()%>">
                                    <span class="material-symbols-rounded justify-content-center">delete</span>
                                </button>
                                <!-- Contenido de la alerta para borrar un grupo -->
                                <div class="modal fade" id="exampleModal2_<%=grupo.getId_grupo()%>" tabindex="-1" aria-labelledby="exampleModalLabel2_<%=grupo.getId_grupo()%>" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header bg-blue-utz">
                                                <h1 class="modal-title fs-5 text-white"
                                                    id="exampleModalLabel2_<%=grupo.getId_grupo()%>">
                                                    Eliminar grupo del <%=grupo.getGrado()+"-"+grupo.getGrupo()%>
                                                </h1>
                                                <button type="button" class="btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <strong>¿Estás seguro de que quieres eliminar el grupo del
                                                    <%=grupo.getGrado()+"-"+grupo.getGrupo()%>?</strong>
                                                <p>Esta acción no se puede deshacer, sin embargo, puedes crear otro grupo después.</p>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="botonCancelar_<%=grupo.getId_grupo()%>">
                                                    Cancelar
                                                </button>
                                                <a class="btn btn-danger bg-red-SICE border-0 text-white"
                                                   href="../../EliminarAlumnoGrupoServlet?id_grupo=<%=grupo.getId_grupo()%>">Eliminar grupo</a>
                                            </div>
                                        </div>
                                    </div>
                                    <script>
                                        document.querySelectorAll('[id^="botonCancelar_"]').forEach(function (cancelButton) {
                                            cancelButton.addEventListener('click', function () {
                                                let modalId = cancelButton.getAttribute('id').replace('botonCancelar_', '');
                                                // Aquí puedes agregar lógica adicional si es necesario.
                                                // Por ejemplo, limpiar o resetear datos del modal
                                            });
                                        });
                                    </script>
                                </div>
                            </td>
                        </tr><%}}}%>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Parte de alumnos -->
        <div class="col-md-1 col-12 p-3">
            <div>
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Alumnos</th>
                        </tr>
                        </thead>
                    <tbody>
                    <%for (DivisionAcademica divisionAcademica : divisiones) {%>
                        <tr> <%
                            CarreraDao carreraDao = new CarreraDao();
                            ArrayList<Carrera> carreras = carreraDao.getAll(divisionAcademica.getId_division_academica());
                            for (Carrera carrera : carreras) {
                                GrupoDao grupoDao = new GrupoDao();
                                ArrayList<Grupo> grupos = grupoDao.getAll(carrera.getId_carrera());
                                for (Grupo grupo : grupos) {%>
                            <th scope="row">
                                <button type="button" data-bs-toggle="modal" data-bs-target="#alumnos_grupo_<%= grupo.getId_grupo() %>" class="btn btn-success bg-green-SICE-obscuro border-0 text-white me-0">
                                    <span class="material-symbols-rounded justify-content-center">person</span>
                                </button>
                                <!-- Modal para eliminar alumnos de un grupo -->
                                <div class="modal fade modal-lg" id="alumnos_grupo_<%= grupo.getId_grupo() %>" tabindex="-1" aria-labelledby="exampleModalLabel_<%= grupo.getId_grupo()  %>" aria-hidden="true">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">
                                            <div class="modal-header bg-blue-utz">
                                                <h1 class="modal-title fs-5 text-white" id="exampleModalLabel_<%= grupo.getId_grupo()  %>">
                                                    Alumnos del <%=grupo.getGrado()+"-"+grupo.getGrupo()%>:
                                                </h1>
                                                <button type="button" class="btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form method="post" action="../../EliminarAlumnoGrupoServlet" id="eliminar_alumno_grupo">
                                                    <table class="table">
                                                        <thead>
                                                            <tr>
                                                                <th scope="col">Correo electrónico:</th>
                                                                <th scope="col">Nombre:</th>
                                                                <th scope="col">Eliminar</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <input type="hidden" name="id_grupo" value="<%=grupo.getId_grupo()%>">
                                                            <%
                                                                UsuarioDao usuarioDao = new UsuarioDao();
                                                                ArrayList<Usuario> alumnos = usuarioDao.getAllAlumnosConGrupo(grupo.getId_grupo());
                                                                for (Usuario u : alumnos) {%>
                                                            <tr>
                                                                <th scope="row"><%=u.getCorreo_electronico()%></th>
                                                                <td><%=u.getApellido_usuario()+" "+u.getNombre_usuario()%></td>
                                                                <td>
                                                                    <div class="form-check form-switch">
                                                                        <input class="form-check-input" type="checkbox" role="switch" name="id_usuario" value="<%=u.getId_usuario()%>">
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <%}%>
                                                        </tbody>
                                                    </table>
                                                </form>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="botonCancelar_<%= grupo.getId_grupo() %>">
                                                    Cancelar
                                                </button>
                                                <button type="submit" form="eliminar_alumno_grupo" class="btn btn-warning justify-content-center mb-0" value="Eliminar">Eliminar del grupo</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </th>
                        </tr><%}}}%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <script src="../../JS/bootstrap.bundle.min.js"></script>
    <div class="position-fixed bottom-0 start-0 p-3" style="width: 400px;">
        <% if ((String) request.getSession().getAttribute("mensajeAdministrador") != null) {%>
        <div class="alert p-3 mb-2 bg-<% if ((Boolean) request.getSession().getAttribute("flag")){%>success<%}else{%>danger<%}%> text-white alert-dismissible fade show"
             role="alert">
            <strong><%=(String) request.getSession().getAttribute("mensajeAdministrador")%></strong>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <%}%>
    </div>

    <!-- Modal para asignar alumnos a grupo -->
    <div class="modal fade" id="asignarCarreraGrupoModal" tabindex="-1" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-blue-utz">
                    <h1 class="modal-title fs-5 text-white">Alumnos por asignar a un grupo:</h1>
                    <button type="button" class="btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form method="post" action="../../AsignarAlumnoGrupoServlet" id="asignar_alumno_grupo">
                        <div>
                            <table class="table">
                                <thead>
                                <tr>
                                    <th scope="col">Correo electrónico:</th>
                                    <th scope="col">Nombre:</th>
                                    <th scope="col">Asignar</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    UsuarioDao UsuarioDao = new UsuarioDao();
                                    ArrayList<Usuario> alumnosSinGrupo = UsuarioDao.getAllAlumnosSinGrupo();
                                    for (Usuario u : alumnosSinGrupo) {%>
                                    <tr>
                                        <th scope="row"><%=u.getCorreo_electronico()%></th>
                                        <td><%=u.getNombre_usuario() + " " + u.getApellido_usuario()%></td>
                                        <td>
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" role="switch" name="id_usuario" value="<%=u.getId_usuario()%>" checked>
                                            </div>
                                        </td>
                                    </tr>
                                <%}%>
                                </tbody>
                            </table>
                        </div>
                        <hr>
                        <div>
                            <label class="form-label">División académica:</label>
                            <select id="division" onchange="cargarCarreras()" required class="form-control" name="id_division_academica">
                                <option disabled selected> Selecciona una división académica</option>
                                <%for (DivisionAcademica division : divisiones) {%>
                                <option value="<%= division.getId_division_academica() %>"><%= division.getDivision_academica() %></option>
                                <% } %>
                            </select>
                            <div class="row">
                                <div class="col-md-9 col-12 p-3">
                                    <label class="form-label">Carrera:</label>
                                    <select id="carrera" onchange="cargarGrupos()" disabled required
                                            class="form-control" name="id_carrera">
                                        <option disabled selected> Selecciona una carrera</option>
                                    </select>
                                </div>
                                <div class="col-md-3 col-12 p-3">
                                    <label class="form-label">Grupo:</label>
                                    <select id="grupo" disabled required class="form-control" name="id_grupo">
                                        <option disabled selected> Selecciona un grupo</option>
                                    </select>
                                </div>
                            </div>
                            <br>
                            <script src="../../JS/jquery-3.7.0.js"></script>
                            <script>
                                function cargarCarreras() {
                                    var divisionId = $('#division').val();
                                    if (divisionId) {
                                        $.ajax({
                                            url: '${pageContext.request.contextPath}/CarrerasServlet',
                                            data: {divisionId: divisionId},
                                            success: function (response) {
                                                console.log("Respuesta recibida:", response);
                                                $('#carrera').html(response);
                                                $('#carrera').prop('disabled', false);
                                                $('#grupo').html('<option value="">Selecciona un grupo</option>');
                                                $('#grupo').prop('disabled', true);
                                            },
                                            error: function (xhr, status, error) {
                                                console.error("Error al cargar carreras:", status, error);
                                            }
                                        });
                                    } else {
                                        // ... código existente ...
                                    }
                                }

                                function cargarGrupos() {
                                    var divisionId = $('#division').val();
                                    var carreraId = $('#carrera').val();
                                    if (divisionId && carreraId) {
                                        $.ajax({
                                            url: '${pageContext.request.contextPath}/GruposServlet',
                                            data: {divisionId: divisionId, carreraId: carreraId},
                                            success: function (response) {
                                                $('#grupo').html(response);
                                                $('#grupo').prop('disabled', false);
                                            }
                                        });
                                    } else {
                                        $('#grupo').html('<option value="">Selecciona un Grupo</option>');
                                        $('#grupo').prop('disabled', true);
                                    }
                                }
                            </script>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary bg-gray-SICE" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" form="asignar_alumno_grupo" class="btn btn-primary bg-blue-utz justify-content-center mb-0" value="Asignar">Asignar</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        const myModalAsignarCarreraGrupo = document.getElementById('asignarCarreraGrupoModal')
        const myInput = document.getElementById('recipient-name')

        myModalAsignarCarreraGrupo.addEventListener('shown.bs.modal', () => {
            myInput.focus()
        })
    </script>

    <!-- Modal registro usuario -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-blue-utz">
                    <h1 class="modal-title fs-5 text-white">Registrar nuevo usuario</h1>
                    <button type="button" class="btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form method="post" action="../../RegistrarUsuarioServlet" id="registrar_usuario">
                        <div class="row">
                            <div class="col-md-6 col-12 p-3">
                                <label class="col-form-label h6">Ingrese su nombre: </label>
                                <input required class="form-control" type="text" name="nombre_usuario" value=""
                                       placeholder="Nombre">
                                <br>
                                <label class="col-form-label h6">Ingrese su apellido: </label>
                                <input required class="form-control" type="text" name="apellido_usuario" value=""
                                       placeholder="Apellido">
                                <br>
                                <label class="col-form-label h6">Ingrese su correo electrónico: </label>
                                <input required class="form-control" type="email" name="correo_electronico" value=""
                                       placeholder="matricula/nombre@utez.edu.mx">
                            </div>

                            <div class="col-md-6 col-12 p-3">
                                <label class="col-form-label h6">Ingrese su contraseña: </label>
                                <input required class="form-control" type="password" name="contrasena1">
                                <br>
                                <label class="col-form-label h6">Reingrese su contraseña: </label>
                                <input required class="form-control" type="password" name="contrasena2">
                                <br>
                                <label class="col-form-label h6">Ingrese el tipo de usuario: </label>
                                <select required class="form-control" name="id_tipo_usuario" id="id_tipo_usuario">
                                    <option value="4">Docente administrador</option>
                                    <option value="1">Administrador</option>
                                    <option value="2">Docente</option>
                                    <option value="3">Alumno</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary bg-gray-SICE" data-bs-dismiss="modal">Cancelar
                    </button>
                    <button type="submit" form="registrar_usuario"
                            class="btn btn-primary bg-blue-utz justify-content-center mb-0" value="Registrar">
                        <p class="mb-0">Registrar</p>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal registro grupo -->
    <div class="modal fade" id="crearGrupo" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-blue-utz">
                    <h1 class="modal-title fs-5 text-white">Crear grupo</h1>
                    <button type="button" class="btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form method="post" action="../../CrearGrupoServlet" id="crear_grupo">
                        <div class="row">
                            <div class="col-md-8 col-12 p-3">
                                <label class="form-label">Carrera:</label>
                                <select required class="form-control" name="id_carrera">
                                    <option disabled selected> Selecciona una carrera</option>
                                    <% CarreraDao carreraDao = new CarreraDao();
                                        ArrayList<Carrera> carreras = carreraDao.getAll();
                                        for (Carrera carrera : carreras){%>
                                    <option value="<%=carrera.getId_carrera()%>"><%=carrera.getCarrera()%></option>
                                    <%}%>
                                </select>
                            </div>
                            <div class="col-md-2 col-12 p-3">
                                <label class="form-label">Grado:</label>
                                <input required class="form-control" type="number" min="1" max="10" name="grado" placeholder="Grado">
                            </div>
                            <div class="col-md-2 col-12 p-3">
                                <label class="form-label">Grupo:</label>
                                <select required class="form-control" name="grupo">
                                    <option disabled selected>Grupo</option>
                                    <option value="A">A</option>
                                    <option value="B">B</option>
                                    <option value="C">C</option>
                                    <option value="D">D</option>
                                    <option value="E">E</option>
                                    <option value="F">F</option>
                                    <option value="G">G</option>
                                    <option value="H">H</option>
                                    <option value="I">I</option>
                                    <option value="J">J</option>
                                </select>
                            </div>
                            <div>
                                <label class="form-label">Selecciona un periodo</label>
                                <select required class="form-control" name="id_periodo">
                                    <option disabled selected> Selecciona un periodo</option>
                                    <% PeriodoDao periodoDao = new PeriodoDao();
                                        ArrayList<Periodo> periodos = periodoDao.getAll();
                                        for (Periodo periodo : periodos){%>
                                    <option value="<%=periodo.getId_periodo()%>"><%=periodo.getDescripcion()%></option>
                                    <%}%>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary bg-gray-SICE" data-bs-dismiss="modal">Cancelar
                    </button>
                    <button type="submit" form="crear_grupo"
                            class="btn btn-primary bg-blue-utz justify-content-center mb-0" value="Crear">
                        <p class="mb-0">Crear</p>
                    </button>
                </div>
            </div>
        </div>
    </div>
    <script>
        const myModal = document.getElementById('exampleModal')
        const myInput = document.getElementById('recipient-name')
        myModal.addEventListener('shown.bs.modal', () => {
            myInput.focus()
        })
    </script>
    <%
        request.getSession().removeAttribute("mensaje");
    %>
    <script>
        const myModal = document.getElementById('myModal')
        const myInput = document.getElementById('myInput')

        myModal.addEventListener('shown.bs.modal', () => {
            myInput.focus()
        });
    </script>
</div>
</body>
</html>
<%} else {response.sendRedirect("../permisoDenegado.jsp");}%>