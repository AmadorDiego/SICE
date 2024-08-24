<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.dao.PreguntaDao" %>
<%@ page import="mx.edu.utez.sice.model.*" %>
<%@ page import="mx.edu.utez.sice.dao.OpcionDao" %>
<%--
  Created by IntelliJ IDEA.
  User: corey
  Date: 30/07/2024
  Time: 11:34 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.dao.PreguntaDao" %>
<%@ page import="mx.edu.utez.sice.model.*" %>
<%@ page import="mx.edu.utez.sice.dao.OpcionDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.logging.Level" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>Crear Examen</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/fondo.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/adicionalesEBM.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Docentes.css">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@30,600,0,0"/>
    <style>
        #banco-preguntas {
            height: 100vh;
            overflow-y: auto;
        }

        #lista-banco-preguntas li {
            margin-bottom: 10px;
        }

        #lista-banco-preguntas input[type="checkbox"] {
            margin-right: 10px;
        }
    </style>
    <%
        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuarioIndexDocente");
    %>

    <script>
        var contextPath = '${pageContext.request.contextPath}';
        var bancoPreguntas = [];  // Inicializa bancoPreguntas como un array vacío
    </script>
</head>
<body>
<!-- NavBar -->
<header>
    <nav class="navbar bg-blue-utz">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <a class="navbar-brand text-white">
                <img src="../../IMG/logoBueno.png" width="50" height="45" alt="Logo"
                     class="d-inline-block align-middle mt-0 mb-2">
                <h3 class="ms-2 d-inline-block align-middle">SICE</h3>
            </a>
            <div class="d-flex">
                <a href="PieroCalificarExamen.jsp" class="btn btn-primary bg-blue-utz ms-3 text-white border-0 d-flex align-items-center">
                    <span class="material-symbols-rounded">pending_actions</span>
                    <h6 class="mb-0 ms-2">Calificar examenes</h6>
                </a>
                <a href="indexDocente.jsp" class="btn btn-primary bg-blue-utz ms-3 text-white border-0 d-flex align-items-center">
                    <span class="material-symbols-rounded">home</span>
                    <h6 class="mb-0 ms-2">Inicio</h6>
                </a>
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

<!-- Fondo -->
<div class="bg"></div>
<div class="bg bg2"></div>
<div class="bg bg3"></div>

<!-- Contenido -->
<div class="container md">
    <div class="row">
        <div class="col-12">
            <a class="btn btn-primary bg-blue-utz text-white h5 g-2 mt-4 h6" href="indexDocente.jsp">
                <span class="material-symbols-rounded">arrow_back</span>
            </a>
        </div>

        <!-- Banco de preguntas -->
        <div class="col-md-3">
            <div id="banco-preguntas" class="bg-light p-3 rounded">
                <h3>Banco de Preguntas</h3>
                <input type="text" id="buscar-banco" class="form-control mb-3" placeholder="Buscar pregunta...">
                <ul id="lista-banco-preguntas" class="list-unstyled">
                    <%
                        Logger logger = Logger.getLogger("examen.jsp");
                        int i = 0;
                        try {
                            PreguntaDao bancoPreguntaDao = new PreguntaDao();
                            ArrayList<Pregunta> todasLasPreguntas = bancoPreguntaDao.getAll();
                            for (Pregunta pregunta : todasLasPreguntas) {
                                i++;
                    %>
                    <li data-id-pregunta="<%=pregunta.getId_pregunta()%>" data-tipo-pregunta="<%=pregunta.getId_tipo_pregunta()%>">
                        <input type="checkbox" name="preguntasSeleccionadas" value="<%=pregunta.getId_pregunta()%>"
                               id="pregunta-<%=pregunta.getId_pregunta()%>" onchange="togglePregunta(<%=pregunta.getId_pregunta()%>)">
                        <label for="pregunta-<%=pregunta.getId_pregunta()%>">
                            Pregunta <%=i%>: <%=pregunta.getPregunta()%>
                        </label>
                    </li>
                    <%
                        }
                    } catch (Exception e) {
                        logger.log(Level.SEVERE, "Error al cargar las preguntas", e);
                    %>
                    <p>Error al cargar las preguntas: <%=e.getMessage()%></p>
                    <%
                        }
                    %>
                </ul>
            </div>
        </div>

        <div class="col-md-9">
            <div class="rounded-5 p-3 bg-green-utz g-3">
                <h1 class="mb-4 blue-utz">Crear Nuevo Examen</h1>
                <br>
                <form method="post" action="../../ExamenServlet" class="mb-4">
                    <div id="mensajeResultado" class="alert" style="display: none;"></div>

                    <input type="hidden" id="id_usuario" name="id_usuario" value="<%=usuario
                .
                getId_usuario
                (
                )%>">
                    <input type="hidden" id="cantidad_preguntas" name="cantidad_preguntas" value="0">

                    <div class="mb-3">
                        <label class="form-label text-white h5" for="nombre_examen">Nombre del Examen:</label>
                        <input class="form-control" type="text" id="nombre_examen" name="nombre_examen" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-white h5" for="descripcion">Descripción:</label>
                        <textarea class="form-control fixed-size-textarea" id="descripcion" name="descripcion" rows="4" style="resize: none;"></textarea>
                    </div>

                    <div id="id_preguntas" class="mb-3 mt-4">
                        <!--Aqui se van agregando las preguntas que se vayan creando-->
                    </div>

                    <div class="mt-5">
                        <button type="button" class="btn btn-primary blue-utz me-2 text-white"
                                onclick="agregarPregunta('cerrada')">Pregunta cerrada</button>
                        <button type="button" class="btn btn-secondary gray-SICE text-white"
                                onclick="agregarPregunta('abierta')">Pregunta abierta</button>
                    </div>
                    <button class="btn btn-primary bg-blue-utz mt-3 d-flex" type="submit" value="Crear">
                        <h6 class="d-block me-2">Crear </h6>
                        <span class="material-symbols-rounded d-block">check_circle</span>
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<!--<script src="ruta/a/tu/ScriptExamen.js"></script>-->

<script src="${pageContext.request.contextPath}/JS/jquery-3.7.0.js"></script>
<script src="${pageContext.request.contextPath}/JS/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/JS/ScriptExamen.js"></script>

</body>
</html>

