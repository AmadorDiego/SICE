package mx.edu.utez.sice.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.sice.dao.AlumnoEspecificoDao;
import mx.edu.utez.sice.model.Tabla;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet (name = "AsignarAlumnoServlet",value = "/asignarAlumno")
public class AsignarAlumnoServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //String id_grupo = req.getParameter("id_grupo");
        int grado = Integer.parseInt(req.getParameter("grado"));
        String grupo = req.getParameter("grupo");
        int id_division = Integer.parseInt(req.getParameter("id_division"));
        //String id_carrera = req.getParameter("id_carrera");

        //System.out.println("SERVLET id_grupo: " + id_grupo);
        System.out.println("SERVLET grado: " + grado);
        System.out.println("SERVLET grupo: " + grupo);
        System.out.println("SERVLET id_division: " + id_division);
        //System.out.println("SERVLET id_carrera: " + id_carrera);

        if (grupo == null || grupo.isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            JsonObject errorJson = new JsonObject();
            errorJson.addProperty("error", "Parámetros faltantes o inválidos");
            resp.getWriter().write(new Gson().toJson(errorJson));
            return;    
        }
    }
        /*if (id_grupo == null || id_grupo.isEmpty() ||
                grado == null || grado.isEmpty() ||
                //grupo == null || grupo.isEmpty() ||
                id_division == null || id_division.isEmpty() /*||
                id_carrera == null || id_carrera.isEmpty()) {
            /*resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            JsonObject errorJson = new JsonObject();
            errorJson.addProperty("error", "Parámetros faltantes o inválidos");
            resp.getWriter().write(new Gson().toJson(errorJson));
            return;
        }*/

        /*try {
            //int idGrupo = Integer.parseInt(id_grupo);
            String grado;
            int gradoInt = Integer.parseInt(grado); // Si `grado` debe ser un número
            //String grupoLetra = grupo; // `grupo` es una letra, no necesita conversión
            int idDivision = Integer.parseInt(id_division);
            //int idCarrera = Integer.parseInt(id_carrera);

            AlumnoEspecificoDao dao = new AlumnoEspecificoDao();
            ArrayList<Tabla> lista;
            lista = dao.getGrupoAlumnoEspecifico(idGrupo,grado,idDivision);

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(new Gson().toJson(lista));
            new Gson().toJson(lista,resp.getWriter());

        }catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            JsonObject errorJson = new JsonObject();
            errorJson.addProperty("error", "Parámetros inválidos: " + e.getMessage());
            resp.getWriter().write(new Gson().toJson(errorJson));
        }catch (SQLException e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JsonObject errorJson = new JsonObject();
            errorJson.addProperty("error", "Error al obtener datos del grupo específico: "
                    + e.getMessage());
            resp.getWriter().write(new Gson().toJson(errorJson));
        }*/

        /*AlumnoEspecificoDao dao = new AlumnoEspecificoDao();
        try {
            ArrayList<Tabla> lista = dao.getGrupoAlumnoEspecifico(
                    Integer.parseInt(grado),
                    grupo,
                    Integer.parseInt(id_division),
                    Integer.parseInt(id_carrera)
            );
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            new Gson().toJson(lista, resp.getWriter());

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
        }*/
    /*}*/
}
