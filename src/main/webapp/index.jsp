<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de Sesión</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/adicionales.css">

</head>
<body>

<div class="container p-3 mb-2 bg-black text-white"> <!-- Contenedor Principal-->

    <div class="row">
        <div class="col">
            <img id="imagen_esq_derecha" style="width: 230px;" class="position-absolute top-0 end-0 mw-25" src="img/colorArriba.png">
        </div>
    </div>


    <div class="row justify-content-center">
        <div class="col-6 align-self-center">

            <div class="container text-white">   <!--contenedor para login-->
                <div class="row align-items-center justify-content-center">
                    <div class="col-10">

                        <form method="post" action="login">      <!--inicio form-->
                            <img src="img/LogoUtez.png" style="width: 300px;" class="rounded mx-auto d-block">

                            <br>
                            <h2>Inicio de Sesión</h2>
                            <br>

                            <div class="mb-3">
                                <label for="correo_electronico" class="form-label">Correo:</label>
                                <input type="email" name="correo_electronico" id="correo_electronico" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label for="contrasena" class="form-label">Contraseña:</label>
                                <input type="password" name="contrasena" id="contrasena" class="form-control" required>
                                <br>
                                <button type="submit" class="btn btn-primary bg-blue-800" value="iniciar sesión">Ingresar</button>
                            </div>

                            <%
                                HttpSession sesion = request.getSession();
                                String mensaje = (String) sesion.getAttribute("mensaje");
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
            <img id="imagen_esq_izq" class="position-absolute bottom-0 start-0 mw-25" style="width: 200px;" src="img/colorAbajo.png">
        </div>
    </div>

</div>


<script src='js/bootstrap.js'></script>
</body>
</html>


