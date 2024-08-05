
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
<nav class="navbar navbar-dark bg-dark">
    <!-- Navbar content -->
</nav>
    <h1>Bienvenido administrador</h1>
    <a href="registroUsuario.jsp">Registrar usuario</a>
    <h3 style="color: red"><%=(String)request.getSession().getAttribute("mensaje")%></h3>
    <table id="usuarios" class="table table-striped table-hover">
        <thead>
            <tr>
                <th>NOMBRE</th>
                <th>APELLIDO</th>
                <th>CORREO</th>
                <th>ESTADO</th>
                <th>TIPO DE USUARIO</th>
                <th>FECHA REGISTRADO</th>
                <th>VER</th>
                <th>ELIMINAR</th>
            </tr>
        </thead>
        <tbody>

        <%  // necesitamos acceder a la base de datos y obtener
            // TODOS los usuarios
            UsuarioDao dao = new UsuarioDao();
            ArrayList<Usuario> lista = dao.getAll();
            for(Usuario u : lista){//Por cada usuario de la lista %>
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
            <td><a href="../../VerUsuarioServlet?id_usuario=<%=u.getId_usuario()%>">Ver ></a></td>
            <td><a href="../../EliminacionLogServlet?id_usuario=<%=u.getId_usuario()%>">Eliminar</a></td>
        </tr>
        <% } %>
        </tbody>
    </table>
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
    <%
        request.getSession().removeAttribute("mensaje");
    %>
</body>
</html>
