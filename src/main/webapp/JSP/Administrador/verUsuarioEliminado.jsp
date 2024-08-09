<%@ page import="mx.edu.utez.sice.dao.UsuarioDao" %>
<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page import="java.util.ArrayList" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Usuarios eliminados</title>
    <link rel="stylesheet" type="text/css" href="../../CSS/datatables.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/fondo.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/adicionalesEBM.css">
</head>
<body>
<!--/////////////////////////////////////////// Fondo ///////////////////////////////////////////////////////-->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>


<!--/////////////////////////////////////// Contenido ///////////////////////////////////////////////////////-->
<div class="container-fluid">
    <div class="row">
        <div class="col-12 mt-4">
            <h1 class="blue-utz">Usuarios eliminados:</h1>
            <br>
            <a class="btn btn-primary bg-blue-utz text-white h5" href="indexAdministrador.jsp"> Regresar </a>
            <br>
            <div class="container-sm">
                <% if ((String)request.getSession().getAttribute("mensaje") != null){%><div class="alert alert-primary alert-dismissible fade show" role="alert">
                <strong><%=(String)request.getSession().getAttribute("mensaje")%></strong>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div><%}%>

                <table id="usuarios" class="table table-striped table-hover">
                    <thead class="bg-blue-utz">
                    <tr class="text-white h5">
                        <th>Nombre</th>
                        <th>Apellido</th>
                        <th>Correo</th>
                        <th>Tipo de usuario</th>
                        <th>Fecha registrado</th>
                        <th></th>
                        <th></th>
                    </tr>
                    </thead>

                    <tbody class="bg-green-SICE">
                    <%  // necesitamos acceder a la base de datos y obtener
                        // TODOS los usuarios
                        UsuarioDao dao = new UsuarioDao();
                        ArrayList<Usuario> lista = dao.getAll();
                        for(Usuario u : lista){ if (u.getEstado()==2){//Por cada usuario de la lista "eliminado"%>
                    <tr class="h6">
                        <td><%=u.getNombre_usuario()%></td>
                        <td><%=u.getApellido_usuario()%></td>
                        <td><%=u.getCorreo_electronico()%></td>
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
                        <td><a class="btn btn-primary bg-blue-utz h5 text-white" href="../../VerUsuarioServlet?id_usuario=<%=u.getId_usuario()%>">Ver</a></td>
                        <td><a class="btn btn-primary bg-blue-utz h5 text-white" href="../../RestaurarUsuarioServlet?id_usuario=<%=u.getId_usuario()%>">Restaurar</a></td>
                    </tr>
                    <% }} %>
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

<%
    request.getSession().removeAttribute("mensaje");
%>

</body>
</html>