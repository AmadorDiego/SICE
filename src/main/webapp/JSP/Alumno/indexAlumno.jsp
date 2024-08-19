<%@ page import="mx.edu.utez.sice.model.Usuario" %>
<%@ page import="mx.edu.utez.sice.model.Examen" %>
<%@ page import="mx.edu.utez.sice.dao.ExamenDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.dao.UsuarioDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Bienvenido Alumno</title>
    <link rel='stylesheet' type='text/css' media='screen' href='../../CSS/bootstrap.css'>
    <link rel='stylesheet' type='text/css' media='screen' href='../../CSS/fondo.css'>
    <link rel='stylesheet' type='text/css' media='screen' href='../../CSS/adicionalesEBM.css'>
    <!--///////////////////////////// Iconos ////////////////////////////////////-->
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@30,600,0,0"/>
    <%
        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuarioIndexAlumno");
    %>
</head>
<body>
<!--/////////////////////////////////// Fondo //////////////////////////////////////////-->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>


<!-- //////////////////////////// Navbar /////////////////////////////////-->
<header>
    <nav class="navbar bg-blue-utz">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <a class="navbar-brand text-white">
                <img src="../../IMG/logoBueno.png" width="50" height="45" alt="Logo"
                     class="d-inline-block align-middle mt-0 mb-2">
                <h3 class="ms-2 d-inline-block align-middle">SICE</h3>
            </a>

            <div class="d-flex">
                <a href="indexAlumno.jsp" class="btn btn-primary bg-blue-utz ms-3 text-white border-0">
                    <span class="material-symbols-rounded">Home</span>
                </a>
                <a href="alumnoRelizados.jsp" class="btn btn-primary bg-blue-utz ms-3 text-white border-0">
                    <span class="material-symbols-rounded">task</span>
                </a>
            </div>
        </div>
    </nav>
</header>


<!--////////////////////////// Encabezado ////////////////////////////////////-->
<div class="container-fluid">
    <div class="row align-items-center">
        <div class="col-6 p-4">
            <h1 class="text-white">¡Bienvenido <%=usuario.getNombre_usuario()+" "+usuario.getApellido_usuario()%>!</h1>
        </div>
    </div>


    <hr style="color: white">

    <!--////////////////////////////// Contenido principal(Tarjetas) ////////////////////////////-->
    <div class="row">
        <%
            ExamenDao examenDao = new ExamenDao();
            UsuarioDao usuarioDao = new UsuarioDao();
            ArrayList<Examen> examenes = examenDao.getAll(usuario.getId_usuario());
            for (Examen examen : examenes){%>
        <div class="col-12 col-md-6 p-4">
            <div class="card rounded-5 border-0 bg-blue-utz">
                <div class="card-header bg-blue-utz border-0 rounded-5"><br></div>
                <div class="card-body bg-gray-SICE rounded-bottom border-0">
                    <h3 class="card-title blue-utz"><strong><%=examen.getNombre_examen()%></strong></h3>
                    <h6 class="card-text text-white"><%=examen.getDescripcion()%></h6>
                    <div class="p-4 d-flex flex-row-reverse bd-highlight gap-2">
                        <a href="../../ContestarExamenServlet?id_examen=<%=examen.getId_examen()%>" class="btn bg-blue-utz text-white">Realizar</a>
                        <%Usuario docente = usuarioDao.getDocentePorExamen(examen.getId_examen());%>
                        <strong class="text-white align-content-center"><%=docente.getNombre_usuario()+" "+docente.getApellido_usuario()%></strong>
                    </div>
                </div>
            </div>
        </div>
        <%}
        %>
    </div>
</div>
<script href="../../JS/bootstrap.js"></script>
</body>
</html>
