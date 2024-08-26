<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.dao.PreguntaDao" %>
<%@ page import="mx.edu.utez.sice.dao.OpcionDao" %>
<%@ page import="mx.edu.utez.sice.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Personalizar Examen</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel="stylesheet" href="../../CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/fondo.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/adicionalesEBM.css">
    <!--///////////////////////////// Iconos ////////////////////////////////////-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@30,600,0,0"/>
    <style>
        .btn-primary {
            background-color: #003e81;
        }
    </style>
</head>
<body>
<%
    HttpSession sesion = request.getSession();
    Usuario usuario = (Usuario) sesion.getAttribute("usuarioIndexDocente");
    if (usuario != null){
    Examen examen = (Examen) sesion.getAttribute("examen");
%>
<!--//////////////////////////////////////// Fondo ///////////////////////////////////////////////////-->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>


<!-- //////////////////////////////////////////NavBar//////////////////////////////////////////////////////  -->
<header>
    <nav class="navbar bg-blue-utz">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <a class="navbar-brand text-white">
                <img src="../../IMG/logoBueno.png" width="50" height="45" alt="Logo"
                     class="d-inline-block align-middle mt-0 mb-2">
                <h3 class="ms-2 d-inline-block align-middle">SICE</h3>
            </a>
            <div class="d-flex">
                <a href="/////////////////////////////////////////////" class="btn btn-primary bg-blue-utz ms-3 text-white border-0 d-flex align-items-center">
                    <span class="material-symbols-rounded">pending_actions</span>
                    <h6 class="mb-0 ms-2">Calificar examenes</h6>
                </a>
                <a href="indexDocente.jsp" class="btn btn-primary bg-blue-utz ms-3 text-white border-0 d-flex align-items-center">
                    <span class="material-symbols-rounded">home</span>
                    <h6 class="mb-0 ms-2">Inicio</h6>
                </a>

                <!------------- Boton dezplegable ---------------->
                <div class="dropdown dropstart">
                    <button class="btn btn-primary bg-blue-utz ms-3 text-white border-0" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                        <span class="material-symbols-rounded">arrow_drop_down</span>
                    </button>
                    <ul class="dropdown-menu bg-green-utz-claro" aria-labelledby="dropdownMenuButton">
                        <li class="p-2">
                            <a class="btn btn-success bg-green-utz d-flex align-items-center">
                                <span class="material-symbols-rounded">person</span>
                                <h6 class="mb-0 ms-2">Perfil</h6>
                            </a>
                        </li>
                        <li class="p-2">
                            <a class="btn btn-danger bg-red-SICE d-flex align-items-center">
                                <span class="material-symbols-rounded">logout</span>
                                <h6 class="mb-0 ms-2">Cerrar Sesion</h6>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
</header>

<!--////////////////////////////////////// Contenido //////////////////////////////////////////////////-->
<div class="container my-2 my-md-4">
    <h1 class="text-start mb-2 mb-md-3 blue-utz">Modificar Examen</h1>
    <h3 class="text-start mb-2 mb-md-3 green-SICE-obscuro"><%=examen.getNombre_examen()%></h3>

    <div class="d-flex flex-wrap justify-content-start gap-2 mb-3">
        <!--
        <div class="d-flex flex-column flex-md-row align-items-start align-items-md-center gap-2 mb-3">
            <span class="me-2">Eliminar Examen</span>
            <button class="btn btn-primary btn-sm btn-md-lg">Eliminar</button>
        </div>
        -->
    </div>
    <div class="container-md">
        <div class="row">
            <div class="col-12">
                <form class="form-control rounded-5 p-3 mt-4 mb-4 border-0 bg-green-utz" method="post" action="../../ModificarExamenServlet">
                    <h1 class="blue-utz">Modificar Examen</h1>
                    <br>
                    <label class="form-label text-white h5">Título del examen: </label>
                    <input class="form-control mb-2" type="text" name="nombre_examen" required value="<%=examen.getNombre_examen()%>" placeholder="<%=examen.getNombre_examen()%>">

                    <label class="form-label text-white h5">Descripción: </label>
                    <input class="form-control mb-4" type="text" name="descripcion" required value="<%=examen.getDescripcion()%>" placeholder="<%=examen.getDescripcion()%>">
                    <%
                        PreguntaDao preguntaDao = new PreguntaDao();
                        ArrayList<Pregunta> listaPreguntas = preguntaDao.getAll(examen.getId_examen());
                        int i = 0;
                        for (Pregunta pregunta : listaPreguntas) {
                            i++; %>
                    <div>
                        <label class="form-label text-white h5">Pregunta <%=i%>:  </label>
                        <input class="form-control" type="text" name="pregunta_<%=i%>" required value="<%=pregunta.getPregunta()%>" placeholder="<%=pregunta.getPregunta()%>">
                    </div>
                    <%
                        if (pregunta.getId_tipo_pregunta()==2){
                            OpcionDao opcionDao = new OpcionDao();
                            ArrayList<Opcion> listaOpciones = opcionDao.getAll(pregunta.getId_pregunta());
                            int j = 0;
                            for (Opcion opcion : listaOpciones) {
                                PreguntaOpcion preguntaOpcion = opcionDao.getOpcionCorrecta(opcion.getId_opcion());
                                j++; %>
                    <div class="mb-2 mt-3 d-flex px-3">
                        <input class="d-flex form-check-input me-2 align-self-center" type="radio" name="pregunta_<%=i%>_opcion_<%=j%>_correcta_<%=preguntaOpcion.getCorrecta()%>" value="" <%if (preguntaOpcion.getCorrecta()==1){%>checked<%}%> >
                        <input class="d-flex form-control align-self-center" type="text" name="pregunta_<%=i%>_opcion_<%=j%>" required value="<%=opcion.getOpcion()%>" placeholder="<%=opcion.getOpcion()%>">
                    </div>
                    <%}
                    }
                    }
                    %>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="../../JS/bootstrap.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%} else {response.sendRedirect("../permisoDenegado.jsp");}%>