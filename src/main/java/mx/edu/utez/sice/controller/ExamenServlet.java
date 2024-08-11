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
import mx.edu.utez.sice.model.Examen;
import mx.edu.utez.sice.model.Opcion;
import mx.edu.utez.sice.model.Pregunta;
import mx.edu.utez.sice.model.PreguntaOpcion;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

@WebServlet (name="CrearExamenServlet", value = "/CrearExamenServlet")
public class ExamenServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nombre_examen = req.getParameter("nombre_examen");
        int cantidad_preguntas = Integer.parseInt(req.getParameter("cantidad_preguntas"));
        String descripcion = req.getParameter("descripcion");
        int id_usuario = Integer.parseInt(req.getParameter("id_usuario"));

        Examen examen  = new Examen(0,nombre_examen,cantidad_preguntas,1,descripcion,id_usuario, new ArrayList<>());
        for (int i = 1; i <= cantidad_preguntas; i++) {
            String preguntaTexto = req.getParameter("pregunta_" + i);
            int tipoPregunta = Integer.parseInt(req.getParameter("tipo_pregunta"+i));

            Pregunta pregunta = new Pregunta(0, preguntaTexto, tipoPregunta);

            if (tipoPregunta == 1) { // Pregunta de opción múltiple
                for (int j = 1; j <= 4; j++) {
                    String opcionTexto = req.getParameter("opcion" + i + "_" + j);
                    boolean esCorrecta = req.getParameter("correcta" + i).equals(String.valueOf(j));

                    Opcion opcion = new Opcion(0, opcionTexto);
                    PreguntaOpcion preguntaOpcion = new PreguntaOpcion(0, 0, esCorrecta);
                    preguntaOpcion.setOpcion(opcion);
                    pregunta.addOpcion(preguntaOpcion);
                }
            }
            examen.getPreguntas().add(pregunta);
        }
        // Guardar el examen en la base de datos
        ExamenDao examenDao = new ExamenDao();
        boolean exito = examenDao.crearExamen(examen);

        if (exito) {
            resp.sendRedirect(req.getContextPath() + "/ExamenServlet?action=listar&message=Examen creado exitosamente");
        } else {
            req.setAttribute("error", "Hubo un problema al crear el examen");
            req.getRequestDispatcher("JSP/Docente/examen.jsp").forward(req, resp);
        }
    }

}