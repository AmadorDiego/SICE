package mx.edu.utez.sice.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.sice.dao.ExamenDao;
import mx.edu.utez.sice.dao.PreguntaDao;
import mx.edu.utez.sice.model.Pregunta;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "PreguntaServlet",value = "/PreguntaServlet")
public class PreguntaServlet extends HttpServlet {

    private PreguntaDao PreguntaDao;
    private ExamenDao ExamenDao;

    public void init() {
        PreguntaDao = new PreguntaDao();
        ExamenDao ExamenDao = new ExamenDao();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deletePregunta(request, response);
                break;
            default:
                listPreguntas(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "create":
                createPregunta(request, response);
                break;
            case "update":
                updatePregunta(request, response);
                break;
            default:
                listPreguntas(request, response);
        }
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id_examen = Integer.parseInt(request.getParameter("id_examen"));
        request.setAttribute("id_examen", id_examen);
        request.getRequestDispatcher("JSP/Docente/examen.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id_pregunta = Integer.parseInt(request.getParameter("id_pregunta"));
        Pregunta pregunta = PreguntaDao.getPreguntaById(id_pregunta);
        request.setAttribute("pregunta", pregunta);
        request.getRequestDispatcher("JSP/Docente/examen.jsp").forward(request, response);
    }

    //Aqui se hiciero modificaciones para ajustar preguntas --------------------------------------------------------
    private void createPregunta(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id_tipo_pregunta = Integer.parseInt(request.getParameter("id_tipo_pregunta"));
        String enunciado = request.getParameter("enunciado");

        Pregunta pregunta = new Pregunta(0, enunciado, id_tipo_pregunta);
        // Assuming insertPregunta handles generating id_pregunta
        PreguntaDao.insertPregunta(pregunta);

        int examenId = Integer.parseInt(request.getParameter("examenId"));
        response.sendRedirect("ExamenServlet?action=edit&id=" + examenId);
    }

    private void updatePregunta(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String enunciado = request.getParameter("enunciado");
        int id_tipo_pregunta = Integer.parseInt(request.getParameter("id_tipo_pregunta"));

        //Campo modificado, en proceso ya que tiene tipo de pregunta, puede que varie y se le actualice despues
        //id_pregunta,
        Pregunta pregunta = PreguntaDao.getPreguntaById(id_tipo_pregunta);
        pregunta.setPregunta(enunciado);
        pregunta.setId_tipo_pregunta(id_tipo_pregunta);

        PreguntaDao.updatePregunta(pregunta);

        //Campo modificado
        int id_examen = Integer.parseInt(request.getParameter("id_examen"));
        response.sendRedirect("ExamenServlet?action=edit&id=" + id_examen);
    }

    private void deletePregunta(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Campo modificado
        int id_pregunta = Integer.parseInt(request.getParameter("id_pregunta"));
        PreguntaDao.deletePregunta(id_pregunta);

        //Campo modificado
        int id_examen = Integer.parseInt(request.getParameter("id_examen"));
        response.sendRedirect("ExamenServlet?action=edit&id=" + id_examen);
    }

    private void listPreguntas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Campo modificado
        int id_examen = Integer.parseInt(request.getParameter("id_examen"));
        List<Pregunta> preguntas = PreguntaDao.getPreguntasByExamenId(id_examen);
        request.setAttribute("preguntas", preguntas);
        request.setAttribute("id_examen", id_examen);
        request.getRequestDispatcher("JSP/Docente/examen.jsp").forward(request, response);
    }
}
