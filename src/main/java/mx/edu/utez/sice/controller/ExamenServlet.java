package mx.edu.utez.sice.controller;

import com.google.api.client.googleapis.json.GoogleJsonError;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sice.dao.ExamenDao;
import mx.edu.utez.sice.dao.OpcionDao;
import mx.edu.utez.sice.dao.PreguntaDao;
import mx.edu.utez.sice.dao.PreguntaOpcionDao;
import mx.edu.utez.sice.model.*;
import org.apache.poi.sl.draw.geom.GuideIf;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet (name="ExamenServlet", value = "/ExamenServlet")
public class ExamenServlet extends HttpServlet {
    /*protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("crear".equals(action)) {
            // Preparar para la creación de un nuevo examen
            request.setAttribute("modo", "crear");
            request.getRequestDispatcher("JSP/Docente/examen.jsp").forward(request, response);
        } else {
            // Lógica existente para mostrar todos los exámenes
            ExamenDao dao = new ExamenDao();
            List<Examen> examenes = dao.getAll();
            request.setAttribute("examenes", examenes);
            request.setAttribute("modo", "listar");
            request.getRequestDispatcher("JSP/Docente/examen.jsp").forward(request, response);
        }
    }*/

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Examen examen = new Examen();
        examen.setNombre_examen(req.getParameter("nombre_examen"));
        examen.setCantidad_preguntas(Integer.parseInt(req.getParameter("cantidad_preguntas")));
        examen.setEstado(0);
        examen.setDescripcion((req.getParameter("descripcion")));
        examen.setId_usuario((Integer.parseInt(req.getParameter("id_usuario"))));

        HttpSession sesion = req.getSession();
        ExamenDao dao = new ExamenDao();
        dao.insertExamen(examen);
        int id_examen = dao.getOne(examen);

        String[] preguntas = req.getParameterValues("texto_pregunta[]");
        String[] tipos = req.getParameterValues("id_tipo_pregunta[]");
        ArrayList<Integer> examen_tiene_preguntas = new ArrayList<>();

        for (int i = 0; i < preguntas.length; i++) {
            Pregunta pregunta = new Pregunta();
            pregunta.setPregunta(preguntas[i]);
            pregunta.setId_tipo_pregunta(Integer.parseInt(tipos[i]));

            // Guardar la pregunta y manejar las opciones
            PreguntaDao preguntaDao = new PreguntaDao();
            preguntaDao.insertPregunta(pregunta);

            int id_pregunta = preguntaDao.getOne(pregunta);
            examen_tiene_preguntas.add(id_pregunta);

            if (pregunta.getId_tipo_pregunta() == 2) { // Pregunta cerrada
                String[] opciones = req.getParameterValues("opcion_" + (i + 1) + "[]");
                String opcionCorrecta = req.getParameter("opcion_correcta_" + (i + 1));
                ArrayList<Integer> pregunta_opcion= new ArrayList<>();

                for (int j = 0; j < opciones.length; j++) {
                    Opcion opcion = new Opcion();
                    opcion.setOpcion(opciones[j]);

                    OpcionDao opcionDao = new OpcionDao();
                    opcionDao.insertOpcion(opcion);

                    int id_opcion = opcionDao.getOne(opcion);
                    pregunta_opcion.add(id_opcion);

                    PreguntaOpcion preguntaOpcion = new PreguntaOpcion();
                    preguntaOpcion.setId_opcion(id_opcion);
                    preguntaOpcion.setId_pregunta(id_pregunta);
                    preguntaOpcion.setCorrecta(opcionCorrecta.equals(String.valueOf(j + 1)) ? 1 : 0); // Cambiado a int
                    preguntaDao.insertPreguntaOpcion(preguntaOpcion);
                }
                pregunta.setOpciones(pregunta_opcion);
            }

        }
        examen.setPreguntas(examen_tiene_preguntas);
        for (int i = 0; i < examen.getPreguntas().size(); i++) {
            int id_pregunta = examen.getPreguntas().get(i);
            dao.insertExamenPreguntas(id_examen, id_pregunta);
        }
        if (dao.insertExamen(examen)) {
            resp.sendRedirect(req.getContextPath() + "/ExamenServlet?action=listar&message=Examen creado exitosamente");
        } else {
            req.setAttribute("error", "Hubo un problema al crear el examen");
            req.getRequestDispatcher("JSP/Docente/examen.jsp").forward(req, resp);
        }
    }
}