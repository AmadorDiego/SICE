package mx.edu.utez.sice.controller;

import com.google.gson.Gson;
import mx.edu.utez.sice.dao.ExamenDao;
import mx.edu.utez.sice.model.Examen;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "BuscarExamenServlet", value = "/BuscarExamenServlet")
public class BuscarExamenServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        PrintWriter out = response.getWriter();

        /*try {
            // Obtener los parámetros de los filtros
            String grupo = request.getParameter("grupo");
            String division_academica = request.getParameter("division_academica");
            String carrera = request.getParameter("carrera");

            // Instanciar el DAO y obtener la lista de exámenes
            ExamenDao examenDao = new ExamenDao();
            /*List<Examen> examenes = examenDao.getExamenes(grupo, division_academica, carrera);

            // Crear el objeto de respuesta para DataTables
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("data", examenes);

            // Convertir la respuesta a JSON usando Gson
            Gson gson = new Gson();
            String jsonResponse = gson.toJson(responseData);

            // Escribir la respuesta JSON
            out.print(jsonResponse);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"Ocurrió un error al procesar la solicitud.\"}");
        } finally {
            out.close();
        }*/
    }
}
