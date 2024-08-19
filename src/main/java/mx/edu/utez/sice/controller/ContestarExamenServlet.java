package mx.edu.utez.sice.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sice.dao.*;
import mx.edu.utez.sice.model.*;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet (name = "ContestarExamenServlet", value = "/ContestarExamenServlet")
public class ContestarExamenServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id_examen = Integer.parseInt(req.getParameter("id_examen"));
        ExamenDao examenDao = new ExamenDao();
        Examen examen = examenDao.getOne(id_examen);
        HttpSession sesion = req.getSession();
        sesion.setAttribute("examenAlumno", examen);
        resp.sendRedirect("JSP/Alumno/contestarExamen.jsp");
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        boolean flag = true;
        HttpSession sesion = req.getSession();

        // Obtener el examen y el usuario desde la sesión
        Examen examen = (Examen) sesion.getAttribute("examenAlumno");
        Usuario usuario = (Usuario) sesion.getAttribute("usuarioIndexAlumno");
        int id_usuario = usuario.getId_usuario();

        // Inicializar DAOs
        PreguntaDao preguntaDao = new PreguntaDao();
        OpcionDao opcionDao = new OpcionDao();
        ExamenDao examenDao = new ExamenDao();
        AplicacionDao aplicacionDao = new AplicacionDao();
        flag = aplicacionDao.insertExamen(examen.getId_examen());
        int id_aplicación = aplicacionDao.getOne(examen.getId_examen());
        // Obtener las preguntas del examen
        ArrayList<Pregunta> listaPreguntas = preguntaDao.getAll(examen.getId_examen());

        // Iterar sobre cada pregunta para procesar las respuestas
        for (Pregunta pregunta : listaPreguntas) {
            String tipoPregunta = pregunta.getId_tipo_pregunta() == 2 ? "cerrada" : "abierta";
            String respuesta = req.getParameter("pregunta_" + pregunta.getId_pregunta());

            if ("cerrada".equals(tipoPregunta)) {
                // Procesar respuesta de pregunta cerrada
                int id_opcion = Integer.parseInt(respuesta);
                PreguntaOpcion preguntaOpcion = new PreguntaOpcion();
                preguntaOpcion.setId_opcion(id_opcion);
                preguntaOpcion.setId_pregunta(pregunta.getId_pregunta());

                // Guardar la respuesta en la base de datos
                flag = flag && aplicacionDao.insertPreguntaCerrada(pregunta.getId_pregunta(), id_opcion, id_aplicación);
            } else {
                // Procesar respuesta de pregunta abierta
                flag = flag && aplicacionDao.insertPreguntaAbierta(pregunta.getId_pregunta(), id_aplicación , respuesta);
            }
        }

        // Redirigir según el resultado de la operación
        if (flag) {
            sesion.setAttribute("mensaje", "Respuestas guardadas exitosamente");
            resp.sendRedirect("JSP/Alumno/resultadoExamen.jsp");
        } else {
            sesion.setAttribute("mensaje", "Ocurrió un error al guardar las respuestas");
            resp.sendRedirect("JSP/Alumno/contestarExamen.jsp");
        }
    }
}
