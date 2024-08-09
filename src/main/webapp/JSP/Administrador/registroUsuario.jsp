<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page import="mx.edu.utez.sice.dao.CarreraDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.model.Carrera" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registrar nuevo usuario</title>
    <link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/adicionalesEBM.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/fondo.css">
</head>
<body>
<%
    HttpSession sesion = request.getSession();
    Usuario usuario = (Usuario) sesion.getAttribute("usuario");
%>

<!--/////////////////////////////////////////////// Fondo /////////////////////////////////////////////////////////////-->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>


<!--///////////////////////////////////////////// NavBar //////////////////////////////////////////////////////-->
<header>
    <div class="collapse" id="navbarToggleExternalContent">
        <div class="bg-blue-utz p-2">
            <h2 class="text-white p-2 ms-2">SICE</h2>
            <div class="d-flex flex-column ms-2">
                <a href="indexAdministrador.jsp" class="btn w-25 text-white btn-brillo-efecto bg-blue-utz"><h6>Inicio
                </h6></a>
                <a href="verUsuarioEliminado.jsp" class="btn w-25 text-white btn-brillo-efecto bg-blue-utz"><h6>Usuarios
                    Eliminados</h6></a>
            </div>
        </div>
    </div>
    <nav class="navbar bg-blue-utz">
        <div class="container-fluid">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
    </nav>
</header>

<!--//////////////////////////////////////////// Contenido ////////////////////////////////////////////////////////////-->
<div class="container ">
    <form class="form-control bg-green-utz p-3 mt-5 rounded-4 border-0 bg-opacity-75" method="post"
          action="../../RegistrarUsuarioServlet">
        <div class="row">
            <div class="col-12">
                <h1 class="blue-utz">Registrar nuevo usuario</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 col-12 p-3">
                <label class="form-label text-white h6">Ingrese su nombre: </label>
                <input required class="form-control" type="text" name="nombre_usuario" value="">
                <br>
                <label class="form-label text-white h6">Ingrese su apellido: </label>
                <input required class="form-control" type="text" name="apellido_usuario" value="">
                <br>
                <label class="form-label text-white h6">Ingrese su correo electrónico: </label>
                <input required class="form-control" type="email" name="correo_electronico" value="">
            </div>

            <div class="col-md-6 col-12 p-3">
                <label class="form-label text-white h6">Ingrese su contraseña: </label>
                <input required class="form-control" type="password" name="contrasena1">
                <br>
                <label class="form-label text-white h6">Reingrese su contraseña: </label>
                <input required class="form-control" type="password" name="contrasena2">
                <br>
                <label class="form-label text-white h6">Ingrese el tipo de usuario: </label>
                <select required class="form-control" name="id_tipo_usuario" id="id_tipo_usuario">
                    <option value="4">Docente administrador</option>
                    <option value="1">Administrador</option>
                    <option value="2">Docente</option>
                    <option value="3">Alumno</option>
                </select>
                <!-- Este es el campo select adicional que solo aparecerá si se selecciona "Alumno" -->
                <div class="row" id="campoAdicional" style="display:none;">
                    <div class="col-md-6 col-12 p-3">
                        <label class="form-label text-white h6">Seleccione la carrera: </label>
                        <select required class="form-control" name="id_carrera">
                            <%
                                CarreraDao dao = new CarreraDao();
                                ArrayList<Carrera> lista = dao.getAll();
                                for (Carrera carrera : lista) {
                            %>
                            <option value="<%= carrera.getId_carrera() %>"><%= carrera.getCarrera() %></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-3">
                <br>
                <input type="submit" class="btn btn-primary bg-blue-utz">
            </div>
        </div>
    </form>
</div>
<script>
    // Escuchar el cambio en el select de tipo de usuario
    document.getElementById('id_tipo_usuario').addEventListener('change', function () {
        // Obtener el valor seleccionado
        var tipoUsuario = this.value;

        // Mostrar o esconder el campo adicional basado en la selección
        if (tipoUsuario == '3') { // "Alumno" tiene el valor "3"
            document.getElementById('campoAdicional').style.display = 'block';
        } else {
            document.getElementById('campoAdicional').style.display = 'none';
        }
    });
</script>

</body>
</html>