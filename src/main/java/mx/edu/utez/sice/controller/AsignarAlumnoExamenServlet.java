package mx.edu.utez.sice.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sice.dao.ExamenDao;
import mx.edu.utez.sice.dao.GrupoDao;

import java.io.IOException;
@WebServlet (name = "AsignarAlumnoExamenServlet", value = "/AsignarAlumnoExamenServlet")
public class AsignarAlumnoExamenServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id_examen = Integer.parseInt(req.getParameter("id_examen"));  // Obtiene el id del grupo
        int id_docente = Integer.parseInt(req.getParameter("id_usuario"));
        ExamenDao examenDao = new ExamenDao();

        // Captura los IDs de los usuarios seleccionados
        String[] alumnos_seleccionados = req.getParameterValues("id_usuario");
        boolean flag = false;
        // Si hay usuarios seleccionados, inserta cada uno en el grupo
        if (alumnos_seleccionados != null) {
            for (String usuario_id_usuario : alumnos_seleccionados) {
                int id_usuario = Integer.parseInt(usuario_id_usuario);
                if (examenDao.insertExamenUsuario(id_usuario, id_examen)) {
                    flag = examenDao.examenAsignadoCompletado(id_examen, id_usuario);
                    if (!flag) {
                        break; // Si falla la actualización de estado, salimos del bucle
                    }
                }
            }
        }
        HttpSession sesion = req.getSession();
        if (flag){
            if (examenDao.examenAsignadoCompletado(id_examen, id_docente)){
                sesion.setAttribute("mensajeDocente","Se asignó correctamente el examen a el/los alumno/s");
                sesion.setAttribute("flag", true);
            }
        }else {
            sesion.setAttribute("mensajeDocente","Ocurrio un error al asignar el examen");
            sesion.setAttribute("flag", false);
        }
        resp.sendRedirect("JSP/Docente/indexDocente.jsp");
    }
}
