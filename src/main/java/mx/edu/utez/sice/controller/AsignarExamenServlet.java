package mx.edu.utez.sice.controller;

import com.google.gson.FieldNamingPolicy;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sice.dao.*;
import mx.edu.utez.sice.model.Examen;
import mx.edu.utez.sice.model.Opcion;
import mx.edu.utez.sice.model.Pregunta;
import mx.edu.utez.sice.model.Tabla;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet(name="AsignarExamenServlet", value = "/asignarExamen")
public class AsignarExamenServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String id_grupo = req.getParameter("id_grupo");
        String grado = req.getParameter("grado");
        String grupo = req.getParameter("grupo");
        String id_division = req.getParameter("id_division");
        String id_carrera = req.getParameter("id_carrera");

        System.out.println("SERVLET id_grupo: " + id_grupo);
        System.out.println("SERVLET grado: " + grado);
        System.out.println("SERVLET grupo: " + grupo);
        System.out.println("SERVLET id_division: " + id_division);
        System.out.println("SERVLET id_carrera: " + id_carrera);

        GrupoEspecificoDao dao = new GrupoEspecificoDao();
        try {
            ArrayList<Tabla> lista = dao.getGrupoEspecifico(
                    Integer.parseInt(grado),
                    grupo,
                    Integer.parseInt(id_division),
                    Integer.parseInt(id_carrera)
            );
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            Gson gson = new GsonBuilder()
                    .setFieldNamingPolicy(FieldNamingPolicy.IDENTITY)
                    .create();
            String json = gson.toJson(lista);
            System.out.println("JSON: " + json);

            resp.getWriter().write(json);
        } catch (SQLException e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JsonObject errorJson = new JsonObject();
            errorJson.addProperty("error", "Error al obtener datos del grupo específico: " + e.getMessage());
            resp.getWriter().write(new Gson().toJson(errorJson));
        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            JsonObject errorJson = new JsonObject();
            errorJson.addProperty("error", "Parámetros inválidos: " + e.getMessage());
            resp.getWriter().write(new Gson().toJson(errorJson));
        }
    }

}