

<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.dao.PreguntaDao" %>
<%@ page import="mx.edu.utez.sice.dao.OpcionDao" %>
<%@ page import="mx.edu.utez.sice.model.Examen" %>
<%@ page import="mx.edu.utez.sice.model.Pregunta" %>
<%@ page import="mx.edu.utez.sice.model.Opcion" %>
<%@ page import="mx.edu.utez.sice.model.PreguntaOpcion" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Personalizar Examen</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel="stylesheet" href="../../CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/fondo.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/adicionalesEBM.css">
    <style>
        body {
            background-color: #f0f0f0;
        }
        .navbar {
            background-color: #002E60 !important;
        }
        .navbar-light .navbar-nav .nav-link {
            color: white !important;
        }
        .navbar-light .navbar-toggler-icon {
            background-image: url("/img/menu.png") !important; /* Cambiado a la imagen local */
            background-size: cover;
        }
        .btn-primary {
            background-color: #00604C !important;
            border-color: #00604C !important;
        }
        .btn-success {
            background-color: #00604C !important;
            border-color: #00604C !important;
        }
        .thead {
            background-color: #002E60;
            color: white;
        }

        .full-width-navbar {
            margin: 0;
            padding: 0;
            width: 100%;
        }
    </style>


</head>
<body>
<%
    HttpSession sesion = request.getSession();
    Examen examen = (Examen) sesion.getAttribute("examen");
%>
<!--//////////////////////////////////////// Fondo ///////////////////////////////////////////////////-->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>

<!--////////////////////////////////////// Contenido //////////////////////////////////////////////////-->

<div class="full-width-navbar">
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="#"></a>
        </div>
    </nav>
</div>

<div class="container my-2 my-md-4">
    <h1 class="text-start mb-2 mb-md-3">Modificar Examen</h1>
    <h3 class="text-start mb-3 mb-md-4"><%=examen.getNombre_examen()%></h3>

    <div class="d-flex flex-wrap justify-content-start gap-2 mb-3">
        <!--
        <div class="d-flex flex-column flex-md-row align-items-start align-items-md-center gap-2 mb-3">
            <span class="me-2">Eliminar Examen</span>
            <button class="btn btn-primary btn-sm btn-md-lg">Eliminar</button>
        </div>
        -->

        <div class="d-flex flex-column flex-md-row align-items-start align-items-md-center gap-2 mb-3">
            <a href="../Docente/indexDocente.jsp" class="btn btn-primary btn-sm d-inline-flex align-items-center">
                <img src="../../IMG/home.png" alt="Home" class="me-2" style="width: 20px; height: 20px;">
            </a>
        </div>
    </div>
<<<<<<< HEAD

=======
>>>>>>> 7e8392b955b30464f6deb24fa59a4a8a44465899
    <div class="container-md">
        <div class="row">
            <div class="col-12">
                <form class="form-control rounded-5 p-3 mt-4 border-0 bg-green-utz" method="post" action="../../ModificarExamenServlet">
                    <h1 class="blue-utz">Modificar Examen</h1>
                    <br>
                    <label class="form-label text-white h5">Título del examen: </label>
                    <input class="form-control" type="text" name="nombre_examen" required value="<%=examen.getNombre_examen()%>" placeholder="<%=examen.getNombre_examen()%>">
                    <br>
                    <label class="form-label text-white h5">Descripción: </label>
                    <input class="form-control" type="text" name="descripcion" required value="<%=examen.getDescripcion()%>" placeholder="<%=examen.getDescripcion()%>">
                    <br>
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
                    <div class="mb-2">
                        <input type="radio" name="pregunta_<%=i%>_opcion_<%=j%>_correcta_<%=preguntaOpcion.getCorrecta()%>" value="" <%if (preguntaOpcion.getCorrecta()==1){%>checked<%}%> >
                        <input class="form-control" type="text" name="pregunta_<%=i%>_opcion_<%=j%>" required value="<%=opcion.getOpcion()%>" placeholder="<%=opcion.getOpcion()%>">
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>