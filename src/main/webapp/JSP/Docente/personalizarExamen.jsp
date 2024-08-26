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
    <title>Detalles del examen</title>
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
                    <ul class="dropdown-menu bg-blue-utz" aria-labelledby="dropdownMenuButton">
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






<!-- Encabezado -->
<div class="container-fluid">
    <!-- Contenido -->
    <div class="row align-items-center mt-3">
        <div class="col bg-white rounded-4 mx-5 p-5">
            <form action="../../ModificarExamenServlet" method="post">
                <hr>
                <input type="text" name="nombre_examen" value="<%=examen.getNombre_examen()%>" placeholder="<%=examen.getNombre_examen()%>" class="form-control text-center text-wrap" style="max-width: 100%; word-break: break-word;">
                <input type="text" name="descripcion" value="<%=examen.getDescripcion()%>" placeholder="<%=examen.getDescripcion()%>" class="form-control text-center text-wrap" style="max-width: 100%; word-break: break-word;">
                <hr>
                <input type="hidden" name="id_examen" value="<%=examen.getId_examen()%>">
                <%
                    PreguntaDao preguntaDao = new PreguntaDao();
                    ArrayList<Pregunta> listaPreguntas = preguntaDao.getAll(examen.getId_examen());
                    int i = 0;
                    for (Pregunta pregunta : listaPreguntas) {
                        i++;
                %>
                <div class="card rounded-4 border-0 mb-4">
                    <div class="card-header bg-blue-utz text-white">
                        <h6>Pregunta <%= i %>: <input class="form-control" type="text" required name="pregunta_<%= pregunta.getId_pregunta() %>" value="<%= pregunta.getPregunta() %>" placeholder="<%= pregunta.getPregunta() %>">
                            <input type="hidden" name="id_pregunta_<%= pregunta.getId_pregunta() %>" value="<%=pregunta.getId_pregunta()%>">
                        </h6>
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
                                <input required class="form-check-input" type="radio" name="pregunta_<%=pregunta.getId_pregunta()%>_correcta" id="opcion_<%= i %>_<%= j %>" value="<%= opcion.getId_opcion() %>" <%if (preguntaOpcion.getCorrecta() == 1){%>checked<%}%>>


                                <input required class="form-check-label form-control" for="opcion_<%= i %>_<%= j %>" type="text" value="<%= opcion.getOpcion() %>" placeholder="<%= opcion.getOpcion() %>" name="opcion_<%= opcion.getId_opcion() %>">
                                <input type="hidden" value="<%=opcion.getId_opcion()%>" name="id_opcion_<%= opcion.getId_opcion() %>">
                            </div>

                            <% } %>
                        </div>
                        <% } else { %>
                        <% } %>
                    </div>
                </div>
                <% } %>

                <div class="text-center">
                    <button type="submit" class="btn btn-primary bg-blue-utz rounded-3 p-2">
                        Guardar cambios
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>


<script src="../../JS/bootstrap.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%} else {response.sendRedirect("../permisoDenegado.jsp");}%>