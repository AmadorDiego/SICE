package mx.edu.utez.sice.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sice.dao.GrupoDao;
import mx.edu.utez.sice.dao.UsuarioDao;
import mx.edu.utez.sice.model.Usuario;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet (name = "EliminarAlumnoGrupoServlet", value = "/EliminarAlumnoGrupoServlet")
public class EliminarAlumnoGrupoServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id_grupo = Integer.parseInt(req.getParameter("id_grupo"));
        GrupoDao grupoDao = new GrupoDao();
        UsuarioDao usuarioDao = new UsuarioDao();
        ArrayList<Usuario> usuarios = usuarioDao.getAllUsuariosConGrupo(id_grupo);
        for (Usuario usuario : usuarios) {
            grupoDao.deleteUsuariosGrupo(id_grupo, usuario.getId_usuario());
        }
        HttpSession sesion = req.getSession();
        if (grupoDao.deleteGrupo(id_grupo)){
            sesion.setAttribute("mensajeAdministrador","Se eliminó correctamente el grupo");
            sesion.setAttribute("flag", true);
        }else {
            sesion.setAttribute("mensajeAdministrador","Ocurrio un error al eliminar el grupo");
            sesion.setAttribute("flag", false);
        }
        resp.sendRedirect("JSP/Administrador/grupos.jsp");
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id_grupo = Integer.parseInt(req.getParameter("id_grupo"));
        GrupoDao grupoDao = new GrupoDao();

        // Captura los IDs de los usuarios seleccionados
        String[] alumnos_seleccionados = req.getParameterValues("id_usuario");
        boolean flag = false;

        // Si hay usuarios seleccionados, elimínalos del grupo
        if (alumnos_seleccionados != null) {
            for (String usuario_id_usuario : alumnos_seleccionados) {
                System.out.println(usuario_id_usuario + " " + id_grupo);
                int id_usuario = Integer.parseInt(usuario_id_usuario);
                if (!grupoDao.deleteUsuariosGrupo(id_grupo, id_usuario)) {
                    flag = false;
                    break; // Si falla una eliminación, salimos del bucle
                }
                flag = true; // Si al menos una eliminación fue exitosa
            }
        }

        HttpSession sesion = req.getSession();
        if (flag) {
            sesion.setAttribute("mensajeAdministrador", "Se eliminaron correctamente los alumnos del grupo");
            sesion.setAttribute("flag", true);
        } else {
            sesion.setAttribute("mensajeAdministrador", "Ocurrió un error al eliminar los alumnos del grupo");
            sesion.setAttribute("flag", false);
        }
        resp.sendRedirect("JSP/Administrador/grupos.jsp");
    }
}
