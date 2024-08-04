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

@WebServlet (name="CrearExamenServlet", value = "/crear")
public class CrearExamenServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ExamenDao dao = new ExamenDao();
        List<Examen> examenes = dao.getAll();
        request.setAttribute("examenes", examenes);
        request.getRequestDispatcher("indexDocente.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Examen examen = new Examen();
        examen.setNombre_examen(req.getParameter("nombre_examen"));
        examen.setEstado(Boolean.parseBoolean(req.getParameter("estado")));
        examen.setDescripcion(req.getParameter("descripcion"));
        examen.setId_usuario(Integer.parseInt(req.getParameter("usuario_id_usuario")));

        ExamenDao dao = new ExamenDao();
        dao.insertExamen(examen);

        boolean flag = dao.insertExamen(examen);

        if (flag) {
            req.getSession().setAttribute("mensaje", "Examen creado exitosamente");
        } else {
            req.getSession().setAttribute("mensaje", "Error al crear el examen");
        }

        resp.sendRedirect(req.getContextPath() + "/examen");
    }
}