<%@ page import="mx.edu.utez.sice.dao.PreguntaDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mx.edu.utez.sice.dao.OpcionDao" %>
<%@ page import="mx.edu.utez.sice.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        HttpSession sesion = request.getSession();
        Examen examen = (Examen) sesion.getAttribute("examenAlumno");
        Usuario usuario = (Usuario) sesion.getAttribute("usuarioIndexAlumno");
        if (usuario != null){
    %>
    <title><%= examen.getNombre_examen() %></title>
    <link rel="stylesheet" type="text/css" href="../../CSS/datatables.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/adicionalesEBM.css">
    <link rel="stylesheet" type="text/css" href="../../CSS/fondo.css">
    <!-- Iconos -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@30,600,0,0"/>
    <style>
        .btn-primary {
            background-color: #003e81;
        }
    </style>
</head>

<body>
<!-- NavBar -->
<header>
    <nav class="navbar bg-blue-utz">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <a class="navbar-brand text-white">
                <img src="../../IMG/logoBueno.png" width="50" height="45" alt="Logo"
                     class="d-inline-block align-middle mt-0 mb-2">
                <h3 class="ms-2 d-inline-block align-middle"><strong>Bienvenido <%=usuario.getNombre_usuario() + " " + usuario.getApellido_usuario()%></strong>
                </h3>
            </a>
            <div class="d-flex">
                <a href="alumnoRelizados.jsp"
                   class="btn btn-primary bg-blue-SICE-claro ms-3 text-white border-0 d-flex align-items-center">
                    <span class="material-symbols-rounded">task</span>
                    <h6 class="mb-0 ms-2">Examenes Realizados</h6>
                </a>
                <a href="indexAlumno.jsp"
                   class="btn btn-primary bg-blue-utz ms-3 text-white border-0 d-flex align-items-center">
                    <span class="material-symbols-rounded">home</span>
                    <h6 class="mb-0 ms-2">Inicio</h6>
                </a>

                <!------------- Boton dezplegable ---------------->
                <div class="dropdown dropstart">
                    <button class="btn btn-primary bg-blue-utz ms-3 text-white border-0" type="button"
                            id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                        <span class="material-symbols-rounded">arrow_drop_down</span>
                    </button>
                    <ul class="dropdown-menu bg-blue-utz" aria-labelledby="dropdownMenuButton">
                        <li class="p-2">
                            <a href="perfilAlumno.jsp" class="btn btn-success bg-green-utz d-flex align-items-center">
                                <span class="material-symbols-rounded">person</span>
                                <h6 class="mb-0 ms-2">Perfil</h6>
                            </a>
                        </li>
                        <li class="p-2">
                            <a href="../../CerrarSesionServlet" class="btn btn-danger bg-red-SICE d-flex align-items-center">
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

<!-- Encabezado -->
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <hr>
            <h3 class="text-center"><strong><%=examen.getNombre_examen()%></strong></h3>
            <h6 class="text-center"><%=examen.getDescripcion()%></h6>
            <hr>
        </div>
    </div>

    <!-- Contenido -->
    <div class="row align-items-center mt-3">
        <div class="col bg-white rounded-4 mx-5 p-5">
            <form action="../../ContestarExamenServlet" method="post">
                <%
                    PreguntaDao preguntaDao = new PreguntaDao();
                    ArrayList<Pregunta> listaPreguntas = preguntaDao.getAll(examen.getId_examen());
                    int i = 0;
                    for (Pregunta pregunta : listaPreguntas) {
                        i++;
                %>
                <div class="card rounded-4 border-0 mb-4">
                    <div class="card-header bg-blue-utz text-white">
                        <h6>Pregunta <%= i %>: <%= pregunta.getPregunta() %></h6>
                    </div>
                    <div class="card-body shadow-lg bg-light rounded-bottom border-0 p-4">
                        <% if (pregunta.getId_tipo_pregunta() == 2) { %>
                        <div class="mb-3">
                            <%
                                OpcionDao opcionDao = new OpcionDao();
                                ArrayList<Opcion> listaOpciones = opcionDao.getAll(pregunta.getId_pregunta());
                                int j = 0;
                                for (Opcion opcion : listaOpciones) {
                                    PreguntaOpcion preguntaOpcion = opcionDao.getOpcionCorrecta(opcion.getId_opcion());
                                    j++;
                            %>
                            <div class="form-check">
                                <input required class="form-check-input" type="radio" name="pregunta_<%=pregunta.getId_pregunta()%>" id="opcion_<%= i %>_<%= j %>" value="<%= opcion.getId_opcion() %>">
                                <label class="form-check-label" for="opcion_<%= i %>_<%= j %>">
                                    <%= opcion.getOpcion() %>
                                </label>
                            </div>
                            <% } %>
                        </div>
                        <% } else { %>
                        <div class="mb-3">
                            <label for="preguntaAbierta_<%= i %>">Ingresa una respuesta:</label>
                            <input type="text" class="form-control rounded-3" id="preguntaAbierta_<%= i %>" name="pregunta_<%=pregunta.getId_pregunta()%>" required>
                        </div>
                        <% } %>
                    </div>
                </div>
                <% } %>

                <div class="text-center">
                    <button type="submit" class="btn btn-success rounded-3 p-2">
                        Enviar Respuestas
                    </button>
                </div>
            </form>

        </div>
    </div>
</div>

<script src="../../JS/bootstrap.js"></script>
</body>
</html>
<%} else {response.sendRedirect("../permisoDenegado.jsp");}%>
