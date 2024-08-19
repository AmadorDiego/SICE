package mx.edu.utez.sice.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sice.dao.*;
import mx.edu.utez.sice.model.*;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name="AsignarGrupoExamenServlet", value = "/AsignarGrupoExamenServlet")
public class AsignarGrupoExamenServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id_examen = Integer.parseInt(req.getParameter("id_examen"));
        ExamenDao examenDao = new ExamenDao();
        Examen examen = examenDao.getOne(id_examen);  // Obtienes el examen de la base de datos y lo asignas al objeto examen.
        HttpSession sesion = req.getSession();
        sesion.setAttribute("examen", examen);  // Ahora el examen tiene los datos correctos.
        resp.sendRedirect("JSP/Docente/asignarExamen.jsp");
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id_examen = Integer.parseInt(req.getParameter("id_examen"));
        ExamenDao examenDao = new ExamenDao();

        // Captura los IDs de los grupos seleccionados
        String[] grupos_seleccionados = req.getParameterValues("id_grupo");  // Revisa si es necesario usar "id_grupo[]" o "id_grupo"

        boolean flag = false;

        // Si hay grupos seleccionados, inserta cada uno
        if (grupos_seleccionados != null) {
            for (String grupo_id : grupos_seleccionados) {
                int id_grupo = Integer.parseInt(grupo_id); // Convierte el ID a entero
                UsuarioDao usuarioDao = new UsuarioDao();
                ArrayList<Usuario> usuarios = usuarioDao.getAllAlumnosConGrupo(id_grupo);

                for (Usuario usuario : usuarios) {
                    flag = examenDao.insertExamenUsuario(usuario.getId_usuario(), id_examen); // Inserta en la base de datos
                    if (!flag) {
                        break; // Sal del ciclo si ocurre un error
                    }
                }
            }
        }

        HttpSession sesion = req.getSession();
        if (flag) {
            if (examenDao.updateExamenAsignado(id_examen)) {
                sesion.setAttribute("mensajeDocente", "Se asignó el examen correctamente a el/los grupo/s");
                sesion.setAttribute("flag", true);
            }
        } else {
            sesion.setAttribute("mensajeDocente", "Ocurrió un error al asignar el examen");
            sesion.setAttribute("flag", false);
        }
        resp.sendRedirect("JSP/Docente/indexDocente.jsp");
    }
}