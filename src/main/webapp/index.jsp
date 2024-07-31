<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de Sesión</title>
    <link rel="stylesheet" href="CSS/bootstrap.css">
    <link rel="stylesheet" href="CSS/adicionales.css">

<form method="post" action="login">
    <label>Correo electrónico: </label>
    <input type="email" name="correo_electronico" required>
    <br>
    <label>Contra: </label>
    <input type="password" name="contrasena" required>
    <br>
    <input type="submit" value="iniciar sesión">
    <%
        HttpSession sesion = request.getSession();
        String mensaje = (String) sesion.getAttribute("mensaje");
        if(mensaje != null){ %>
    <p style="color: red"><%=mensaje%></p>
    <% } %>

</form>
<a href="solicitudRecuperacion.jsp">¿Olvisdaste tu contraseña?</a>
<a href="registroUsuario.jsp">Registrarme</a>
<a href="gestionUsuario.jsp">Ver usuarios</a>
<a href="pdf">Generar archivo PDF</a>
</head>
<body class="bg-black">

<div class="container p-3 mb-2 bg-black text-white"> <!-- Contenedor Principal-->

    <div class="row">
        <div class="col">
            <img id="imagen_esq_derecha" style="width: 230px;" class="position-absolute top-0 end-0 mw-25" src="IMG/colorArriba.png">
        </div>
    </div>


    <div class="row justify-content-center">
        <div class="col-6 align-self-center">

            <div class="container text-white">   <!--contenedor para login-->
                <div class="row align-items-center justify-content-center">
                    <div class="col-10">

                        <form method="post" action="login">      <!--inicio form-->
                            <img src="IMG/LogoUtez.png" style="width: 300px;" class="rounded mx-auto d-block">

                            <br>
                            <h2>Inicio de Sesión</h2>
                            <br>

                            <div class="mb-3">
                                <label class="form-label">Correo:</label>
                                <input type="email" name="correo_electronico" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Contraseña:</label>
                                <input type="password" name="contrasena" class="form-control" required>
                                <br>
                                <input type="submit" class="btn btn-primary bg-blue-800" value="iniciar sesión">
                            </div>

                            <%
                                if(mensaje != null){ %>
                            <p style="color: red"><%=mensaje%></p>
                            <% } %>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col">
            <img id="imagen_esq_izq" class="position-absolute bottom-0 start-0 mw-25" style="width: 200px;" src="IMG/colorAbajo.png">
        </div>
    </div>

</div>


<script src='JS/bootstrap.js'></script>
</body>
</html>


