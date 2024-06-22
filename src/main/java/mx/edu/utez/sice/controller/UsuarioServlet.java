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

@WebServlet(name = "UsuarioServlet",value = "/login")
public class UsuarioServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //Conseguimos la info del formulario
        //donde los inputs se llamen asi:
        String correo_electronico = req.getParameter("correo_electronico");
        String contrasena = req.getParameter("contrasena");

        UsuarioDao dao = new UsuarioDao();

        //Si el usuario esta vacio
        Usuario usr = dao.getOne(correo_electronico, contrasena);
        if(usr.getCorreo_electronico() == null){
            //Es porque no existe en la base de datos
            System.out.println("El usuario " + correo_electronico + " No existe en la BD");

            HttpSession session = req.getSession();
            session.setAttribute("mensaje","El usuario no existe en la BD");

            resp.sendRedirect("index.jsp");
        }else{
            //Si existe en la base de datos
            System.out.println("El usuario " + correo_electronico + " Si esta en la BD");
            resp.sendRedirect("usuario.jsp");
        }
    }
    public void destroy() {}
    public void init() throws ServletException {}
}