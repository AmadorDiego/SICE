package mx.edu.utez.sice.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sice.dao.GrupoDao;

import java.io.IOException;

@WebServlet (name = "AsignarGrupoDocenteServlet", value = "/AsignarGrupoDocenteServlet")
public class AsignarGrupoDocenteServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id_usuario = Integer.parseInt(req.getParameter("id_usuario"));  // Obtiene el id del usuario
        GrupoDao grupoDao = new GrupoDao();

        // Captura los IDs de los grupos seleccionados
        String[] grupos_seleccionados = req.getParameterValues("id_grupo");
        boolean flag = false;
        // Si hay usuarios seleccionados, inserta cada uno en el grupo
        if (grupos_seleccionados != null) {
            for (String grupo_id_grupo : grupos_seleccionados) {
                int id_grupo = Integer.parseInt(grupo_id_grupo);  // Convierte el ID a entero
                flag = grupoDao.insertUsuarioGrupo(id_grupo, id_usuario);  // Inserta en la base de datos
            }
        }
        HttpSession sesion = req.getSession();
        if (flag){
            sesion.setAttribute("mensaje","Se asignaron los grupos correctamente a tu perfil");
            sesion.setAttribute("flag", true);
        }else {
            sesion.setAttribute("mensaje","Ocurrio un error al asignar los grupo");
            sesion.setAttribute("flag", false);
        }
        resp.sendRedirect("JSP/Docente/indexDocente.jsp");
    }
}
