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
    <%
        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuario");
    %>
</head>

<body>
<!-- //////////////////////////////////////////NavBar//////////////////////////////////////////////////////  -->
<header>
    <div class="collapse" id="navbarToggleExternalContent">
        <div class="bg-blue-utz p-2">
            <h2 class="text-white p-2 ms-2">SICE</h2>
            <div class="d-flex flex-column ms-2">
                <a href="registroUsuario.jsp" class="btn w-25 text-white btn-brillo-efecto bg-blue-utz"> <h6>Registrar Usuario</h6> </a>
                <a href="verUsuarioEliminado.jsp" class="btn w-25 text-white btn-brillo-efecto bg-blue-utz"><h6>Usuarios Eliminados</h6></a>
            </div>
        </div>
    </div>
    <nav class="navbar bg-blue-utz">
        <div class="container-fluid">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
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
        <h1 class="text-white">Bienvenido <%=usuario.getNombre_usuario() %> <%=usuario.getApellido_usuario()%></h1>
        <div>
            <a href="verUsuarioEliminado.jsp" class="btn btn-primary bg-blue-utz border-0">Ver usuarios eliminados</a>
            <a href="registroUsuario.jsp" class="btn btn-primary bg-blue-utz border-0">Registrar usuario</a>
        </div>
    </div>
    <br>
    <div class="row">
        <div class="col-12">
            <% if ((String) request.getSession().getAttribute("mensaje") != null) {%>
            <div class="alert alert-<% if ((Boolean) request.getSession().getAttribute("flag")){%>success<%}else{%>danger<%}%> alert-dismissible fade show"
                 role="alert">
                <strong><%=(String) request.getSession().getAttribute("mensaje")%>
                </strong>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </div>
        <%}%>


<!---//////////////////////////////////////Contanido//////////////////////////////////////////////////-->
        <div class="row text-center">
            <div class="col-12">
                <div class="table-responsive rounded-4 text-white">
                    <table id="usuarios" class="table table-striped table-hover">
                        <thead class="bg-blue-utz text-white">
                        <tr>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>Correo</th>
                            <th>Estado</th>
                            <th>Tipo de usuario</th>
                            <th>Fecha registrado</th>
                            <th></th>
                            <th></th>
                        </tr>
                        </thead>

                        <tbody class="bg-green-utz">
                        <% // necesitamos acceder a la base de datos y obtener
                            // TODOS los usuarios
                            UsuarioDao dao = new UsuarioDao();
                            ArrayList<Usuario> lista = dao.getAll();
                            for (Usuario u : lista) {
                                if (u.getEstado() != 2) {//Por cada usuario de la lista %>
                        <tr>
                            <td class="text-white"><%=u.getNombre_usuario()%>
                            </td>
                            <td class="text-white"><%=u.getApellido_usuario()%>
                            </td>
                            <td class="text-white"><%=u.getCorreo_electronico()%>
                            </td>
                            <td class="text-white"><%=u.getEstado() == 1 ? "Habilitado" : "Deshabilitado"%>
                            </td>
                            <td class="text-white"><% switch (u.getId_tipo_usuario()) {
                                case 1:%>
                                <%="Administrador"%><%
                                        break;
                                    case 2:%>
                                <%="Docente"%><%
                                        break;
                                    case 3:%>
                                <%="Alumno"%><%
                                        break;
                                    case 4:%>
                                <%="Docente administrador"%><%
                                            break;
                                    }%></td>
                            <td class="text-white"><%=u.getFecha_registrado()%>
                            </td>
                            <td><a class="btn btn-success bg-green-SICE-obscuro border-0 text-white" href="../../VerUsuarioServlet?id_usuario=<%=u.getId_usuario()%>">Ver</a>
                            </td>
                            <td><a class="btn btn-warning bg-red-SICE border-0 text-white"
                                   href="../../EliminacionLogServlet?id_usuario=<%=u.getId_usuario()%>">Eliminar</a></td>
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
<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
    Launch demo modal
</button>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                ...
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>
<script>
    const myModal = document.getElementById('myModal')
    const myInput = document.getElementById('myInput')

    myModal.addEventListener('shown.bs.modal', () => {
        myInput.focus()
    })
</script>
</body>
</html>
