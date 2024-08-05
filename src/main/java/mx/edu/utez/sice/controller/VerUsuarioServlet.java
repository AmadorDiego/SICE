package mx.edu.utez.sice.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.sice.dao.UsuarioDao;
import mx.edu.utez.sice.model.Usuario;

import java.io.IOException;

@WebServlet (name = "VerUsuarioServlet", value = "/VerUsuarioServlet")
public class VerUsuarioServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // obtenemos el id del usuario, recabado por parte del link "ver" que está dentro de la tabla de
        // la vista indexAdministrador.jsp
        int id_usuario = Integer.parseInt(req.getParameter("id_usuario"));
        // el id identifica al usuario y necesitamos un método Para obtener su información (DAO)
        UsuarioDao dao = new UsuarioDao();
        Usuario usuario = dao.getOne(id_usuario);
        // llevamos la información a una vista que está en la vista verUsuario.jsp
        HttpSession sesion = req.getSession();
        sesion.setAttribute("usuario", usuario);
        // aqui vamos a ver los datos del usuario anteriormente seleccionado
        resp.sendRedirect("JSP/Administrador/verUsuario.jsp");
        // proseguimos con un update
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Usuario u = new Usuario();
        u.setId_usuario(Integer.parseInt(req.getParameter("id_usuario")));
        u.setNombre_usuario(req.getParameter("nombre_usuario"));
        u.setApellido_usuario(req.getParameter("apellido_usuario"));
        u.setCorreo_electronico(req.getParameter("correo_electronico"));
        if(req.getParameter("contrasena1").equals(req.getParameter("contrasena2"))){
            u.setContrasena(req.getParameter("contrasena1"));
        }else{
            //Mensaje para visar que las contras no son iguales
            req.getSession().setAttribute("mensaje", "Las contraseñas no coinciden");
            resp.sendRedirect("JSP/Administrador/registroUsuario.jsp");
        }
        //u.setEstado(0);
        u.setEstado(req.getParameter("estado") != null ? 1 : 0);
        u.setId_tipo_usuario(Integer.parseInt(req.getParameter("id_tipo_usuario")));
        //Debemos mandar a llamar un DAO que me permita insertar
        UsuarioDao dao = new UsuarioDao();
        if (dao.updateDocenteAdministrador(u)) {
            req.getSession().setAttribute("mensaje", "Se actualizó correctamente");
        } else {
            req.getSession().setAttribute("mensaje", "Error al actualizar");
        }
        resp.sendRedirect("JSP/Administrador/indexAdministrador.jsp");
        /*if (dao.updateDocenteAdministrador(u)){
            req.getSession().setAttribute("mensaje","se actualizo");
        }else {
            req.getSession().setAttribute("mensaje","no se actualizo");
        }*/
    }
}
