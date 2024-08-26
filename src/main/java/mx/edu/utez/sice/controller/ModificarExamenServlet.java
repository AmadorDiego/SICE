package mx.edu.utez.sice.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sice.dao.ExamenDao;
import mx.edu.utez.sice.dao.OpcionDao;
import mx.edu.utez.sice.dao.PreguntaDao;
import mx.edu.utez.sice.model.Examen;
import mx.edu.utez.sice.model.Opcion;
import mx.edu.utez.sice.model.Pregunta;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "ModificarExamenServlet", value = "/ModificarExamenServlet")
public class ModificarExamenServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // obtenemos el id del usuario, recabado por parte del link "actualizar" que está dentro de la tabla de
        // la vista indexAdministrador.jsp
        int id_examen = Integer.parseInt(req.getParameter("id_examen"));
        // el id identifica al usuario y necesitamos un método Para obtener su información (DAO)
        ExamenDao examenDao = new ExamenDao();
        Examen examen = examenDao.getOne(id_examen);
        PreguntaDao preguntaDao = new PreguntaDao();
        ArrayList<Pregunta> listaPreguntas = preguntaDao.getAll(examen.getId_examen());
        OpcionDao opcionDao = new OpcionDao();
        ArrayList<Opcion> listaOpciones = opcionDao.getAll(examen.getId_examen());

        HttpSession sesion = req.getSession();
        sesion.setAttribute("examen", examen);
        sesion.setAttribute("preguntas", listaPreguntas);
        sesion.setAttribute("opciones", listaOpciones);

        // aqui vamos a actualizar los datos del usuario anteriormente seleccionado
        resp.sendRedirect("JSP/Docente/personalizarExamen.jsp");
        // proseguimos con un update
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Obtener los parámetros del formulario
        String nombreExamen = req.getParameter("nombre_examen");
        String descripcion = req.getParameter("descripcion");
        int idExamen = Integer.parseInt(req.getParameter("id_examen"));

        // Actualizar los detalles del examen
        ExamenDao examenDao = new ExamenDao();
        boolean examenActualizado = examenDao.updateExamen(idExamen, nombreExamen, descripcion);

        if (examenActualizado) {
            // Obtener todas las preguntas del examen
            PreguntaDao preguntaDao = new PreguntaDao();
            ArrayList<Pregunta> listaPreguntas = preguntaDao.getAll(idExamen);

            for (Pregunta pregunta : listaPreguntas) {
                // Obtener los parámetros de cada pregunta del formulario
                String textoPregunta = req.getParameter("pregunta_" + pregunta.getId_pregunta());
                int idPregunta = pregunta.getId_pregunta();

                // Actualizar la pregunta en la base de datos
                preguntaDao.updatePregunta(idPregunta, textoPregunta);

                if (pregunta.getId_tipo_pregunta() == 2) { // Pregunta con opciones
                    // Obtener todas las opciones de la pregunta
                    OpcionDao opcionDao = new OpcionDao();
                    ArrayList<Opcion> listaOpciones = opcionDao.getAll(idPregunta);

                    // Obtener el ID de la opción correcta seleccionada
                    String opcionCorrectaParam = req.getParameter("pregunta_" + idPregunta + "_correcta");
                    int idOpcionCorrecta = opcionCorrectaParam != null ? Integer.parseInt(opcionCorrectaParam) : -1;

                    // Actualizar el estado de cada opción
                    for (Opcion opcion : listaOpciones) {
                        int idOpcion = opcion.getId_opcion();
                        String textoOpcion = req.getParameter("opcion_" + idOpcion);

                        // Comprobar si esta opción es la correcta
                        int correcta = (idOpcion == idOpcionCorrecta) ? 1 : 0;

                        // Actualizar la opción en la base de datos
                        opcionDao.updateOpcion(idOpcion, textoOpcion);
                        opcionDao.updateOpcionCorrecta(idOpcion, correcta);
                    }
                }
            }

            // Redireccionar a la página de éxito o mostrar un mensaje de éxito
            req.setAttribute("mensajeDocente", "Se actualizó el examen");
            req.setAttribute("flag", true); // Cambia la redirección según tu flujo de trabajo
        } else {
            // Manejar el caso de fallo al actualizar el examen
            req.setAttribute("mensajeDocente", "No se pudo actualizar el examen.");
            req.setAttribute("flag", false);
        }
        resp.sendRedirect("JSP/Docente/indexDocente.jsp");
    }


}
