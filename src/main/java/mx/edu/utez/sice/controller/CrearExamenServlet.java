package mx.edu.utez.sice.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.sice.dao.ExamenDao;
import mx.edu.utez.sice.model.Examen;

import java.io.IOException;
import java.util.List;

@WebServlet (name="CrearExamenServlet", value = "/examen")
public class CrearExamenServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("crear".equals(action)) {
            // Preparar para la creación de un nuevo examen
            request.setAttribute("modo", "crear");
            request.getRequestDispatcher("examen.jsp").forward(request, response);
        } else {
            // Lógica existente para mostrar todos los exámenes
            ExamenDao dao = new ExamenDao();
            List<Examen> examenes = dao.getAll();
            request.setAttribute("examenes", examenes);
            request.setAttribute("modo", "listar");
            request.getRequestDispatcher("examen.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Examen examen = new Examen();
        examen.setNombre_examen(req.getParameter("nombre_examen"));
        //examen.setEstado(true); // Asumimos que el examen se crea activo, despues lo activo, RECORDATORIO ELIAS
        examen.setDescripcion(req.getParameter("descripcion"));
        examen.setId_usuario(1);

        ExamenDao dao = new ExamenDao();
        boolean flag = dao.insertExamen(examen);

        if (flag) {
            req.getSession().setAttribute("mensaje", "Examen creado exitosamente");
            resp.sendRedirect(req.getContextPath() + "/examen");
        } else {
            req.getSession().setAttribute("mensaje", "Error al crear el examen");
            resp.sendRedirect(req.getContextPath() + "/");
        }

        resp.sendRedirect(req.getContextPath() + "/examen");
    }
}