<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page import="mx.edu.utez.sice.dao.UsuarioDao" %>
<%@ page import="mx.edu.utez.sice.dao.DivisionAcademicaDao" %>
<%@ page import="mx.edu.utez.sice.model.DivisionAcademica" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bienvenido administrador</title>
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
    %>
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
                <a href="#" class="btn btn-primary bg-blue-utz ms-3 text-white border-0 d-flex align-items-center"
                   data-bs-toggle="modal"
                   data-bs-target="#asignarCarreraGrupoModal" data-bs-whatever="@getbootstrap">
                    <span class="material-symbols-rounded">group_add</span>
                    <h6 class="mb-0 ms-2">Agregar a grupo</h6>
                </a>
                <a href="#" class="btn btn-primary bg-blue-utz ms-3 text-white border-0 d-flex align-items-center"
                   data-bs-toggle="modal"
                   data-bs-target="#exampleModal" data-bs-whatever="@getbootstrap">
                    <span class="material-symbols-rounded">person_add</span>
                    <h6 class="mb-0 ms-2">Agregar usuario</h6>
                </a>
                <a href="indexAdministrador.jsp"
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
                            <a href="perfilAdministrador.jsp" class="btn btn-success bg-green-utz d-flex align-items-center">
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


<!--///////////////////////////////////////////// Fondo //////////////////////////////////////////////////////////////-->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>


<!--/////////////////////////////////////////////// Encabezado //////////////////////////////////////////////////////////////////////-->
<div class="container-xl">
    <div class="col-12">
        <h1 class="text-white mt-2">Bienvenido <%=usuario.getNombre_usuario() %> <%=usuario.getApellido_usuario()%>
        </h1>
    </div>


        <!---//////////////////////////////////////Contenido//////////////////////////////////////////////////-->
        <div class="row text-center">
            <div class="col-12">
                <div class="table-responsive rounded-4 text-white d-flex d-md-block">
                    <table id="usuarios" class="table table-striped table-hover">
                        <thead class="bg-blue-utz text-white">
                        <tr>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>Correo</th>
                            <th class="d-none d-md-table-cell">Estado</th>
                            <th>Tipo de usuario</th>
                            <th class="d-none d-md-table-cell">Fecha registrado</th>
                            <th class="me-0"></th>
                            <th class="me-0"></th>
                        </tr>
                        </thead>

                        <tbody class="bg-green-utz">
                        <% // necesitamos acceder a la base de datos y obtener
                            // TODOS los usuarios
                            UsuarioDao dao = new UsuarioDao();
                            ArrayList<Usuario> lista = dao.getAll();
                            for (Usuario u : lista) {
                                if (u.getId_tipo_usuario() > 1 && u.getId_tipo_usuario() < 4) {//Por cada usuario de la lista %>
                        <tr>
                            <td class="text-white"><%=u.getNombre_usuario()%>
                            </td>
                            <td class="text-white"><%=u.getApellido_usuario()%>
                            </td>
                            <td class="text-white"><%=u.getCorreo_electronico()%>
                            </td>
                            <td class="text-white d-none d-md-table-cell"><%=u.getEstado() == 1 ? "Habilitado" : "Deshabilitado"%>
                            </td>
                            <td class="text-white"><% switch (u.getId_tipo_usuario()) {
                                case 2:%>
                                <%="Docente"%><%
                                        break;
                                    case 3:%>
                                <%="Alumno"%><%
                                            break;
                                    }%></td>
                            <td class="text-white d-none d-md-table-cell"><%=u.getFecha_registrado()%>
                            </td>
                            <td><a class="btn btn-success bg-green-SICE-obscuro border-0 text-white me-0"
                                   href="../../ActualizarUsuarioServlet?id_usuario=<%=u.getId_usuario()%>">
                                <span class="material-symbols-rounded justify-content-center">edit</span>
                            </a>
                            </td>
                            <!----------------------- Esta es la columna que contienen todo el codigo de la alerta, perdon si se ve horrible -EBM -------------------------->
                            <td>
                                <%
                                    if (u.getEstado() == 1) { %>
                                <!-- Boton que activa la alerta -->
                                <button type="button" class="btn btn-warning bg-red-SICE border-0 text-white me-0"
                                        data-bs-toggle="modal" data-bs-target="#exampleModal_<%= u.getId_usuario() %>">
                                    <span class="material-symbols-rounded justify-content-center">delete</span>
                                </button>
                                <%} else { %>
                                <button type="button" class="btn btn-warning bg-green-SICE border-0 text-white"
                                        data-bs-toggle="modal" data-bs-target="#exampleModal_<%= u.getId_usuario() %>">
                                    <span class="material-symbols-rounded justify-content-center">restore_from_trash</span>
                                </button>
                                <%
                                    }
                                %>

                                <!-- Contenido de la alerta -->
                                <div class="modal fade" id="exampleModal_<%= u.getId_usuario() %>" tabindex="-1"
                                     aria-labelledby="exampleModalLabel_<%= u.getId_usuario() %>" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header bg-blue-utz">
                                                <h1 class="modal-title fs-5 text-white"
                                                    id="exampleModalLabel_<%= u.getId_usuario() %>">
                                                    <%if (u.getEstado() == 1) {%>Deshabilitar usuario<%} else {%>
                                                    Restaurar usuario<%}%>
                                                </h1>
                                                <button type="button" class="btn-close-white" data-bs-dismiss="modal"
                                                        aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <%
                                                    if (u.getEstado() == 1) { // %>
                                                <strong>¿Estás seguro de que quieres deshabilitar
                                                    a <%= u.getNombre_usuario()%> <%=u.getApellido_usuario()%>?</strong>
                                                <p>Los usuarios deshabilitados no podrán ingresar en el sistema, sin
                                                    embargo, pueden volver a ser habilitados.</p>
                                                <%} else { %>
                                                <strong>¿Estás seguro de que quieres habilitar
                                                    a <%= u.getNombre_usuario()%> <%=u.getApellido_usuario()%>?</strong>
                                                <p>Los usuarios una vez habilitados volverán a tener los mismos permisos
                                                    que anteriormente respecto a su rol.</p>
                                                <%
                                                    }
                                                %>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                                                        id="botonCancelar_<%= u.getId_usuario() %>">
                                                    Cancelar
                                                </button>
                                                <a class="btn btn-warning bg-red-SICE border-0 text-white"
                                                        <%
                                                            if (u.getEstado() == 1) { // %>
                                                   href="../../EliminacionLogServlet?id_usuario=<%=u.getId_usuario()%>">Deshabilitar</a>
                                                <%} else { %>
                                                href="../../RestaurarUsuarioServlet?id_usuario=<%=u.getId_usuario()%>
                                                ">Restaurar</a>
                                                <%
                                                    }
                                                %>
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
                        </tr>
                        <% }
                        } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script src="../../JS/jquery-3.7.0.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="../../JS/datatables.js"></script>
        <script src="../../JS/dataTables.bootstrap5.js"></script>
        <script src="../../JS/es-MX.json"></script>
        <script>
            document.addEventListener('DOMContentLoaded', () => {
                const table = document.getElementById('usuarios');
                new DataTable(table, {
                    language: {
                        url: '../../JS/es-MX.json'
                    }
                });
            });
        </script>
    </div>
    <div class="position-fixed bottom-0 end-0 col-3 p-3">
        <% if ((String) request.getSession().getAttribute("mensaje") != null) {%>
        <div class="alert alert-<% if ((Boolean) request.getSession().getAttribute("flag")){%>success<%}else{%>danger<%}%> alert-dismissible fade show"
             role="alert">
            <strong><%=(String) request.getSession().getAttribute("mensaje")%>
            </strong>
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
                                    ArrayList<Usuario> alumnos = dao.getAllAlumnosSinGrupo();
                                    for (Usuario u : alumnos) {%>
                                <tr>
                                    <th scope="row"><%=u.getCorreo_electronico()%>
                                    </th>
                                    <td><%=u.getNombre_usuario() + " " + u.getApellido_usuario()%>
                                    </td>
                                    <td>
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" role="switch"
                                                   name="id_usuario" value="<%=u.getId_usuario()%>" checked>
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
                            <select id="division" onchange="cargarCarreras()" required class="form-control"
                                    name="id_division_academica">
                                <option disabled selected> Selecciona una división académica</option>
                                <%
                                    DivisionAcademicaDao divisionAcademicaDao = new DivisionAcademicaDao();
                                    ArrayList<DivisionAcademica> divisiones = divisionAcademicaDao.getAll();
                                    for (DivisionAcademica division : divisiones) {
                                %>
                                <option value="<%= division.getId_division_academica() %>"><%= division.getDivision_academica() %>
                                </option>
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
                    <button type="button" class="btn btn-secondary bg-gray-SICE" data-bs-dismiss="modal">Cancelar
                    </button>
                    <button type="submit" form="asignar_alumno_grupo"
                            class="btn btn-primary bg-blue-utz justify-content-center mb-0" value="Asignar">
                        <p class="mb-0">Asignar</p>
                    </button>
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
</div>
<script>
    const myModal = document.getElementById('myModal')
    const myInput = document.getElementById('myInput')

    myModal.addEventListener('shown.bs.modal', () => {
        myInput.focus()
    });
</script>
</body>
</html>
