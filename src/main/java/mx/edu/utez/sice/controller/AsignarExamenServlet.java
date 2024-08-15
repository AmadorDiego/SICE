package mx.edu.utez.sice.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.sice.dao.GrupoDao;
import mx.edu.utez.sice.model.Tabla;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name="AsignarExamenServlet", value = "/asignarExamen")
public class AsignarExamenServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {



    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id_grupo = req.getParameter("id_grupo");
        String id_division = req.getParameter("id_division");
        String id_carrera = req.getParameter("id_carrera");

        GrupoDao dao  = new GrupoDao();
        ArrayList<Tabla> lista = dao.getInfo(
                Integer.parseInt(id_grupo),
                Integer.parseInt(id_division),
                Integer.parseInt(id_carrera)
        );

        Gson gson = new Gson();
        String json = gson.toJson(lista);

        resp.setContentType("text/json");
        resp.getWriter().write(json);
    }
}