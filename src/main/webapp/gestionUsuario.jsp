
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page import="mx.edu.utez.sice.dao.UsuarioDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/datatables.css">
</head>
<body>
    <h3 style="color: red"><%=(String)request.getSession().getAttribute("mensaje")%></h3>
    <table id="example" class="table table-striped table-hover">
        <thead>
            <tr>
                <th>ID</th>
                <th>CORREO</th>
                <th>ESTADO</th>
                <th>MODIFICAR</th>
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
            <td><%=u.getId()%></td>
            <td><%=u.getNombre()%></td>
            <td><%=u.getCorreo()%></td>
            <td><%=u.isEstado() ? "Habilitado":"Deshabilitado"%></td>
            <td><a href="sign_in?id=<%=u.getId()%>">Actualizar</a></td>
            <td><a href="fisico?id=<%=u.getId()%>">Eliminar</a></td>
            <td><a href="logico?id=<%=u.getId()%>">Eliminar</a></td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <script src="${pageContext.request.contextPath}/JS/jquery-3.7.0.js"></script>
    <script src="${pageContext.request.contextPath}/JS/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/JS/datatables.js"></script>
    <script src="${pageContext.request.contextPath}/JS/dataTables.bootstrap5.js"></script>
    <script src="${pageContext.request.contextPath}/JS/es-MX.json"></script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const table = document.getElementById('example');
            new DataTable(table, {
                language: {
                    url: '${pageContext.request.contextPath}/JS/es-MX.json'
                }
            });
        });
    </script>
    <%
        request.getSession().removeAttribute("mensaje");
    %>
</body>
</html>
