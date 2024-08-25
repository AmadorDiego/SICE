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

@WebServlet(name = "UsuarioServlet",value = "/UsuarioServlet")
public class UsuarioServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //Conseguimos la info del formulario
        //donde los inputs se llamen así:
        String correo_electronico = req.getParameter("correo_electronico");
        String contrasena = req.getParameter("contrasena");
        UsuarioDao dao = new UsuarioDao();
        Usuario usuario = dao.getOne(correo_electronico, contrasena);
        // llevamos la información a una vista que está en la vista verUsuario.jsp
        HttpSession session = req.getSession();
        if(usuario.getCorreo_electronico() == null){
            //Es porque no existe en la base de datos
            session.setAttribute("mensajeInicio","Correo y/o contraseña incorrecta");
            session.setAttribute("flag", false);
            resp.sendRedirect("loginSICE.jsp");
        }else{
            switch (usuario.getId_tipo_usuario()) {
                case 1:
                    resp.sendRedirect("JSP/Administrador/indexAdministrador.jsp");
                    session.setAttribute("usuarioIndexAdministrador", usuario);
                    break;
                case 2:
                    resp.sendRedirect("JSP/Docente/indexDocente.jsp");
                    session.setAttribute("usuarioIndexDocente", usuario);
                    break;
                case 3:
                    resp.sendRedirect("JSP/Alumno/indexAlumno.jsp");
                    session.setAttribute("usuarioIndexAlumno", usuario);
                    break;
                case 4:
                    resp.sendRedirect("JSP/Docente-Administrador/indexDocenteAdministrador.jsp");
                    session.setAttribute("usuarioIndexDocenteAdministrador", usuario);
                    break;
            }
        }
    }
    public void destroy() {}
    public void init() throws ServletException {}
}