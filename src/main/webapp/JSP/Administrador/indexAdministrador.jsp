
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page import="mx.edu.utez.sice.dao.UsuarioDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Bienvenido administrador</title>
    <link rel="stylesheet" type="text/css" href="../../CSS/datatables.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.css">
</head>
<body>
<br>
    <div class="container-xl">
        <h1>Bienvenido administrador</h1>
        <div>
            <a href="verUsuarioEliminado.jsp" class="btn btn-primary">Ver usuarios eliminados</a>
            <a href="registroUsuario.jsp" class="btn btn-primary">Registrar usuario</a>
        </div>
        <br>
        <div class="container-sm">
            <% if ((String)request.getSession().getAttribute("mensaje") != null){%><div class="alert alert-<% if ((Boolean) request.getSession().getAttribute("flag")){%>success<%}else{%>danger<%}%> alert-dismissible fade show" role="alert">
            <strong><%=(String)request.getSession().getAttribute("mensaje")%></strong>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div><%}%>
    </div>
    <div class="container text-center" >
        <table id="usuarios" class="table table-striped table-hover">
            <thead>
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
            <tbody>

            <%  // necesitamos acceder a la base de datos y obtener
                // TODOS los usuarios
                UsuarioDao dao = new UsuarioDao();
                ArrayList<Usuario> lista = dao.getAll();
                for(Usuario u : lista){ if (u.getEstado()!=2){//Por cada usuario de la lista %>
            <tr>
                <td><%=u.getNombre_usuario()%></td>
                <td><%=u.getApellido_usuario()%></td>
                <td><%=u.getCorreo_electronico()%></td>
                <td><%=u.getEstado()==1 ? "Habilitado":"Deshabilitado"%></td>
                <td><% switch(u.getId_tipo_usuario()){
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
                <td><%=u.getFecha_registrado()%></td>
                <td><a class="btn btn-primary" href="../../VerUsuarioServlet?id_usuario=<%=u.getId_usuario()%>">Ver</a></td>
                <td><a class="btn btn-primary" href="../../EliminacionLogServlet?id_usuario=<%=u.getId_usuario()%>">Eliminar</a></td>
            </tr>
            <% }} %>
            </tbody>
        </table>
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
</body>
</html>
