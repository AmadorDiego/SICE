<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page import="mx.edu.utez.sice.dao.UsuarioDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Bienvenido administrador</title>
    <link rel="stylesheet" type="text/css" href="../../CSS/datatables.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/adicionalesEBM.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/fondo.css">
    <!--///////////////////////////// Iconos ////////////////////////////////////-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,600,0,0"/>
    <%
        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuario");
    %>
</head>

<body>
<!-- //////////////////////////////////////////NavBar//////////////////////////////////////////////////////  -->
<header>
    <nav class="navbar bg-blue-utz">
        <div class="container-fluid">
            <a class="navbar-brand text-white">
                <img src="../../IMG/logo.png" alt="Logo" class="d-inline-block align-text-top logoNav">
                <h5 class="ms-1">SICE</h5>
            </a>
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
        <h1 class="text-white">Bienvenido <%=usuario.getNombre_usuario() %> <%=usuario.getApellido_usuario()%>
        </h1>
        <div>
            <a href="verUsuarioEliminado.jsp" class="btn btn-primary bg-blue-utz border-0 text-white">
                <span class="material-symbols-rounded justify-content-center ms-1">delete_sweep</span>
                <h6 class="justify-content-center">Ver usuarios eliminados</h6> </a>
            <a href="registroUsuario.jsp" class="btn btn-primary bg-blue-utz border-0 text-white">
                <span class="material-symbols-rounded justify-content-center ms-1">person_add</span>
                <h6 class="justify-content-center">Registrar usuario</h6> </a>
        </div>
    </div>
    <br>
    <div class="row">
        <div class="col-12">
            <% if ((String) request.getSession().getAttribute("mensaje") != null) {%>
            <div class="alert alert-<% if ((Boolean) request.getSession().getAttribute("flag")){%>primary<%}else{%>danger<%}%> alert-dismissible fade show"
                 role="alert">
                <strong><%=(String) request.getSession().getAttribute("mensaje")%>
                </strong>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </div>
        <%}%>


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
                                if (u.getId_tipo_usuario() > 1 && u.getId_tipo_usuario() < 4 ) {//Por cada usuario de la lista %>
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
                                   href="../../VerUsuarioServlet?id_usuario=<%=u.getId_usuario()%>">
                                <span class="material-symbols-rounded justify-content-center">edit</span>
                            </a>
                            </td>
                            <!----------------------- Esta es la columna que contienen todo el codigo de la alerta, perdon si se ve horrible -EBM -------------------------->
                            <td>
                                <%
                                    if(u.getEstado()==1){ %>
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
                                    <%}
                                %>

                                <!-- Contenido de la alerta -->
                                <div class="modal fade" id="exampleModal_<%= u.getId_usuario() %>" tabindex="-1"
                                     aria-labelledby="exampleModalLabel_<%= u.getId_usuario() %>" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header bg-blue-utz">
                                                <h1 class="modal-title fs-5 text-white" id="exampleModalLabel_<%= u.getId_usuario() %>">
                                                    <%if (u.getEstado()==1){%>Deshabilitar usuario<%}else{%>Restaurar usuario<%}%>
                                                </h1>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                        aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <%
                                                    if(u.getEstado()==1){ // %>
                                                        <h4>¿Estás seguro de que quieres deshabilitar a <%= u.getNombre_usuario()%> <%=u.getApellido_usuario()%>?</h4>
                                                        <p>Los usuarios deshabilitados no podrán ingresar en el sistema, sin embargo, pueden volver a ser habilitados.</p>
                                                <%} else { %>
                                                        <h4>¿Estás seguro de que quieres habilitar a <%= u.getNombre_usuario()%> <%=u.getApellido_usuario()%>?</h4>
                                                        <p>Los usuarios una vez habilitados volverán a tener los mismos permisos que anteriormente respecto a su rol.</p>
                                                <%}
                                                %>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="botonCancelar_<%= u.getId_usuario() %>">
                                                    Cancelar
                                                </button>
                                                <a class="btn btn-warning bg-red-SICE border-0 text-white"
                                                <%
                                                    if(u.getEstado()==1){ // %>
                                                    href="../../EliminacionLogServlet?id_usuario=<%=u.getId_usuario()%>">Deshabilitar</a>
                                                <%} else { %>
                                                    href="../../RestaurarUsuarioServlet?id_usuario=<%=u.getId_usuario()%>">Restaurar</a>
                                                <%}
                                                %>
                                            </div>
                                        </div>
                                    </div>
                                    <script>
                                        document.querySelectorAll('[id^="botonCancelar_"]').forEach(function(cancelButton) {
                                            cancelButton.addEventListener('click', function() {
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
        <script src="../../JS/bootstrap.js"></script>
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
<%

%>
</body>
</html>
