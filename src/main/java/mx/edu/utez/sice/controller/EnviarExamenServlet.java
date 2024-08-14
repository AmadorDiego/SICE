package mx.edu.utez.sice.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "EnviarExamenServlet", urlPatterns = "/EnviarExamenServlet" )
public class EnviarExamenServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id_examen = Integer.parseInt(req.getParameter("id_examen"));
        String[] id_grupo = req.getParameter("id_grupo").split(",");

        try {

            resp.setContentType("application/json");
            resp.getWriter().write("{\"message\":\"Examen enviado correctamente\"}");
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"error\":\"Ocurrio un error al enviar examen\"}");
        }
    }
}
