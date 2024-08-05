<%@ page import="mx.edu.utez.sice.model.Usuario" %><%--
  Created by IntelliJ IDEA.
  User: amado
  Date: 04/08/2024
  Time: 06:55 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuario");
        if (usuario == null) {
            response.sendRedirect("index.jsp"); // Redirect if user is not found
            return;
        }
    %>
    <title>Perfil de <%=usuario.getNombre_usuario() %> <%=usuario.getApellido_usuario()%></title>
</head>
<body>

    <input type="hidden" name="id_usuario" value="<%= usuario.getId_usuario() %>">
    <label>Ingrese su nombre: </label>
    <input type="text" disabled name="nombre_usuario" value="<%= usuario.getNombre_usuario()%>" placeholder="<%= usuario.getNombre_usuario()%>">
    <br>
    <label>Ingrese su apellido: </label>
    <input type="text" disabled name="apellido_usuario" value="<%= usuario.getApellido_usuario()%>" placeholder="<%= usuario.getApellido_usuario()%>">
    <br>
    <label>Ingrese su correo electrónico: </label>
    <input type="email" disabled name="correo_electronico" value="<%= usuario.getCorreo_electronico()%>" placeholder="<%= usuario.getCorreo_electronico()%>">
    <br>
    <label>Ingrese su contraseña: </label>
    <input type="password" disabled name="contrasena1">
    <br>
    <label>Reingrese su contraseña: </label>
    <input type="password" disabled name="contrasena2">
    <br>
    <div class="form-check form-switch">
        <input class="form-check-input" type="checkbox" disabled role="switch" name="estado" id="estado" <% if(usuario.getEstado()==1){%>checked<%}%>>
        <label class="form-check-label" for="estado">Estado</label>
    </div>
    <label>Seleccione el tipo de usuario: </label>
    <select name="id_tipo_usuario" disabled>
        <option value="1" <% if(usuario.getId_tipo_usuario()==1){%>selected<%}%>>Administrador</option>
        <option value="2" <% if(usuario.getId_tipo_usuario()==2){%>selected<%}%>>Docente</option>
        <option value="3" <% if(usuario.getId_tipo_usuario()==3){%>selected<%}%>>Alumno</option>
        <option value="4" <% if(usuario.getId_tipo_usuario()==4){%>selected<%}%>>Docente administrador</option>
    </select>
    <br>
    <label>Fecha registrado: </label>
    <input type="date" disabled value="<%= usuario.getFecha_registrado()%>">
    <a href="../../ActualizarUsuarioServlet?id_usuario=<%= usuario.getId_usuario()%>">Actualizar ></a>
</body>
</html>
