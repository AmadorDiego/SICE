package mx.edu.utez.sice.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sice.dao.GrupoDao;
import mx.edu.utez.sice.dao.UsuarioDao;

import java.io.IOException;

@WebServlet (name = "AsignarAlumnoGrupoServlet", value = "/AsignarAlumnoGrupoServlet")
public class AsignarAlumnoGrupoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UsuarioDao usuarioDao = new UsuarioDao();  // Instancia del DAO
        int id_grupo = Integer.parseInt(req.getParameter("id_grupo"));  // Obtiene el id del grupo
        GrupoDao grupoDao = new GrupoDao();

        // Captura los IDs de los usuarios seleccionados
        String[] alumnos_seleccionados = req.getParameterValues("id_usuario");
        boolean flag = false;
        // Si hay usuarios seleccionados, inserta cada uno en el grupo
        if (alumnos_seleccionados != null) {
            for (String usuario_id_usuario : alumnos_seleccionados) {
                int id_usuario = Integer.parseInt(usuario_id_usuario);  // Convierte el ID a entero
                flag = grupoDao.insertAlumnoGrupo(id_grupo, id_usuario);  // Inserta en la base de datos
            }

        }
        HttpSession sesion = req.getSession();
        if (flag){
            sesion.setAttribute("mensaje","Se asignó a el/los alumno/s correctamente al grupo");
            sesion.setAttribute("flag", true);
        }else {
            sesion.setAttribute("mensaje","Ocurrio un error al asignar el grupo");
            sesion.setAttribute("flag", false);
        }
        resp.sendRedirect("JSP/Administrador/indexAdministrador.jsp");
    }
}
