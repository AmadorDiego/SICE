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

import java.io.IOException;
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

        try {
            //Crea y configura un examen el objeto examen
            Examen examen = new Examen();
            examen.setNombre_examen(req.getParameter("nombre_examen"));
            examen.setEstado(1); // Asumimos que el examen se crea activo, despues lo activo, RECORDATORIO ELIAS
            examen.setDescripcion(req.getParameter("descripcion"));
            examen.setId_usuario(1);

            ServletRequest request = null; //Variable nula para r
            String nombreExamen = request.getParameter("nombre_examen");
            if (nombreExamen == null || nombreExamen.trim().isEmpty()) {
                HttpSession session = null; //Variable nula para despues cambiarla
                session.setAttribute("mensaje", "El nombre del examen no puede estar vacío");
                resp.sendRedirect(req.getContextPath() + "/examen");
                return;
            }

            //Inserta el examen en la base de datos
            ExamenDao dao = new ExamenDao();
            boolean flag = dao.insertExamen(examen);

            //Redirige un mensaje adecuado
            HttpSession session = req.getSession();
            if (flag) {
                req.getSession().setAttribute("mensaje", "Examen creado exitosamente");
                resp.sendRedirect(req.getContextPath() + "/examen");
            } else {
                req.getSession().setAttribute("mensaje", "Error al crear el examen");
                resp.sendRedirect(req.getContextPath() + "/examen");
            }
        }catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("mensaje", "Error interno del servidor");
            resp.sendRedirect(req.getContextPath() + "/error");
        }
        resp.sendRedirect(req.getContextPath() + "/examen");
    }
}