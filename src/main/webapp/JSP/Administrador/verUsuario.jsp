<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuario");
        if (usuario == null) {
            response.sendRedirect("loginSICE.jsp"); // Redirect if user is not found
            return;
        }
    %>
    <title>Perfil de <%=usuario.getNombre_usuario() %> <%=usuario.getApellido_usuario()%></title>
    <link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/fondo.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/adicionalesEBM.css">
</head>
<body>

<!--//////////////////////////////////////////////// Fondo //////////////////////////////////////////////////////////////-->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>


<!--////////////////////////////////////////// Contenido principal //////////////////////////////////////////////////////-->
<div class="container-sm">
    <div class="row">
        <div class="col-12">
            <div class="bg-green-utz rounded-5 p-4 mt-4">
                <h1 class="h1 blue-utz">Perfil de <%=usuario.getNombre_usuario() %> <%=usuario.getApellido_usuario()%></h1>
                <br>
                <input class="text-center"  type="hidden" name="id_usuario" value="<%= usuario.getId_usuario() %>">
                <label class="form-label text-white h5">Nombre(s): </label>
                <input class="form-control" type="text" disabled name="nombre_usuario" value="<%= usuario.getNombre_usuario()%>" placeholder="<%= usuario.getNombre_usuario()%>">
                <br>
                <label class="form-label text-white h5">Apellido(s): </label>
                <input class="form-control" type="text" disabled name="apellido_usuario" value="<%= usuario.getApellido_usuario()%>" placeholder="<%= usuario.getApellido_usuario()%>">
                <br>
                <label class="form-label text-white h5">Correo electrónico: </label>
                <input class="form-control" type="email" disabled name="correo_electronico" value="<%= usuario.getCorreo_electronico()%>" placeholder="<%= usuario.getCorreo_electronico()%>">
                <br>
                <div class="form-check form-switch">
                    <input class="form-check-input" type="checkbox" disabled role="switch" name="estado" id="estado" <% if(usuario.getEstado()==1){%>checked<%}%>>
                    <label class="form-check-label text-white h5" for="estado">Estado: <% if(usuario.getEstado() == 1){%>Habilitado<%}else if (usuario.getEstado() == 0){%>Deshabilitado<%} else{%>Eliminado<%}%> </label>
                    <br>
                </div>
                <br>
                <label class="form-label text-white h5">Tipo de usuario: </label>
                <input class="form-control" type="text" disabled value="<% switch(usuario.getId_tipo_usuario()){case 1:%><%="Administrador"%><%break;case 2:%><%="Docente"%><%break;case 3:%><%="Alumno"%><%break;case 4:%><%="Docente administrador"%><%break;
                }%>">
                <br>
                <label class="form-label text-white h5">Fecha registrado: </label>
                <input class="form-control" type="text" disabled value="<%= usuario.getFecha_registrado()%>">
                <br>
                <a class="btn btn-primary bg-blue-utz" href="../../ActualizarUsuarioServlet?id_usuario=<%= usuario.getId_usuario()%>">Actualizar ></a>
        </div>
    </div>
</div>
</body>
</html>
